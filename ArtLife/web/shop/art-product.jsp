<%-- 
    Document   : art-product
    Created on : Nov 17, 2016, 8:00:47 PM
    Author     : chamaljayasuriya
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../CSS/orderPortlet.css" rel="stylesheet" type="text/css"/>


        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <title><%out.write(request.getParameter("pname"));%> - Art Life</title>

        <script>
            function checkPQty() {
                var pqty = document.getElementById('proqty').value;
                var maxqty = document.getElementById('proqty').max;
                
                var num1 = parseInt(pqty);
                var num2 = parseInt(maxqty);
                
                if(num1 > num2){
                    alert("Enter a quantity less than "+maxqty);
                    document.getElementById('addToBagBtn').disabled=true;
                }else{
                    document.getElementById('addToBagBtn').disabled=false;
                }

            }
        </script>

    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />
        <div class="container-fluid">
            <div class="row">
                <%
                    NumberFormat nf = NumberFormat.getNumberInstance();
                    DecimalFormat df = (DecimalFormat) nf;
                    df.applyPattern("###,###.00");

                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                    productCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("pid"))));

                    org.json.simple.parser.JSONParser jParserMeta = new org.json.simple.parser.JSONParser();

                    if (productCriteria.uniqueResult() != null) {

                        Pojos.Products productDetails = (Pojos.Products) productCriteria.uniqueResult();
                        org.json.simple.parser.JSONParser jParserDesc = new org.json.simple.parser.JSONParser();
                        Object metaObj = jParserMeta.parse(productDetails.getMeta());
                        JSONObject metaJObj = (JSONObject) metaObj;

                        Object descObject = jParserDesc.parse(metaJObj.get("description").toString());
                %>

                <div class="col-md-12"><br/></div>
                <div class="col-md-10 col-md-offset-1">
                    <div class="col-md-12">
                        <div class="col-md-6 container-fluid">
                            <div class="col-md-12"><br/></div>
                            <img src="../IMAGES/productImages/<%=metaJObj.get("imgP")%>" width="100%" height="100%">
                        </div>
                        <div class="col-md-6 container-fluid">
                            <div class="col-md-12">
                                <h1 style="color: #663300;"><%out.write(request.getParameter("pname"));%> <small><span style="color: #c68c53;">| <%=productDetails.getCategories().getName()%></span></small></h1>
                                <h4>LKR <%=df.format(productDetails.getSellingPrice())%></h4>
                                <hr/>
                            </div>
                            <div class="col-md-12">
                                <p class="text-justify">
                                    <%

                                        try {

                                            JSONObject desJObj = (JSONObject) descObject;
                                            if (desJObj.get("short") != null) {
                                                out.write((String) desJObj.get("short"));
                                            }

                                        } catch (Exception e) {
                                        }

                                    %>
                                </p>
                            </div>
                            <div class="col-md-12">

                                <p class="text-left"> <b>Availability : 
                                        <%                                        if (productDetails.getQty() > 20) {
                                        %>
                                        <span class="text-success">In stock</span>
                                        <%
                                        } else if (productDetails.getQty() > 10 && productDetails.getQty() < 20) {
                                        %>
                                        <span class="text-warning"><strong>More than 10 available</strong></span>
                                        <%
                                        } else if (productDetails.getQty() > 5 && productDetails.getQty() < 10) {
                                        %>
                                        <span class="text-danger"><strong>Less than 10 available</strong></span>
                                        <%
                                        } else if (productDetails.getQty() < 5) {

                                        %>
                                        <span class="text-danger"><strong>Out of the stock</strong></span>
                                        <%                                        }
                                        %>
                                    </b></p>

                            </div>
                            <form method="POST" action="../CartManagementServlet">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <%                                        if (productDetails.getQty() > 20) {
                                        %>
                                        <input type="number" class="form-control" id="proqty" name="pqty" onchange="checkPQty()" max="15" min="1" value="1" placeholder="" required="required"/>
                                        <%
                                        } else if (productDetails.getQty() > 10 && productDetails.getQty() < 20) {
                                        %>
                                        <input type="number" class="form-control" id="proqty" name="pqty" onchange="checkPQty()" max="<%=productDetails.getQty()%>" min="1" value="1" placeholder="" required="required"/>
                                        <%
                                        } else if (productDetails.getQty() > 5 && productDetails.getQty() < 10) {
                                        %>
                                        <input type="number" class="form-control" id="proqty" name="pqty" onchange="checkPQty()" max="<%=productDetails.getQty()%>" min="1" value="1" placeholder="" required="required"/>
                                        <%
                                        } else if (productDetails.getQty() < 5) {

                                        %>
                                        <input type="number" class="form-control" disabled="disabled" id="proqty" name="pqty" onchange="checkPQty()" max="15" min="1" value="1" placeholder="" required="required"/>
                                        <%                                        }
                                        %>
                                    </div>
                                    <input type="hidden" name="proid" value="<%out.write(request.getParameter("pid"));%>"/>
                                    <input type="hidden" name="proSellingPrice" value="<%out.write(productDetails.getSellingPrice().toString());%>">

                                </div>
                                <div class="col-md-12">
                                    <button type="submit"  id="addToBagBtn" name="psescaty" class="form-control btn btn-block btn-primary" <%if (productDetails.getQty() < 5) {%>disabled="disabled"<%}%>>
                                        Add to bag <span class="fa fa-shopping-bag"></span> 
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-md-12"><br></div>
                    <div class="col-md-12">
                        <p class="text-justify">
                            <%

                                try {

                                    JSONObject desJObj = (JSONObject) descObject;
                                    if (desJObj.get("long") != null) {
                                        out.write((String) desJObj.get("long"));
                                    }

                                } catch (Exception e) {
                                }

                            %>
                        </p>
                    </div>





                    <!-- GENERAL INFORMATION-->
                    <div class="col-md-12">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-cog" style="color: #E26A6A;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #E26A6A;">General info</span>
                                </div>
                            </div>
                            <div class="portlet-body">


                                <p>Brand  : <b><%=metaJObj.get("brandname").toString()%></b></p>  

                                <p>Sizes : 
                                <ul>
                                    <li>Height : <b><%=metaJObj.get("height").toString()%></b></li>
                                    <li>Width : <b><%=metaJObj.get("width").toString()%></b></li>
                                    <li>Depth price : <b><%=metaJObj.get("depth").toString()%></b></li>
                                </ul>
                                </p>

                                <p>Weight : <b><%=productDetails.getWeight()%></b></p>

                            </div>
                        </div>
                    </div>

                    <%}%>
                </div>
            </div>

        </div>

    </body>


</html>
