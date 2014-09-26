package com.mycompany.controller.pops;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.currency.domain.BroadleafCurrency;
import org.broadleafcommerce.common.locale.domain.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.Constants;
import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;
import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.domain.FlightInfoImpl;
import com.mycompany.pops.pojo.Category;
import com.mycompany.pops.pojo.MyData;
import com.mycompany.pops.pojo.Product;

@Controller
public class MyController {

	protected static final Log LOG = LogFactory.getLog(MyController.class);

	@RequestMapping(value = "/some/path")
	public String doSomething() {
		LOG.info("Inside doSomething!");
		return "pops/foo";

	}

	@RequestMapping(value = "/some/path2")
	public ModelAndView doSomething2() {
		LOG.info("Inside doSomething2!");
		return new ModelAndView("pops/foo", "myfield", "hello world");
	}

	@RequestMapping(value = "/some/path3")
	public ModelAndView doSomething3() {
		LOG.info("Inside doSomething3!");

		return new ModelAndView("pops/upload");
	}


	
	@RequestMapping(value="/myform/datapost")
	public ModelAndView doSomething4(HttpServletRequest request, HttpServletResponse response) {
		
		LOG.info("Inside doSomething4 /myform/datapost");

		MyData data = new MyData();
		try {
		data.setData1(request.getParameter("data1"));
		data.setData2(request.getParameter("data2"));
		data.setData3(new Integer(request.getParameter("data3")).intValue());
		} catch (Exception e) {
			LOG.error("error in datapost2",e);
		}
		
		LOG.info("Here is data: "+data.getData1()+","+data.getData2()+", "+data.getData3());

		doTestDB(data);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/bar");

		modelAndView.addObject("mystuff", data);

		return modelAndView;
	}
	
	private void doTestDB(MyData data) {
		LOG.info("doTestDB");
		FlightInfo f = new FlightInfoImpl();
		f.setFlightNumber("A"+data.getData3());
		f.setDepartureLocation(data.getData1());
		f.setDestinationLocation(data.getData2());
		Dao u = new DaoImpl();
		u.insertFlight(f);
	}

	
	@RequestMapping(value = "/loginNew")
	public String doSomething7() {
		LOG.info("Inside doSomething7!");

		return "pops/newlogin";
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

	/* (not used because we are using directly reusing broadleaf's product url
	@RequestMapping(value = "/productdetail/{productID}")
	public ModelAndView doProductDetail(@PathVariable int productID, HttpServletRequest request, HttpServletResponse response) {
		LOG.info("Inside doProductDetail, productID:"+productID);

		Dao u = new DaoImpl();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/productdetail");

		String locale = getLocale(request);
		List<Category> l = u.getCategories(Constants.PRIMARY_NAV,locale);

		modelAndView.addObject("categories", l);
		modelAndView.addObject("breadcrumb",u.getBreadCrumbForProduct(productID,locale));
//		modelAndView.addObject("product",p);

		return modelAndView;
	}
	*/
	
}