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
package de.hybris.platform.acceleratorstorefrontcommons.security.impl;

import de.hybris.platform.acceleratorstorefrontcommons.security.BruteForceAttackCounter;

import java.util.Date;
import java.util.Iterator;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.util.Assert;


/**
 * Default implementation of {@link BruteForceAttackCounter}
 */
public class DefaultBruteForceAttackCounter implements BruteForceAttackCounter
{
	private static final Logger LOG = Logger.getLogger(DefaultBruteForceAttackCounter.class);//NOPMD

	private final ConcurrentHashMap<String, LoginFailure> bruteForceAttackCache;
	private final Integer maxFailedLogins;
	private final Integer cacheSizeLimit;
	private final Integer cacheExpiration;

	public DefaultBruteForceAttackCounter(final Integer maxFailedLogins, final Integer cacheExpiration,
			final Integer cacheSizeLimit)
	{
		Assert.notNull(maxFailedLogins, "Constructor param maxFailedLogins must not be null.");
		Assert.notNull(cacheExpiration, "Constructor param cacheExpiration must not be null.");
		Assert.notNull(cacheSizeLimit, "Constructor param cacheSizeLimit must not be null.");

		bruteForceAttackCache = new ConcurrentHashMap((int) 0.5 * cacheSizeLimit.intValue());
		this.maxFailedLogins = maxFailedLogins;
		this.cacheSizeLimit = cacheSizeLimit;
		this.cacheExpiration = cacheExpiration;
	}

	@Override
	public void registerLoginFailure(final String userUid)
	{
		if (StringUtils.isNotEmpty(userUid))
		{
			final LoginFailure count = get(prepareUserUid(userUid), Integer.valueOf(0));
			count.setCounter(Integer.valueOf(Math.min(count.getCounter().intValue() + 1, maxFailedLogins.intValue() + 1)));
			count.setDate(new Date());
			bruteForceAttackCache.put(prepareUserUid(userUid), count);
			if (LOG.isDebugEnabled())
			{
				LOG.debug("Failed Login for user " + userUid + ", count now " + count.getCounter());
			}
		}
	}


	@Override
	public boolean isAttack(final String userUid)
	{
		if (StringUtils.isNotEmpty(userUid))
		{
			return maxFailedLogins.compareTo(get(prepareUserUid(userUid), Integer.valueOf(0)).getCounter()) <= 0;
		}
		else
		{
			return false;
		}
	}

	@Override
	public void resetUserCounter(final String userUid)
	{
		if (StringUtils.isNotEmpty(userUid))
		{
			bruteForceAttackCache.remove(prepareUserUid(userUid));
		}
	}

	@Override
	public int getUserFailedLogins(final String userUid)
	{
		if (StringUtils.isNotEmpty(userUid))
		{
			return get(prepareUserUid(userUid), Integer.valueOf(0)).getCounter().intValue();
		}
		else
		{
			return 0;
		}
	}


	protected LoginFailure get(final String userUid, final Integer startValue)
	{
		LoginFailure value = bruteForceAttackCache.get(prepareUserUid(userUid));
		if (value == null)
		{
			value = new LoginFailure(startValue, new Date());
			bruteForceAttackCache.put(prepareUserUid(userUid), value);
			if (bruteForceAttackCache.size() > cacheSizeLimit.intValue())
			{
				evict();
			}
		}
		return value;
	}


	protected String prepareUserUid(final String userUid)
	{
		return StringUtils.lowerCase(userUid);
	}


	protected void evict()
	{
		if (bruteForceAttackCache.size() > cacheSizeLimit.intValue())
		{
			final Iterator<String> cacheIterator = bruteForceAttackCache.keySet().iterator();
			final Date dateLimit = DateUtils.addMinutes(new Date(), 0 - cacheExpiration.intValue());
			while (cacheIterator.hasNext())
			{
				final String userKey = cacheIterator.next();
				final LoginFailure value = bruteForceAttackCache.get(userKey);
				if (value.getDate().before(dateLimit))
				{
					bruteForceAttackCache.remove(userKey);
				}
			}
		}
	}


	public class LoginFailure
	{
		private Integer counter;
		private Date date;

		public LoginFailure()
		{
			this.counter = Integer.valueOf(0);
			this.date = new Date();
		}

		public LoginFailure(final Integer counter, final Date date)
		{
			this.counter = counter;
			this.date = date;
		}

		public Integer getCounter()
		{
			return counter;
		}

		public void setCounter(final Integer counter)
		{
			this.counter = counter;
		}

		public Date getDate()
		{
			return date;
		}

		public void setDate(final Date date)
		{
			this.date = date;
		}
	}
}
