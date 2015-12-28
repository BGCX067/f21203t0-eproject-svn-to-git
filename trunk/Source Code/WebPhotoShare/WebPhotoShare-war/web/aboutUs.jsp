<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>About Us - Web Photo Share</title>
    <link href="templates/css/960_12_col.css" rel="stylesheet" type="text/css">
    <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="templates/css/users.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="templates/jscripts/jquery.min.js"></script>
    <script type="text/javascript" src="templates/jscripts/common.js"></script>
</head>
<body>
    <section id="header">
        <div class="headerBackground"></div>
        <div class="headerContainer container_12">
            <div class="leftHeaderContent grid_4">
                <c:if test="${not empty sessionScope.user}">
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
                                <a href="admin/ContacManager" class="button link_text_black">ManagerContact</a>
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
                </c:if>
            </div>
            <!-- EOF LEFT HEADER CONTENT -->
            <!-- BOG LOGO -->
            <div class="grid_4">
                <h1 class="siteTitle">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="Home" title=""><span>Web Photo Share</span></a>
                        </c:when>
                        <c:otherwise>
                            <a href="index.jsp" title=""><span>Web Photo Share</span></a>
                        </c:otherwise>
                    </c:choose>
                </h1>
            </div>
            <!-- BOG LOGO -->
            <c:if test="${not empty sessionScope.user}">
            <!-- BOF RIGHT HEADER CONTENT -->
            <div class="rightHeaderContent grid_4">
                <ul class="table-menu">
                    <li class="first-menu"><span><strong><c:out value="${sessionScope.user}"/></strong></span></li>
                    <li class="last-menu"><a class="link_text_black" href="Logout" title=""><span>Logout</span></a></li>
                </ul>
                <span class="welcome">Welcome</span>
            </div>
            <!-- EOF RIGHT HEADER CONTENT -->
            </c:if>
        </div>
    </section>
    <section class="container_12" id="main_content_area">
        <!-- BOF USER CONTAITNER -->
        <div class="grid_3 pin_box">
            <%@include file="templateSiteNavigation.jsp"%>
        </div>
        <!-- EOF USER CONTAITNER -->
        <!-- BOF MAIN CONTENT -->
        <div class="grid_9 content border_radius box_shadow">
            <h2 class="main-title">About Us</h2>
            <div class="content_inner">
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus suscipit scelerisque augue. In eu neque ut metus commodo vestibulum eget sit amet dolor. Sed pellentesque, ligula ut consectetur tincidunt, ligula turpis varius justo, nec sagittis lorem diam at lacus. Sed ut sem id odio tempor viverra. Aenean sagittis, metus quis tincidunt lobortis, sem nisi dapibus libero, non imperdiet nisl ligula ut enim. Aliquam egestas tempus tortor, ac egestas tortor rutrum vel. Fusce vestibulum dolor interdum est lobortis, vitae rhoncus lectus ultricies.</p>
                <p>Donec molestie eros tellus, dapibus euismod turpis venenatis non. Ut bibendum sed felis sed ultricies. Ut et magna purus. Proin odio nibh, tincidunt eu volutpat varius, tincidunt at ante. Maecenas gravida nulla vitae porttitor ultrices. Vestibulum vitae dolor ac ligula convallis aliquet quis vitae sem. Aenean eleifend eros ac suscipit aliquam. Etiam ut velit mauris. Quisque mattis suscipit metus ut aliquam.</p>
                <p>Praesent tincidunt sed eros non fringilla. Maecenas justo lorem, dictum sit amet massa in, euismod posuere elit. Sed eu erat sed lectus aliquam placerat. Nulla nec cursus erat. In eu ante sagittis, consectetur ipsum eu, sagittis quam. Cras aliquet auctor tellus id accumsan. Vestibulum cursus adipiscing lacinia. Integer egestas ipsum id nisi aliquam, malesuada condimentum libero pretium. Sed hendrerit tempus mi, non euismod nisi iaculis non. Integer porta nulla nisl, eget semper nunc eleifend bibendum. Pellentesque rhoncus libero et leo tristique, a accumsan est consectetur. Pellentesque odio mi, malesuada non tristique a, venenatis pretium felis. Maecenas rutrum accumsan diam quis posuere. Aliquam elit magna, auctor vitae dignissim vel, pulvinar vel turpis. Pellentesque cursus ipsum sem.</p>
                <p>Integer ut suscipit nisl. Etiam non nisl nibh. Maecenas justo libero, rutrum sed nunc sed, malesuada dictum risus. Phasellus lacus tortor, mollis sed consectetur vitae, vehicula quis tellus. Maecenas lorem magna, accumsan sit amet dolor vitae, feugiat ullamcorper dolor. Fusce gravida justo sed diam consequat, eget porta ligula feugiat. Duis mollis lorem placerat felis adipiscing placerat. Pellentesque ac ante feugiat, fringilla nulla sollicitudin, molestie erat. Vivamus euismod, turpis eget ornare rutrum, diam felis iaculis augue, hendrerit fringilla ipsum velit eu velit. Sed vitae diam massa. Etiam euismod tempus libero, vitae consectetur lacus adipiscing in.</p>
            </div>
        </div>
        <!-- BOF MAIN CONTENT -->
    </section>
    <span id="back-top" style="display: block;"><a href="#top">TOP</a></span>
</body>
</html>