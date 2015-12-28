<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <c:choose>
            <c:when test="${empty sessionScope.admin}">
                <meta http-equiv="refresh" content="0; url=login.jsp">
            </c:when>
            <c:otherwise>
                <meta http-equiv="refresh" content="0; url=Dashboard">
            </c:otherwise>
        </c:choose>
        <link href="../templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="../templates/css/login.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="visitorForm">
            <div class="formWrapper">
                <h1 class="siteLogo"><span>Web Photo Share</span></h1>
            </div>
        </div>
    </body>
</html>