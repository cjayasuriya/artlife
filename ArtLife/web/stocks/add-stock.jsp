<%-- 
    Document   : add-stock
    Created on : Jul 9, 2017, 2:09:58 PM
    Author     : chamal
--%>
<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../CSS/intlTelInput.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

        <title>Add stock - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <div class="col-md-12"><br/></div>
        <div class="col-md-12"><br/></div>
        <div class="col-md-12"><br/></div>

        <ul class="breadcrumb">
            <li><a href="../products/products.jsp">Products</a></li>
            <li><a href="../products/products.jsp">Products</a></li>
            <li class="active">Add stock</li>
        </ul>
        <div class="container-fluid">
            <%
                Pojos.Products product = (Pojos.Products) Classes.helpers.getProduct(Integer.parseInt(request.getParameter("productId").toString()));
            %>
            <div class="row">
                <div class="col-md-12">
                    <h1>
                        Add stock - <%=product.getName()%>
                    </h1>
                </div>
                <div class="col-md-12"><br/></div>
            </div>
            <div class="row">
                <form method="POST" action="../AddProductStockServlet">
                    <input id="productId" type="hidden" name="productId" value="<%=request.getParameter("productId")%>">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Quantity <span style="color: red" class="required">*</span></label>
                                <input type="text" id="productqty" class="form-control" name="productqty" placeholder="Quantity" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Supplier</label>
                                <input type="text" id="supplier" class="form-control" name="supplier" placeholder="Supplier"/>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Description</label>
                                <textarea id="stockdesc" class="form-control" name="stockdesc" rows="3"></textarea>

                            </div>
                        </div>
                    </div>
                    </br>
                    <div class="col-md-12">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-block"  id="addstock" name="addstock" value="Add stock" />
                        </div>
                    </div>
                </form>
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
