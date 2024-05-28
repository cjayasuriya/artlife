<%-- 
    Document   : welcome
    Created on : Sep 2, 2016, 1:26:32 PM
    Author     : Chamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
        <style>
            body{background-image:url("../IMAGES/welcome_page.jpeg");background-repeat: no-repeat; background-size:100%;}
            
            h1,p{color: white;}
        </style>

        <title>Welcome</title>
    </head>
    <body>
        <jsp:include page="../nevbartwo.jsp" />
        <div class="container-fluid text-center">
            <br/>
            <br/>
            <h1>Welcome 
                <%
                    out.write(request.getSession().getAttribute("firstname").toString() + "");
                %>
            </h1>
            <br/>
            <p>Thanks for creating an account. Use it to subscribe, get updates, new events, <br/>
                purchase products and lots more...
            </p>
            <%
                try {
                    if (!request.getSession().getAttribute("checkoutStatus").equals(null)) {
            %>
            <form action="/shop/checkout.jsp" method="GET">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-5">
                            <button type="submit" class="btn btn-primary">
                                Continue
                            </button>
                        </div>
                    </div>
                </div>
            </form>
            <%
                }
            } catch (Exception e) {
            %>
            <form action="../index.jsp" method="GET">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-5">
                            <button type="submit" class="btn btn-primary">
                                <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                                Continue to home
                            </button>
                        </div>
                    </div>
                </div>
            </form>
            <%
                }
            %>
        </div>
    </body>

    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</html>
