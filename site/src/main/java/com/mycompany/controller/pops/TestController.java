package com.mycompany.controller.pops;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.email.domain.EmailTargetImpl;
import org.broadleafcommerce.common.email.service.EmailService;
import org.broadleafcommerce.common.email.service.info.EmailInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;
import com.mycompany.pops.domain.FlightInfo;
import com.mycompany.pops.domain.FlightInfoImpl;
import com.mycompany.pops.pojo.MyData;

/**
 * This file contains experimental request mapping routines
 *
 */
@Controller
public class TestController {

	protected static final Log LOG = LogFactory.getLog(MyController.class);

	@Resource(name = "blEmailService")
	protected EmailService emailService;
	
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

	@RequestMapping(value = "/myform/datapost")
	public ModelAndView doSomething4(HttpServletRequest request,
			HttpServletResponse response) {

		LOG.info("Inside doSomething4 /myform/datapost");

		MyData data = new MyData();
		try {
			data.setData1(request.getParameter("data1"));
			data.setData2(request.getParameter("data2"));
			data.setData3(new Integer(request.getParameter("data3")).intValue());
		} catch (Exception e) {
			LOG.error("error in datapost2", e);
		}

		LOG.info("Here is data: " + data.getData1() + "," + data.getData2()
				+ ", " + data.getData3());

		doTestDB(data);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pops/bar");

		modelAndView.addObject("mystuff", data);

		return modelAndView;
	}

	private void doTestDB(MyData data) {
		LOG.info("doTestDB");
		FlightInfo f = new FlightInfoImpl();
		f.setFlightNumber("A" + data.getData3());
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

	@RequestMapping(value = "/home")
	public String dohome() {
		LOG.info("Inside dohome!");

		return "layout/home";
	}

	
	@RequestMapping(value = "/sendEmailTest") 
	public String doSendEmailTest(HttpServletRequest request, HttpServletResponse response) {
		
		String emailFrom="testing123@egate.com";
		String emailTo="josephmak0865@gmail.com";
		EmailInfo emailInfo = new EmailInfo();
		
		String name="me";
		emailInfo.setFromAddress(emailFrom);

		emailInfo.setSubject("Message from " + name);
		emailInfo.setMessageBody("How are you today?");
		EmailTargetImpl emailTarget = new EmailTargetImpl();
		
		HashMap<String, Object> vars = new HashMap<String, Object>();
		emailTarget.setEmailAddress(emailTo);

		try {
			emailService.sendBasicEmail(emailInfo, emailTarget, vars);
		} catch (Exception e) {
			LOG.info("sorry, error in send email",e);

		}
		return "pops/done";
	}
}
