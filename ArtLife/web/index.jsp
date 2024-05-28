<%-- 
    Document   : index
    Created on : Jul 25, 2016, 10:33:02 PM
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

        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <style>
            hr{
                height: 1px;
                width: 75%;
            }
        </style>

        <title>Art Life</title>
    </head>
    <body>
        <jsp:include page="navbarSandBox.jsp" />
        <div class="row">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="IMAGES/carousel-main1.png" alt="Los Angeles" style="width:100%; height: 50%;">
                    </div>

                    <div class="item">
                        <img src="IMAGES/carousel-main.png" alt="Chicago" style="width:100%; height: 50%;">
                    </div>

                    <div class="item">
                        <img src="IMAGES/carousel-main2.png" alt="New york" style="width:100%; height: 50%;">
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>

        <div class="row">
            <br/><br/>
            <div class="col-md-12 text-center">
                <div class="col-md-4">
                    <h4>AWESOME SUPPORT</h4>
                    <hr>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer tincidunt eleifend enim,
                        viverra laoreet lacus aliquam ut. Etiam eget tellus eu est ultrices vestibulum fermentum 
                        sit amet purus. Vivamus volutpat.
                    </p>
                </div>
                <div class="col-md-4">
                    <h4>EVERY ART PRODUCTS YOU WANT</h4>
                    <hr>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer tincidunt eleifend enim,
                        viverra laoreet lacus aliquam ut. Etiam eget tellus eu est ultrices vestibulum fermentum 
                        sit amet purus. Vivamus volutpat.
                    </p>
                </div>
                <div class="col-md-4">
                    <h4>365 DAYS SERVICE</h4>
                    <hr>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer tincidunt eleifend enim,
                        viverra laoreet lacus aliquam ut. Etiam eget tellus eu est ultrices vestibulum fermentum 
                        sit amet purus. Vivamus volutpat.
                    </p>
                </div>
            </div>
        </div>

        <div class="12"><br></div>

    </body>

</html>
