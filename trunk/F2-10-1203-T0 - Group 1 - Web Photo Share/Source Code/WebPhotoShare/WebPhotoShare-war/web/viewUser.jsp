<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>View ${member.name} Profile - Web Photo Share</title>
        <c:if test="${empty sessionScope.user}">
            <meta http-equiv="refresh" content="0; url=index.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/users.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/media.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
        <c:if test="${member.userStatus ne 1}">
            <script type="text/javascript">
                alert('User not found !');
                window.location = 'Home';
            </script>
        </c:if>
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
                                            <a href="${collection.collectionId}" class="link_text_black">${collection.title}</a>
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
                    <h2>${member.name}</h2>
                    <div class="profile_avatar">
                        <img src="${baseURL}/profiles/${member.userAvatar}" alt="">
                    </div>
                    <hr>
                    <c:if test="${sessionScope.userID ne member.userId}">
                        <div class="profile_navigation content_inner">
                            <c:choose>
                                <c:when test="${friend.requestStatus eq false}">
                                    <a href="${baseURL}/UserFriendCancel?request=${friend.friendId}" class="button link_text_black"><span class="icon-add"></span>Cancel Friend Request</a>
                                </c:when>
                                <c:when test="${friend.requestStatus eq true}">
                                    <a href="${baseURL}/UserFriendCancel?request=${friend.friendId}" class="button link_text_black"><span class="icon-add"></span>Unfriend</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${baseURL}/AddFriend?friend=${member.userId}" class="button link_text_black"><span class="icon-add"></span>Add Friend</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </div>
                <!-- EOF USER PROFILE -->
            </div>
            <!-- EOF USER CONTAITNER -->
            <c:forEach var="image" items="${requestScope.image}">
                <!-- BOF PIN IMAGE -->
                <div class="grid_3 content border_radius box_shadow pin_box">
                    <div class="pinImage"><a href="ViewImage?image=${image.imageId}" class="action-pin" title="${image.title}"><img src="${baseURL}${image.path}/${image.filename}" alt="${image.title}"></a></div>
                    <div class="content_inner pinContent">
                        <p class="pinTitle"><a href="ViewImage?image=${image.imageId}" title="" class="link_text_black">${image.title}</a></p>
                        <p class="pinDesc last">${image.description}</p>
                    </div>
                    <div class="content_inner pinContent">
                        <ul class="pin_meta">
                            <li class="pin_category"><a class="link_text_black" href="${baseURL}/ViewCollection?collection=${image.collectionId.getCollectionId()}" title=""><span class="icon-category"></span>${image.collectionId.getTitle()}</a></li>
                            <li class="pin_view_count"><span class="icon-tag"></span>${image.viewCount} views</li>
                            <li class="pin_comment_count"><span class="icon-comments"></span>${image.commentsCollection.size()} comments</li>
                        </ul>
                    </div>
                </div>
                <!-- EOF PIN IMAGE -->
            </c:forEach>
            <div class="clear"></div>
        </section>
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </body>
</html>