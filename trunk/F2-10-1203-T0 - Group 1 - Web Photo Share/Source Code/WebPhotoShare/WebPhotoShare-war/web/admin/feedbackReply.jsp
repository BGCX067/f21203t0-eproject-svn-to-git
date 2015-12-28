<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin Dashboard - Web Photo Share</title>
        <c:if test="${empty sessionScope.admin}">
            <meta http-equiv="refresh" content="0; url=login.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/admin/css/admin.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#feedbackReply").validate({
                    rules: {
                        reply: {
                            required: true
                        }
                    },
                    messages: {
                        collectionTitle: {
                            required: "Reply message cannot be blank"
                        }
                    }
                });
            });
        </script>
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
                        <li class="active"><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li><a href="Dashboard">Dashboard</a></li>
                        <li>Feedback Manage</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <div class="pageHeader">
                        <h2 class="main-title">Reply</h2>
                        <div class="clear"></div>
                    </div>
                    <form action="" method="post" id="feedbackReply">
                    <table class="table table-bordered form">
                        <tr>
                            <td width="100px"><strong>Sender</strong></td><td>${feedback.userId.getName()}</td>
                        </tr>
                        <tr>
                            <td><strong>Email</strong></td><td>${feedback.userId.getEmail()}</td>
                        </tr>
                        <tr>
                            <td><strong>Date</strong></td><td><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${feedback.feedbackDate}" /></td>
                        </tr>
                        <tr>
                            <td><strong>Subject</strong></td><td>${feedback.subject}</td>
                        </tr>
                        <tr>
                            <td><strong>Message</strong></td>
                            <td>
                                ${feedback.message}
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Reply</strong></td>
                            <td>
                                <textarea name="reply" placeholder="Reply message">${feedback.reply}</textarea>
                            </td>
                        </tr>
                        <c:if test="${not empty requestScope.errors}">
                            <tr>
                                <td colspan="2">
                            <div class="error_message">
                                <h3>The form you submitted contained the following errors</h3>
                                <ol>
                            <c:forEach var="i" items="${requestScope.errors}">
                                    <li><c:out value="${i}"/></li>
                            </c:forEach>
                                </ol>
                            </div>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td></td>
                            <td>
                                <input type="hidden" name="senderName" value="${feedback.userId.getName()}">
                                <input type="hidden" name="senderEmail" value="${feedback.userId.getEmail()}">
                                <input type="hidden" name="feedbackSubject" value="${feedback.subject}">
                                <input type="hidden" name="date" value="<fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${feedback.feedbackDate}" />">
                                <input type="submit" value="Send Message">
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
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