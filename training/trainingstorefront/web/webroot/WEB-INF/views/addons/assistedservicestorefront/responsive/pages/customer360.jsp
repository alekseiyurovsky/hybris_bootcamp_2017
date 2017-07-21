<%@ taglib prefix="asm" tagdir="/WEB-INF/tags/addons/assistedservicestorefront/asm"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Terminal+Dosis">
<link rel="stylesheet" type="text/css" media="all" href="/yacceleratorstorefront/_ui/addons/assistedservicestorefront/responsive/common/css/customer360.css">

<div class="asm__customer360">
    
    <asm:fragment id="headingFragment" />

    <ul class="nav nav-tabs nav-tabs--responsive asm__customer360__menu" role="tablist" id="customer-360-tabs">
        <c:forEach items="${sections}" var="section" varStatus="loop">
            <li role="presentation" value="${section.id}">
                <a href="#${section.id}" role="tab" data-toggle="tab"><spring:theme code="${section.title}" /></a>
            </li>
        </c:forEach>
        <li class="nav-tabs-mobile-caret" data-toggle="dropdown">
            <a class="pull-right" href="#"><span class="caret"></span></a>
        </li>
    </ul>

    <div id="section" class="tab-content">
         <div id="longLoadExample">
             <div class="loader">Loading..</div>
         </div>
         <div id="sectionPlaceholder" class="tab-content"></div>
    </div>
    <script>asmAifSectionClickHandler(); aifSelectLastSection();</script>
</div>