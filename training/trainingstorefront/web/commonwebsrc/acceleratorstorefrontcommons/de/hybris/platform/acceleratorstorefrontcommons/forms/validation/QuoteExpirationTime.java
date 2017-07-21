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
package de.hybris.platform.acceleratorstorefrontcommons.forms.validation;

import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;

import javax.validation.Constraint;
import javax.validation.Payload;

/**
 * Quote expiration time validation constraint
 */
@Retention(RUNTIME)
@Constraint(validatedBy = QuoteExpirationTimeValidator.class)
@Documented
public @interface QuoteExpirationTime
{
	String message();

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};
}
