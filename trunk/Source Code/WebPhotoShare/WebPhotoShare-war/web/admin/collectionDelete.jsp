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
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#collectionForm").validate({
                    rules: {
                        collectionTitle: {
                            required: true,
                            maxlength: 255
                        },
                        collectionDescription:{
                            required: true,
                            maxlength: 255
                        }
                    },
                    messages: {
                        collectionTitle: {
                            required: "Collection title cannot be blank",
                            maxlength: "Collection title must be less than 255 characters long"
                        },
                        collectionDescription:{
                            required: "Collection description cannot be blank",
                            maxlength: "Collection description must be less than 255 characters long"
                        }
                    }
                });
            });
        </script>
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
                        <li><a href="UserManage" title="Users">Users</a></li>
                        <li class="active"><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li><a href="ImageManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li><a href="Dashboard">Dashboard</a></li>
                        <li>Collection Manage</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <div class="pageHeader">
                        <h2 class="main-title">Collections</h2>
                        <div class="adminSearch">
                            <form method="post" id="searchCollections">
                                <label for="searchKeyword">Search Collections</label>
                                <input type="text" name="searchKeyword" id="searchKeyword" placeholder="Enter your search here...">
                                <input type="submit" value="Search">
                            </form>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="grid_6">
                    <div class="pageHeader">
                        <h2>Delete Collection</h2>
                    </div>
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>Collection ID</th>
                            <td>${collectionDelete.collectionId}</td>
                        </tr>
                        <tr>
                            <th>Collection Name</th>
                            <td>${collectionDelete.title}</td>
                        </tr>
                        <tr>
                            <th>Description</th>
                            <td>
                                ${collection.description}
                                <div class="sub desc">
                                <c:if test="${collection.status eq false}">
                                    <font color="red">Disabled</font><br>
                                </c:if>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="error_message">
                                    Delete this collection will permanently delete others related information like images, comments.<br>
                                    Do you want to delete?
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <form action="" method="post">
                                    <a href="CollectionManage" title="">Cancel</a>
                                    <input type="hidden" name="cid" value="${collectionDelete.collectionId}">
                                    <input type="submit" value="Delete Collection">
                                </form>
                            </td>
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