<%-- 
    Document   : adminNavbar
    Created on : Feb 12, 2017, 11:51:16 PM
    Author     : chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 

        <style>
            .navbar-default {
                background-color: #913D88;
                border-color: #913D88;
            }
            .navbar-default .navbar-brand {
                color: #e2e2e2;
            }
            .navbar-default .navbar-brand:hover,
            .navbar-default .navbar-brand:focus {
                color: #ffffff;
            }
            .navbar-default .navbar-nav > li > a {
                color: #e2e2e2;
            }
            .navbar-default .navbar-nav > li > a:hover,
            .navbar-default .navbar-nav > li > a:focus {
                color: #ffffff;
            }
            .navbar-default .navbar-nav > .active > a, 
            .navbar-default .navbar-nav > .active > a:hover, 
            .navbar-default .navbar-nav > .active > a:focus {
                color: #ffffff;
                background-color: #ffffff;
            }
            /*  TO CHANGE THE CLICK*/
            .navbar-default .navbar-nav > .open > a, 
            .navbar-default .navbar-nav > .open > a:hover, 
            .navbar-default .navbar-nav > .open > a:focus {
                color: #ffffff;
                background-color: #913D88;
            }
            .navbar-default .navbar-nav > .dropdown > a .caret {
                border-top-color: #ffffff;
                border-bottom-color: #ffffff;
            }
            .navbar-default .navbar-nav > .dropdown > a:hover .caret,
            .navbar-default .navbar-nav > .dropdown > a:focus .caret {
                border-top-color: #ffffff;
                border-bottom-color: #ffffff;
            }
            .navbar-default .navbar-nav > .open > a .caret, 
            .navbar-default .navbar-nav > .open > a:hover .caret, 
            .navbar-default .navbar-nav > .open > a:focus .caret {
                border-top-color: #ffffff;
                border-bottom-color: #ffffff;
            }
        </style>

        <title>JSP Page</title>
    </head>
    <body>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="../index.jsp">Art Life</a>
                </div>
                <ul class="nav navbar-nav">
                    
                     <li ><a href="../dashboard/dashboard.jsp">Dashboard</a></li>

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Products Management
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../products/products.jsp">Products</a></li>
                            <li><a href="../products/categories.jsp">Categories</a></li>
                            <li><a href="../stocks/stocks.jsp">Stocks</a></li>
                        </ul>
                    </li>
                    
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Orders
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../orders/orders.jsp">Orders</a></li>
                        </ul>
                    </li>
                    
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Users Management
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../users/users.jsp">Users</a></li>
                        </ul>
                    </li>
                    
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <%
                        try {
                            System.out.println(request.getSession().getAttribute("firstname").toString() + "");
                            if (request.getSession().getAttribute("firstname").toString().equals("null")) {
                    %>

                    <%
                    } else {
                    %> 


                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <span class="glyphicon glyphicon-user"></span>
                            <%out.write(request.getSession().getAttribute("firstname").toString() + "");%>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="../shop/bag.jsp"><span class="fa fa-shopping-bag"></span> My bag</a></li>
<!--                            <li><a href="#"><span class="fa fa-heart-o" style="color:red;"></span> Favorites</a></li>-->
                            <li role="separator" class="divider"></li>
                            <li><a href="../account/profile.jsp?id=<%=request.getSession().getAttribute("uid")%>&name=<%out.write(request.getSession().getAttribute("firstname").toString().toLowerCase() + "." + request.getSession().getAttribute("lastname").toString().toLowerCase());%>"><span class="fa fa-cog"></span> Account</a></li> 
                            <li><a href="../SignOutServlet"><span class="fa fa-sign-out"></span> Sign out</a></li> 
                        </ul>
                    </li>


                    <!--                  <form action="SignOutServlet" method="GET">
                                          <input class="btn btn-primary" type="submit" value="Sign out"/>
                                      </form>-->

                    <%
                        }
                    } catch (Exception e) {
                    %>
                    <li><a href="../shop/bag.jsp"><span class="fa fa-shopping-bag"></span></a></li>
                    <li><a href="../auth/login.jsp"><span class="fa fa-sign-in"></span> Sign in</a></li>

                    <%
                        }
                    %>

                </ul>
            </div>
        </nav>
    </body>
</html>

<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
