<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Admin Dashboard - Web Photo Share</title>
        <c:if test="${empty sessionScope.admin}">
            <meta http-equiv="refresh" content="0; url=login.jsp">
        </c:if>
        <link href="${baseURL}/templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/css/960_12_col.css" rel="stylesheet" type="text/css">
        <link href="${baseURL}/templates/admin/css/admin.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <section id="header">
            <div class="container_12">
                <div class="grid_5" id="logo"><a href="Dashboard" title="">Admin Dashboard</a></div>
                <div class="float-right">Logged in as <c:out value="${sessionScope.admin}"/></div>
            </div>
        </section>
        <section id="mainpage">
            <div class="container_12">
                <div class="grid_3" id="mainMenu">
                    <h3>NAVIGATOR</h3>
                    <ul>
                        <li><a href="Dashboard" title="Dashboard">Dashboard</a></li>
                        <li class="active"><a href="UserManage" title="Users">Users</a></li>
                        <li><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li><a href="ImageManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li><a href="Dashboard">Dashboard</a></li>
                        <li>User Declined</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <div class="actionBar">
                        <ul class="table-menu">
                            <li class="first-menu"><a class="link_text_black" href="UserManage" title=""><span>Users</span></a></li>
                            <li><a class="link_text_black" href="UserValidating" title=""><span>Validating</span></a></li>
                            <li class="last-menu"><a class="link_text_black active" href="UserDeclined" title=""><span>Declined</span></a></li>
                        </ul>
                        <div class="adminSearch">
                            <form method="post" id="searchUser">
                                <label for="searchKeyword">Search User</label>
                                <input type="text" name="searchKeyword" id="searchKeyword" placeholder="Enter your search here...">
                                <input type="submit" value="Search" name="action">
                            </form>
                        </div>
                        <div class="clear"></div> 
                    </div>
                    <h2 class="main-title">Users</h2>
                    <form action="UserDeclined" method="post">
                        <table class="table table-bordered table-striped userList">
                            <thead>
                                <tr>
                                    <th width="1%">&nbsp;</th>
                                    <th>Name</th>
                                    <th>Email address</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${requestScope.userD}">
                                    <tr>
                                        <td><img src="${baseURL}/profiles/${u.userAvatar}" width="30px"></td>
                                        <td><a class="link_text_black" href="UserEdit?UserId=${u.userId}" title="">${u.username}</a></td>  
                                        <td>${u.email}</td>
                                        <td>Declined</td>
                                        <td>
                                            <a href="UserAproveManage?UserId=${u.userId}" title=""><img src="../templates/admin/images/btnApprove.png" alt=""></a>
                                            <a href="UserDelete?UserId=${u.userId}" title=""><img src="../templates/admin/images/btnDelete.png" alt=""></a>
                                        </td> 
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                    </form>
                    <div class="pagination" id="page-nav" style="margin-bottom: 20px;">
                            <c:if test="${currentPage != 1}">
                                <a href="${baseURL}/admin/UserDeclined?page=${currentPage - 1}">Previous</a>
                            </c:if>
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}"><span>${i}</span></c:when>
                                    <c:otherwise><a href="${baseURL}/admin/UserDeclined?page=${i}">${i}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${currentPage lt noOfPages}">
                                <a class="pager-next" href="${baseURL}/admin/UserDeclined?page=${currentPage + 1}">Next</a>
                            </c:if> 
                        </div>
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
