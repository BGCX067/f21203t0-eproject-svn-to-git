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
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#editImageForm").validate({
                    rules: {
                        imageTitle: {
                            required: true,
                            maxlength: 255
                        }
                    },
                    messages: {
                        imageTitle: {
                            required: "The title cannot be blank",
                            maxlength: "The question must be less than 255 characters long"
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
                        <li class="active"><a href="ImageManage" title="Images">Images</a></li>
                        <li><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="02-admin-Contact.html" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li>Images Management</li>
                    </ul>
                    <a href="admin.jsp" class="buttonLink">Logout</a>
                    <a href="02-admin-Change-Password.html" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <h2 class="main-title">Editing <span class="title">${image.title}</span></h2>
                    <form id="editImageForm" action="" method="post">
                        <table class="table table-bordered table-striped form">
                            <tr>
                                <td width="1%">
                                    <p><img src="${baseURL}${image.path}/${image.filename}" width="220px" alt=""></p>
                                    <p><strong>Uploaded by: ${image.userId.getName()}</strong></p>
                                </td>
                                <td valign="top" style="vertical-align:top !important">
                                    <p><input type="text" name="imageTitle" id="imageTitle" placeholder="Image title" value="${image.title}" required="" maxlength="255"></p>
                                    <p><textarea rows="5" name="imageDesc" placeholder="Description">${image.description}</textarea></p>
                                    <p>
                                        <label>Collection:</label>
                                        <select name="imageCollection" id="imageCollection" style="width:200px">
                                            <c:forEach var="collection" items="${collections}" varStatus="status">
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
                                    </p> 
                                    <p>
                                        <label>Access</label> 
                                        <select name="imagePrivacy" id="imagePrivacy" style="width:200px">
                                            <option<c:if test="${image.shareStatus eq 0}"> selected="selected"</c:if> value="0">Private</option>
                                            <option<c:if test="${image.shareStatus eq 1}"> selected="selected"</c:if> value="1">Friend Only</option>
                                            <option<c:if test="${image.shareStatus eq 2}"> selected="selected"</c:if> value="2">Public</option>
                                            </select>
                                        </p>
                                        <p></p>
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
                                    <p><input type="submit" value="Save Image"></p>
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