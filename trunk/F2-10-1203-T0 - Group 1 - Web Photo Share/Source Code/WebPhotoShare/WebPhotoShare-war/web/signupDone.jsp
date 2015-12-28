<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sign Up Form - Web Photo Share</title>
    <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="templates/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="visitorForm">
        <div class="formWrapper">
            <h1 class="siteLogo"><span>Web Photo Share</span></h1>
            <div class="content box_shadow border_radius signUpForm">
                <div class="formContainer">
                    <h2>Sign Up Account</h2>
                        <div class="clear"></div>
                        <p>Thank you <strong><c:out value="${requestScope.name}"/></strong>. Your registration has been submitted.</p>
                        <p>The community administrator has chosen to require validation for all registration. You'll receive an email with instructions on the next step. Don't worry, it won't take long before you can post!</p>
                        <div class="formButtonContainer">
                            <a class="button size_L" href="index.jsp" title="Homepage">Homepage</a>
                        </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>