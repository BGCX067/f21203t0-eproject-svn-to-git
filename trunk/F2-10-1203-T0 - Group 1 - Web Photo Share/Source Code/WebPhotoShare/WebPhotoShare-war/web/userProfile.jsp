<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script type="text/javascript" src="${baseURL}/templates/jscripts/common.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#profileForm").validate({
                    rules: {
                        name: {
                            required: true,
                            maxlength: 255
                        },
                        email: {
                            required: true
                        },
                        address: {
                            required: true
                        }
                    },
                    messages: {
                        name: {
                            required: "The question cannot be blank",
                            maxlength: "The question must be less than 255 characters long"
                        },
                        email: {
                            required: "The answer cannot be blank",
                            maxlength: "The question must be less than 255 characters long"
                        },
                        address: {
                            maxlength: "The question must be less than 255 characters long"
                        }
                    }
                });
            });
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
                        <a href="MyProfile" class="button active">My Profile Setting</a>
                        <a href="MyImage" class="button link_text_black">My Uploaded Images</a>
                        <a href="MyFriend" class="button link_text_black">My Friends
                            <c:if test="${not empty sessionScope.newFriends}">
                                <span class="desc">(${sessionScope.newFriends} new requests)</span>
                            </c:if>
                        </a>
                    </div>
                </div>
                <!-- EOF USER PROFILE -->
            </div>
            <!-- EOF USER CONTAITNER -->
            <!-- BOF MAIN CONTENT -->
            <div class="grid_6 content border_radius box_shadow">
                <h2 class="main-title">Account Settings</h2>
                <div class="content_inner form">
                    <form method="post" id="profileForm">
                        <div class="row">
                            <label for="userName">Your name</label>
                            <input type="text" name="name" id="userName" value="${profile.name}" maxlength="255" required="">
                        </div>
                        <div class="row">
                            <label for="">Password</label>
                            <a href="MyPassword" title="">Change your password...</a>
                        </div>
                        <div class="row">
                            <label for="userAddress">Address</label>
                            <input type="text" name="userAddress" id="userAddress" value="${profile.address}" maxlength="255">
                        </div>
                        <div class="row">
                            <label for="userEmail">Email</label>
                            <input type="email" name="userEmail" id="userEmail" value="${profile.email}" maxlength="255">
                        </div>
                        <div class="row">
                            <label for="gender">Gender</label>
                            <c:choose>
                                <c:when test="${profile.gender eq true}">
                                    <input type="radio" name="gender" value="male" id="genderMale" checked><label for="genderMale" class="labelGender">Male</label>
                                    <input type="radio" name="gender" value="female" id="genderFemale"><label for="genderFemale" class="labelGender">Female</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="gender" value="male" id="genderMale"><label for="genderMale" class="labelGender">Male</label>
                                    <input type="radio" name="gender" value="female" id="genderFemale" checked><label for="genderFemale" class="labelGender">Female</label>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="row">
                            <label for="userYearOfBirth">Year of Birth</label>
                            <c:set var="now" value="<%=new java.util.Date()%>" />
                            <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
                            <select name="userYearOfBirth" id="userYearOfBirth">
                                <c:forEach begin="${currentYear-100}" end="${currentYear-15}" var="year">
                                    <c:choose>
                                        <c:when test="${profile.birthYear eq year}">
                                            <option selected="selected"><c:out value="${year}"/></option>
                                        </c:when>
                                        <c:otherwise>
                                            <option><c:out value="${year}"/></option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="row">
                            <label for="">Account status</label>
                            <span class="active">Activated</span>
                        </div>
                        <div class="row">
                            <label for="">Join Date</label>
                            <fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${profile.joinDate}"/>
                        </div>
                        <div class="row">
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
                            <label>&nbsp;</label>
                            <input type="hidden" name="userID" value="${profile.userId}">
                            <input type="hidden" name="userName" value="${profile.username}">
                            <input type="hidden" name="userStatus" value="${profile.userStatus}">
                            <input type="hidden" name="password" value="${profile.password}">
                            <input type="submit" class="size_L blue" value="Save Settings"> 
                        </div>
                    </form>
                </div>
            </div>
            <div class="grid_3 content border_radius box_shadow">
                <h2 class="main-title">My Avatar</h2>
                <div class="profile_avatar">
                    <img src="${baseURL}/profiles/${profile.userAvatar}" alt="">
                </div>
                <hr>
                <div class="content_inner">
                    <form action="UpdateAvatar" method="post" enctype="multipart/form-data">
                        <input type="file" name="avatarFile" id="avatarFile" accept="image/*" required="required">
                        <input type="hidden" name="userID" value="${profile.userId}">
                        <input type="submit" class="blue" value="Update Avatar">
                    </form>
                </div>
            </div>
            <!-- BOF MAIN CONTENT -->
        </section>
        <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
    </body>
</html>