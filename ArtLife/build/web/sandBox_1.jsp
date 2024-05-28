<%-- 
    Document   : sandBox
    Created on : Jan 6, 2017, 12:11:04 PM
    Author     : chamaljayasuriya
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>
            function checkVal() {
                var minVal = document.getElementById('minVal').value;
                var maxVal = document.getElementById('maxVal').value;
                var defVal = document.getElementById('defVal').value;

                if ((minVal < defVal) && (maxVal > defVal) && (minVal!=maxVal)) {
                    window.alert("Hari 1")
                    document.getElementById('message').innerHTML = "Wade hari ";
                }

                else {
                    document.getElementById('message').innerHTML = "Waradi";
                }
            }
        </script>
    </head>
    <body>

        <input type="number" min="1"name="minVal" id="minVal" placeholder="Min Value"/><br/>
        <input type="number" min="1"name="maxVal" id="maxVal" placeholder="Max Value"><br/>
        <input type="number" min="1" name="defVal" id="defVal" placeholder="Default Value" onblur="checkVal()"/><br/>


        <br><br>
        <div id="message"></div>
    </body>
</html>
