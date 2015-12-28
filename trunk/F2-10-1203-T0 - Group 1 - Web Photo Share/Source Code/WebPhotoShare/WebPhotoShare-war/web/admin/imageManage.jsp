<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Images Management - Web Photo Share</title>
        <link href="../templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="../templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="../templates/admin/css/admin.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.imagesloaded.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.masonry.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                var $container = $('#imageManage');
                $container.imagesLoaded(function() {
                    $container.masonry({
                        itemSelector: '.pin_box',
                        isAnimated: true,
                        animationOptions: {
                            duration: 750,
                            easing: 'linear',
                            queue: false
                        }
                    });
                });
            })
        </script>
    </head>
    <body>
        <section id="header">
            <div class="container_12">
                <div class="grid_5" id="logo"><a href="admin.jsp" title="">Admin Dashboard</a></div>
            </div>
        </section>
        <section id="mainpage">
            <div class="container_12">
                <div class="grid_3" id="mainMenu">
                    <h3>NAVIGATOR</h3>
                    <ul>
                        <li><a href="Dashboard" title="Dashboard">Dashboard</a></li>
                        <li><a href="UserManage" title="Users">Users</a></li>
                        <li><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li class="active"><a href="ImagesManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="02-admin-Contact.html" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li>Images Management</li>
                    </ul>
                    <a href="login.jsp" class="buttonLink">Logout</a>
                    <a href="02-admin-Change-Password.html" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <div class="pageHeader">
                        <h2 class="main-title">Images</h2>
                        <div class="adminSearch">
                            <form method="post" id="searchImages">
                                <label for="searchKeyword">Search Images</label>
                                <input type="text" name="searchKeyword" id="searchKeyword" placeholder="Enter your search here...">
                                <input type="submit" name="action" value="Search">
                            </form>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <c:if test="${not empty requestScope.images}">
                        <div class="pagination" id="page-nav" style="margin-bottom: 20px;">
                            <c:if test="${currentPage != 1}">
                                <a href="${baseURL}/admin/ImageManage?page=${currentPage - 1}">Previous</a>
                            </c:if>
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}"><span>${i}</span></c:when>
                                    <c:otherwise><a href="${baseURL}/admin/ImageManage?page=${i}">${i}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${currentPage lt noOfPages}">
                                <a class="pager-next" href="${baseURL}/admin/ImageManage?page=${currentPage + 1}">Next</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
                <div id="imageManage" style="float:left; width: 720px">
                    <c:if test="${not empty requestScope.images}">
                        <c:forEach var="image" items="${requestScope.images}">
                            <!-- BOF PIN IMAGE -->
                            <div class="grid_3 content border_radius box_shadow pin_box">
                                <div class="pinImage"><a href="${baseURL}/admin/ImageEdit?imageId=${image.imageId}" class="action-pin" title="${image.title}"><img src="${baseURL}${image.path}/${image.filename}" alt="${image.title}"></a></div>
                                <div class="content_inner pinContent">
                                    <p class="pinTitle">${image.title}</p>
                                    <p class="pinDesc last">${image.description}</p>
                                </div>
                                <div class="content_inner pinContent">
                                    <ul class="pin_meta">
                                        <li class="pin_category"><a class="link_text_black" href="${baseURL}/admin/CollectionManage?edit=${image.collectionId.getCollectionId()}" title=""><span class="icon-category"></span>${image.collectionId.getTitle()}</a></li>
                                        <li class="pin_author"><a class="content_inner pinAuthor link_text_black" href="${baseURL}/admin/UserEdit?UserId=${image.userId.getUserId()}" title=""><span class="icon-user"></span>${image.userId.getName()}</a></li>
                                    </ul>
                                </div>
                                <div class="content_inner">
                                    <a href="${baseURL}/admin/ImageEdit?imageId=${image.imageId}" title=""><img src="../templates/images/btnEdit.png" alt=""></a>
                                    <a href="${baseURL}/admin/ImageDelete?imageId=${image.imageId}" title=""><img src="../templates/images/btnDelete.png" alt=""></a> 
                                </div>
                            </div>
                            <!-- EOF PIN IMAGE -->
                        </c:forEach> 
                        <div class="clear"></div>
                    </c:if>
                </div>
                <!-- EOF MAIN CONTENT -->
            </div>
        </section>
        <section id="footer">
            <div class="container_12">
                <div class="grid_12">
                    <div id="copyRight">&copy; 2013 Web Photo Share. All Rights Reserved</div>
                </div>
            </div>
        </section>
    </body>
</html>