<%-- 
    Document   : products
    Created on : Sep 22, 2016, 12:48:19 PM
    Author     : Chamal
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="jdk.nashorn.internal.parser.JSONParser"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="JS/jquery.min.js" type="text/javascript"></script>

        <style>
            .box{
                //padding: px;
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.1), 0 6px 20px 0 rgba(0, 0, 0, 0.1);
                height: 600px;
                width: 450px;
            } 
            hr{
                color: #ac7339;
                background-color: #ac7339;
                height: 1px;

            }
            .myImg{
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.1);
            }
        </style>

        <title>Products - Art Life</title>
    </head>
    <body>

        <div class="container-fluid">
            <br/><br/>
            <div class="row">
                <div class="col-md-12 container-fluid">
                    <div class="col-md-4">
                        <div class="row box">
                            <div class="col-md-12"><img src="IMAGES/signinbody.jpeg" class="myImg" alt="" width="100%" height="100%"></div>
                            <h4 class="col-md-12 text-center">Category</h4>
                            <h3 class="col-md-12 text-center"><a style="text-decoration: none;" href="">Product name</a></h3>
                            <p class="text-center">Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates.</p>
                            <hr width="90%"> 

                            <div class="text-center">
                                <strong>LKR 120.00</strong>
                            </div>

                            <hr width="90%"> 
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="row box">
                            <div class="col-md-12"><img src="IMAGES/signinbody.jpeg" class="myImg" alt="" width="100%" height="100%"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </body>

</html>
