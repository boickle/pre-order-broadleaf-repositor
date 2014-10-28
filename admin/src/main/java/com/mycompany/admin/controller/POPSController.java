package com.mycompany.admin.controller;

import java.util.List;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.Constants;
import com.mycompany.pops.dao.Dao;
import com.mycompany.pops.dao.DaoImpl;
import com.mycompany.pops.pojo.FlightData;
import com.mycompany.pops.pojo.Product;

/**
 * This is the controller object for POPS Admin
 * 
 */

@Controller
@Secured("PERMISSION_OTHER_DEFAULT")
public class POPSController  {
	

	@RequestMapping(value = "/showflights")
	public ModelAndView doShowFlights() {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/flightsinfo");

		Dao dao = new DaoImpl(null); // ok, until i figure out how to make it look like the site's version with autowiring
		List<FlightData> data = dao.getAllFlights();
		modelAndView.addObject("data", data);

		return modelAndView;

	}
	
	@RequestMapping(value = "/flightMeals/{flightID}/{flightNumber}")
	public ModelAndView doShowFlightMeals(@PathVariable int flightID,@PathVariable String flightNumber) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/flightmealinfo");
		
		String locale="us";
		Dao dao = new DaoImpl(null); // ok, until i figure out how to make it look like the site's version with autowiring

		List<Long> breakfast = dao.getMealsIDForFlightID(flightID+"",Constants.BREAKFAST,locale);
		List<Long> lunch = dao.getMealsIDForFlightID(flightID+"",Constants.LUNCH,locale);
		List<Long> dinner = dao.getMealsIDForFlightID(flightID+"",Constants.DINNER,locale);

		List<Product> allBreakfast = dao.getProductsForCategory(Constants.BREAKFAST_CATEGORY, locale);
		List<Product> allLunch = dao.getProductsForCategory(Constants.LUNCH_CATEGORY, locale);
		List<Product> allDinner = dao.getProductsForCategory(Constants.DINNER_CATEGORY, locale);

		modelAndView.addObject("flightNumber",flightNumber);
		modelAndView.addObject("flightbreakfast", breakfast);
		modelAndView.addObject("flightlunch", lunch);
		modelAndView.addObject("flightdinner", dinner);
		modelAndView.addObject("allbreakfast", allBreakfast);
		modelAndView.addObject("alllunch", allLunch);
		modelAndView.addObject("alldinner", allDinner);

		return modelAndView;

	}
}
