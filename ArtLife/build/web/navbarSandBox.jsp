<%-- 
    Document   : navbarSandBox
    Created on : Sep 8, 2016, 12:51:02 AM
    Author     : Chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>        
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="JS/jquery.min.js" type="text/javascript"></script>

        <style>
            .nbar{
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            } 
            .nav,.dropdown-content{background-color:white;}


        </style>

    </head>
    <body>
        <nav class="navbar  navbar-default navbar-static-top-top" style="background-color:white;">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp" style="color: #663300">Art Life</a>
                </div>
                <ul class="nav navbar-nav">
                    <li ><a href="about.jsp">About</a></li>
                    <li><a href="shop/art-products.jsp">Shop now</a></li>
                    <li><a href="contact.jsp">Contact </a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <%
                        try {
                            System.out.println(request.getSession().getAttribute("firstname").toString() + "");
                            if (request.getSession().getAttribute("firstname").toString().equals("null")) {
                    %>
                    <%
                    } else {
                        Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
                        if (user.getStatus() == 1) {

                    %> 


                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <span class="glyphicon glyphicon-user"></span>
                            <%out.write(request.getSession().getAttribute("firstname").toString() + "");%>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="shop/bag.jsp"><span class="fa fa-shopping-bag"></span> My bag</a></li>
                            <!--                           <li><a href="#"><span class="fa fa-heart-o" style="color:red;"></span> Favorites</a></li>-->
                            <li role="separator" class="divider"></li>
                            <li><a href="account/profile.jsp?id=<%=request.getSession().getAttribute("uid")%>&name=<%out.write(request.getSession().getAttribute("firstname").toString().toLowerCase() + "." + request.getSession().getAttribute("lastname").toString().toLowerCase());%>"><span class="fa fa-cog"></span> Account</a></li> 
                            <li><a href="SignOutServlet"><span class="fa fa-sign-out"></span> Sign out</a></li> 
                        </ul>
                    </li>

                    <%
                    } else {
                    %>
                        
                    <%
                            }
                        }
                    } catch (Exception e) {
                    %>
                    <li><a href="shop/bag.jsp"><span class="fa fa-shopping-bag"></span></a></li>
                    <li><a href="auth/login.jsp"><span class="fa fa-sign-in"></span> Sign in</a></li>
                        <%
                            }
                        %>
                </ul>
            </div>
        </nav>
    </body>
</html>
