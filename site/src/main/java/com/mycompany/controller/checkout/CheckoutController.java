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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.mycompany.pops.Dao;
import com.mycompany.pops.DaoImpl;

@Controller
public class CheckoutController extends BroadleafCheckoutController {

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

    @RequestMapping(value = "/checkout/noaddress", method = RequestMethod.POST)
    public String processCompleteCheckoutOrderFinalizedNoBilling(RedirectAttributes redirectAttributes) throws PaymentException {
    	// find the order number, set blank address and free shipping option
    	//update blc_fulfillment_group set fulfillment_option_id=4, address_id=1 where order_Id=1

        Order cart = CartState.getCart();

        if (cart != null && !(cart instanceof NullOrderImpl)) {
            try {
                String orderNumber = initiateCheckout(cart.getId());
                //Log.info("Hey I am processing this order:"+orderNumber+" cartID is "+cart.getId()+" ordernumber"+cart.getOrderNumber());
                Dao u = new DaoImpl();
                u.insertBlankAddressToOrder(cart.getId());
                
                
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
        
		ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("pops/orderreview");
    	modelAndView.addObject("payment",null);
    	modelAndView.addObject("shipping",null);
    	modelAndView.addObject("cart",cart);
    	return modelAndView;

	}
}
