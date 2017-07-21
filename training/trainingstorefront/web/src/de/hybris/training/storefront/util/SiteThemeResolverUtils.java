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
package de.hybris.training.storefront.util;

import de.hybris.platform.acceleratorservices.uiexperience.UiExperienceService;
import de.hybris.platform.cms2.model.site.CMSSiteModel;
import de.hybris.platform.cms2.servicelayer.services.CMSSiteService;
import de.hybris.platform.commerceservices.enums.SiteTheme;
import de.hybris.platform.commerceservices.enums.UiExperienceLevel;
import org.springframework.beans.factory.annotation.Required;


public class SiteThemeResolverUtils
{
	private CMSSiteService cmsSiteService;
	private UiExperienceService uiExperienceService;
	private String defaultTheme;

	public String resolveThemeForCurrentSite()
	{
		final UiExperienceLevel uiExperienceLevel = getUiExperienceService().getUiExperienceLevel();

		// Resolve Theme from CMSSiteService
		final CMSSiteModel currentSite = getCmsSiteService().getCurrentSite();
		if (currentSite != null)
		{
			return combineSiteAndTheme(uiExperienceLevel.getCode(), currentSite.getUid(), getThemeNameForSite(currentSite));
		}
		return null;
	}

	protected String getThemeNameForSite(final CMSSiteModel site)
	{
		final SiteTheme theme = site.getTheme();
		if (theme != null)
		{
			final String themeCode = theme.getCode();
			if (themeCode != null && !themeCode.isEmpty())
			{
				return themeCode;
			}
		}
		return getDefaultTheme();
	}

	protected String combineSiteAndTheme(final String uiExperienceLevel, final String siteUid, final String themeName)
	{
		return uiExperienceLevel + "," + siteUid + "," + themeName;
	}

	/**
	 * @return the cmsSiteService
	 */
	protected CMSSiteService getCmsSiteService()
	{
		return cmsSiteService;
	}

	/**
	 * @param cmsSiteService the CMSSiteService to set
	 */
	@Required public void setCmsSiteService(final CMSSiteService cmsSiteService)
	{
		this.cmsSiteService = cmsSiteService;
	}

	protected UiExperienceService getUiExperienceService()
	{
		return uiExperienceService;
	}

	@Required public void setUiExperienceService(final UiExperienceService uiExperienceService)
	{
		this.uiExperienceService = uiExperienceService;
	}

	public String getDefaultTheme()
	{
		return defaultTheme;
	}

	@Required public void setDefaultTheme(String defaultTheme)
	{
		this.defaultTheme = defaultTheme;
	}
}
