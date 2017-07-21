<%@ taglib prefix="asm" tagdir="/WEB-INF/tags/addons/assistedservicestorefront/asm"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="asm__section">
    <c:forEach items="${section.fragments}" var="fragment">
		<asm:fragment id="${fragment.id}" title="${fragment.title}" sectionId="${section.id}"/>
	</c:forEach>
</div>
