<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Redirecting...</title>
    
    <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/login.css" rel="stylesheet" type="text/css">
    <meta http-equiv='refresh' content='2; url=${redirectLink}' />
</head>
<body>
    <div id="visitorForm">
        <div class="formWrapper">
            <h1 class="siteLogo"><span>Web Photo Share</span></h1>
            <div class="content box_shadow border_radius" id="loginForm">
                <div class="formContainer">
                    <h2>Redirecting...</h2>
                    <p>${redirectMessage}</p>
                    <a href="${redirectLink}">( Click here if you do not wish to wait )</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
