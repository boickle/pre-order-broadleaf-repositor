package com.mycompany.controller.pops;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.email.domain.EmailTargetImpl;
import org.broadleafcommerce.common.email.service.EmailService;
import org.broadleafcommerce.common.email.service.info.EmailInfo;
import org.broadleafcommerce.common.locale.domain.Locale;
import org.broadleafcommerce.core.order.domain.Order;
import org.broadleafcommerce.core.order.service.OrderService;
import org.broadleafcommerce.core.order.service.type.OrderStatus;
import org.broadleafcommerce.core.web.order.CartState;
import org.broadleafcommerce.profile.core.domain.Customer;
import org.broadleafcommerce.profile.web.core.CustomerState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.Constants;
import com.mycompany.pops.configuration.AppConfiguration;
import com.mycompany.pops.dao.Dao;
import com.mycompany.pops.dao.DaoUtil;
import com.mycompany.pops.dao.TransactionDaoImpl;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.Passenger;
import com.mycompany.pops.pojo.PopsCustomer;
import com.mycompany.pops.pojo.Product;
import com.mycompany.pops.pojo.Transaction;
import com.mycompany.pops.tools.UserToken;

@Controller
public class MyController {

	protected static final Log LOG = LogFactory.getLog(MyController.class);

	// so I can find orders for the customer for the dashboard
    @Resource(name="blOrderService")
    protected OrderService orderService;
    
    @Resource(name = "blEmailService")
	protected EmailService emailService;
    
    @Resource(name = "preselectionEmailInfo")
    protected EmailInfo preSelectionEmailInfo;
    
	private final Dao dao;
	private final Integer PRIMARY_NAV;
	private final String[] BCC_LIST;
	
    @Autowired
    public MyController(
    		AppConfiguration appConfiguration, 
    		Dao dao
    ) {
		this.dao = dao;
		this.PRIMARY_NAV = appConfiguration.primaryNav();
		this.BCC_LIST = appConfiguration.emailBccList();
    }
	
	/**
	 * This is the controller for auto login, which is the first step.
	 * It just takes you to the flight info screen to let
	 * user see info passing in
	 */
	@RequestMapping(value = "/loginAuto")
	public ModelAndView gotoConfirmScreen(HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside loginAuto");

		// all work used to be in here, to login automatically
		// but now we want to show flight info first. so this is now completely useless
		// can be eliminated if the welcome email goes to flight info instead
		// so don't need to read parameters and set session variables then read it back from flight info
		TransactionDaoImpl tranDao = new TransactionDaoImpl(dao);
		String token = request.getParameter("token");
		tranDao.getTransaction(token);
		
		return this.doFlightInfo(request, response);
	}	

	/**
	 * This method creates the user by inserting a row to blc_customer, then go to the login page
	 * and let it click automatically
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/loginCreateUser")
	public String doCreateUserAndLogin(HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside autologin");

		String email = request.getParameter("email");
		/*String flight = request.getParameter("flight");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String flightDateParameter = request.getParameter("flightDate");
		String originStation = request.getParameter("originStation");
		String destinationStation = request.getParameter("destinationStation");*/
		
		HttpSession session = request.getSession();
		session.setAttribute("email", email);
		
		//dao.insertNewCustomer(lastName,firstName,email,flight,flightDateParameter,originStation,destinationStation);
		
