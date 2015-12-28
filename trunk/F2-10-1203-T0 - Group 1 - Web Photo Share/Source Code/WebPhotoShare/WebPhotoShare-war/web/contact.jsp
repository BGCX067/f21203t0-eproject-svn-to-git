<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Contact Us - Web Photo Share</title>
        <link href="templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="templates/css/users.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#contactForm").validate({
                    rules: {
                        contactSubject: {
                            required: true,
                            maxlength: 255
                        },
                        feedbacktMessage:{
                            required: true
                        },
                        contactName: {
                            required: true,
                            maxlength: 255
                        },
                        contactEmail: {
                            required: true,
                            maxlength: 255,
                            email: true
                        }
                    },
                    contactSubject: {
                        feedbackSubject: {
                            required: "Please enter subject",
                            maxlength: "Contact subject must be less than 255 characters long"
                        },
                        feedbacktMessage:{
                            required: "Please provide message"
                        },
                        contactName: {
                            required: "Please enter your name",
                            maxlength: "Your name must be less than 255 characters long"
                        },
                        contactEmail: "Please enter a valid email address"
                    }
                });
            });
        </script>
    </head>
    <body>
        <section id="header">
            <div class="headerBackground"></div>
            <div class="headerContainer container_12">
                <div class="leftHeaderContent grid_4">
                    <c:if test="${not empty sessionScope.user}">
                        <!-- BOF CATEGORY CONTAINER -->
                        <div class="categoriesContainer">
                            <button class="btnCategory"><em></em></button>
                            <div class="categoryMenu content border_radius box_shadow">
                                <span class="categoryMenuCaret"></span>
                                <div class="categoryMenuContainer">
                                    <div class="grid_3" id="siteMenu">
                                        <a href="aboutUs.jsp" class="button link_text_black">About Us</a>
                                        <a href="FAQ" class="button link_text_black">FAQs</a>
                                        <a href="Feedback" class="button link_text_black">Feedback</a>
                                        <a href="terms.jsp" class="button link_text_black">Terms & Privacy</a>
                                        <a href="ContactUs" class="button link_text_black">Contact</a>
                                        <c:if test="${not empty sessionScope.collections}">
                                            <div class="categoryTitle">Collections</div>
                                            <c:forEach var="collection" items="${sessionScope.collections}" varStatus="status">
                                                <a href="${baseURL}/ViewCollection?collection=${collection.collectionId}" class="link_text_black">${collection.title}</a>
                                                <c:if test="${status.count eq '6'}"></div><div class="grid_3"></c:if>
                                                <c:if test="${(status.count-6)%14 eq '0'}"></div><div class="grid_3"></c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                        <!-- EOF CATEGORY CONTAINER -->
                        <!-- BOF SEARCH CONTAINER -->
                        <div class="searchForm">
                            <form method="post">
                                <input type="search" name="txtSearch" placeholder="Enter your search here...">
                                <input type="submit" value="Search">
                            </form>
                        </div>
                        <!-- EOF SEARCH CONTAINER -->
                    </c:if>
                </div>
                <!-- EOF LEFT HEADER CONTENT -->
                <!-- BOG LOGO -->
                <div class="grid_4">
                    <h1 class="siteTitle">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a href="Home" title=""><span>Web Photo Share</span></a>
                            </c:when>
                            <c:otherwise>
                                <a href="index.jsp" title=""><span>Web Photo Share</span></a>
                            </c:otherwise>
                        </c:choose>
                    </h1>
                </div>
                <!-- BOG LOGO -->
                <c:if test="${not empty sessionScope.user}">
                    <!-- BOF RIGHT HEADER CONTENT -->
                    <div class="rightHeaderContent grid_4">
                        <ul class="table-menu">
                            <li class="first-menu"><span><strong><c:out value="${sessionScope.user}"/></strong></span></li>
                            <li class="last-menu"><a class="link_text_black" href="Logout" title=""><span>Logout</span></a></li>
                        </ul>
                        <span class="welcome">Welcome</span>
                    </div>
                    <!-- EOF RIGHT HEADER CONTENT -->
                </c:if>
            </div>
        </section>
        <section class="container_12" id="main_content_area">
            <!-- BOF USER CONTAITNER -->
            <div class="grid_3 pin_box">
                <%@include file="templateSiteNavigation.jsp"%>
            </div>
            <!-- EOF USER CONTAITNER -->
            <!-- BOF MAIN CONTENT -->
            <div class="grid_9 content border_radius box_shadow">
                <h2 class="main-title">Contact</h2>
                <div class="content_inner form">
                    <form action="" method="post" id="contactForm">
                        <div class="row">
                            <label for="contactSubject">Subject *</label>
                            <input type="text" name="contactSubject" id="contactSubject" required>
                        </div>
                        <div class="row">
                            <label for="contactMessage">Message *</label>
                            <textarea name="contactMessage" id="contactMessage" required></textarea>
                        </div>
                        <div class="row">
                            <label for="contactName">Your name *</label>
                            <input type="text" name="contactName" id="contactName" required>
                        </div>
                        <div class="row">
                            <label for="contactEmail">Your email *</label>
                            <input type="text" name="contactEmail" id="contactEmail" required>
                        </div>
                        <div class="row">
                            <label>&nbsp;</label>
                            <input type="submit" class="size_L blue" value="Send Contact">
                        </div>
                    </form>
                </div>
            </div>
            <!-- BOF MAIN CONTENT -->
        </section>
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </body>
</html>