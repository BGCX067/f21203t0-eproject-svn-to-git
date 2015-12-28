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
                    <li class="active"><a href="Dashboard" title="Dashboard">Dashboard</a></li>
                    <li><a href="UserManage" title="Users">Users</a></li>
                    <li><a href="CollectionManage" title="Collections">Collections</a></li>
                    <li><a href="ImageManage" title="Images">Images</a></li>
                    <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                    <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                    <li><a href="ContactManage" title="Contact">Contact</a></li>
                </ul>
            </div>
            <div class="breadcrumb">
                <ul>
                    <li>Dashboard</li>
                </ul>
                <a href="Logout" class="buttonLink">Logout</a>
                <a href="ChangePassword" class="buttonLink">Change Password</a>
            </div>
            <!-- BOF MAIN CONTENT -->
            <div class="grid_5">
                <h2 class="main-title no-border no-space">Quick Search</h2>
                <table class="table table-bordered table-striped">
                    <tr>
                        <td>Find User</td>
                        <td><input type="text" name="searchUser" placeholder="Username, name"></td>
                        <td width="1%"><input type="submit" value="GO"></td>
                    </tr>
                    <tr>
                        <td>Find Collection</td>
                        <td><input type="text" name="searchCollection" placeholder="Input collection name"></td>
                        <td width="1%"><input type="submit" value="GO"></td>
                    </tr>
                    <tr>
                        <td>Find Image</td>
                        <td><input type="text" name="searchImage" placeholder="Image title, description"></td>
                        <td width="1%"><input type="submit" value="GO"></td>
                    </tr>
                </table>
            </div>
            <div class="grid_4">
                <h2 class="main-title no-border no-space">Site Static</h2>
                <table class="table table-bordered table-striped">
                    <tr>
                        <td>
                            <strong>Total users</strong>
                            <div class="sub desctext">
                                Awaiting Validation:<br>
                                Locked Account:<br>
                                Newest User:
                            </div>
                        </td>
                        <td>
                            <strong>${totalUser}</strong>
                            <div class="sub desctext">
                                <a href="UserValidating" title="">Manage (${userValidating})</a><br>
                                <a href="UserDeclined" title="">Manage (${userDeclined})</a><br>
                                <a href="" title="">${latestUser.name}</a><br>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Total images</strong></td>
                        <td><strong>${totalImage}</strong></td>
                    </tr>
                </table>
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