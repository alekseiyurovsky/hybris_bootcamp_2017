<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="pagination" tagdir="/WEB-INF/tags/responsive/nav/pagination" %>

<c:set var="searchUrl" value="/assisted-service-querying/listCustomers?sort=${searchPageData.pagination.sort}&customerListUId=${defaultList}"/>
<c:set var="baseUrl" value="/assisted-service-querying/listCustomers"/>
<spring:url value="/assisted-service/emulate/?customerId=" var="emulateCustomerUrl"/>
<spring:url value="${baseUrl}" var="sortUrl" htmlEscape="true"><spring:param name="customerListUId" value="${defaultList}"/><spring:param name="sort" value=""/></spring:url>

<div class="account-section">
    <c:if test="${empty searchPageData || empty searchPageData.results}">
        <div class="account-section-content	col-md-6 col-md-push-3 content-empty">
            <ycommerce:testId code="orderHistory_noOrders_label">
                <spring:theme code="text.asm.customerList.noCustomers" />
            </ycommerce:testId>
        </div>
    </c:if>
    <c:if test="${not empty searchPageData.results}">
        <div class="account-section-content	">
            <div class="account-orderhistory">
                <div class="account-orderhistory-pagination js-customer-list-sorting" data-sort-url="${sortUrl}">
                    <nav:pagination top="true" msgKey="text.account.customerList.page" showCurrentPageInfo="true" hideRefineButton="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}" searchUrl="${searchUrl}"  numberPagesShown="${numberPagesShown}"/>
                </div>
                <div class="account-overview-table">
                    <table class="table techne-table">
                        <thead>
                            <tr>
                            <th></th>
                            <th><spring:theme code="text.asm.customerList.name" /></th>
                            <th><spring:theme code="text.asm.customerList.email" /></th>
                            <th><spring:theme code="text.asm.customerList.phone" /></th>
                            <th><spring:theme code="text.asm.customerList.cart" /></th>
                            <th><spring:theme code="text.asm.customerList.orders" /></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${searchPageData.results}" var="customer">
                                <tr class="techne-table-xs-left">
                                <ycommerce:testId code="orderHistoryItem_orderDetails_link">
                                    <td class="techne-table-xs-left-slot">
                                    <c:choose>
                                        <c:when test="${not empty customer.profilePicture}">
                                            <a href="${emulateCustomerUrl}${customer.uid}" class="responsive-table-link">
                                            <img src="${customer.profilePicture.url}" class="img-circle img-profile-thumbnail" title="<spring:theme code="text.asm.customerList.picture.alt" />"/>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${emulateCustomerUrl}${customer.uid}" class="responsive-table-link default-pic" title="<spring:theme code="text.asm.customerList.picture.alt"/>">
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td data-th="<spring:theme code="text.asm.customerList.name" />" >
                                    <a href="${emulateCustomerUrl}${customer.uid}" class="responsive-table-link">
                                    ${customer.name}
                                    </a>
                                    </td>
                                    <td data-th="<spring:theme code="text.asm.customerList.email" />" >
                                    ${customer.displayUid}
                                    </td>
                                    <td data-th="<spring:theme code="text.asm.customerList.phone" />" >
                                    <c:choose>
                                        <c:when test="${(not empty customer.defaultAddress) && (not empty customer.defaultAddress.phone)}">
                                            ${customer.defaultAddress.phone}
                                        </c:when>
                                        <c:otherwise>
                                            <spring:theme code="text.asm.customerList.phone.empty" />
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td data-th="<spring:theme code="text.asm.customerList.cart" />" >
                                    <c:choose>
                                        <c:when test="${null != customer.latestCartId}">
                                            <spring:url value="/assisted-service/emulate/" var="cartEmulationUrl" htmlEscape="true">
                                                <spring:param name="customerId" value="${customer.uid}"/>
                                                <spring:param name="cartId" value="${customer.latestCartId}"/>
                                            </spring:url>
                                            <a href="${cartEmulationUrl}" class="responsive-table-link" title="<spring:theme code="text.asm.customerList.viewCarts"/>">
                                            <div class="asm-full-card-icon asm-card-icon">
                                            <span class="glyphicon glyphicon-shopping-cart"></span>
                                            </div>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="asm-empty-card-icon asm-card-icon">
                                            <span class="glyphicon glyphicon-shopping-cart" title="<spring:theme code="text.asm.customerList.carts.empty" />"></span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td data-th="<spring:theme code="text.asm.customerList.orders" />" >
                                    <a href="${emulateCustomerUrl}${customer.uid}&fwd=${frowardUrl}" class="responsive-table-link">
                                    <div class="nav-order-tools" title="<spring:theme code="text.asm.customerList.viewOrders" />"></div>
                                    </a>
                                    </td>
                                </ycommerce:testId>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>