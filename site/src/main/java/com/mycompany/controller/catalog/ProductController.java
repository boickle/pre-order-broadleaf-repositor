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

package com.mycompany.controller.catalog;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.broadleafcommerce.common.currency.domain.BroadleafCurrency;
import org.broadleafcommerce.common.locale.domain.Locale;
import org.broadleafcommerce.core.catalog.domain.Product;
import org.broadleafcommerce.core.web.catalog.ProductHandlerMapping;
import org.broadleafcommerce.core.web.controller.catalog.BroadleafProductController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.pops.configuration.AppConfiguration;
import com.mycompany.pops.dao.Dao;
import com.mycompany.pops.pojo.Category;

/**
 * This class works in combination with the CategoryHandlerMapping which finds a category based upon
 * the passed in URL.
 */


@Controller("blProductController")
public class ProductController extends BroadleafProductController {
    
	protected static final Log LOG = LogFactory.getLog(ProductController.class);

	private final Dao dao;
	private final Integer PRIMARY_NAV;
	
	@Autowired
	public ProductController(
			Dao dao,
			AppConfiguration appConfiguration) {
		this.dao = dao;
		this.PRIMARY_NAV = appConfiguration.primaryNav();
	}
	
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

    @Override
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView m = super.handleRequest(request, response);
        
        Product product = (Product) request.getAttribute(ProductHandlerMapping.CURRENT_PRODUCT_ATTRIBUTE_NAME);
        long productID = product.getId();
        
        // [JMAK] Adding left-nav and breadcrumb
		String locale = getLocale(request);
		List<Category> l = dao.getCategories(PRIMARY_NAV, locale);
		
		m.addObject("breadcrumb", dao.getBreadCrumbForProduct(productID,locale));
		m.addObject("categories", l);
        return m;
    }

}
