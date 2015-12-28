<%-- 
    Document   : login
    Created on : Oct 13, 2013, 2:41:18 PM
    Author     : Hung Nguyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Homepage - Web Photo Share</title>
    <c:if test="${not empty sessionScope.user}">
        <meta http-equiv="refresh" content="0; url=Home">
    </c:if>
    <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="templates/css/homepage.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="templates/jscripts/jquery.min.js"></script>
</head>
<body>
    <div class="UnauthHomePage">
        <div class="pageTop">
            <div class="homepageWrapper">
                <h1 class="homeLogo"><span>Web Photo Share</span></h1>
                <div class="homepageText">
                    <p>Fast and easy photo sharing</p>
                    <p class="last"> Share with friends or explore public photos.</p>
                </div>
                <div class="registrationButtonWrapper">
                    <a class="button blue size_L" href="Register" title="Sign Up">Sign Up Free Account</a>
                </div>
                <div class="homepageText">
                    <p class="last">Already have an account? <a href="Login">Log in now</a></p>
                </div>
            </div>
        </div>
        <div class="pageBottom">
            <div class="splash"></div>
        </div>
        <div class="aboutTermsWrapper">
            <a href="aboutUs.jsp" title="">About Us</a>
            <a href="FAQ" title="">FAQs</a>
            <a href="terms.jsp" title="">Terms & Privacy</a>
            <a href="ContactUs" title="">Contact</a>
        </div>
    </div>
</body>
</html>