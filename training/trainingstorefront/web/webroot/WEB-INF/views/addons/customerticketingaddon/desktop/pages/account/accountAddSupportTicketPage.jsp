<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<spring:htmlEscape defaultHtmlEscape="true" />

<div class="span-24">
	<div class="span-20 last">
		<div class="accountContentPane clearfix">
			<div class="headline"><spring:theme code="text.account.supporttickets.createTicket.heading" text="Request Customer Support"/></div>
			<div class="required right"><spring:theme code="form.required" text="Fields marked * are required"/></div>
			
			<form:form method="post" commandName="supportTicketForm">
				<table>
					<tr>
						<td>
							<formElement:formInputBox idKey="text.account.supporttickets.createTicket.subject" labelKey="text.account.supporttickets.createTicket.subject" path="subject" inputCSS="text" mandatory="true"/>
						</td>
					</tr>
					<tr>
						<td>
							<spring:theme code="text.account.supporttickets.createTicket.subject.desc" text="Enter Subject"/>
						</td>
					</tr>
					<tr>
						<td>
							<formElement:formTextArea idKey="text.account.supporttickets.createTicket.message" labelKey="text.account.supporttickets.createTicket.message" path="message" mandatory="true"/>
						</td>
					</tr>
					<tr>
						<td>
							<spring:theme code="text.account.supporttickets.createTicket.message.desc" text="Enter Message"/>
						</td>
					</tr>
					
					<!-- Associated Objects -->
					<c:if test="${not empty associatedObjects}">
						<tr>
							<td>
								<div class="control-group">
									<label class="control-group" for="text.account.supporttickets.createTicket.associatedTo.option1"> <spring:theme code="text.account.supporttickets.createTicket.associatedTo" text="Associated To"/></label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="control-group">
									<form:select path="associatedTo">
										<option><spring:theme code="text.account.supporttickets.createTicket.associatedTo.option1" text="Please select"></spring:theme></option>
										<c:forEach var="associatedMap" items="${associatedObjects}">
											<c:forEach var="associatedItem" items="${associatedMap.value}">
											<form:option value="${associatedMap.key}=${associatedItem.code}">${associatedMap.key}: ${associatedItem.code}; Updated: <fmt:formatDate pattern="dd/MM/yy" value="${associatedItem.modifiedtime}"/> </form:option>
											</c:forEach>
										</c:forEach>
									</form:select>
								</div>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty categories }">
						<tr>
							<td>
								<div class="control-group">
									<label class="control-group" for="text.account.supporttickets.createTicket.ticketCategory"> <spring:theme code="text.account.supporttickets.createTicket.ticketCategory" text="Category"/></label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="control-group">
									<form:select path="ticketCategory" >
										<c:forEach var="category" items="${categories}">
											<form:option value="${category}"><spring:message code="text.account.supporttickets.createTicket.ticketCategory.${category}"/></form:option>
										</c:forEach>
									</form:select>
								</div>
							</td>
						</tr>
					</c:if>
				</table>
				
				<div id="addressform_button_panel" class="form-actions">
					<ycommerce:testId code="supportTicket_create_button">
						<button class="positive right" type="submit">
							<spring:theme code="text.account.supporttickets.createTicket.submit" text="Submit"/>
						</button>
					</ycommerce:testId>
					
					<a href="support-tickets" class="button"> 
						<spring:theme code="text.account.supporttickets.createTicket.back" text="Back" />
					</a>
				</div>
			</form:form>
		</div>
	</div>
</div>