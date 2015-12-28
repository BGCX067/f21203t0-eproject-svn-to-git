<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Login Form - Web Photo Share</title>
    <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="templates/css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="templates/jscripts/jquery.min.js"></script>
</head>
<body>
    <div id="visitorForm">
        <div class="formWrapper">
            <h1 class="siteLogo"><span>Web Photo Share</span></h1>
            
            <div class="content box_shadow border_radius" id="loginForm">
                <div class="formContainer">
                    <form method="post" action="Login">
                        <input type="text" name="txtUsername" placeholder="Username" required>
                        <input type="password" name="txtPassword" placeholder="Password" required>
                        <c:if test="${not empty requestScope.error}">
                            <div class="error_message">
                                <h3>An error was encountered</h3>
                                Please check your Username and Password
                            </div>
                        </c:if>
                        <div class="formButtonContainer">
                            <div class="formLink">
                                <a class="link_text_black" href="ForgotPassword" title="Click here to recover your account">Forgot your password?</a>
                                <a class="link_text_black" href="Register" title="Sign up now">Sign up now</a>
                            </div>
                            <input class="blue size_L" type="submit" value="Login">
                            <div class="clear"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>