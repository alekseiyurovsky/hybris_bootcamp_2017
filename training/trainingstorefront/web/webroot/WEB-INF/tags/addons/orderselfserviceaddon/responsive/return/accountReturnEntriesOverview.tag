<%@ attribute name="returnRequest" required="true"
              type="de.hybris.platform.ordermanagementfacade.returns.data.ReturnRequestData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<ul class="item__list cart__list return__list">

    <li class="hidden-xs hidden-sm">
        <ul class="item__list--header">
            <li class="item__toggle"></li>
            <li class="item__image"></li>
            <li class="item__info"><spring:theme code="basket.page.item"/></li>
            <li class="item__price"><spring:theme code="basket.page.price"/></li>
            <li class="item__quantity"><spring:theme code="text.account.return.details.qty"/></li>
            <li class="item__price"><spring:theme code="text.account.return.details.refund.amount"/></li>
        </ul>
    </li>

    <c:forEach items="${returnRequest.returnEntries}" var="entry" varStatus="loop">
        <li class="item__list--item">

            <%-- chevron for multi-d products --%>
            <div class="hidden-xs hidden-sm item__toggle">
                <c:if test="${entry.orderEntry.product.multidimensional}">
                    <div class="js-show-editable-grid" data-index="${loop.index}"
                            data-read-only-multid-grid="${not entry.updateable}">
                        <ycommerce:testId code="confirmCancel_product_updateQuantity">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </ycommerce:testId>

                    </div>
                </c:if>
            </div>
                <%-- product image --%>
            <div class="item__image">
                <product:productPrimaryImage product="${entry.orderEntry.product}" format="thumbnail"/>
            </div>

                <%-- product name, code, promotions --%>
            <div class="item__info">
                <ycommerce:testId code="return_product_name">
                    <span class="item__name">${fn:escapeXml(entry.orderEntry.product.name)}</span>
                </ycommerce:testId>

                <div class="item__code">${fn:escapeXml(entry.orderEntry.product.code)}</div>

                <c:if test="${entry.orderEntry.product.configurable}">
                    <div class="item__configurations">
                        <c:forEach var="config" items="${entry.orderEntry.configurationInfos}">
                            <c:set var="style" value=""/>
                            <c:if test="${config.status eq errorStatus}">
                                <c:set var="style" value="color:red"/>
                            </c:if>
                            <div class="item__configuration-entry row" style="${style}">
                                <div class="item__configuration-name col-md-4">${fn:escapeXml(config.configurationLabel)}:</div>
                                <div class="item__configuration-value col-md-8">${fn:escapeXml(config.configurationValue)}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <c:if test="${not empty entry.orderEntry.configurationInfos}">
                        <div class="item__configurations-edit">
                            <spring:theme code="basket.page.change.configuration"/>
                        </div>
                    </c:if>
                </c:if>
            </div>
                <%-- price --%>
            <div class="item__price">
                <span class="visible-xs visible-sm"><spring:theme code="basket.page.itemPrice"/>: </span>
                <format:price priceData="${entry.orderEntry.basePrice}" displayFreeForZero="true"/>
            </div>

                <%-- returned quantity --%>
            <div class="item__quantity">
                <div class="item__quantity-wrapper">
                    <label class="visible-xs visible-sm"><spring:theme code="text.account.return.details.qty"/>:</label>
                    <span class="qtyValue"><c:out value="${entry.expectedQuantity}"/></span>
                </div>
            </div>

                <%-- refund amount --%>
            <div class="item__price">
                <span class="visible-xs visible-sm"><spring:theme code="text.account.return.details.refund.amount"/>: </span>
                <format:price priceData="${entry.refundAmount}" displayFreeForZero="true"/>
            </div>
        </li>

        <li>
            <div class="add-to-cart-order-form-wrap display-none"></div>
        </li>
    </c:forEach>

</ul>
