<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Contact Manage - Web Photo Share</title>
        <c:if test="${empty sessionScope.admin}">
            <meta http-equiv="refresh" content="0; url=login.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/admin/css/admin.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <section id="header">
            <div class="container_12">
                <div class="grid_5" id="logo"><a href="Dashboard" title="">Admin Dashboard</a></div>
                <div class="float-right">Logged in as <c:out value="${sessionScope.admin}"/></div>
            </div>
        </section>
        <section id="mainpage">
            <div class="container_12">
                <div class="grid_3" id="mainMenu">
                    <h3>NAVIGATOR</h3>
                    <ul>
                        <li><a href="Dashboard" title="Dashboard">Dashboard</a></li>
                        <li><a href="UserManage" title="Users">Users</a></li>
                        <li><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li><a href="ImageManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li class="active"><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li>Dashboard</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <div class="pageHeader">
                        <h2 class="main-title">Contact</h2>
                        <div class="clear"></div>
                    </div>
                    <c:if test="${not empty contacts}">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>Sender</th>
                            <th>Subject</th>
                            <th>Date</th>
                            <th width="170">&nbsp;</th>
                        </tr>
                        <c:forEach var="contact" items="${contacts}">
                            <c:choose>
                                <c:when test="${contact.contactStatus eq 0}">
                        <tr>
                            <td><strong>${contact.contactName}</strong></td>
                            <td><a href="ContactReply?contact=${contact.contactId}" title=""><strong>${contact.contactSubject}</strong></a></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${contact.contactDate}" /></td>
                            <td>
                                <a href="ContactReply?contact=${contact.contactId}" title=""><img src="${baseURL}/templates/admin/images/btnReply.png"></a>
                                <a href="ContactDelete?contact=${contact.contactId}" title=""><img src="${baseURL}/templates/admin/images/btnDelete.png"></a>
                            </td>
                        </tr>
                                </c:when>
                                <c:when test="${contact.contactStatus eq 1}">
                        <tr>
                            <td>${contact.contactName}</td>
                            <td><a href="ContactReply?contact=${contact.contactId}" title="">${contact.contactSubject}</a></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${contact.contactDate}" /></td>
                            <td>
                                <a href="ContactReply?contact=${contact.contactId}" title=""><img src="${baseURL}/templates/admin/images/btnReply.png"></a>
                                <a href="ContactDelete?contact=${contact.contactId}" title=""><img src="${baseURL}/templates/admin/images/btnDelete.png"></a>
                            </td>
                        </tr>
                                </c:when>
                                <c:otherwise>
                        <tr>
                            <td>${contact.contactName}</td>
                            <td><a href="ContactReply?contact=${contact.contactId}" title="">${contact.contactSubject}</a></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${contact.contactDate}" /></td>
                            <td>
                                <a href="ContactDelete?contact=${contact.contactId}" title=""><img src="${baseURL}/templates/admin/images/btnDelete.png"></a>
                            </td>
                        </tr>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    </table>
                </div>
                </c:if>
                <!-- EOF MAIN CONTENT -->
            </div>
        </section>
        <section id="footer">
            <div class="container_12">
                <div class="grid_12">
                    <div id="copyRight">&copy; 2013 Web Photo Share. All Rights Reserved</div>
                </div>
            </div>
        </section>
    </body>
</html>