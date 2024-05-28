<%-- 
    Document   : create-product
    Created on : Sep 28, 2016, 7:08:50 PM
    Author     : Chamal
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
        Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
        if (user.getStatus() == 1) {
%>


<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>

        <title>Add new product - Art Life</title>
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
                    <li class="active">Add new product</li>
                </ul>

                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Add new product</h2> 
                    </div> 
                </div>
            </div>  
            <div class="col-md-12"><br/></div>
            <form action="../CreateProductServlet" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>SKU code <span style="color: red" class="required">*</span></label>
                            <input type="text" class="form-control" id="categoryname" name="skucode" placeholder="SKU code" required="required"/>
                        </div>
                        <div class="col-md-3">
                            <label>Barcode</label>
                            <input type="text" class="form-control" id="barcode" name="barcode" placeholder="Barcode"/>
                        </div>
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Product category <span style="color: red" class="required">*</span></label>
                            <select type="search" class="form-control" name="productcategory" id="productcategory" required="required">
                                <option value="0" disabled></option>
                                <%
                                    try {
                                        for (Pojos.Categories category : Classes.helpers.getAllCategories()) {
                                %>
                                <option value="<%=category.getId()%>"><%=category.getName()%></option>

                                <%
                                    }
                                } catch (Exception e) { %>
                                <option  value = "0" ></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Product name <span style="color: red" class="required">*</span></label>
                            <input type="text" class="form-control" id="productname" name="productname" placeholder="Product name" required="required"/>
                        </div>
                        <div class="col-md-3">
                            <label>Brand name</label>
                            <input type="text" class="form-control" id="brandname" name="brandname" placeholder="Brand name"/>
                        </div>
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <label>Product short description</label>
                            <textarea class="form-control" id="productshortdesc" name="productshortdesc" placeholder="Product short description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <label>Product long description</label>
                            <textarea class="form-control" id="productlongdesc" name="productlongdesc" placeholder="Product long description" rows="5"></textarea>
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Product price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="productprice" name="productprice" min="0" placeholder="00.00" required="required" onclick=""/>
                        </div>
                        <div class="col-md-3">
                            <label>Selling price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="sellingprice" name="sellingprice" min="0" placeholder="00.00" required="required"/>
                        </div>
                        <div class="col-md-3">
                            <label>Shipping price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="shippingprice" name="shippingprice" min="0" placeholder="00.00" required="required"/>
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Quantity <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="qty" name="qty" placeholder="Quantity" min="0" required="required"/>
                        </div>    
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Weight</label>
                            <input type="number" class="form-control" id="weight" name="weight" min="0" placeholder="00.00" />
                        </div>  
                        <div class="col-md-3">
                            <label>Weight unit</label>
                            <select class="form-control" name="weightunit" id="weightunit">
                                <option></option>
                            </select>
                        </div>  
                    </div>                   
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Height</label>
                            <input type="number" min="0" class="form-control" id="height" name="height" placeholder="00.00" />
                        </div>  
                        <div class="col-md-3">
                            <label>Width</label>
                            <input type="number" min="0" class="form-control" id="width" name="width" placeholder="00.00" />
                        </div>  
                        <div class="col-md-3">
                            <label>Depth</label>
                            <input type="number" min="0" class="form-control" id="depth" name="depth" placeholder="00.00" />
                        </div>  
                        <div class="col-md-3">
                            <label>Length unit</label>
                            <select class="form-control" name="lengthunit" id="lengthunit">
                                <option></option>
                            </select>
                        </div>  
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Manufacturer</label>
                            <input type="text" class="form-control" id="manufacturer" name="manufacturer" placeholder="Manufacturer" />
                        </div> 
                        <div class="col-md-3">
                            <label>Manufacturer country</label>
                            <select class="form-control" name="manucountry" id="manucountry">
                                <%
                                    try {
                                        for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                %>
                                <option value="<%=country.getId()%>"><%=country.getName()%></option>

                                <%
                                    }
                                } catch (Exception e) { %>
                                <option  value = "0" ></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Manufacturer email</label>
                            <input type="email" class="form-control" id="manuemail" name="manuemail" placeholder="Manufacturer email" />
                        </div>  
                        <div class="col-md-3">
                            <label>Manufacturer website</label>
                            <input type="url" class="form-control" id="manuurl" name="manuurl" placeholder="Manufacturer website" />
                        </div>    
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Supplier</label>
                            <input type="text" class="form-control" id="supplier" name="supplier" placeholder="Supplier" />
                        </div> 
                        <div class="col-md-3">
                            <label>Supplier country</label>
                            <select class="form-control" name="supcountry" id="supcountry">
                                <%
                                    try {
                                        for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                %>
                                <option value="<%=country.getId()%>"><%=country.getName()%></option>

                                <%
                                    }
                                } catch (Exception e) { %>
                                <option  value = "0" ></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Supplier email</label>
                            <input type="email" class="form-control" id="supemail" name="supemail" placeholder="Supplier email" />
                        </div>  
                        <div class="col-md-3">
                            <label>Supplier website</label>
                            <input type="url" class="form-control" id="supurl" name="supurl" placeholder="Supplier website" />
                        </div>    
                    </div>
                    <div class="col-md-12"><br/></div>

                    <div class="col-md-12">
                        <div class="col-md-12">
                            <input type="submit" id="create-product-btn" class="btn btn-primary btn-block" name="create-product-btn" value="Add new product"/>
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12"><br/></div>
                </div>
            </form>
        </div>
    </body>

    <!--NUMBER FIELDS VALIDATION-->
    <script type="text/javascript">

    </script>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<%        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("errors/erroe401.jsp");
    }%>
