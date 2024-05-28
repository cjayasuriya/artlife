<%-- 
    Document   : login
    Created on : Jul 26, 2016, 5:40:52 PM
    Author     : Chamal
--%>
<%if (request.getSession().getAttribute("uid") == null) {
%>
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



        <title>Sign in - Art Life</title>

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
                                <h4 style="color: #663300">Sign in with your account to continue</h4>
                                <hr>
                            </div>
                            <div class="col-md-12 text-center">
                                <img src="../IMAGES/user-profile-picture.png" class="img-circle profpic" alt="Cinque Terre" width="150" height="150">
                            </div>
                            <div class="col-md-12"><br/></div>
                            <form action="../LoginServlet" method="POST">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="email" class="form-control " name="useremail" placeholder="Email" required="required"/>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="password" class="form-control" name="userpassword" placeholder="Password" required="required"/>
                                    </div>
                                </div>
                                <%
                                    if (request.getSession().getAttribute("loginErrorMsg") != null) {
                                %>
                                <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                    <p><span class="glyphicon glyphicon-warning-sign"></span>
                                        <%=request.getSession().getAttribute("loginErrorMsg").toString()%>
                                    </p>
                                </div>
                                <%
                                } else if (request.getSession().getAttribute("loginEmailErrorMsg") != null) {
                                %>
                                <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                    <p><span class="glyphicon glyphicon-warning-sign"></span>
                                        <%=request.getSession().getAttribute("loginEmailErrorMsg").toString()%>
                                    </p>
                                </div>
                                <%
                                } else if (request.getSession().getAttribute("loginPasswordErrorMsg") != null) {
                                %>
                                <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                    <p><span class="glyphicon glyphicon-warning-sign"></span>
                                        <%=request.getSession().getAttribute("loginPasswordErrorMsg").toString()%>
                                    </p>
                                </div>
                                <%
                                } else if (request.getSession().getAttribute("loginBlockErrorMsg") != null) {
                                %>
                                <div class="col-md-12" style="text-align: left;color: #ff1a1a">
                                    <p><span class="glyphicon glyphicon-warning-sign"></span>
                                        <%=request.getSession().getAttribute("loginBlockErrorMsg").toString()%>
                                    </p>
                                </div>
                                <%
                                    }
                                %>
                                <div class="col-md-6">
<!--                                    <input type="checkbox">
                                    Remember me-->
                                </div>
                                <div class="col-md-6 text-right" >
                                    <a href="reset.jsp">Forgot your password ?</a>
                                </div>
                                <div class="col-md-12"><br/></div>
                                <div class="col-md-12">
                                    <input type="submit" class="btn btn-primary btn-block" name="userlogin" value="Sign in"/>
                                </div>
                                <div><br/><br/></div>
                                <div class="col-md-12">
                                    <hr>
                                    Doesn't have an account ?
                                    <a href="register.jsp">Create account</a>
                                </div>
                                <div class="col-md-12"><br/></div>
                            </form>    
                        </div>
                        <div class="col-md-12"><br/></div>        
                    </div>
                </div>
            </div>  
        </div>
    </body>

    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</html>
<%} else {
    response.sendRedirect("../index.jsp");
    }%>
