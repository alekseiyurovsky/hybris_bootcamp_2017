<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/desktop/formElement" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<spring:htmlEscape defaultHtmlEscape="true" />

<div class="span-24">
	<div class="span-20 last">
		<div class="accountContentPane clearfix">
			<div class="headline"><spring:theme code="text.account.supportTicket.updateTicket.heading" text="Request Customer Support"/></div>
			<div class="required right"><spring:theme code="form.required" text="Fields marked * are required"/></div>
			<form:form method="post" commandName="supportTicketForm">
				<input id="currentTicketStatus" type="hidden" value="${ticketData.status.id}">
				<table class="supportTicketTableUpdate">
					<tr>
						<td><label for="text.account.supporttickets.createTicket.subject"><spring:message code="text.account.supporttickets.createTicket.subject" text="Subject"/> </label></td>
					</tr>
					<tr>
						<td class="supportTicketBR">
							<div class="control-group">
								<form:input path="subject" value="${ticketData.subject}" readonly="true" size="52" htmlEscape="true"/>
							</div>
						</td>
					</tr>
					<c:if test="${not empty ticketData.associatedTo}">
						<tr>
							<td>
								<div class="control-group">
									<label class="control-group" for="text.account.supporttickets.createTicket.associatedTo.option1"> <spring:theme code="text.account.supporttickets.createTicket.associatedTo" text="Associated To"/></label>
								</div>
							</td>
						</tr>
						<tr>
							<td class="supportTicketBR">
								<div class="control-group">
									<form:input path="associatedTo" value="${ticketData.associatedTo}" readonly="true" size="52" htmlEscape="true"/>
								</div>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty ticketData.ticketCategory }">
						<tr>
							<td>
								<div class="control-group">
									<label class="control-group" for="text.account.supporttickets.createTicket.ticketCategory"> <spring:theme code="text.account.supporttickets.createTicket.ticketCategory" text="Category"/></label>
								</div>
							</td>
						</tr>
						<tr>
							<td class="supportTicketBR">
								<div class="control-group">
									<form:hidden path="ticketCategory" value="${ticketData.ticketCategory}"/>
									<c:set var="ticketCategory"><spring:theme code="text.account.supporttickets.createTicket.ticketCategory.${ticketData.ticketCategory}"/></c:set>
									<input type="text" value="${fn:escapeXml(ticketCategory)}" readonly="readonly" size="52"/>
								</div>
							</td>
						</tr>
					</c:if>

					<tr>
						<td><label><spring:message code="text.account.supporttickets.createTicket.message.history"/> &nbsp;</label></td>
					</tr>
					<c:choose>
						<c:when test="${not empty ticketData.messageHistory}">
							<tr>
								<td class="supportTicketBR">
									<div class="control-group">
										<div class="controls">
											<textarea readonly="readonly" >${fn:escapeXml(ticketData.messageHistory)}</textarea>
										</div>
									</div>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ticketData.ticketEvents}" var="ticketEventData">
								<tr>
									<td class="supportTicketBR">
										<div class="control-group">
											<c:choose>
												<c:when test="${ticketEventData.addedByAgent}">
													<c:set var="cssClass" value="controls right" scope="page"/>
												</c:when>
												<c:otherwise>
													<c:set var="cssClass" value="controls left" scope="page"/>
												</c:otherwise>
											</c:choose>
											
											<div class="${cssClass }">
												<textarea rows="3" cols="35" readonly="readonly" >${fn:escapeXml(ticketEventData.displayText)}</textarea>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>

					<c:if test="${ticketData.status.id ne 'CLOSED'}">
						<tr>
							<td>
								<form:hidden path="id" value="${ticketData.id}"/>
								<formElement:formTextArea idKey="message" labelKey="text.account.supporttickets.createTicket.message" path="message"/>
							</td>
						</tr>
						<tr>
							<td class="supportTicketBR" colspan="2" align="center" ><spring:theme code="text.account.supporttickets.updateTicket.message.desc" text="Update Message"/></td>
						</tr>
					</c:if>

					<tr>
						<td><label for="text.account.supportTicket.updateTicket.status"><spring:message code="text.account.supportTicket.updateTicket.status" text="Status"/> </label></td>
					</tr>
					<tr>
						<td class="supportTicketBR">
							<form:select path="status">
								<form:option value="${ticketData.status.id}"><spring:message code="ticketstatus.${fn:toUpperCase(ticketData.status.id)}"/> (<spring:message code="text.account.supporttickets.currentStatus" text="Current Status"/>)</form:option>
								<c:forEach items="${ticketData.availableStatusTransitions}" var="status">
									<form:option value="${status.id}" ><spring:message code="ticketstatus.box.${status.id}"/> </form:option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
				</table>

				<div id="addressform_button_panel" class="form-actions">
					<c:if test="${ticketData.status.id ne 'CLOSED'}">
						<ycommerce:testId code="supportTicket_update_button">
							<button class="positive right" id="updateTicket" type="submit">
								<spring:theme code="text.account.supporttickets.createTicket.submit" text="Submit"/>
							</button>
						</ycommerce:testId>
					</c:if>
					<a href="../support-tickets" class="button">
						<spring:theme code="text.account.supporttickets.createTicket.back" text="Back" />
					</a>
				</div>
			</form:form>
		</div>
	</div>
</div>