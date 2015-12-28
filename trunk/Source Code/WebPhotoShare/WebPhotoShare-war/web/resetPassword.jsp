<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Account Recovery Form - Web Photo Share</title>
        <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="templates/css/login.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#changePasswordForm").validate({
                    rules: {
                        password: {
                            required: true,
                            minlength: 5,
                            maxlength:32
                        },
                        confirm_password: {
                            required: true,
                            minlength: 5,
                            maxlength:32,
                            equalTo: "#password"
                        }
                    },
                    messages: {
                        password: {
                            required: "Please provide a password",
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long"
                        },
                        confirm_password: {
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
        <div id="visitorForm">
            <div class="formWrapper">
                <h1 class="siteLogo"><span>Web Photo Share</span></h1>
                <div class="content box_shadow border_radius">
                    <div class="formContainer">
                        <h2>Password Recovery</h2>
                        <p align="justify">Please ensure that you complete the form fully. The information you need will be in the email that was sent to you.</p>
                        <form method="post" action="" id="changePasswordForm">
                            <c:choose>
                                <c:when test="${empty key}">
                                    <input type="text" name="txtKey" placeholder="Your password reset code" required>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="txtKey" required value="${key}">
                                </c:otherwise>
                            </c:choose>
                            <hr>
                            <h3>New Password</h3>
                            <input type="password" name="password" id="password" placeholder="Your new password" maxlength="32" required>
                            <div class="clear"></div>
                            <h3>Re-type New Password</h3>
                            <input type="password" name="confirm_password" id="confirm_password" placeholder="Re-type your new password" oninput="check(this)" required>
                            <div class="clear"></div>
                        <c:if test="${not empty requestScope.errors}">
                            <div class="error_message">
                                <h3>The form you submitted contained the following errors</h3>
                                <ol>
                            <c:forEach var="i" items="${requestScope.errors}">
                                    <li><c:out value="${i}"/></li>
                            </c:forEach>
                                </ol>
                            </div>
                        </c:if>
                            <div class="formButtonContainer">
                                <input class="blue size_L" type="submit" value="Reset Password">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>