		return "redirect:/login";
	}	
	

	/**
	 * This method reads the locale variable set by broadleaf flag icon
	 * @param request
	 * @return
	 */
	private String getLocale(HttpServletRequest request) {
		String locale=null;
		HttpSession s = request.getSession();
		if (s!=null) {
			Locale l = (Locale) s.getAttribute("blLocale");
			if (l!=null) {
				locale = l.getLocaleCode();
//				LOG.info("trying to read the session variable for locale: "+locale);
//				
//				BroadleafCurrency currency = (BroadleafCurrency) s.getAttribute("blCurrency");
//				if (currency!=null) {
//					LOG.info("currency code is: "+currency.getCurrencyCode());
//				}
//				else {
//					LOG.info("I don't have a currency code from session");
//				}
			}
		}
		return locale;
	}

	/**
	 * This is for the main shopping page to show all categories
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/categories")
	public ModelAndView doGetAllCategories(HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside doGetAllCategories!");
		
		List<Category> l = dao.getCategories(PRIMARY_NAV, getLocale(request));
		String locale = getLocale(request);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/categories");
		modelAndView.addObject("breadcrumb",dao.getBreadCrumbForCategory(PRIMARY_NAV, locale)); // going to be blank
		modelAndView.addObject("categories", l);
		return modelAndView;
	}

	
	/**
	 * This is for the product listing page, for a particular category
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/products/{categoryID}")
	public ModelAndView doProductListing(@PathVariable int categoryID, HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside doProductListing!");
		if (categoryID==0) categoryID=2002; //2002 means hot sauce (just in case nothing is passed)

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/products");

		String locale = getLocale(request);
		List<Category> l = dao.getCategories(PRIMARY_NAV, locale);
		List<Product> productList = dao.getProductsForCategory(categoryID,locale); 

		modelAndView.addObject("categories", l);
		modelAndView.addObject("breadcrumb", dao.getBreadCrumbForCategory(categoryID,locale));
		modelAndView.addObject("products", productList);

		return modelAndView;
	}
	


	
	/**
	 * This is for meal selection
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/mealSelect")
	public ModelAndView doMealSelect(HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside meal select");

	    Customer customer = (Customer) CustomerState.getCustomer();
	    String flightNumber=null;
	    if (customer!=null) {
	    	flightNumber=DaoUtil.getFlightNumberFromRequest(request);
	    }

	    String locale = getLocale(request);
		List<Category> l = dao.getCategories(PRIMARY_NAV, locale);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/mealselect");
		modelAndView.addObject("categories", l);
		modelAndView.addObject("flightNumber",flightNumber);
		modelAndView.addObject("breakfast",dao.getMealsForFlightID(flightNumber,Constants.BREAKFAST,locale));
		modelAndView.addObject("lunch",dao.getMealsForFlightID(flightNumber,Constants.LUNCH,locale));
		modelAndView.addObject("dinner",dao.getMealsForFlightID(flightNumber,Constants.DINNER,locale));

		return modelAndView;
	}



	@RequestMapping(value = "/dashboard")
	public ModelAndView doDashBoard(HttpServletRequest request, HttpServletResponse response) {

		List<Order> orders = null;
		Customer customer = (Customer) CustomerState.getCustomer();
		String flightID = null; 

	    if (customer!=null) {
	    	flightID=DaoUtil.getFlightNumberFromRequest(request);
	    }

	    long customerID = 0;
		if (customer!=null) {
			customerID = customer.getId();
			orders = orderService.findOrdersForCustomer(customer, OrderStatus.SUBMITTED);
		}

    	FlightData f = dao.getFlightDataForFlightID(new Long(flightID).longValue());

		List<Meal> meals = dao.getMealsForCustomer(customerID,flightID,f.getFlightNumber());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/dashboard");
		modelAndView.addObject("meals",meals);
		modelAndView.addObject("orders", orders);
		modelAndView.addObject("flightData",f);
		
		return modelAndView;
	}
	

	/**
	 * This is called by home.html, and responsible for redirecting
	 * if not logged in, take you to the comingsoon page
	 * if logged in and have meal: go to dashboard
	 * if logged in but not have meal: go meal select
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/welcome")
	public ModelAndView doRedirect(HttpServletRequest request, HttpServletResponse response) {

		Customer customer = (Customer) CustomerState.getCustomer();
//		String flightNumber = null;  

		// if you are logged in, and you have meal selected, go to dashboard. if not, go to mealSelect
		// if you are not logged in, go home.
	    if (customer!=null) {

	    	LOG.info("doRedirect, you are: "+customer.getUsername());
			String userName = customer.getUsername();
			long customerID = customer.getId();
	
			if (userName!=null) {
				String flightID=DaoUtil.getFlightNumberFromRequest(request);

				if (flightID!=null) {
					List<Meal> meals = dao.getMealsForCustomer(customerID,flightID, ""); // flight number doesn't matter here
					if (meals!=null && !meals.isEmpty()) {
						return doDashBoard(request,response);
					}
					return doMealSelect(request,response);
				}
			}

	    } else {
	    	LOG.info("doRedirect: customer is null");
	    }

	    
		ModelAndView modelAndView = new ModelAndView();
    	//modelAndView.setViewName("authentication/login"); adding a coming soon page.
    	modelAndView.setViewName("pops/comingsoon");
		return modelAndView;

	}
	
	@RequestMapping(value = "/flightinfo")
	public ModelAndView doFlightInfo(HttpServletRequest request, HttpServletResponse response) {

		LOG.info("inside flightinfo");

		String email = request.getParameter("email");
		String flightNumber = request.getParameter("flight");
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String flightDate = request.getParameter("flightDate");
		String originStation = request.getParameter("originStation");
		String destinationStation = request.getParameter("destinationStation");

    	LOG.info("email is: "+email);
    	LOG.info("flight is: "+flightNumber);
    	
		String loginLink = "/loginCreateUser?email=" + email + "&flight="
				+ flightNumber + "&firstName=" + firstName + "&lastName="
				+ lastName + "&flightDate=" + flightDate + "&originStation="
				+ originStation + "&destinationStation=" + destinationStation;
    	
		LOG.info("Name: " + firstName );
		ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("pops/flightconfirmation");
    	modelAndView.addObject("firstname",firstName);
    	modelAndView.addObject("lastname",lastName);
    	modelAndView.addObject("email",email);
    	
    	//debating... should this be lookup or displaying whatever passed in?
    	FlightData f = dao.getFlightDataForFlight(flightNumber, flightDate, originStation, destinationStation);
    	if(f!=null)
    		LOG.info("Flight Info: " + f.getFlightNumber() );
    	else{
    		LOG.error("Flight Info is null. Cannot find "+flightNumber+" flight data would be whatever passed in" );
    		
    		// Can't find flight... so just taking from the parameters
    		f = new FlightData();
    		SimpleDateFormat sdf = new SimpleDateFormat(Constants.FLIGHT_DATE_FORMAT_FROM_EMAIL_LINK);
    		Date theFlightDate = new Date();
    		try {
    			theFlightDate = sdf.parse(flightDate);
    		}
    		catch (ParseException e) {
    			// that's ok, it would be today's date (just so things don't crash)
    		}
    		f.setDepartureDate(theFlightDate);
    		f.setFlightNumber(flightNumber);
    		f.setOriginStation(originStation);
    		f.setDestinationStation(destinationStation);
    	}
    	//String depart = f.getDepartureDate();
 
    	HttpSession session = request.getSession();
		session.setAttribute("flightdata", f);
		session.setAttribute("flightID", f.getFlightID());
		
    	modelAndView.addObject("flightdata",f);
    	modelAndView.addObject("loginlink",loginLink);
    	String absolutePath=request.getServerName();
    	modelAndView.addObject("absolutepath",absolutePath);
    	
		return modelAndView;
	}
	
	@RequestMapping(value = "/sendWelcomeEmailPost", method = RequestMethod.POST)
	public ResponseEntity<String> doSendWelcomeEmailPost(@RequestBody Transaction transaction) {
		TransactionDaoImpl tranDao = new TransactionDaoImpl(dao);
		String jsonResponse = "{\"Status\":\"Success\"}";
		if(transaction.getFlights()==null){
			//TODO
		}
		for(int i=0;i<transaction.getFlights().size();i++){
			FlightData flight = transaction.getFlights().get(i);
			if(flight==null){
				return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			List<Passenger> passengers = flight.getPassengers();
			for(int z=0;z<passengers.size();z++){
				Passenger p = passengers.get(z);
				if(p==null){
					return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
				}
				
				//dao.insertNewCustomer(p.getLastName(),p.getLastName(),p.getEmail(),flight.getFlightNumber(),flight.getDepartureDateOnly(),flight.getOriginStation(),flight.getDestinationStation());
			}	
		}
		
		UserToken token = new UserToken(transaction.getCustomer());
		tranDao.insertNewTransaction(token, transaction);
		
		PopsCustomer c = transaction.getCustomer();
		EmailTargetImpl emailTarget = new EmailTargetImpl();
		emailTarget.setEmailAddress(c.getEmail());
		//if (BCC_LIST != null && BCC_LIST.length != 0) {
			//emailTarget.setBCCAddresses(BCC_LIST);
		//}

		HashMap<String, Object> vars = new HashMap<String, Object>();
		
		ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = sra.getRequest();  
		String absolutePath = request.getServerName();

		// in case you are not running on port 80
		int port = request.getServerPort();
		if (port > 80) {
			absolutePath = absolutePath + ":" + port;
		}

		LOG.info("absolutePath:" + absolutePath);
		LOG.info("email ab: " + absolutePath);
		vars.put("firstname", c.getFirstName());
		vars.put("absolutepath", absolutePath);

		String url = "http://" + absolutePath + "/loginAuto?token=" + token.getToken();
				
		LOG.info("email url: " + url);
		vars.put("link", url);

		try {
			emailService.sendTemplateEmail(emailTarget, preSelectionEmailInfo, vars);
		} catch (Exception e) {
			LOG.info("sorry, error in send email", e);
		}
	
		return new ResponseEntity<String>(jsonResponse,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/sendWelcomeEmail", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView doSendWelcomeEmail(HttpServletRequest request,
			HttpServletResponse response) {
		
		LOG.info("----------------------");
		LOG.info("Sending Welcome Email");
		String emailTo = request.getParameter("emailTo");
		// String emailFrom="testing123@egate.com"; //<-- this variable is not
		// used. the real emailFrom is defined in configuration file
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String flight = request.getParameter("flight");
		String flightDate = request.getParameter("flightDate");
		String originStation = request.getParameter("originStation");
		String destinationStation = request.getParameter("destinationStation");

		List<String> messages = new ArrayList<String>();

		if (firstName == null) {
			messages.add("Cannot find firstname parameter");
		}
		if (lastName == null) {
			messages.add("Cannot find lastname parameter");
		}
		if (flight == null) {
			messages.add("Cannot find flight parameter");
		}
		if (flightDate == null) {
			messages.add("Cannot find flightDate parameter");
		}

		// Adding flight info to prevent header from failing when showing done
		// page. Probably a better way to do this.
		FlightData f = dao.getFlightDataForFlight(flight,flightDate,originStation,destinationStation);
		HttpSession session = request.getSession();
		if (f == null) {
			// This is just to prevent flightdata is null in the session
			f = new FlightData();
			messages.add("Cannot find flight " + flight);

		}
		session.setAttribute("flightdata", f);

		// String emailTo="boickle@bigroomstudios.com";

		EmailTargetImpl emailTarget = new EmailTargetImpl();
		emailTarget.setEmailAddress(emailTo);
		if (BCC_LIST != null && BCC_LIST.length != 0) {
			emailTarget.setBCCAddresses(BCC_LIST);
		}

		HashMap<String, Object> vars = new HashMap<String, Object>();

		String absolutePath = request.getServerName();

		// in case you are not running on port 80
		int port = request.getServerPort();
		if (port > 80) {
			absolutePath = absolutePath + ":" + port;
		}

		LOG.info("absolutePath:" + absolutePath);
		LOG.info("email ab: " + absolutePath);
		vars.put("firstname", firstName);
		vars.put("absolutepath", absolutePath);

		String url = "http://" + absolutePath + "/loginAuto?email=" + emailTo
				+ "&flight=" + flight + "&firstname=" + firstName
				+ "&lastname=" + lastName + "&flightDate=" + flightDate
				+ "&originStation=" + originStation + "&destinationStation="
				+ destinationStation;
		LOG.info("email url: " + url);
		vars.put("link", url);

		try {
			emailService.sendTemplateEmail(emailTarget, preSelectionEmailInfo, vars);
		} catch (Exception e) {
			messages.add("Error in sending mail:" + e.getMessage());
			LOG.info("sorry, error in send email", e);

		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/doneSendingWelcomeEmail");
		modelAndView.addObject("firstname", firstName);
		modelAndView.addObject("lastname", lastName);
		modelAndView.addObject("email", emailTo);
		modelAndView.addObject("messages", messages);
		return modelAndView;
	}	

	@RequestMapping(value = "/payment")
	public ModelAndView doPaymentInfo(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/payment");
		return modelAndView;
	
	}
	
	@RequestMapping(value = "/checkout/paymentorreview") 
	public ModelAndView doCheckoutGoToPaymentOrReview(HttpServletRequest request, HttpServletResponse response) {

		// If the cart has no money involved, that means meal selected, go right to review, otherwise, go to payment page

		String nextPage = "pops/orderreview";
        Order cart = CartState.getCart();
        BigDecimal subTotal = cart.getSubTotal().getAmount();
        if (subTotal.compareTo( BigDecimal.ZERO) > 0) {
        	nextPage = "pops/payment";
        }
        
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(nextPage);
		return modelAndView;
	
			
	}
	
}