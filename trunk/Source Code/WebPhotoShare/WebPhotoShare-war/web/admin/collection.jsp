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
                        collectionDescription: {
                            required: true,
                            maxlength: 255
                        }
                    },
                    messages: {
                        collectionTitle: {
                            required: "Collection title cannot be blank",
                            maxlength: "Collection title must be less than 255 characters long"
                        },
                        collectionDescription: {
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
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>Collection</th>
                            <th width="140">&nbsp;</th>
                        </tr>
                        <c:forEach var="collection" items="${collections}">
                            <tr>
                                <td>
                                    ${collection.title}
                                    <div class="sub desc">
                                        <c:if test="${collection.status eq false}">
                                            <font color="red">Disabled</font><br>
                                        </c:if>
                                        ${collection.description}
                                    </div>
                                </td>
                                <td>
                                    <a href="CollectionManage?edit=${collection.collectionId}" title=""><img src="${baseURL}/templates/admin/images/btnEdit.png"></a>
                                    <a href="CollectionDelete?cid=${collection.collectionId}" title=""><img src="${baseURL}/templates/admin/images/btnDelete.png" alt=""></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="pagination" id="page-nav" style="margin-bottom: 20px;">
                        <c:if test="${currentPage != 1}">
                            <a href="${baseURL}/admin/CollectionManage?page=${currentPage - 1}">Previous</a>
                        </c:if>
                        <c:forEach begin="1" end="${noOfPages}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq i}"><span>${i}</span></c:when>
                                <c:otherwise><a href="${baseURL}/admin/CollectionManage?page=${i}">${i}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage lt noOfPages}">
                            <a class="pager-next" href="${baseURL}/admin/CollectionManage?page=${currentPage + 1}">Next</a>
                        </c:if>
                    </div>
                </div>
                <div class="grid_3">
                    <h3>Collection Form</h3>
                    <form action="" method="post" id="collectionForm">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <th>Collection</th>
                                <td><input type="text" name="collectionTitle" id="collectionTitle" <c:if test="${not empty collectionEdit}">value="${collectionEdit.title}"</c:if> placeholder="Collection name"></td>
                                </tr>
                                <tr>
                                    <th>Description</th>
                                    <td>
                                        <textarea name="collectionDescription" id="collectionDescription" placeholder="Description"><c:if test="${not empty collectionEdit}">${collectionEdit.description}</c:if></textarea>
                                    </td>
                                </tr>
                            <c:if test="${not empty collectionEdit}">
                                <tr>
                                    <th>Status</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${collectionEdit.status eq false}">
                                                <input type="radio" name="status" id="statusEnable" value="1"><label for="statusEnable">Enable</label><div class="clear"></div>
                                                <input type="radio" name="status" id="statusDisable" value="0" checked="checked"><label for="statusDisable">Disabled</label>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="radio" name="status" id="statusEnable" value="1" checked="checked"><label for="statusEnable">Enabled</label><div class="clear"></div>
                                                <input type="radio" name="status" id="statusDisable" value="0"><label for="statusDisable">Disable</label>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty collectionEdit}">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="collectionId" value="${collectionEdit.collectionId}">
                                            <input type="submit" value="Save Collection">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="insert">
                                            <input type="submit" value="Insert Collection">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </form> 
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