<%-- 
    Document   : sandbox2
    Created on : Oct 27, 2016, 11:15:57 AM
    Author     : Chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <style>
            table{
                max-width: 100%;
                width:100%;
                border-collapse: collapse;
                background-color: transparent
            }
            img {
                max-height: 150px;
                min-width: 50px;
            }
            th,td{
                border-bottom: 1px solid #ddd;
            }
            th{
                padding: 15px;
                alignment-adjust: middle;
                text-align: left;
            }
            td{
                padding: 20px;
                text-align: left;
            }
            .ltotal{
                text-align: right;
            }
        </style>

        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 container-fluid text-center">
                    <h3 class="text-center">My Bag</h3>
                    <hr width="90%">

                    <div class="col-md-10 col-md-offset-1">
                        <table>
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Product</th>
                                    <th> Category</th>
                                    <th>Brand name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Line total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">
                                        <img src="IMAGES/signinbody.jpeg" class="img-fluid z-depth-0">
                                    </th>
                                    <td>
                                        <h5><strong>Triosharpener GRIP 2001</strong></h5>
                                        <p class="text-muted">by Singer</p>
                                    </td>
                                    <td>Pencil</td>
                                    <td>Stadler</td>
                                    <td>LKR 300</td>
                                    <td>2</td>
                                    <td class="ltotal">LKR 400</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>


                </div>



            </div>
        </div>
    </body>
</html>
