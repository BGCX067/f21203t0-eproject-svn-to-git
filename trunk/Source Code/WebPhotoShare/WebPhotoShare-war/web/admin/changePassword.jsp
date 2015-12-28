<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link href="../templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="../templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="../templates/admin/css/admin.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#changePasswordForm").validate({
                    rules: {
                        newPassword: {
                            required: true,
                            minlength: 5,
                            maxlength: 32
                        },
                        newPassword2: {
                            required: true,
                            minlength: 5,
                            maxlength: 32,
                            equalTo: "#newPassword"
                        }
                    },
                    messages: {
                        newPassword: {
                            required: "Please provide a password",
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long"
                        },
                        newPassword2: {
                            required: "Please provide a password",
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long",
                            equalTo: "Please enter the same password as above"
                        }
                    }
                });
            });
        </script>
    </head>
    <body>
        <section id="header">
            <div class="container_12">
                <div class="grid_5" id="logo"><a href="${baseURL}" title="">Admin Dashboard</a></div>
                <div class="float-right">Logged in as <c:out value="${sessionScope.admin}"/></div>
            </div>
        </section>
        <section id="mainpage">
            <div class="container_12">
                <div class="grid_3" id="mainMenu">
                    <h3>NAVIGATOR</h3>
                    <ul>
                        <li class="active"><a href="${baseURL}" title="Dashboard">Dashboard</a></li>
                        <li><a href="UserManage" title="Users">Users</a></li>
                        <li><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li><a href="ImageManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li><a href="${baseURL}" title="Dashboard">Dashboard</a></li>
                        <li>Change Password</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_5">
                    <h2 class="main-title no-border no-space">Change password</h2>
                    <form action="" method="post" id="changePasswordForm">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <td>Current Password</td>
                                <td><input type="password" name="password" placeholder="Your current password"></td>
                            </tr>
                            <tr>
                                <td>New Password</td>
                                <td><input type="password" name="newPassword" id="newPassword" placeholder="Your new password"></td>
                            </tr>
                            <tr>
                                <td>Re-Type New Password</td>
                                <td><input type="password" name="newPassword2" id="newPassword2" placeholder="Re-type your new password"></td>
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
                                <td><input type="submit" value="Save Setting"></td>
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