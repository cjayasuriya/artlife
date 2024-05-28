<%-- 
    Document   : reset
    Created on : Mar 21, 2017, 11:53:20 AM
    Author     : chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <style>
            body{background-image:url("../IMAGES/signinbody.jpeg");background-repeat: no-repeat; background-size:100%;}

            .btn-primary{
                background-color:#ac7339;
                border-color:#ac7339;
            }
            .btn-primary:focus{
                background-color:#ac7339;
                border-color:#ac7339;
            }
            .btn-primary:hover{
                background-color: #663300;
                border-color: #663300;
            }

            .box{
                padding: 10px;
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                background-color:#f9f2ec; 
            } 
            hr{
                color: #ac7339;
                background-color: #ac7339;
                height: 1px;
            }



        </style>



        <title>Forgot password - Art Life</title>

    </head>
    <body>
        <jsp:include page="../nevbartwo.jsp" />
        <div class="container-fluid">
            <div class="row">

                <div class="col-md-12">
                    <div class="col-md-4 col-md-offset-4">

                        <div class="row box">
                            <div class="col-md-12 text-center">
                                <h1>Art Life</h1>
                                <h4 style="color: #663300">Forgot your password</h4>
                                <hr>
                            </div>
                            <!-- Submitting verification code -->
                            <%
                                try {
                                    if (request.getSession().getAttribute("fpActiveToTypeRandomText").equals("Active")) {
                            %>

                            <div class="col-md-12 text-center">
                                <p style="color: #663300">We've emailed you a verification code. </p>
                            </div>
                            <div class="col-md-12"><br/></div>
                            <form action="../ForgotPasswordVerifyCodeServlet" method="POST">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="verifivationCode" placeholder="Verification code" required="required" />
                                    </div>
                                </div>

                                <%
                                    if (request.getSession()
                                            .getAttribute("fpErrorMsg") != null) {
                                %>
                                <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                    <p><span class="glyphicon glyphicon-warning-sign"></span>
                                        <%=request.getSession().getAttribute("fpErrorMsg").toString()%>
                                    </p>
                                </div>
                                <%
                                    }
                                %>
                                <div class="col-md-12"><br/></div>
                                <div class="col-md-12">
                                    <input type="submit" class="btn btn-primary btn-block" name="verifyCode" value="Submit"/>
                                </div>
                                <div><br/><br/></div>
                                <div class="col-md-12">
                                    <hr>
                                </div>
                                <div class="col-md-12"><br/></div>
                            </form>    
                        </div>
                        <div class="col-md-12"><br/></div>


                        <%
                        } else if (request.getSession().getAttribute("fpChangePassword").equals("Active")) {
                        %>
                        <!-- Create new password -->
                        <%request.getSession().setAttribute("fpActiveToTypeRandomText", "Inactive");%>
                        <div class="col-md-12 text-center">
                            <p style="color: #663300">Verification successful. Create your new password </p>
                        </div>
                        <div class="col-md-12"><br/></div>
                        <form action="../ForgotPasswordChangepassword" method="POST">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="password" class="form-control" name="newPassword" placeholder="New password" required="required" />
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" required="required" />
                                </div>
                            </div>

                            <%
                                if (request.getSession()
                                        .getAttribute("fpErrorMsg") != null) {
                            %>
                            <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                <p><span class="glyphicon glyphicon-warning-sign"></span>
                                    <%=request.getSession().getAttribute("fpErrorMsg").toString()%>
                                </p>
                            </div>
                            <%
                            } else if (request.getSession()
                                    .getAttribute("fpPasswordErrorMsg") != null) {
                            %>
                            <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                <p><span class="glyphicon glyphicon-warning-sign"></span>
                                    <%=request.getSession().getAttribute("fpPasswordErrorMsg").toString()%>
                                </p>
                            </div>
                            <%
                                }
                            %>
                            <div class="col-md-12"><br/></div>
                            <div class="col-md-12">
                                <input type="submit" class="btn btn-primary btn-block" name="changePasswordBtn" value="Create new password"/>
                            </div>
                            <div><br/><br/></div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <div class="col-md-12"><br/></div>
                        </form>    
                    </div>
                    <div class="col-md-12"><br/></div>
                        <%
                            }
                        } catch (Exception e) {
                        %>
                    <!-- Email verification -->
                    <%request.getSession().setAttribute("fpActiveToTypeRandomText", "Inactive");%>
                    <div class="col-md-12 text-center">
                        <p style="color: #663300">Type your email to verify your account. </p>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <form action="../ForgotPasswordEmailVerifyServlet" method="POST">
                        <div class="col-md-12">
                            <div class="form-group">
                                <input type="email" class="form-control" name="useremail" placeholder="Email" required="required" onblur="validateEmail()"/>
                            </div>
                        </div>

                        <%
                            if (request.getSession()
                                    .getAttribute("fpErrorMsg") != null) {
                        %>
                        <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                            <p><span class="glyphicon glyphicon-warning-sign"></span>
                                <%=request.getSession().getAttribute("fpErrorMsg").toString()%>
                            </p>
                        </div>
                        <%
                        } else if (request.getSession()
                                .getAttribute("fpEmailErrorMsg") != null) {
                        %>
                        <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                            <p><span class="glyphicon glyphicon-warning-sign"></span>
                                <%=request.getSession().getAttribute("fpEmailErrorMsg").toString()%>
                            </p>
                        </div>
                        <%
                        } else if (request.getSession()
                                .getAttribute("fpPasswordErrorMsg") != null) {
                        %>
                        <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                            <p><span class="glyphicon glyphicon-warning-sign"></span>
                                <%=request.getSession().getAttribute("fpPasswordErrorMsg").toString()%>
                            </p>
                        </div>
                        <%
                        } else if (request.getSession()
                                .getAttribute("fpBlockErrorMsg") != null) {
                        %>
                        <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                            <p><span class="glyphicon glyphicon-warning-sign"></span>
                                <%=request.getSession().getAttribute("fpBlockErrorMsg").toString()%>
                            </p>
                        </div>
                        <%
                            }
                        %>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-primary btn-block" name="verifyEmail" value="Verify email"/>
                        </div>
                        <div><br/><br/></div>
                        <div class="col-md-12">
                            <hr>
                        </div>
                        <div class="col-md-12"><br/></div>
                    </form>    
                </div>
                <div class="col-md-12"><br/></div>

                <%
                    }
                %>

            </div>
        </div>
    </div>  
</div>
</body>

<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script type="text/javascript">
                                    //EMAIL VALIDATION
                                    function validateEmail() {
                                        var email = document.getElementById('useremail').value;
                                        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                                        if (re.test(email)) {
                                            document.getElementById('useremail').style.borderColor = "green";
                                            document.getElementById('verifyEmail').disabled = false;
                                        } else {
                                            document.getElementById('useremail').style.borderColor = "red";
                                            document.getElementById('verifyEmail').disabled = true;
                                        }
                                    }
</script>

</html>
