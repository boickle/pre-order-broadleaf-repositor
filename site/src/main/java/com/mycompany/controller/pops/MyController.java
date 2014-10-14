package com.mycompany.controller.pops;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.currency.domain.BroadleafCurrency;
import org.broadleafcommerce.common.email.domain.EmailTargetImpl;
import org.broadleafcommerce.common.email.service.EmailService;
import org.broadleafcommerce.common.email.service.info.EmailInfo;
import org.broadleafcommerce.common.locale.domain.Locale;
import org.broadleafcommerce.core.order.domain.Order;
import org.broadleafcommerce.core.order.service.OrderService;
import org.broadleafcommerce.core.order.service.type.OrderStatus;
import org.broadleafcommerce.profile.core.domain.Customer;
import org.broadleafcommerce.profile.web.core.CustomerState;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.Constants;
import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;
import com.mycompany.pops.DaoUtil;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Meal;
import com.mycompany.pops.pojo.Product;

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
		String flight = request.getParameter("flight");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String flightDateParameter = request.getParameter("flightDate");
		String originStation = request.getParameter("originStation");
		String destinationStation = request.getParameter("destinationStation");
		
		HttpSession session = request.getSession();
		session.setAttribute("email", email);
		session.setAttribute("flight", flight);
		

		Dao u = new DaoImpl();
		u.insertNewCustomer(lastName,firstName,email,flight,flightDateParameter,originStation,destinationStation);
		
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
				LOG.info("trying to read the session variable for locale: "+locale);
				
				BroadleafCurrency currency = (BroadleafCurrency) s.getAttribute("blCurrency");
				if (currency!=null) {
					LOG.info("currency code is: "+currency.getCurrencyCode());
				}
				else {
					LOG.info("I don't have a currency code from session");
				}
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
		
		Dao u = new DaoImpl();
		List<Category> l = u.getCategories(Constants.PRIMARY_NAV,getLocale(request));
		String locale = getLocale(request);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/categories");
		modelAndView.addObject("breadcrumb",u.getBreadCrumbForCategory(Constants.PRIMARY_NAV,locale)); // going to be blank
		modelAndView.addObject("categories", l);
		return modelAndView;
	}

	@RequestMapping(value = "/subcategories/{categoryID}")
	public ModelAndView doGetSubCategories(@PathVariable int categoryID, HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside doGetSubCategories!");
		
		Dao u = new DaoImpl();
		List<Category> l = u.getCategories(Constants.PRIMARY_NAV,getLocale(request));
		String locale = getLocale(request);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/categories");
		modelAndView.addObject("breadcrumb",u.getBreadCrumbForCategory(categoryID,locale));
		modelAndView.addObject("categories", l);
		modelAndView.addObject("categoryID",categoryID);
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

		Dao u = new DaoImpl();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/products");

// for the simple product page		
//		modelAndView.addObject("categoryName",u.getCategoryName(categoryID));
//		modelAndView.addObject("products", l);

// for bigroom one
		String locale = getLocale(request);
		List<Category> l = u.getCategories(Constants.PRIMARY_NAV,locale);
		List<Product> productList = u.getProductsForCategory(categoryID,locale); 

		modelAndView.addObject("categories", l);
		modelAndView.addObject("breadcrumb",u.getBreadCrumbForCategory(categoryID,locale));
		modelAndView.addObject("products", productList);

		return modelAndView;
	}
	
	@RequestMapping(value = "/teststatic")
	public String doSomething10() {
		return "pops/static";
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

		Dao dao = new DaoImpl();
	    String locale = getLocale(request);
		List<Category> l = dao.getCategories(Constants.PRIMARY_NAV,locale);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/mealselect");
		modelAndView.addObject("categories", l);
		modelAndView.addObject("flightNumber",flightNumber);
		modelAndView.addObject("breakfast",dao.getMealsForFlight(flightNumber,Constants.BREAKFAST,locale));
		modelAndView.addObject("lunch",dao.getMealsForFlight(flightNumber,Constants.LUNCH,locale));
		modelAndView.addObject("dinner",dao.getMealsForFlight(flightNumber,Constants.DINNER,locale));

		return modelAndView;
	}



	@RequestMapping(value = "/dashboard")
	public ModelAndView doDashBoard(HttpServletRequest request, HttpServletResponse response) {

		List<Order> orders = null;
		Customer customer = (Customer) CustomerState.getCustomer();
		String flightNumber = null; 

	    if (customer!=null) {
	    	flightNumber=DaoUtil.getFlightNumberFromRequest(request);
	    }

	    long customerID = 0;
		if (customer!=null) {
			customerID = customer.getId();
			orders = orderService.findOrdersForCustomer(customer, OrderStatus.SUBMITTED);
		}

		Dao dao = new DaoImpl();
		List<Meal> meals = dao.getMealsForCustomer(customerID,flightNumber);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/dashboard");
		modelAndView.addObject("meals",meals);
		modelAndView.addObject("orders", orders);
    	FlightData f = dao.getFlightDataForFlight(flightNumber);
		modelAndView.addObject("flightData",f);
		
		return modelAndView;
	}
	

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
				String flightNumber=DaoUtil.getFlightNumberFromRequest(request);

				if (flightNumber!=null) {
					Dao dao = new DaoImpl();
					List<Meal> meals = dao.getMealsForCustomer(customerID,flightNumber);
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
    	modelAndView.setViewName("layout/ohome");
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
    	Dao dao = new DaoImpl();
		ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("pops/flightconfirmation");
    	modelAndView.addObject("firstname",firstName);
    	modelAndView.addObject("lastname",lastName);
    	modelAndView.addObject("email",email);
    	
    	//debating... should this be lookup or displaying whatever passed in?
    	FlightData f = dao.getFlightDataForFlight(flightNumber);
    	if(f!=null)
    		LOG.info("Flight Info: " + f.getFlightNumber() );
    	else{
    		LOG.info("Flight Info is null " );
    	}
    	//String depart = f.getDepartureDate();
    	HttpSession session = request.getSession();
		session.setAttribute("flightdata", f);
    	modelAndView.addObject("flightdata",f);
    	modelAndView.addObject("loginlink",loginLink);
    	
    	
		return modelAndView;
	}
	
	@RequestMapping(value = "/sendWelcomeEmail") 
	public String doSendEmailTest2(HttpServletRequest request, HttpServletResponse response) {
		String emailTo = request.getParameter("emailTo");
        //String emailFrom="testing123@egate.com";  //<-- this variable is not used. the real emailFrom is defined in configuration file
        String firstName=request.getParameter("firstname");
        String lastName=request.getParameter("lastname");
        String flight=request.getParameter("flight");
        String flightDate =request.getParameter("flightDate");
        String originStation = request.getParameter("originStation");
        String destinationStation = request.getParameter("destinationStation");

		
        //Adding flight info to prevent header from failing when showing done page. Probably a better way to do this.
        Dao dao = new DaoImpl();
        FlightData f = dao.getFlightDataForFlight(flight);
    	HttpSession session = request.getSession();
		session.setAttribute("flightdata", f);
		
		
		//String emailTo="boickle@bigroomstudios.com";
		
		EmailTargetImpl emailTarget = new EmailTargetImpl();
		emailTarget.setEmailAddress(emailTo);
		
		HashMap<String, Object> vars = new HashMap<String, Object>();

		String absolutePath=request.getServerName();
		LOG.info("absolutePath:"+absolutePath);
		LOG.info("email ab: " + absolutePath);
        vars.put("firstname",firstName);
        vars.put("absolutepath",absolutePath);
        
		String url = "http://" + absolutePath + "/loginAuto?email=" + emailTo
				+ "&flight=" + flight + "&firstname=" + firstName
				+ "&lastname=" + lastName + "&flightDate=" + flightDate
				+ "&originStation=" + originStation + "&destinationStation="
				+ destinationStation;
        LOG.info("email url: " + url);
        vars.put("link",url);
        
        
		try {
			emailService.sendTemplateEmail(emailTarget, preSelectionEmailInfo, vars);
		} catch (Exception e) {
			LOG.info("sorry, error in send email",e);

		}
		return "pops/done";
	}	

	
}