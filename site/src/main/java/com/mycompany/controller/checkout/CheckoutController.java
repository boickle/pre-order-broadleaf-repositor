/*
  * Copyright 2008-2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.mycompany.controller.checkout;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.email.domain.EmailTargetImpl;
import org.broadleafcommerce.common.email.service.EmailService;
import org.broadleafcommerce.common.email.service.info.EmailInfo;
import org.broadleafcommerce.common.exception.ServiceException;
import org.broadleafcommerce.common.payment.PaymentType;
import org.broadleafcommerce.common.vendor.service.exception.PaymentException;
import org.broadleafcommerce.core.order.domain.NullOrderImpl;
import org.broadleafcommerce.core.order.domain.Order;
import org.broadleafcommerce.core.pricing.service.exception.PricingException;
import org.broadleafcommerce.core.web.checkout.model.BillingInfoForm;
import org.broadleafcommerce.core.web.checkout.model.CustomerCreditInfoForm;
import org.broadleafcommerce.core.web.checkout.model.GiftCardInfoForm;
import org.broadleafcommerce.core.web.checkout.model.OrderInfoForm;
import org.broadleafcommerce.core.web.checkout.model.ShippingInfoForm;
import org.broadleafcommerce.core.web.controller.checkout.BroadleafCheckoutController;
import org.broadleafcommerce.core.web.order.CartState;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mycompany.pops.Constants;
import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;
import com.mycompany.pops.DaoUtil;
import com.mycompany.pops.domain.BillingInfo;
import com.mycompany.pops.pojo.FlightData;

@Controller
public class CheckoutController extends BroadleafCheckoutController {

	protected static final Log LOG = LogFactory.getLog(CheckoutController.class);
	
    @Resource(name = "blOrderConfirmationEmailInfo")
    protected EmailInfo orderConfirmationEmailInfo;
    
	@Resource(name = "blEmailService")
	protected EmailService emailService;
	
    @RequestMapping("/checkout")
    public String checkout(HttpServletRequest request, HttpServletResponse response, Model model,
            @ModelAttribute("orderInfoForm") OrderInfoForm orderInfoForm,
            @ModelAttribute("shippingInfoForm") ShippingInfoForm shippingForm,
            @ModelAttribute("billingInfoForm") BillingInfoForm billingForm,
            @ModelAttribute("giftCardInfoForm") GiftCardInfoForm giftCardInfoForm,
            @ModelAttribute("customerCreditInfoForm") CustomerCreditInfoForm customerCreditInfoForm,
            RedirectAttributes redirectAttributes) {
        return super.checkout(request, response, model, redirectAttributes);
    }

    @RequestMapping(value = "/checkout/savedetails", method = RequestMethod.POST)
    public String saveGlobalOrderDetails(HttpServletRequest request, Model model,
            @ModelAttribute("shippingInfoForm") ShippingInfoForm shippingForm,
            @ModelAttribute("billingInfoForm") BillingInfoForm billingForm,
            @ModelAttribute("giftCardInfoForm") GiftCardInfoForm giftCardInfoForm,
            @ModelAttribute("orderInfoForm") OrderInfoForm orderInfoForm, BindingResult result) throws ServiceException {
        return super.saveGlobalOrderDetails(request, model, orderInfoForm, result);
    }

    @RequestMapping(value = "/checkout/complete", method = RequestMethod.POST)
    public String processCompleteCheckoutOrderFinalized(RedirectAttributes redirectAttributes) throws PaymentException {
        return super.processCompleteCheckoutOrderFinalized(redirectAttributes);
    }
    
    private void sendConfirmationEmail(Order order) {
    	LOG.info("Inside my own send Confirmation Email");
        HashMap<String, Object> vars = new HashMap<String, Object>();
        vars.put("customer", order.getCustomer());
        vars.put("orderNumber", order.getOrderNumber());
        vars.put("order", order);

		SimpleDateFormat sdf = new SimpleDateFormat(Constants.ORDER_DATE_FORMAT_IN_EMAIL);
		String df = sdf.format(order.getSubmitDate());
		Calendar cal = Calendar.getInstance();
	    cal.setTime(order.getSubmitDate());
	    int day = cal.get(Calendar.DAY_OF_MONTH);
	    if (day < 10 || day > 20) {
	    	switch (day % 10) {
	    	case 1:
	    		df = df.replace("th", "st");
	    		break;
	    	case 2:
	    		df = df.replace("th", "nd");
	    		break;
	    	case 3:
	    		df = df.replace("th", "rd");
	    		break;
	    	default:
	    		break;
	    	}
	    }
        vars.put("order_submitDateFormatted", df);
        
        vars.put("serverpath", Constants.SERVERPATH_FOR_EMAIL);

	    Dao dao = new DaoImpl();
        FlightData f = dao.getFlightInfoFromMealOrder(order.getOrderNumber());

        vars.put("flightData", f);
        
        EmailTargetImpl emailTarget = new EmailTargetImpl();
		emailTarget.setEmailAddress(order.getEmailAddress());
		if (Constants.BCC_LIST!=null) {
			emailTarget.setBCCAddresses(Constants.BCC_LIST);
		}

        try {
            emailService.sendTemplateEmail(emailTarget, orderConfirmationEmailInfo, vars);
        } catch (Exception e) {
            LOG.error(e);
        }

    }

    @RequestMapping(value = "/checkout/noaddress", method = RequestMethod.POST)
    public String processCompleteCheckoutOrderFinalizedNoBilling(HttpServletRequest request, RedirectAttributes redirectAttributes) throws PaymentException {
    	
    	// find the order number, set blank address and free shipping option
    	//update blc_fulfillment_group set fulfillment_option_id=4, address_id=1 where order_Id=1

        Order cart = CartState.getCart();

        if (cart != null && !(cart instanceof NullOrderImpl)) {
            try {
            	// The following will fail if the order amount > 0, as no payment info is made for the order,
            	// that can possibly be fixed by a record in blc_order_payment with "Passthrough"
                String orderNumber = initiateCheckout(cart.getId());

                //Log.info("Hey I am processing this order:"+orderNumber+" cartID is "+cart.getId()+" ordernumber"+cart.getOrderNumber());
                String flightNumber = DaoUtil.getFlightNumberFromRequest(request);

                Dao u = new DaoImpl();
                u.insertBlankAddressToOrder(cart.getId());
                
                LOG.info("inside checkout, flight is: "+flightNumber);
                if (flightNumber!=null) {
                	u.saveFlightInfoForOrder(cart.getCustomer().getId(),flightNumber,cart.getOrderNumber());
                }
                
                // odd that the SendOrderConfirmationEmailActivity went too early! before I can save the flight info for order
                sendConfirmationEmail(cart);

                return getConfirmationViewRedirect(orderNumber);

            } catch (Exception e) {
                handleProcessingException(e, redirectAttributes);
            }
        }

        return getCheckoutPageRedirect();
    }
    
    @RequestMapping(value = "/checkout/cod/complete", method = RequestMethod.POST)
    public String processPassthroughCheckout(RedirectAttributes redirectAttributes)
            throws PaymentException, PricingException {
        return super.processPassthroughCheckout(redirectAttributes, PaymentType.COD);
    }

    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        super.initBinder(request, binder);
    }
    
	@RequestMapping(value = "/checkout/mealorderreview")
	public ModelAndView doOrderReview(HttpServletRequest request, HttpServletResponse response) {

        Order cart = CartState.getCart();
        
        BillingInfo b = null;
        
        if (request.getParameter("ccNumber")!=null) {
        	b = new BillingInfo();
	        b.setBillingAddress1(request.getParameter("billingAddress1"));
	        b.setBillingAddress2(request.getParameter("billingAddress2"));
	        b.setBillingEmail(request.getParameter("billingEmail"));
	        b.setBillingPhone(request.getParameter("billingPhone"));
	        b.setBillingFirstName(request.getParameter("billingFirstName"));
	        b.setBillingLastName(request.getParameter("billingLastName"));
	        b.setCcMonth(request.getParameter("ccExpMonth"));
	        b.setCcYear(request.getParameter("ccExpYear"));
	        b.setCcNumber(request.getParameter("ccNumber"));
        
			LOG.info("Payment Info in review");
			LOG.info("=============");
			LOG.info("Billing first name:"+b.getBillingFirstName());
			LOG.info("Billing last name:"+b.getBillingLastName());
			LOG.info("Billing email:"+b.getBillingEmail());
			LOG.info("Billing Phone:"+b.getBillingPhone());
			LOG.info("Billing billingAddress1:"+b.getBillingAddress1());
			LOG.info("Billing billingAddress2:"+b.getBillingAddress2());
			LOG.info("ccNumber:"+b.getCcNumber());
			LOG.info("ccExpMonth:"+b.getCcMonth());
			LOG.info("ccExpYear:"+b.getCcYear());
        }
		
		ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("pops/orderreview");
    	modelAndView.addObject("payment",b);
    	modelAndView.addObject("shipping",null); // <-TODO: are we collecting shipping address 
    	modelAndView.addObject("cart",cart);
    	return modelAndView;

	}
	
	@RequestMapping(value = "/checkout/savepaymentinfo")
	public ModelAndView doSavePaymentInfo(HttpServletRequest request, HttpServletResponse response) {
		//TODO: complete this method to store info in the right place


		
		return doOrderReview(request,response);

	}	
}