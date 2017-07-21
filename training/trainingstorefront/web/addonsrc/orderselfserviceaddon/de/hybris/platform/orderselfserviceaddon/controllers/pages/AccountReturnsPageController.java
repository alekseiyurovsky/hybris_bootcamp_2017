/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2016 SAP SE or an SAP affiliate company.
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package de.hybris.platform.orderselfserviceaddon.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.Breadcrumb;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.ResourceBreadcrumbBuilder;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.ThirdPartyConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractSearchPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commerceservices.search.pagedata.PageableData;
import de.hybris.platform.commerceservices.search.pagedata.SearchPageData;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.ordermanagementfacade.returns.OmsReturnFacade;
import de.hybris.platform.ordermanagementfacade.returns.data.ReturnEntryData;
import de.hybris.platform.ordermanagementfacade.returns.data.ReturnRequestData;
import de.hybris.platform.product.ProductService;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.platform.servicelayer.exceptions.UnknownIdentifierException;

import javax.annotation.Resource;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Controller for return order pages
 */
@Controller
@RequestMapping(value = "/my-account/returns")
public class AccountReturnsPageController extends AbstractSearchPageController
{
	public static final Logger LOG = Logger.getLogger(AccountReturnsPageController.class);
	private static final String BREADCRUMBS_ATTR = "breadcrumbs";
	public static final String MY_ACCOUNT_RETURNS_PAGE = "returns";
	public static final String TEXT_ACCOUNT_RETURNS_HISTORY = "text.account.returnHistory";
	private static final String REDIRECT_TO_RETURNS_HISTORY_PAGE = REDIRECT_PREFIX + "/my-account/returns";
	private static final String RETURN_REQUEST_DETAILS_CMS_PAGE = "return-request-details";

	@Resource(name = "omsReturnFacade")
	private OmsReturnFacade omsReturnFacade;

	@Resource(name = "accountBreadcrumbBuilder")
	private ResourceBreadcrumbBuilder accountBreadcrumbBuilder;

	@Resource(name = "productConverter")
	private Converter<ProductModel, ProductData> productConverter;

	@Resource(name = "productService")
	private ProductService productService;

	/**
	 * Lists all return requests
	 *
	 * @param pageNumber
	 * @param showMode
	 * @param sortCode
	 * @param model
	 * @return View String
	 * @throws CMSItemNotFoundException
	 */
	@RequestMapping(method = RequestMethod.GET)
	@RequireHardLogIn
	public String getMyReturnRequests(@RequestParam(value = "page", defaultValue = "0") final int pageNumber,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode, final Model model) throws CMSItemNotFoundException
	{
		storeCmsPageInModel(model, getContentPageForLabelOrId(MY_ACCOUNT_RETURNS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MY_ACCOUNT_RETURNS_PAGE));
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, accountBreadcrumbBuilder.getBreadcrumbs(TEXT_ACCOUNT_RETURNS_HISTORY));
		model.addAttribute(ThirdPartyConstants.SeoRobots.META_ROBOTS, ThirdPartyConstants.SeoRobots.NOINDEX_NOFOLLOW);

		final PageableData pageableData = createPageableData(pageNumber, 5, sortCode, showMode);
		final SearchPageData<ReturnRequestData> searchPageData = omsReturnFacade.getPagedReturnRequestsByCurrentUser(pageableData);

		populateModel(model, searchPageData, showMode);

		return getViewForPage(model);
	}

	@RequireHardLogIn
	@RequestMapping(value = "/{returnRequestCode:.*}", method = { RequestMethod.POST, RequestMethod.GET })
	public String showReturnRequestDetailsPage(@PathVariable(value = "returnRequestCode") final String returnRequestCode, final Model model,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException // NOSONAR
	{
		try
		{
			ReturnRequestData returnRequestDetails = omsReturnFacade.getReturnForReturnCode(returnRequestCode);

			for (ReturnEntryData returnEntryData : returnRequestDetails.getReturnEntries())
			{
				ProductModel product = productService.getProductForCode(returnEntryData.getOrderEntry().getProduct().getCode());
				ProductData productData = productConverter.convert(product);
				returnEntryData.getOrderEntry().setProduct(productData);
			}

			model.addAttribute("returnRequestData", returnRequestDetails);

			final List<Breadcrumb> breadcrumbs = accountBreadcrumbBuilder.getBreadcrumbs(null);
			breadcrumbs.add(new Breadcrumb("/my-account/returns",
					getMessageSource().getMessage(TEXT_ACCOUNT_RETURNS_HISTORY, null, getI18nService().getCurrentLocale()), null));
			breadcrumbs.add(new Breadcrumb("#", getMessageSource()
					.getMessage("text.account.returns.returnBreadcrumb", new Object[] { returnRequestDetails.getRma() }, "Return Request {0}",
							getI18nService().getCurrentLocale()), null));
			model.addAttribute(BREADCRUMBS_ATTR, breadcrumbs);

		}
		catch (final UnknownIdentifierException e)
		{
			LOG.warn("Attempted to load a return request that does not exist or is not visible");
			GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER, "system.error.page.not.found", null);
			return REDIRECT_TO_RETURNS_HISTORY_PAGE;
		}
		storeCmsPageInModel(model, getContentPageForLabelOrId(RETURN_REQUEST_DETAILS_CMS_PAGE));
		model.addAttribute(ThirdPartyConstants.SeoRobots.META_ROBOTS, ThirdPartyConstants.SeoRobots.NOINDEX_NOFOLLOW);
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(RETURN_REQUEST_DETAILS_CMS_PAGE));
		return getViewForPage(model);
	}
}
