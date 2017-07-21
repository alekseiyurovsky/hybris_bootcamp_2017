/*
 * [y] hybris Platform
 *
 * Copyright (c) 2017 SAP SE or an SAP affiliate company.  All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package de.hybris.platform.acceleratorstorefrontcommons.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Strategy for automatic login of a user after registration
 */
public interface AutoLoginStrategy
{
	/**
	 * Login a user
	 * 
	 * @param username
	 * @param password
	 * @param request
	 * @param response
	 */
	void login(String username, String password, HttpServletRequest request, HttpServletResponse response);
}
