<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<div role="tabpanel" class="tab-pane" id="activitySection">
	<div class="pageable-fragment asm-customer360-tab">

		<div class="asm-customer360-activity-tab asm-customer360-promotions">
			<div class="clearfix">
				<h3>
					<spring:theme code="${text.customer360.couponHeading}"
						text="COUPONS" />
				</h3>
			</div>
			<c:choose>
				<c:when test="${empty fragmentData}">
					<div class="asm__customer360-noCoupons">
						<spring:message code="text.customer360.noCoupons"
							text="There are currently no CSA Discount Coupons available." />
					</div>

				</c:when>
				<c:otherwise>

					<c:forEach items="${fragmentData}" var="coupon">

						<div class="asm-customer360-promotions-item clearfix">
							<div class="asm-customer360-promotions-item-title">
								<spring:theme code="${coupon.code}" />
							</div>

							<c:choose>
								<c:when test="${coupon.couponApplied}">
									<div id="${coupon.code}show">
										<a href="" id="${coupon.code}"
											class="asm-customer360-promotions-removefromCart  js-add-to-cart js-enable-btn apply-to-cart-enabled disabled">
											<spring:theme code="${text.customer360.couponApplied}"
												text="Coupon Applied" /> <span
											class="asm-customer360-promotions-removefromCart-pipe">|</span>
											<span
											class="asm-customer360-promotions-removefromCart-remove">
												<spring:theme
													code="${text.customer360.removeCouponFromCart}"
													text="Remove" />
										</span>
										</a>
									</div>
									<div id="${coupon.code}hide" style="display: none">
										<a href="" id="${coupon.code}"
											class="asm-customer360-promotions-addToCart  js-add-to-cart js-enable-btn apply-to-cart-enabled">

											<spring:theme code="${text.customer360.applyCouponToCart}"
												text="Apply To Cart" />
										</a>
									</div>


								</c:when>
								<c:otherwise>
									<div id="${coupon.code}hide" style="display: none">
										<a href="" id="${coupon.code}"
											class="asm-customer360-promotions-removefromCart  js-add-to-cart js-enable-btn apply-to-cart-enabled disabled">

											<spring:theme code="${text.customer360.couponApplied}"
												text="Coupon Applied" /> <span
											class="asm-customer360-promotions-removefromCart-pipe">|</span>
											<span
											class="asm-customer360-promotions-removefromCart-remove">
												<spring:theme
													code="${text.customer360.removeCouponFromCart}"
													text="Remove" />
										</span>
										</a>
									</div>
									<div id="${coupon.code}show">
										<a href="" id="${coupon.code}"
											class="asm-customer360-promotions-addToCart  js-add-to-cart js-enable-btn apply-to-cart-enabled">

											<spring:theme code="${text.customer360.applyCouponToCart}"
												text="Apply To Cart" />
										</a>
									</div>

								</c:otherwise>

							</c:choose>

							<div class="asm-customer360-promotions-item-desc">
								<spring:theme code="${coupon.name}" />
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
