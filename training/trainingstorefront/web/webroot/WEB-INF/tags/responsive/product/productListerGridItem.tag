<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="action" tagdir="/WEB-INF/tags/responsive/action" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url value="${product.url}" var="productUrl"/>
<c:set value="${not empty product.potentialPromotions}" var="hasPromotion"/>
<div class="product-item">
	<ycommerce:testId code="product_wholeProduct">
		<a class="thumb" href="${productUrl}" title="${fn:escapeXml(product.name)}">
			<product:productPrimaryImage product="${product}" format="product"/>
		</a>
		<div class="details">

			<ycommerce:testId code="product_productName">
				<a class="name" href="${productUrl}">
					<c:choose>
						<c:when test="${fn:length(product.name) > 30}">
							<c:out value="${fn:substring(product.name, 0, 30)}..."/>
						</c:when>
						<c:otherwise>
							<c:out value="${product.name}" />
						</c:otherwise>	
					</c:choose>
				</a>
			</ycommerce:testId>
		
			<c:if test="${not empty product.potentialPromotions}">
				<div class="promo">
					<c:forEach items="${product.potentialPromotions}" var="promotion">
						${ycommerce:sanitizeHTML(promotion.description)}
					</c:forEach>
				</div>
			</c:if>
			
			<ycommerce:testId code="product_productPrice">
				<div class="price"><product:productListerItemPrice product="${product}"/></div>
			</ycommerce:testId>
			<c:forEach var="variantOption" items="${product.variantOptions}">
				<c:forEach items="${variantOption.variantOptionQualifiers}" var="variantOptionQualifier">
					<c:if test="${variantOptionQualifier.qualifier eq 'rollupProperty'}">
	                    <c:set var="rollupProperty" value="${variantOptionQualifier.value}"/>
	                </c:if>
					<c:if test="${variantOptionQualifier.qualifier eq 'thumbnail'}">
	                    <c:set var="imageUrl" value="${fn:escapeXml(variantOptionQualifier.value)}"/>
	                </c:if>
	                <c:if test="${variantOptionQualifier.qualifier eq rollupProperty}">
	                    <c:set var="variantName" value="${fn:escapeXml(variantOptionQualifier.value)}"/>
	                </c:if>
				</c:forEach>
				<img style="width: 32px; height: 32px;" src="${imageUrl}" title="${variantName}" alt="${variantName}"/>
			</c:forEach>
		</div>


		<c:set var="product" value="${product}" scope="request"/>
		<c:set var="addToCartText" value="${addToCartText}" scope="request"/>
		<c:set var="addToCartUrl" value="${addToCartUrl}" scope="request"/>
		<c:set var="isGrid" value="true" scope="request"/>
		<div class="addtocart">
			<div class="actions-container-for-${fn:escapeXml(component.uid)} <c:if test="${ycommerce:checkIfPickupEnabledForStore() and product.availableForPickup}"> pickup-in-store-available</c:if>">
				<action:actions element="div" parentComponent="${component}"/>
			</div>
		</div>
	</ycommerce:testId>
</div>