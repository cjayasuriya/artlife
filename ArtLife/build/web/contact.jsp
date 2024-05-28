<%-- 
    Document   : contact
    Created on : Sep 30, 2016, 9:45:27 AM
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
        <script src="https://maps.googleapis.com/maps/api/js?callback=myMap"></script>

        <style>
            #map{
                width: 100%;
                height: 320px;
            }
        </style>

        <title>Contact - Art Life</title>
    </head>
    <body>
        <jsp:include page="navbarSandBox.jsp" />


        <div class="">
            <h1 style="text-align: center">Get in touch</h1>
            <div class="row">
                <div class="col-md-12" >
                    <div class="col-md-12" id="map">

                    </div>
                </div>
            </div>
        </div> 
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="col-md-12"> <h3>Write us</h3></div>
                    <div class="col-md-12"> <br/></div>
                    <form action="SendContactMessageServlet" method="POST">
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <input type="text" class="form-control" id="contactname" name="contactname" placeholder="Name" required="required"/>
                            </div>
                            <div class="col-md-6">
                                <input type="email" class="form-control" id="contactemail" name="contactemail" placeholder="Email" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <br/>
                            <div class="col-md-12">
                                <input type="text" class="form-control" id="contactsubject" name="contactsubject" placeholder="Subject" required="required"/>
                            </div>
                        </div>    
                        <div class="col-md-12">
                            <br/>
                            <div class="col-md-12">
                                <textarea class="form-control" id="contactmessage" name="contactmessage" placeholder="Your message" rows="4" required="required"></textarea>
                            </div>
                        </div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12">
                            <div class="col-md-12">

                                <input type="submit" id="send-contact-message-btn" class="btn btn-primary btn-block" name="send-contact-message-btn" value="Send message" />

                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="col-md-12"> <h3>Contact information</h3></div>
                    <div class="col-md-12"> <br/></div>
                    <div class="col-md-12">
                        <p><span class="fa fa-building"></span> Rd1, Rd2, City, Sri Lanka, Zip</p>
                        <p><span class="fa fa-envelope"></span> <a href="mailto:contact@artlife.com">contact@artlife.com</a></p>
                        <p><span class="fa fa-phone"></span> +94 (11) 272 9012</p>
                        <hr/>
                        <p style="text-align: center">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sed tincidunt libero. Donec ut scelerisque lorem. Sed posuere, odio in viverra auctor, leo dui eleifend arcu, nec volutpat orci tellus quis nisi. Suspendisse semper dui nec enim tempor dictum. Quisque porta volutpat convallis. Sed eu viverra neque. Maecenas varius convallis diam. Donec quis porta sem.</p>
                        
                    </div>
                    
                    
                    
                    
                </div>

                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
            </div>

        </div>
    </body>

    <script>
        function myMap() {
            var myCenter = new google.maps.LatLng(51.508742, -0.120850);
            var mapCanvas = document.getElementById("map");
            var mapOptions = {center: myCenter, zoom: 5};
            var map = new google.maps.Map(mapCanvas, mapOptions);
            var marker = new google.maps.Marker({position: myCenter});
            marker.setMap(map);
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?callback=myMap"></script>
    <script src="JS/googleMap.js" type="text/javascript"></script>




</html>
