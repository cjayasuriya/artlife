<%-- 
    Document   : art-products
    Created on : Nov 17, 2016, 7:52:35 PM
    Author     : chamaljayasuriya
--%>

<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <style>
            .box{
                padding: 2px;
                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.1), 0 6px 20px 0 rgba(0, 0, 0, 0.1);
                height: 500px;
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

        <script type="text/javascript">

            var xmlhttp;
            function createXHTTP() {
                if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest()
                }
            }

            function search() {

                var name = document.getElementById("productname").value;
                var cat = document.getElementById("categoryid");
                var category = cat[cat.selectedIndex].value;

                var url = "../SearchProductServlet?productname=" + name + "&category=" + category + "";

                if (document.getElementById("cbname").checked) {
                    url += "&cbname=on";
                }

                if (document.getElementById("cbcategory").checked) {
                    url += "&cbcategory=on";
                }




                createXHTTP();

                xmlhttp.onreadystatechange = function() {

                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        document.getElementById("products").innerHTML = xmlhttp.responseText;
                    }

                }

                xmlhttp.open("GET", url, true);
                xmlhttp.send();

            }
        </script>


        <title>Art products - Art Life</title>
    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Products</h2> 
                    </div> 
                </div>
            </div> 

        </div>

        <div class="container-fluid">
            <!--TO PUT PRODUCT CATEGORIES-->
            <div class="col-md-12">
                <div class="col-md-3">
                    Categories

                    <%
                        Session hSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria categotyCriteria = hSession.createCriteria(Pojos.Categories.class);
                        categotyCriteria.add(Restrictions.eq("parentid", 0));

                        List<Pojos.Categories> categoriesList = categotyCriteria.list();
                        for (Pojos.Categories categories : categoriesList) {
                    %>
                    <ul>
                        <li><%=categories.getName()%></li>
                    </ul>
                    <%
                        }

                    %>

                </div>

                <div class="col-md-9">
                    <!--TO PUT PRODUCT CATEGORIES-->

                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                            <li data-target="#myCarousel" data-slide-to="3"></li>
                            <li data-target="#myCarousel" data-slide-to="4"></li>
                            <li data-target="#myCarousel" data-slide-to="5"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="../IMAGES/carousel-main1.png" alt="Los Angeles" style="width:100%; height: 50%;">
                            </div>

                            <div class="item">
                                <img src="../IMAGES/carousel-main.png" alt="Chicago" style="width:100%; height: 50%;">
                            </div>

                            <div class="item">
                                <img src="../IMAGES/carousel-main2.png" alt="New york" style="width:100%; height: 50%;">
                            </div>
                            <%                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                for (Pojos.Products product : Classes.helpers.getLatestProducts(3)) {
                                    JSONParser jSONParser = new JSONParser();
                                    Object productObject = jSONParser.parse(product.getMeta());
                                    JSONObject metaObj = (JSONObject)productObject;
                            %>
                            <div class="item">
                                <img src="../IMAGES/productImages/<%=metaObj.get("imgP")%>" alt="New york" style="width:100%; height: 50%;">
                                <div class="carousel-caption">
                                    <h3>
                                        <a href="art-product.jsp?pid=<%=product.getId()%>&pname=<%=product.getName()%>">
                                        <%=product.getName()%> | LKR <%=product.getSellingPrice()%>
                                        </a>
                                    </h3>
                                    <p><%=product.getCategories().getName()%></p>
                                </div>
                            </div>
                            <%
                                }
                            %>
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

                    <div class="col-md-12 container-fluid"><br/></div>
                    <div class="col-md-12 container-fluid"><hr/></div>
                    <div class="col-md-12 container-fluid"><br/></div>

                    <!--TO PUT PRODUCT CARDS-->

                    <div class="col-md-12">
                        <div class="col-md-12">
                            <div class="col-md-5">
                                Search by name :
                                <input type="checkbox" id="cbname" name="cbname"/>
                                <input type="text" class="form-control" id="productname" name="productname" placeholder="Product name"/>
                            </div>
                            <div class="col-md-4">
                                Search by category :
                                <input type="checkbox" id="cbcategory" name="cbcategory"/>
                                <select id="categoryid" class="form-control" name="category"/>
                                <%                                    for (Pojos.Categories category : Classes.helpers.getAllCategories()) {
                                %>
                                <option value="<%=category.getId()%>"><%=category.getName()%></option>
                                <%
                                    }
                                %>

                                </select>
                            </div>
                            <div class="col-md-3">
                                <br>
                                <!--                                    <input type="submit"class="form-control btn btn-block btn-primary" value="Search"/>-->
                                <button onclick="search()" class="form-control btn btn-block btn-primary">Search</button>
                            </div>
                        </div>
                        <div class="col-md-12"><br></div>
                        <div class="col-md-12">

                            <div id="products">

                                <div class="row list-group">
                                    <%                                    for (Pojos.Products product : Classes.helpers.getAllActiveProducts()) {
                                            JSONParser jSONParser = new JSONParser();
                                            Object meta = jSONParser.parse(product.getMeta());
                                            JSONObject jObj = (JSONObject) meta;
                                    %>
                                    <div class="item  col-xs-4 col-lg-4">
                                        <div class="thumbnail">
                                            <img class="group list-group-image img-responsive" src="../IMAGES/productImages/<%=jObj.get("imgP")%>" alt="" />
                                            <div class="caption">
                                                <h3 class="group inner list-group-item-heading text-center"><a href="art-product.jsp?pid=<%=product.getId()%>&pname=<%=product.getName()%>"><%=product.getName()%></a></h3>
                                                <h5 class="group inner list-group-item-heading text-center"><%=product.getCategories().getName()%></h5>
                                                <p class="group inner list-group-item-text small text-justify">
                                                    <%
                                                        org.json.simple.parser.JSONParser jParserMeta = new org.json.simple.parser.JSONParser();
                                                        org.json.simple.parser.JSONParser jParserDesc = new org.json.simple.parser.JSONParser();

                                                        try {
                                                            Object metaObj = jParserMeta.parse(product.getMeta());
                                                            JSONObject metaJObj = (JSONObject) metaObj;
                                                            Object descObject = jParserDesc.parse(metaJObj.get("description").toString());
                                                            JSONObject desJObj = (JSONObject) descObject;
                                                            out.write((String) desJObj.get("short"));
                                                        } catch (Exception e) {
                                                        }

                                                    %>
                                                </p>
                                                <p class="text-muted text-center" style="margin-top: 10px;font-size: 14px;">
                                                    <strong>LKR <%=product.getSellingPrice()%></strong>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="col-md-12 container-fluid"><br/></div>

                    <div class="col-md-12"><br></div>

                    <div class="col-md-12"><br></div>

                </div> 
            </div>
        </div>
    </body>
</html>
