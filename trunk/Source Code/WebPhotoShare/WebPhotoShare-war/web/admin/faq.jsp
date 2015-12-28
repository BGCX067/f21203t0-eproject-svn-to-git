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
                $("#faqForm").validate({
                    rules: {
                        question: {
                            required: true,
                            maxlength: 255
                        },
                        answer: {
                            required: true
                        }
                    },
                    messages: {
                        question: {
                            required: "The question cannot be blank",
                            maxlength: "The question must be less than 255 characters long"
                        },
                        answer: {
                            required: "The answer cannot be blank"
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
                        <li><a href="CollectionManage" title="Collections">Collections</a></li>
                        <li><a href="ImageManage" title="Images">Images</a></li>
                        <li class="active"><a href="FAQManage" title="FAQs">FAQs</a></li>
                        <li><a href="FeedbackManage" title="Feedback">Feedback</a></li>
                        <li><a href="ContactManage" title="Contact">Contact</a></li>
                    </ul>
                </div>
                <div class="breadcrumb">
                    <ul>
                        <li><a href="Dashboard">Dashboard</a></li>
                        <li>FAQs Manage</li>
                    </ul>
                    <a href="Logout" class="buttonLink">Logout</a>
                    <a href="ChangePassword" class="buttonLink">Change Password</a>
                </div>
                <!-- BOF MAIN CONTENT -->
                <div class="grid_9">
                    <h2 class="main-title">Frequently asked questions</h2>
                </div>
                <div class="grid_5">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>Question</th>
                            <th width="140">&nbsp;</th>
                        </tr>
                        <c:forEach var="faq" items="${faqs}">
                            <tr>
                                <td>${faq.question}</td>
                                <td>
                                    <a href="FAQManage?edit=${faq.faqId}" title="">
                                        <img src="${baseURL}/templates/admin/images/btnEdit.png">
                                    </a>
                                    <a href="FAQManage?delete=${faq.faqId}" title="">
                                        <img src="${baseURL}/templates/admin/images/btnDelete.png" alt="">
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <div class="pagination" id="page-nav" style="margin-bottom: 20px;">
                        <c:if test="${currentPage != 1}"> 
                            <a href="${baseURL}/admin/FAQManage?page=${currentPage - 1}">Previous</a>
                        </c:if>
                        <c:forEach begin="1" end="${noOfPages}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq i}"><span>${i}</span></c:when>
                                <c:otherwise><a href="${baseURL}/admin/FAQManage?page=${i}">${i}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage lt noOfPages}">
                            <a class="pager-next" href="${baseURL}/admin/FAQManage?page=${currentPage + 1}">Next</a>
                        </c:if>
                    </div>
                </div>
                <div class="grid_4">
                    <c:choose>
                        <c:when test="${not empty faqEdit}">
                            <h3>Edit FAQs</h3>
                        </c:when>
                        <c:otherwise>
                            <h3>New FAQs</h3>
                        </c:otherwise>
                    </c:choose>
                    <form action="" method="post" id="faqForm">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <th>Question</th>
                                <td><input type="text" name="question" id="question" <c:if test="${not empty faqEdit}">value="${faqEdit.question}"</c:if>></td>
                                </tr>
                                <tr>
                                    <th>Answer</th>
                                    <td><textarea name="answer" id="answer"><c:if test="${not empty faqEdit}">${faqEdit.answer}</c:if></textarea></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>
                                    <c:choose>
                                        <c:when test="${not empty faqEdit}">
                                            <input type="hidden" name="faqID" value="${faqEdit.faqId}">
                                            <input type="hidden" name="action" value="edit">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="insert">
                                        </c:otherwise>
                                    </c:choose>
                                    <input type="submit" value="Save FAQs">
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