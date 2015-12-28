<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>${image.title} - Web Photo Share</title>
    <c:if test="${empty sessionScope.user}">
        <meta http-equiv="refresh" content="0; url=index.jsp">
    </c:if>
    <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/users.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/media.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
    <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
    <c:if test="${empty image}">
        <script type="text/javascript">
            alert('Image not found !');
            window.location = 'Home';
        </script>
    </c:if>
</head>
<body>
    <c:if test="${empty requestScope.overlay}">
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
    </c:if>
    <section class="container_12" id="main_content_area">
        <!-- BOF MAIN CONTENT -->
        <div class="grid_9">
            <div class="content border_radius box_shadow pin-image">
                <div class="media-container">
                    <img src="${baseURL}/${image.path}/${image.filename}" alt="">
                </div>
                <div class="media-detail">
                    <h3>${image.title}</h3>
                    <p class="last">${image.description}</p>
                </div>
                <div class="media-category">
                    Collection: ${image.collectionId.getTitle()}
                </div>
            </div>
            <div class="content border_radius box_shadow comment-container">
                <c:if test="${not empty requestScope.comments}">
                <c:forEach var="comment" items="${requestScope.comments}">
                <div class="comment">
                    <div class="commentAuthorImage border_radius"><img src="${baseURL}/profiles/${comment.userId.getUserAvatar()}" alt=""></div>
                    <div class="commentAuthor"><a href="${baseURL}/ViewUser?user=${comment.userId.getUserId()}" class="link_text_black" title=""><strong>${comment.userId.getName()}</strong></a></div>
                    <div class="commentContent">
                        <p>${comment.comment}</p>
                    </div>
                    <div class="clear"></div>
                </div>
                </c:forEach>
                </c:if>
                <c:if test="${empty requestScope.overlay}">
                <div class="comment">
                    <div class="commentAuthorImage border_radius"><img src="${baseURL}/profiles/${myAvatar}" alt=""></div>
                    <div class="commentAuthor"><a href="MyProfile" class="link_text_black" title=""><strong>${myName}</strong></a></div>
                    <div class="commentContent form">
                        <form id="postComment" method="post" action="">
                            <textarea name="comment" placeholder="Your comment"></textarea>
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
                            <input type="submit" class="button blue" value="Comment">
                        </form>
                    </div>
                    <div class="clear"></div>
                </div>
                </c:if>
            </div>
        </div>
        <!-- BOF MAIN CONTENT -->
        <!-- BOF USER CONTAITNER -->
        <div class="grid_3 pin_box">
            <!-- BOF USER PROFILE -->
            <div class="content border_radius box_shadow" id="userProfile">
                <h2>${image.userId.getName()}</h2>
                <div class="profile_avatar">
                    <img src="${baseURL}/profiles/${image.userId.getUserAvatar()}" alt="">
                </div>
                <hr>
                <c:if test="${userID ne image.userId.getUserId()}">
                    <div class="profile_navigation content_inner">
                        <a href="AddFriend?friend=${image.userId.getUserId()}" class="button link_text_black"><span class="icon-add"></span>Add Friend</a>
                    </div>
                </c:if>
            </div>
            <div id="shareImage">
                <a id="btnShare" href="javascript:void(0);" title="" class="button link_text_black"><i class="icon-share"></i><span>Share Image</span></a>
                <div class="clear"></div>
            </div>
            <!-- EOF USER PROFILE -->
        </div>
        <!-- EOF USER CONTAITNER -->
        <div class="clear"></div>
    </section>
    <c:if test="${empty requestScope.overlay}">
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </c:if>
</body>
</html>