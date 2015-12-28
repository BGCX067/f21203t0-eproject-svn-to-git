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
    <c:if test="${empty contact}">
        <script type="text/javascript">
            alert('Contact not found !');
            window.location = 'ContactManage';
        </script>
    </c:if>
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
                    <form action="" method="post" name="contactReplyForm">
                    <table class="table table-bordered form">
                        <tr>
                            <td width="100px"><strong>Sender</strong></td><td>${contact.contactName}</td>
                        </tr>
                        <tr>
                            <td><strong>Email</strong></td><td>${contact.contactEmail}</td>
                        </tr>
                        <tr>
                            <td><strong>Date</strong></td><td><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${contact.contactDate}" /></td>
                        </tr>
                        <tr>
                            <td><strong>Subject</strong></td><td>${contact.contactSubject}</td>
                        </tr>
                        <tr>
                            <td><strong>Message</strong></td><td>${contact.contactMessage}</td>
                        </tr>
                        <tr>
                            <td><strong>Reply</strong></td>
                            <td>
                                <textarea name="replyMessage" placeholder="Reply message" required="required"></textarea>
                            </td>
                        </tr>
                            <c:if test="${not empty requestScope.errors}">
                                <tr><td colspan="2">
                                <div class="error_message">
                                    <h3>The form you submitted contained the following errors</h3>
                                    <ol>
                                        <c:forEach var="i" items="${requestScope.errors}">
                                            <li><c:out value="${i}"/></li>
                                            </c:forEach>
                                    </ol>
                                </div>
                                </td></tr>
                            </c:if>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" value="Send Message">
                            </td>
                        </tr>
                    </table>
                    </form>
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