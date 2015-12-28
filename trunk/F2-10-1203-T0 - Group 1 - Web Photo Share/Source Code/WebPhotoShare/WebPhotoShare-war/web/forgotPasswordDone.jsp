<%-- 
    Document   : forgotPassword
    Created on : Oct 13, 2013, 2:44:56 PM
    Author     : Hung Nguyen
--%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Account Recovery Form - Web Photo Share</title>
    <link href="templates/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="templates/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="visitorForm">
        <div class="formWrapper">
            <h1 class="siteLogo"><span>Web Photo Share</span></h1>
            <div class="content box_shadow border_radius">
                <div class="formContainer">
                    <h2>Account Recovery</h2>
                    <h3>A recovery email has been sent to ${requestScope.email}</h3>
                    <p align="justify">If you don't see this email in your inbox within 15 minutes, look for it in your junk-mail folder. If you find it there, please mark the email as Not Junk.</p>
                    <p><a href="index.jsp" title="Web Photo Share">Homepage</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>