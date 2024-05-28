<%-- 
    Document   : product
    Created on : Oct 22, 2016, 3:45:19 PM
    Author     : Chamal
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
%>


<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../CSS/orderPortlet.css" rel="stylesheet" type="text/css"/>
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>

        <style>

        </style>

        <title><%out.write(request.getParameter("pname"));%> - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>

                <ul class="breadcrumb">
                    <li><a href="products.jsp">Products Management</a></li>
                    <li><a href="products.jsp">Products</a></li>
                    <li class="active"><%out.write(request.getParameter("pname"));%></li>
                </ul>

                <div class="col-md-12">
                    <%
                        if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
                    %>
                    
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Actions
                            <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="edit-product.jsp?pid=<%=request.getParameter("pid")%>">Edit product</a></li>
                            <li><a href="#"  data-toggle="modal" data-target="#addProductImageModal">Add product image</a></li>
                        </ul>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                    NumberFormat nf = NumberFormat.getNumberInstance();
                    DecimalFormat df = (DecimalFormat) nf;
                    df.applyPattern("###,###.00");

                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                    productCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("pid"))));

                    if (productCriteria.uniqueResult() != null) {

                        Pojos.Products productDetails = (Pojos.Products) productCriteria.uniqueResult();

                        Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
                        userCriteria.add(Restrictions.eq("id", Integer.parseInt(productDetails.getCuid().toString())));
                        Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();

                        JSONParser jSONParser = new JSONParser();
                        Object ojb = jSONParser.parse(productDetails.getMeta());
                        JSONObject jObj = (JSONObject) ojb;
                        JSONObject childDesc = (JSONObject) jObj.get("description");
                        JSONObject childManu = (JSONObject) jObj.get("manufacturer");
                        JSONObject childSup = (JSONObject) jObj.get("supplier");

                        Criteria supplierCountryCriteria = hiberSession.createCriteria(Pojos.Country.class);
                        supplierCountryCriteria.add(Restrictions.eq("id", Integer.parseInt(childSup.get("supplier_country").toString())));
                        Pojos.Country supCountry = (Pojos.Country) supplierCountryCriteria.uniqueResult();

                        Criteria manuCountryCriteria = hiberSession.createCriteria(Pojos.Country.class);
                        manuCountryCriteria.add(Restrictions.eq("id", Integer.parseInt(childSup.get("supplier_country").toString())));
                        Pojos.Country manuCountry = (Pojos.Country) manuCountryCriteria.uniqueResult();

                        Date createdAt = (Date) (productDetails.getCreatedAt());
                        SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy HH:mm:ss a");
                %>

                <div class="col-md-12"><br/></div>
                <div class="col-md-10 col-md-offset-1">
                    <div class="col-md-12">
                        <div class="col-md-6 container-fluid">
                            <div class="col-md-12"><br/></div>
                            <img src="../IMAGES/productImages/<%=jObj.get("imgP")%>" width="100%" height="100%">
                        </div>
                        <div class="col-md-6 container-fluid">
                            <div class="col-md-12">
                                <h1 style="color: #663300;"><%out.write(request.getParameter("pname"));%> <small><span style="color: #c68c53;">| <%=productDetails.getCategories().getName()%></span></small></h1>
                                <h4>LKR <%=df.format(productDetails.getSellingPrice())%></h4>
                                <hr/>
                            </div>
                            <div class="col-md-6">

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
                            <div class="col-md-6"><b>Qty :</b>
                                <%
                                    if (productDetails.getQty() > 20) {
                                %>
                                <span class="text-success"><strong><%=productDetails.getQty()%></strong></span>
                                        <%
                                        } else if (productDetails.getQty() > 10 && productDetails.getQty() < 20) {
                                        %>
                                <span class="text-warning"><strong><%=productDetails.getQty()%></strong></span>
                                        <%
                                        } else if (productDetails.getQty() > 5 && productDetails.getQty() < 10) {
                                        %>
                                <span class="text-danger"><strong><%=productDetails.getQty()%></strong></span>
                                        <%
                                        } else if (productDetails.getQty() < 5) {

                                        %>
                                <span class="text-danger"><strong><%=productDetails.getQty()%></strong></span>
                                        <%                                        }
                                        %>
                            </div>
                            <div class="col-md-12 text-justify">
                                <%=childDesc.get("short")%>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12 text-justify">
                        <%=childDesc.get("long")%>
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

                                <p>SKU code : <b><%=productDetails.getSku()%></b></p>
                                <p>Barcode  : <b><%=productDetails.getBarcode()%></b></p>
                                <p>Brand  : <b><%=jObj.get("brandname").toString()%></b></p>  
                                <p>Prices : 
                                <ul>
                                    <li>Product price : <b>LKR <%=df.format(productDetails.getProductPrice())%></b></li>
                                    <li>Shipping price : <b>LKR <%=df.format(productDetails.getShippingPrice())%></b></li>
                                    <li>Selling price : <b>LKR <%=df.format(productDetails.getSellingPrice())%></b></li>
                                </ul>
                                </p>
                                <p>Sizes : 
                                <ul>
                                    <li>Height : <b><%=jObj.get("height").toString()%></b></li>
                                    <li>Width : <b><%=jObj.get("width").toString()%></b></li>
                                    <li>Depth price : <b><%=jObj.get("depth").toString()%></b></li>
                                </ul>
                                </p>

                                <p>Weight : <b><%=productDetails.getWeight()%></b></p>
                                <p>Created date & time : <b><%=sdf.format(createdAt)%></b></p>
                                <p>Created by : <b><%=user.getFirstname() + " " + user.getLastname()%></b></p>

                            </div>
                        </div>
                    </div> 

                    <!-- MANU INFORMATION-->
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-cogs" style="color: #67809F;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #67809F;">Manufacturer info</span>
                                </div>
                            </div>
                            <div class="portlet-body">

                                <p>Name : <b><%=childManu.get("manufacturer")%></b></p>
                                <p>Country <b><%=manuCountry.getName()%></b></p>
                                <p>Email : <b><%=childManu.get("manufacturer_email")%></b></p>
                                <p>Website : <b><%=childManu.get("manufacturer_web")%></b></p>

                            </div>
                        </div>
                    </div>

                    <!-- SUPPLIER INFORMATION-->
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-truck" style="color: #1BBC9B;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #1BBC9B;">Supplier info</span>
                                </div>
                            </div>
                            <div class="portlet-body">

                                <p>Name : <b><%=childSup.get("supplier")%></b></p>
                                <p>Country <b><%=supCountry.getName()%></b></p>
                                <p>Email : <b><%=childSup.get("supplier_email")%></b></p>
                                <p>Website : <b><%=childSup.get("supplier_web")%></b></p>

                            </div>
                        </div>
                    </div>


                    <%}%>
                </div>
            </div>
        </div>

        <!-- MODAL UPLOAD PRODUCT PICTURE-->
        <div class="modal fade" id="addProductImageModal" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel"><span class="fa fa-circle-o-notch fa-spin fa-1x"></span>Add product image</h3>
                    </div>
                    <div class="modal-body">
                        <form action="../addProductImageServlet" method="POST" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="product-image" class="form-control-label">Add image</label>
                                <input type="file" class="form-control" id="fupload" name="fupload" required="required"/>
                            </div>
                            <input type="hidden" name="proId" id="proId" value="<%=request.getParameter("pid")%>"/>
                            
                            <input type="submit" class="btn btn-primary btn-block" name="add-image-btn" value="Apply changes">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div></div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<%} else {
        response.sendError(401);
    }%>

