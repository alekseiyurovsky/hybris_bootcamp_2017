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
package de.hybris.platform.acceleratorstorefrontcommons.strategy;

import javax.servlet.http.HttpServletRequest;


/**
 * Strategy for cart restoration.
 *
 */
public interface CartRestorationStrategy
{

	/**
	 * Restore cart.
	 *
	 * @param request
	 *           the request
	 */
	void restoreCart(final HttpServletRequest request);
}
