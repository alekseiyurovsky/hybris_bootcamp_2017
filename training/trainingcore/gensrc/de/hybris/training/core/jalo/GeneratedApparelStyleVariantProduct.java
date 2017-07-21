/*
 * ----------------------------------------------------------------
 * --- WARNING: THIS FILE IS GENERATED AND WILL BE OVERWRITTEN! ---
 * --- Generated at Jul 21, 2017 12:52:25 PM                    ---
 * ----------------------------------------------------------------
 *  
 * [y] hybris Platform
 *  
 * Copyright (c) 2000-2016 SAP SE
 * All rights reserved.
 *  
 * This software is the confidential and proprietary information of SAP
 * Hybris ("Confidential Information"). You shall not disclose such
 * Confidential Information and shall use it only in accordance with the
 * terms of the license agreement you entered into with SAP Hybris.
 *  
 */
package de.hybris.training.core.jalo;

import de.hybris.platform.jalo.Item.AttributeMode;
import de.hybris.platform.jalo.JaloInvalidParameterException;
import de.hybris.platform.jalo.SessionContext;
import de.hybris.platform.jalo.c2l.C2LManager;
import de.hybris.platform.jalo.c2l.Language;
import de.hybris.platform.jalo.enumeration.EnumerationValue;
import de.hybris.platform.variants.jalo.VariantProduct;
import de.hybris.training.core.constants.TrainingCoreConstants;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Generated class for type {@link de.hybris.training.core.jalo.ApparelStyleVariantProduct ApparelStyleVariantProduct}.
 */
@SuppressWarnings({"deprecation","unused","cast","PMD"})
public abstract class GeneratedApparelStyleVariantProduct extends VariantProduct
{
	/** Qualifier of the <code>ApparelStyleVariantProduct.style</code> attribute **/
	public static final String STYLE = "style";
	/** Qualifier of the <code>ApparelStyleVariantProduct.swatchColors</code> attribute **/
	public static final String SWATCHCOLORS = "swatchColors";
	protected static final Map<String, AttributeMode> DEFAULT_INITIAL_ATTRIBUTES;
	static
	{
		final Map<String, AttributeMode> tmp = new HashMap<String, AttributeMode>(VariantProduct.DEFAULT_INITIAL_ATTRIBUTES);
		tmp.put(STYLE, AttributeMode.INITIAL);
		tmp.put(SWATCHCOLORS, AttributeMode.INITIAL);
		DEFAULT_INITIAL_ATTRIBUTES = Collections.unmodifiableMap(tmp);
	}
	@Override
	protected Map<String, AttributeMode> getDefaultAttributeModes()
	{
		return DEFAULT_INITIAL_ATTRIBUTES;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.style</code> attribute.
	 * @return the style - Color/Pattern of the product.
	 */
	public String getStyle(final SessionContext ctx)
	{
		if( ctx == null || ctx.getLanguage() == null )
		{
			throw new JaloInvalidParameterException("GeneratedApparelStyleVariantProduct.getStyle requires a session language", 0 );
		}
		return (String)getLocalizedProperty( ctx, STYLE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.style</code> attribute.
	 * @return the style - Color/Pattern of the product.
	 */
	public String getStyle()
	{
		return getStyle( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @return the localized style - Color/Pattern of the product.
	 */
	public Map<Language,String> getAllStyle(final SessionContext ctx)
	{
		return (Map<Language,String>)getAllLocalizedProperties(ctx,STYLE,C2LManager.getInstance().getAllLanguages());
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @return the localized style - Color/Pattern of the product.
	 */
	public Map<Language,String> getAllStyle()
	{
		return getAllStyle( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @param value the style - Color/Pattern of the product.
	 */
	public void setStyle(final SessionContext ctx, final String value)
	{
		if( ctx == null || ctx.getLanguage() == null )
		{
			throw new JaloInvalidParameterException("GeneratedApparelStyleVariantProduct.setStyle requires a session language", 0 );
		}
		setLocalizedProperty(ctx, STYLE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @param value the style - Color/Pattern of the product.
	 */
	public void setStyle(final String value)
	{
		setStyle( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @param value the style - Color/Pattern of the product.
	 */
	public void setAllStyle(final SessionContext ctx, final Map<Language,String> value)
	{
		setAllLocalizedProperties(ctx,STYLE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.style</code> attribute. 
	 * @param value the style - Color/Pattern of the product.
	 */
	public void setAllStyle(final Map<Language,String> value)
	{
		setAllStyle( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.swatchColors</code> attribute.
	 * @return the swatchColors - A normalized color mapping to a standardized front-end navigable name.
	 */
	public Set<EnumerationValue> getSwatchColors(final SessionContext ctx)
	{
		Set<EnumerationValue> coll = (Set<EnumerationValue>)getProperty( ctx, SWATCHCOLORS);
		return coll != null ? coll : Collections.EMPTY_SET;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>ApparelStyleVariantProduct.swatchColors</code> attribute.
	 * @return the swatchColors - A normalized color mapping to a standardized front-end navigable name.
	 */
	public Set<EnumerationValue> getSwatchColors()
	{
		return getSwatchColors( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.swatchColors</code> attribute. 
	 * @param value the swatchColors - A normalized color mapping to a standardized front-end navigable name.
	 */
	public void setSwatchColors(final SessionContext ctx, final Set<EnumerationValue> value)
	{
		setProperty(ctx, SWATCHCOLORS,value == null || !value.isEmpty() ? value : null );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>ApparelStyleVariantProduct.swatchColors</code> attribute. 
	 * @param value the swatchColors - A normalized color mapping to a standardized front-end navigable name.
	 */
	public void setSwatchColors(final Set<EnumerationValue> value)
	{
		setSwatchColors( getSession().getSessionContext(), value );
	}
	
}
