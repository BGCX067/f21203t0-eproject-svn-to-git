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
                    <p align="justify">If you can't sign in or have forgotten your password, enter your email address below, and we will send you instructions to get you signed in.</p>
                    <form method="post">
                        <input type="email" name="txtEmail" placeholder="Your email address" required>
                        <div class="formButtonContainer">
                            <a class="button size_L" href="Login" title="Login">Login</a>
                            <input class="blue size_L" type="submit" value="Send Account Recovery Email">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>