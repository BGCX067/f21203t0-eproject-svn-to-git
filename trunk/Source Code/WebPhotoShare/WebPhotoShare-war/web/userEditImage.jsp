<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>My Image - Web Photo Share</title>
    <c:if test="${empty sessionScope.user}">
        <meta http-equiv="refresh" content="0; url=index.jsp">
    </c:if>
    <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="${baseURL}/templates/css/users.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
    <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.imagesloaded.min.js"></script>
    <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.masonry.min.js"></script>
    <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
    <c:if test="${not empty requestScope.success}">
        <script type="text/javascript">
            alert("Your image had been uploaded !");
        </script>
    </c:if>
        <script type="text/javascript">
            $(document).ready(function() {
                var $container = $('#myImage');
                $container.imagesLoaded(function() {
                    $container.masonry({
                        itemSelector : '.pin_box',
                        isAnimated : true,
                        animationOptions : {
                            duration : 750,
                            easing : 'linear',
                            queue : false
                        }
                    });
                });
            })
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
                                <a href="aboutUs.jsp" class="button link_text_black">About Us</a>
                                <a href="FAQ" class="button link_text_black">FAQs</a>
                                <a href="Feedback" class="button link_text_black">Feedback</a>
                                <a href="terms.jsp" class="button link_text_black">Terms & Privacy</a>
                                <a href="ContactUs" class="button link_text_black">Contact</a>
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
                <h2>User Control Pannel</h2>
                <div class="profile_avatar">
                    <img src="${baseURL}/profiles/${myAvatar}" alt="">
                </div>
                <hr>
                <div class="profile_navigation content_inner">
                    <a href="MyProfile" class="button link_text_black">My Profile Setting</a>
                    <a href="MyImage" class="button active">My Uploaded Images</a>
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
                    <p class="last"><span class="float-left">Newest Member</span>:	Peter Smith</p>
                </div>
            </div>
            <!-- EOF SITE STATIC -->
        </div>
        <!-- EOF USER CONTAITNER -->
        <!-- BOF MAIN CONTENT -->
        <div class="grid_6 content border_radius box_shadow">
            <h2 class="main-title">Upload Image</h2>
            <div class="content_inner form">
                <form action="" method="post" id="uploadImageForm">
                    <div class="row">
                        <label for="imageTitle">Title</label>
                        <input type="text" name="imageTitle" id="imageTitle" value="${image.getTitle()}" required="required" maxlength="255">
                    </div>
                    <div class="row">
                        <label for="imageDesc">Description</label>
                        <textarea name="imageDesc" id="imageDesc">${image.getDescription()}</textarea>
                    </div>
                    <div class="row">
                        <label>Uploaded on</label><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${image.getUploadDate()}" />
                    </div>
                    <div class="row">
                        <label>Last modify</label><fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${image.getModifyDate()}" />
                    </div>
                    <div class="row">
                        <label for="imageCollection">Collection</label>
                        <select name="imageCollection" id="imageCollection">
                            <c:forEach var="collection" items="${sessionScope.collections}" varStatus="status">
                                <c:choose>
                                    <c:when test="${image.collectionId.getCollectionId() eq collection.collectionId}">
                                        <option value="${collection.collectionId}" selected="selected">${collection.title}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${collection.collectionId}">${collection.title}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row">
                        <label for="imagePrivacy">Privacy</label>
                        <select name="imagePrivacy" id="imagePrivacy">
                            <option<c:if test="${image.shareStatus eq 0}"> selected="selected"</c:if> value="0">Private</option>
                            <option<c:if test="${image.shareStatus eq 1}"> selected="selected"</c:if> value="1">Friend Only</option>
                            <option<c:if test="${image.shareStatus eq 2}"> selected="selected"</c:if> value="2">Public</option>
                        </select>
                    </div>
                    <c:if test="${not empty requestScope.error}">
                        <div class="error_message">
                            <h3>The form you submitted contained the following errors</h3>
                            <ol>
                        <c:forEach var="error" items="${requestScope.error}">
                            <li><c:out value="${error}"/></li>
                        </c:forEach>
                            </ol>
                        </div>
                    </c:if>
                    <input type="submit" class="size_L blue" value="Save Setting">
                </form>
            </div>
        </div>
        <!-- BOF MAIN CONTENT -->
        <div class="grid_3 content border_radius box_shadow">
            <h2 class="main-title">Image Preview</h2>
            <div class="content_inner" style="height:405px">
                <img id="imagePreview" src="${baseURL}/${image.getPath()}/${image.getFilename()}" alt="Preview" >
            </div>
        </div>
        <script type="text/javascript">
            $(function() {
                $("#imageFile").change(function() {
                    imagePreview(this);
                });
            });
        </script>
    </section>
    <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
</body>
</html>