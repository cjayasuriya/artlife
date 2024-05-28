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

<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
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

        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.1.1/css/mdb.min.css" rel="stylesheet" type="text/css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.1.1/js/mdb.min.js"></script>

        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>


        <title>Products - Art Life</title>
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
                    <li class="active">Products</li>
                </ul>

                <div class="col-md-12">
                    <h2>Products</h2>
                </div>

                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Actions
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <li><a href="create-product.jsp">Add product</a></li>
                    </ul>
                </div>

            </div> 
        </div>

        <!--ACTIVE PRODUCTS-->
        <div class="row">
            <div class="container-fluid">

                <div class="col-md-12">
                    <h3>Active products</h3>
                </div>

                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Unit price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%try {
                                    for (Pojos.Products products : Classes.helpers.getAllActiveProducts()) {%>

                            <tr>

                                <td><a href="product.jsp?pid=<%=products.getId()%>&pname=<%=products.getName()%>"><%=products.getName()%></a></td>
                                <td>
                                    <%=products.getCategories().getName()%>
                                </td>
                                <td><%=products.getQty()%></td>
                                <td>
                                    <%=products.getSellingPrice()%>
                                </td>
                                <td><%
                                    if (products.getStatus() == 1) {
                                    %>
                                    <form action="../stocks/add-stock.jsp" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="add-stock-btn" value="Add stock">
                                    </form>
                                        </br>
                                    <form action="../productStatusChangeServlet" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-danger btn-block" name="deactiveBtn" value="Deactive">
                                    </form>
                                    <%
                                    } else {
                                    %>         
                                    <form action="../stocks/add-stock.jsp" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="add-stock-btn" value="Add stock">
                                    </form>
                                        </br>
                                    <form action="../productStatusChangeServlet" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="activeBtn" value="Active">
                                    </form><%
                                        }
                                    %></td>
                            </tr>


                            <%}
                            } catch (Exception e) {
                            %>
                            <tr>
                                <td colspan="5">No products to load</td>
                            </tr>
                            <%
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!--INACTIVE PRODUCTS-->
        <div class="row">
            <div class="container-fluid">

                <div class="col-md-12">
                    <h3>Inactive products</h3>
                </div>

                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Quantity</th>
                                <th>Unit price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%try {
                                    for (Pojos.Products products : Classes.helpers.getAllInactiveProducts()) {%>

                            <tr>

                                <td><a href="product.jsp?pid=<%=products.getId()%>&pname=<%=products.getName()%>"><%=products.getName()%></a></td>
                                <td>
                                    <%=products.getCategories().getName()%>
                                </td>
                                <td><%=products.getQty()%></td>
                                <td>
                                    <%=products.getSellingPrice()%>
                                </td>
                                <td><%
                                    if (products.getStatus() == 1) {
                                    %>
                                    <form action="../stocks/add-stock.jsp" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="add-stock-btn" value="Add stock">
                                    </form>
                                        </br>
                                    <form action="../stocks/add-stock.jsp" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-danger btn-block" name="deactiveBtn" value="Deactive">
                                    </form>
                                    <%
                                    } else {
                                    %>             
                                    <form action="../AddProductStockServlet" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="add-stock-btn" value="Add stock">
                                    </form>
                                        </br>
                                    <form action="../productStatusChangeServlet" method="POST">
                                        <input type="hidden" name="productId" value="<%=products.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="activeBtn" value="Active">
                                    </form><%
                                        }
                                    %></td>
                            </tr>


                            <%}
                            } catch (Exception e) {
                            %>
                            <tr>
                                <td colspan="5">No products to load</td>
                            </tr>
                            <%
                                }%>
                        </tbody>
                    </table>
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