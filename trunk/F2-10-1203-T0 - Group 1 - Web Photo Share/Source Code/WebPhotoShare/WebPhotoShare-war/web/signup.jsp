<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sign Up Form - Web Photo Share</title>
        <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="templates/css/login.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.min.js"></script>
        <script type="text/javascript" src="${baseURL}/templates/jscripts/jquery.validate.min.js"></script>
        <script language='javascript' type='text/javascript'>
            $().ready(function() {
                // validate signup form on keyup and submit
                $("#registerForm").validate({
                    rules: {
                        txtName: {
                        required: true,
                        maxlength: 32
                        },
                        txtUsername: {
                            required: true,
                            minlength: 5,
                            maxlength: 32
                        },
                        txtPassword: {
                            required: true,
                            minlength: 5,
                            maxlength: 32
                        },
                        yearOfBirth:{
                            required: true
                        }
                    },
                    messages: {
                        txtName: {
                            required: "Please provide your name",
                            maxlength: "Your name must be less than 255 characters long"
                        },
                        txtUsername: {
                            required: "Please provide your username",
                            minlength: "Your username must be at least 5 characters long",
                            maxlength: "Your username must be less than 32 characters long"
                        },
                        txtPassword: {
                            required: "Please provide a password",
                            minlength: "Your password must be at least 5 characters long",
                            maxlength: "Your password must be less than 32 characters long"
                        },
                        yearOfBirth: "Please provide your year of birth"
                    }
                });
            });
        </script>
    </head>
    <body>
        <div id="visitorForm">
            <div class="formWrapper">
                <h1 class="siteLogo"><span>Web Photo Share</span></h1>
                <div class="content box_shadow border_radius signUpForm">
                    <div class="formContainer">
                        <h2>Sign Up Account</h2>
                        <form method="post" action="Register" id="registerForm">
                            <input type="text" name="txtName" id="txtName" placeholder="Your name" required>
                            <input type="text" name="txtUsername" id="txtUsername" placeholder="Username" required>
                            <input type="password" name="txtPassword" id="txtPassword" placeholder="Password" required>
                            <input type="email" name="txtEmail" id="txtEmail" placeholder="Your Email address" required>
                            <div class="clear"></div>
                            <div class="one_half">
                                <input type="radio" name="gender" value="1" id="genderMale" checked><label for="genderMale">Male</label>
                                <input type="radio" name="gender" value="0" id="genderFemale"><label for="genderFemale">Female</label>
                            </div>
                            <div class="one_half last">
                                <label for="yearOfBirth">Year of birth</label>
                                <select name="yearOfBirth" id="yearOfBirth">
                                    <option disabled selected>Year</option>
                                    <c:set var="now" value="<%=new java.util.Date()%>" />
                                    <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
                                    <c:forEach begin="${currentYear-100}" end="${currentYear-15}" var="year">
                                        <option><c:out value="${year}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="clear"></div>
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
                            <p>By creating an account, I accept Web Photo Share's <a href="" title="">Terms of Service</a> and <a href="" title="">Privacy Policy</a>.</p>
                            <div class="formButtonContainer">
                                <a class="button size_L" href="index.jsp" title="Cancel">Cancel</a>
                                <input type="hidden" name="key" value="register">
                                <input class="blue size_L" type="submit" value="Sign Up">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>