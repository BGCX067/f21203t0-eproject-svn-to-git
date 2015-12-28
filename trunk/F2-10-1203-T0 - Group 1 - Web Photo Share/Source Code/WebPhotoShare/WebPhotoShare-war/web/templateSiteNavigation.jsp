<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>            
            <div class="content border_radius box_shadow" id="userProfile">
                <h2>Site Navigation</h2>
                <div class="profile_navigation content_inner">
                    <a href="aboutUs.jsp" class="button<c:if test="${pageContext.request.servletPath eq '/aboutUs.jsp'}"> active</c:if>">About Us</a>
                    <a href="FAQ" class="button<c:if test="${pageContext.request.servletPath eq '/faq.jsp'}"> active</c:if>">FAQs</a>
                    <c:if test="${not empty sessionScope.user}">
                    <a href="Feedback" class="button<c:if test="${pageContext.request.servletPath eq '/userFeedback.jsp'}"> active</c:if>">Feedback</a>
                    </c:if>
                    <a href="terms.jsp" class="button<c:if test="${pageContext.request.servletPath eq '/terms.jsp'}"> active</c:if>">Terms & Privacy</a>
                    <a href="ContactUs" class="button<c:if test="${pageContext.request.servletPath eq '/contact.jsp'}"> active</c:if>">Contact</a>
                </div>
            </div>