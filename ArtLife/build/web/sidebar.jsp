<%-- 
    Document   : sidebar
    Created on : Nov 17, 2016, 1:27:05 AM
    Author     : chamaljayasuriya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="CSS/sidebar.css" rel="stylesheet" type="text/css"/>
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <title>Side Bar</title>
    </head>
    <body>
        <div class="nav-side-menu">
            <div class="brand">Art Life</div>
            <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>

            <div class="menu-list">

                <ul id="menu-content" class="menu-content collapse out">
                    <li>
                        <a href="#">
                            <i class="fa fa-dashboard fa-lg"></i> Dashboard
                        </a>
                    </li>

                    <li  data-toggle="collapse" data-target="#products" class="collapsed">
                        <a href="#"><i class="fa fa-gift fa-lg"></i>Product management<span class="arrow"></span></a>
                    </li>
                    <ul class="sub-menu collapse" id="products">
                        <li><a href="#">Products</a></li>
                        <li><a href="#">Categories</a></li>
                    </ul>


                    <li data-toggle="collapse" data-target="#service" class="collapsed">
                        <a href="#"><i class="fa fa-users fa-lg"></i>User management<span class="arrow"></span></a>
                    </li>  
                    <ul class="sub-menu collapse" id="service">
                        <li>Users</li>
                        <li>New Service 2</li>
                        <li>New Service 3</li>
                    </ul>


                    <li data-toggle="collapse" data-target="#new" class="collapsed">
                        <a href="#"><i class="fa fa-cogs fa-lg"></i> Settings <span class="arrow"></span></a>
                    </li>
                    <ul class="sub-menu collapse" id="new">
                        <li>Change my details</li>
                    </ul>

                </ul>
            </div>
        </div>
    </body>
</html>
