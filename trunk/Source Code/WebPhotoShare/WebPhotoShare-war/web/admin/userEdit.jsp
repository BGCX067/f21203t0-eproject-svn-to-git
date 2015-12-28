<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                $("#userEditForm").validate({
                    rules: {
                        txtName: {
                            required: true,
                            maxlength: 255
                        },
                        txtEmail: {
                            required: true,
                            email: true
                        },
                        password: {
                            minlength: 5,
                            maxlength: 32
                        },
                        confirm_password: {
                            minlength: 5,
                            maxlength: 32,
                            equalTo: "#password"
                        }
                    },
                    messages: {
                        txtName: {
                            required: "Please provide user's name",
                            maxlength: 255
                        },
                        txtEmail: "Please enter a valid email address", 
                        password: {
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long"
                        },
                        confirm_password: {
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long",
                            equalTo: "Please enter the same password as above"
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
                        <li>User Edit</li> 
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->

                <div class="grid_9">
                    <div class="pageHeader">
                        <h2 class="main-title">Editing <span class="userName">${userE.username}</span></h2>
                        <ul class="context_menu">
                            <li><a href="UserDeclinedManage?UserId=${userE.userId}" title=""><img src="../templates/admin/images/btnDecline.png" alt=""></a></li>
                            <li><a href="UserDelete?UserId=${userE.userId}" title=""><img src="../templates/admin/images/btnDelete.png" alt=""></a></li>
                        </ul> 
                    </div>
                </div>
                <form action="" method="post" id="userEditForm">
                    <div class="grid_6">
                        <c:set var="userE" value="${requestScope.userE}"></c:set>
                            <table class="table table-bordered table-striped">
                                <tr><th colspan="2">User Profile</th></tr>
                                <tr>
                                    <td width="145">User ID</td>
                                    <td>${userE.userId}</td>
                            </tr>
                            <tr> 
                                <td>Name</td><td><input type="text" value="${userE.name}" name="txtName" id="txtName" required="" maxlength="255"></td>
                            </tr>
                            <tr>
                                <td>Email</td><td><input type="text" value="${userE.email}" name="txtEmail" id="txtEmail" required="" maxlength="255"></td> 
                            </tr>
                            <tr>
                                <td>Address</td><td><input type="text" value="${userE.address}" name="txtAddress" maxlength="255"></td> 
                            </tr>
                            <tr>
                                <td>Gender - </td><td> 
                                    <c:set var="gender" value="${userE.gender}"/>
                                    <c:if test="${gender==true}">
                                        <input type="radio" name="gender" value="male" id="genderMale" checked><label for="genderMale">Male</label>
                                        <input type="radio" name="gender" value="female" id="genderFemale"><label for="genderFemale">Female</label>                                     
                                    </c:if>
                                    <c:if test="${gender==false}"> 
                                        <input type="radio" name="gender" value="male" id="genderMale" ><label for="genderMale">Male</label>
                                        <input type="radio" name="gender" value="female" id="genderFemale" checked><label for="genderFemale">Female</label>
                                    </c:if>

                                </td> 
                            </tr>
                            <tr>
                                <td>Year of Birth</td>
                                <td>
                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                    <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
                                    <select name="birthYear" id="birthYear">
                                        <c:forEach begin="${currentYear-100}" end="${currentYear-15}" var="year">
                                            <c:choose>
                                                <c:when test="${userE.birthYear eq year}">
                                                    <option selected="selected"><c:out value="${year}"/></option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option><c:out value="${year}"/></option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </td> 
                            </tr> 
                            <tr>
                                <td>Status</td>
                                <td>
                                    <c:choose>
                                            <c:when test="${userE.userStatus eq 0}">Validating</c:when>
                                            <c:when test="${userE.userStatus eq 1}">Activated</c:when>
                                            <c:when test="${userE.userStatus eq 2}">Declined</c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr><th colspan="2">Change password</th></tr>
                                <tr>
                                    <td>New Password</td><td><input type="password" name="password" id="password" placeholder="New Password"></td>
                                </tr>
                                <tr>
                                    <td>Re-enter New Password</td><td><input type="password" name="confirm_password" id="confirm_password" placeholder="Re-enter New Password"></td>
                                </tr>
                            <c:if test="${not empty requestScope.errors}">
                                <tr>
                                    <td colspan="2">
                                        <div class="error_message">
                                            <h3>The form you submitted contained the following errors</h3>
                                            <ol>
                                                <c:forEach var="i" items="${requestScope.errors}">
                                                    <li><c:out value="${i}"/></li>
                                                    </c:forEach>
                                            </ol>
                                        </div>   
                                    </td>
                                </tr>
                            </c:if>
                            <tr>
                                <td></td>
                            <input type="hidden" name="userID" value="${userE.userId}">
                            <input type="hidden" name="txtPassword" value="${userE.password}">
                            <input type="hidden" name="reset_password_key" value="${userE.resetPasswordKey}">
                            <input type="hidden" name="join_date" value="${userE.joinDate}">
                            <input type="hidden" name="user_avatar" value="${userE.userAvatar}">
                            <td><input type="submit" value="Save User" name="action"/></td>
                            </tr> 
                        </table>
                    </div>
                </form>

                <div class="grid_3">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <td><img src="${baseURL}/profiles/${userE.userAvatar}" width="200px"></td>
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
