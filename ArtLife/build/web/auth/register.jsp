<%-- 
    Document   : register
    Created on : Sep 2, 2016, 1:10:42 PM
    Author     : Chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../CSS/intlTelInput.css" rel="stylesheet" type="text/css"/>

        <style>
            
            body{background-image:url("../IMAGES/register_page.jpeg");background-repeat: no-repeat; background-size:100%;}
            
            .box{
                padding: 50px 10px;
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                background-color:#f9f2ec; 
            } 
        </style>

        <title>Create account - Art Life</title>
    </head>
    <body>
        <jsp:include page="../nevbartwo.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h2>Create your account</h2>
                </div>
                <div class="col-md-12"></br></div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="text-center">
                            <h3>We are here for your every need</h3> 
                            <p>A single username and password gets into everything.</p>
                        </div>
                        <div class="text-center">
                            <h5><b>Subscribe, get updates, new events, purchase products and lots more...</b></h5>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <form method="POST" action="../CreateAccountServlet">
                            <!-- HIDDEN FIELDS-->
                            <input id="hiddenphonefull" type="hidden" name="phonefull">

                            <div class="col-md-12">
                                <div class="col-md-8 col-md-offset-2 box">
                                    <%
                                        if (request.getSession().getAttribute("createErrorMsgNull") != null) {
                                    %>
                                    <div class="col-md-12" style="text-align: left;color: red;">
                                        <p><span class="glyphicon glyphicon-exclamation-sign"></span>
                                            <%
                                                out.write(request.getSession().getAttribute("createErrorMsgNull").toString());
                                            %>
                                        </p>
                                    </div>
                                    <%
                                    } else if (request.getSession().getAttribute("createErrorEmailCheckMsg") != null) {
                                    %>
                                    <div class="col-md-12" style="text-align: left;color: red;">
                                        <p><span class="glyphicon glyphicon-warning-sign"></span>
                                            <%
                                                out.write(request.getSession().getAttribute("createErrorEmailCheckMsg").toString());
                                            %>
                                        </p>
                                    </div>
                                    <%
                                    } else if (request.getSession().getAttribute("createErrorMsg") != null) {
                                    %>
                                    <div class="col-md-12" style="text-align: left;color: red;">
                                        <p><span class="glyphicon glyphicon-warning-sign"></span>
                                            <%
                                                out.write(request.getSession().getAttribute("createErrorMsg").toString());
                                            %>
                                        </p>
                                    </div>
                                    <%}%>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="text" id="firstname" class="form-control" name="firstname" placeholder="First name" required="required"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="text" id="lastname" class="form-control" name="lastname" placeholder="Last name" required="required"/>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="email" id="email" class="form-control" name="email" placeholder="Email address" required="required" onblur="validateEmail()"/>
                                        </div>
                                    </div>
                                    <div class="col-md-12 text-right" id="emailCheckErrorMsg" style="disabled:true;color: red;"></div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="password" id="password" class="form-control" name="password" placeholder="Create a password" required="required" data-toggle="password"/>                             
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="password" id="confirmpassword" class="form-control" name="confirmpassword" placeholder="Confirm password" required="required" onblur="checkPassword()" />
                                        </div>
                                    </div>
                                    <div class="col-md-12 text-right" id="passwordCheckErrorMsg" style="disabled:true;color: red;"></div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="tel" id="mobilenumber" class="form-control" name="mobilenumber"  required="required"/>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="md-checkbox">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="checkbox1" class="md-checkbox" value="true" required="required">
                                                I  agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-12"><br/></div>
                                    <div class="col-md-5 col-md-offset-7">
                                        <div class="form-group">
                                            <input type="submit" class="btn btn-primary btn-block"  id="createaccount" name="createaccount" value="Next" onclick="checkRequiredFields()"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../JS/intlTelInput.min.js" type="text/javascript"></script>

    <!--ADDING COUNTRY FLAG TO MOBILE NUMBER -->
    <script type="text/javascript">
                                                $("#mobilenumber").intlTelInput({
                                                    utilsScript: "../JS/utils.js"
                                                });
                                                $("form").submit(function() {
                                                    $("#hiddenphonefull").val($("#mobilenumber").intlTelInput("getNumber"));
                                                });
    </script>
    <!--PASSWORD VALIDATION-->
    <script type="text/javascript">
        //PASSWORD VALIDATION
        function checkPassword() {
            var newPasswordField = document.getElementById('password').value;
            var confirmPasswordField = document.getElementById('confirmpassword').value;

            if (newPasswordField.trim() != confirmPasswordField || document.getElementById('password').value == null || document.getElementById('confirmpassword').value == null) {
                document.getElementById('passwordCheckErrorMsg').innerHTML = "Passwords don't match";
                document.getElementById('confirmpassword').value = null;
                document.getElementById('password').style.borderColor = "red";
                document.getElementById('confirmpassword').style.borderColor = "red";

            } else {
                document.getElementById('passwordCheckErrorMsg').disabled = true;
                document.getElementById('passwordCheckErrorMsg').innerHTML = null;
                document.getElementById('password').style.borderColor = "green";
                document.getElementById('confirmpassword').style.borderColor = "green";
            }
        }

        //EMAIL VALIDATION
        function validateEmail() {
            var email = document.getElementById('email').value;
            var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (re.test(email)) {
                document.getElementById('email').style.borderColor = "green";
                document.getElementById('emailCheckErrorMsg').innerHTML = null;
                document.getElementById('emailCheckErrorMsg').disabled = true;
            } else {
                document.getElementById('email').style.borderColor = "red";
                document.getElementById('emailCheckErrorMsg').innerHTML = "Not a valid email";
            }
        }
        //REQUIRED FIELDS CHECKING
        function checkRequiredFields() {
            if (document.getElementById('firstname').value == null |
                    document.getElementById('lastname').value == null |
                    document.getElementById('email').value == null |
                    document.getElementById('password').value == null |
                    document.getElementById('confirmpassword').value == null |
                    document.getElementById('mobilenumber').value == null |
                    document.getElementById('checkbox1').value == null) {
                alert("Fields can not be empty!");
            }
        }
    </script>

</html>
