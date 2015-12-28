<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Change Password - Web Photo Share</title>
        <c:if test="${empty sessionScope.user}">
            <meta http-equiv="refresh" content="0; url=index.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/users.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#passwordForm").validate({
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
            <div class="headerBackground"></div>
            <div class="headerContainer container_12">
                <div class="leftHeaderContent grid_4">
                    <!-- BOF CATEGORY CONTAINER -->
                    <div class="categoriesContainer">
                        <button class="btnCategory"><em></em></button>
                        <div class="categoryMenu content border_radius box_shadow">
                            <span class="categoryMenuCaret"></span>
                            <div class="categoryMenuContainer">
                                <div class="grid_3" id="siteMenu">
                                    <a href="${baseURL}/aboutUs.jsp" class="button link_text_black">About Us</a>
                                    <a href="${baseURL}/FAQ" class="button link_text_black">FAQs</a>
                                    <a href="${baseURL}/Feedback" class="button link_text_black">Feedback</a>
                                    <a href="${baseURL}/terms.jsp" class="button link_text_black">Terms & Privacy</a>
                                    <a href="${baseURL}/ContactUs" class="button link_text_black">Contact</a>
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
                </div>
                <!-- EOF LEFT HEADER CONTENT -->
                <!-- BOG LOGO -->
                <div class="grid_4">
                    <h1 class="siteTitle"><a href="Home" title=""><span>Web Photo Share</span></a></h1>
                </div>
                <!-- BOG LOGO -->
                <!-- BOF RIGHT HEADER CONTENT -->
                <div class="rightHeaderContent grid_4">
                    <ul class="table-menu">
                        <li class="first-menu"><span><strong><c:out value="${sessionScope.myName}"/></strong></span></li>
                        <li class="last-menu"><a class="link_text_black" href="Logout" title=""><span>Logout</span></a></li>
                    </ul>
                    <span class="welcome">Welcome</span>
                </div>
                <!-- EOF RIGHT HEADER CONTENT -->
            </div>
        </section>
        <section class="container_12" id="main_content_area">
            <!-- BOF USER CONTAITNER -->
            <div class="grid_3 pin_box">
                <!-- BOF USER PROFILE -->
                <div class="content border_radius box_shadow" id="userProfile">
                    <h2>User Control Pannel</h2>
                    <div class="profile_avatar">
                        <img src="${baseURL}/profiles/${myAvatar}" alt="">
                    </div>
                    <hr>
                    <div class="profile_navigation content_inner">
                        <a href="MyProfile" class="button active">My Profile Setting</a>
                        <a href="MyImage" class="button link_text_black">My Uploaded Images</a>
                        <a href="MyFriend" class="button link_text_black">My Friends
                            <c:if test="${not empty sessionScope.newFriends}">
                                <span class="desc">(${sessionScope.newFriends} new requests)</span>
                            </c:if>
                        </a>
                    </div>
                </div>
                <!-- EOF USER PROFILE -->
            </div>
            <!-- EOF USER CONTAITNER -->
            <!-- BOF MAIN CONTENT -->
            <div class="grid_6 content border_radius box_shadow">
                <h2 class="main-title">Change Password Form</h2>
                <div class="content_inner">
                    <p>You may change your password here. We will attempt to update your current session after your successful password change. If, however, you do experience difficulties, please try logging out and logging back in before contacting a staff member to help resolve the problem</p>
                </div>
                <hr>
                <div class="content_inner form">
                    <form method="post" id="passwordForm">
                        <div class="row">
                            <label for="crPassword">Current password</label>
                            <input type="password" name="crPassword" id="crPassword" maxlength="32" required="">
                        </div>
                        <hr>
                        <div class="row">
                            <label for="newPassword">New password</label>
                            <input type="password" name="newPassword" id="newPassword" maxlength="32" required="">
                        </div>
                        <div class="row">
                            <label for="newPassword2">Re-type new password</label>
                            <input type="password" name="newPassword2" id="newPassword2" maxlength="32" required="">
                        </div>
                        <div class="row">
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
                            <label>&nbsp;</label>
                            <input type="hidden" name="userID" value="${profile.userId}">
                            <input type="submit" class="size_L blue" value="Save Settings"> 
                        </div>
                    </form>
                </div>
            </div>
            <div class="grid_3 content border_radius box_shadow">
                <h2 class="main-title">My Avatar</h2>
                <div class="profile_avatar">
                    <img src="${baseURL}/profiles/${profile.userAvatar}" alt="">
                </div>
                <hr>
                <div class="content_inner">
                    <form action="UpdateAvatar" method="post" enctype="multipart/form-data">
                        <input type="file" name="avatarFile" id="avatarFile" accept="image/*" required="required">
                        <input type="hidden" name="userID" value="${profile.userId}">
                        <input type="submit" class="blue" value="Update Avatar">
                    </form>
                </div>
            </div>
            <!-- BOF MAIN CONTENT -->
        </section>
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </body>
</html>