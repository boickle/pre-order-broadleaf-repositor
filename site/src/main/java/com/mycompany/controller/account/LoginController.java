/*
 * Copyright 2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.mycompany.controller.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.broadleafcommerce.common.exception.ServiceException;
import org.broadleafcommerce.core.web.controller.account.BroadleafLoginController;
import org.broadleafcommerce.core.web.controller.account.ResetPasswordForm;
import org.mortbay.log.Log;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;
import com.mycompany.pops.pojo.FlightData;

/**
 * The controller responsible for all actions involving logging a customer in
 */
@Controller
public class LoginController extends BroadleafLoginController {
    
    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
    	
    	Log.info("Inside login controller");
    	Log.info("email is: "+request.getSession().getAttribute("email"));
    	String flightNumber = (String) request.getSession().getAttribute("flight");
    	Log.info("flight is: "+flightNumber);
    	
    	FlightData f = (FlightData) request.getSession().getAttribute("flightdata");
    	if (f==null) {
    		Log.info("Cannot find flight data in session! Trying to read it again");
    		
    		if (flightNumber!=null) {
	    		Dao dao = new DaoImpl();
	    		f = dao.getFlightDataForFlight(flightNumber);
    		} else {
    			f = new FlightData();
    		}
	        HttpSession session = request.getSession();
    		session.setAttribute("flightdata", f);
    	}
        return super.login(request, response, model);
    }
    
    @RequestMapping(value="/login/forgotPassword", method=RequestMethod.GET)
    public String forgotPassword(HttpServletRequest request, HttpServletResponse response, Model model) {
        return super.forgotPassword(request, response, model);
    }
    
    @RequestMapping(value="/login/forgotPassword", method=RequestMethod.POST)
    public String processForgotPassword(@RequestParam("emailAddress") String emailAddress, HttpServletRequest request, Model model) {
        return super.processForgotPassword(emailAddress, request, model);
    }   

    @RequestMapping(value="/login/resetPassword", method=RequestMethod.GET)
    public String resetPassword(HttpServletRequest request, HttpServletResponse response, Model model) {
        return super.resetPassword(request, response, model);
    }   
    
    @RequestMapping(value="/login/resetPassword", method=RequestMethod.POST)
    public String processResetPassword(@ModelAttribute("resetPasswordForm") ResetPasswordForm resetPasswordForm, HttpServletRequest request, HttpServletResponse response, Model model, BindingResult errors) throws ServiceException {
        return super.processResetPassword(resetPasswordForm, request, response, model, errors);
    }   
    
    @Override
    public String getResetPasswordUrl(HttpServletRequest request) {     
        String url = request.getScheme() + "://" + request.getServerName() + getResetPasswordPort(request, request.getScheme() + "/");
        
        if (request.getContextPath() != null && ! "".equals(request.getContextPath())) {
            url = url + request.getContextPath() + "/login/resetPassword";
        } else {
            url = url + "/login/resetPassword";
        }
        return url;
    }
}
