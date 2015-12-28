<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>User Homepage - Web Photo Share</title>
        <c:if test="${empty sessionScope.user}">
            <meta http-equiv="refresh" content="0; url=index.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/media.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.masonry.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.infinitescroll.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.imagesloaded.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/media.js"></script>
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
            <c:if test="${empty pageContext.request.queryString}">
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
                    <!-- BOF SITE STATIC -->
                    <div class="content border_radius box_shadow" id="siteStatic">
                        <h2>Website Static</h2>
                        <div class="content_inner">
                            <p><span class="float-left">Total images</span>:	<c:out value="${sessionScope.totalImage}"/></p>
                            <p><span class="float-left">Total members</span>:	<c:out value="${sessionScope.totalUser}"/></p>
                            <p class="last"><span class="float-left">Newest Member</span>: <a href="${baseURL}/ViewUser?user=${latestUser.getUserId()}" title="${latestUser.getName()}">${latestUser.getName()}</a></p>
                        </div>
                    </div>
                    <!-- EOF SITE STATIC -->
                </div>
                <!-- EOF USER CONTAITNER -->
            </c:if>
            <!-- BOF MAIN CONTENT -->
            <c:if test="${not empty requestScope.images}">
                <c:forEach var="image" items="${requestScope.images}">
                    <!-- BOF PIN IMAGE -->
                    <div class="grid_3 content border_radius box_shadow pin_box">
                        <div class="pinImage"><a href="${baseURL}/ViewImage?image=${image.imageId}" class="action-pin" title="${image.title}"><img src="${baseURL}${image.path}/${image.filename}" alt="${image.title}"></a></div>
                        <div class="content_inner pinContent">
                            <p class="pinTitle"><a href="${baseURL}/ViewImage?image=${image.imageId}" title="" class="link_text_black">${image.title}</a></p>
                            <p class="pinDesc last">${image.description}</p>
                        </div>
                        <div class="content_inner pinContent">
                            <ul class="pin_meta">
                                <li class="pin_category"><a class="link_text_black" href="${baseURL}/ViewCollection?collection=${image.collectionId.getCollectionId()}" title=""><span class="icon-category"></span>${image.collectionId.getTitle()}</a></li>
                                <li class="pin_view_count"><span class="icon-tag"></span>${image.viewCount} views</li>
                                <li class="pin_comment_count"><span class="icon-comments"></span>${image.commentsCollection.size()} comments</li>
                            </ul>
                        </div>
                        <a class="content_inner pinAuthor link_text_black" href="${baseURL}/ViewUser?user=${image.userId.getUserId()}" title="${image.userId.getName()}">
                            <img class="authorThumb" src="${baseURL}/profiles/${image.userId.getUserAvatar()}" alt="${image.userId.getName()}">
                            <span class="authorName">${image.userId.getName()}</span>
                        </a>
                    </div>
                    <!-- EOF PIN IMAGE -->
                </c:forEach>
            </c:if>
            <div class="clear"></div>
            <!-- EOF MAIN CONTENT -->
        </section>
        <div class="pagination" id="page-nav">
            <c:if test="${currentPage != 1}">
                <a href="${baseURL}/Home?page=${currentPage - 1}">Previous</a>
            </c:if>
            <c:forEach begin="1" end="${noOfPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage eq i}"><span>${i}</span></c:when>
                    <c:otherwise><a href="${baseURL}/Home?page=${i}">${i}</a></c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage lt noOfPages}">
                <a class="pager-next" href="${baseURL}/Home?page=${currentPage + 1}">Next</a>
            </c:if>
        </div>
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </body>
</html>