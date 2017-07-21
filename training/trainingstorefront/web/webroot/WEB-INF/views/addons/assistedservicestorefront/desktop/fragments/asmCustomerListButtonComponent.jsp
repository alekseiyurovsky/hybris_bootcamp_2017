<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url value="/assisted-service-querying/availableCustomerLists" var="listCustomersActionUrl" />

<a href="#"
       class="ASM-btn ASM-btn-customer-list element-separator-height js-customer-list-btn"
       id="product_1"
       data-actionurl="${listCustomersActionUrl}">
        <span class="ASM_icon ASM_icon-customer-list"></span>
</a>
<div class="hidden js-customer-list-modal-content-wrap"><div class="js-customer-list-modal-content"></div></div>