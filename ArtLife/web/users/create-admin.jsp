<%-- 
    Document   : create-admin
    Created on : Jan 21, 2017, 8:46:42 AM
    Author     : chamaljayasuriya
--%>
<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1"))) {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../CSS/intlTelInput.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <title>Add new admin - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <div class="col-md-12"><br/></div>
        <div class="col-md-12"><br/></div>
        <div class="col-md-12"><br/></div>

        <ul class="breadcrumb">
            <li><a href="users.jsp">Users</a></li>
            <li><a href="users.jsp">Users</a></li>
            <li class="active">Add new admin</li>
        </ul>
        <div class="container-fluid">



            <div class="row">
                <div class="col-md-12">
                    <h1>Add new admin</h1>
                </div>
                <div class="col-md-12"><br/></div>
            </div>
            <div class="row">
                <form method="POST" action="../CreateAdminAccountServlet">
                    <input id="hiddenphonefull" type="hidden" name="phonefull">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type="text" id="firstname" class="form-control" name="firstname" placeholder="First name" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type="text" id="lastname" class="form-control" name="lastname" placeholder="Last name" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <input type="tel" id="mobilenumber" class="form-control" name="mobilenumber" placeholder="Mobile" required="required"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type="email" id="email" class="form-control" name="email" placeholder="Email address" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type="password" id="password" class="form-control" name="password" placeholder="Create a password" required="required" data-toggle="password"/>                             
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type="password" id="confirmpassword" class="form-control" name="confirmpassword" placeholder="Confirm password" required="required"  />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-block"  id="createaccount" name="createaccount" value="Create new admin" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

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

<%}else{
        response.sendError(401);
    }
    %>
