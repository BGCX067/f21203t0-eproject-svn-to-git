<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>My Friend - Web Photo Share</title>
    <c:if test="${empty sessionScope.user}">
        <meta http-equiv="refresh" content="0; url=index.jsp">
    </c:if>
    <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/users.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
    <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
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
                    <a href="MyProfile" class="button link_text_black">My Profile Setting</a>
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
        <!-- BOF MAIN CONTENT -->
        <c:if test="${not empty requestScope.friendRequests}">
        <div class="grid_9">
            <h2 class="main-title">New Friend Requests</h2>
        </div>
        <c:forEach var="request" items="${requestScope.friendRequests}">
        <div class="grid_3 content border_radius box_shadow userFriend">
            <div class="userFriendAvatar"><img src="${baseURL}/profiles/${request.userId.getUserAvatar()}" width="90" height="90" alt=""></div>
            <div class="content_inner">
                <span class="userFriendName"><a href="${baseURL}/ViewUser?user=${request.userId.getUserId()}" title="" class="link_text_black">${request.userId.getName()}</a></span>
                <span class="userFriendButton"><a href="${baseURL}/UserFriendAccept?request=${request.friendId}" title="" class="link_text_black"><span class="icon-add"></span>Accept Request</a></span>
                <span class="userFriendButton"><a href="${baseURL}/UserFriendCancel?request=${request.friendId}" title="" class="link_text_black"><span class="icon-no"></span>Decline</a></span>
            </div>
        </div>
        </c:forEach>
        </c:if>
        <c:if test="${not empty requestScope.friends}">
        <div class="grid_9">
            <h2 class="main-title">My Friends</h2>
        </div>
        <c:forEach var="friend" items="${requestScope.friends}">
        <div class="grid_3 content border_radius box_shadow userFriend">
            <div class="userFriendAvatar"><img src="${baseURL}/profiles/${friend.userId.getUserAvatar()}" width="90" height="90" alt=""></div>
            <div class="content_inner">
                <c:choose>
                    <c:when test="${friend.userId.getUserId() eq userID}">
                <span class="userFriendName"><a href="${baseURL}/ViewUser?user=${friend.friend.getUserId()}" title="" class="link_text_black">${friend.friend.getName()}</a></span>
                    </c:when>
                    <c:otherwise>
                <span class="userFriendName"><a href="${baseURL}/ViewUser?user=${friend.userId.getUserId()}" title="" class="link_text_black">${friend.userId.getName()}</a></span>
                    </c:otherwise>
                </c:choose>
                <span class="userFriendButton"><a href="${baseURL}/UserFriendCancel?request=${friend.friendId}" title="" class="link_text_black"><span class="icon-no"></span>Unfriend</a></span>
            </div>
        </div>
        </c:forEach>
        </c:if>
        <!-- BOF MAIN CONTENT -->
    </section>
    <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
</body>
</html>