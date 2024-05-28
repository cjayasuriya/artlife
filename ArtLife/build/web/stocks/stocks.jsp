<%-- 
    Document   : stocks
    Created on : Jul 9, 2017, 5:22:03 PM
    Author     : chamal
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
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

        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>

        <title>Stocks - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />

        <div class="container-fluid">
            <div class="row">

                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>

                <ul class="breadcrumb">
                    <li><a href="../products/products.jsp">Products Management</a></li>
                    <li class="active">Stocks</li>
                </ul>

                <div class="col-md-12">
                    <h2>Stocks</h2>
                </div>
            </div> 
        </div>

        <div class="row">
            <div class="container-fluid">

                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Stock #</th>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Supplied by</th>
                                <th>Added by</th>
                                <th>Added at</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%try {
                                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    for (Pojos.Stocks stock : Classes.helpers.getAllStocks()) {%>

                            <tr>

                                <td><%=stock.getId()%></td>
                                <td>
                                    <a href="../products/product.jsp?pid=<%=stock.getProducts().getId()%>&pname=<%=stock.getProducts().getName()%>">
                                    <%=stock.getProducts().getName()%>
                                    </a>
                                </td>
                                <td><%=stock.getQuantity()%></td>
                                <td>
                                    <%=stock.getSupplier()%>
                                </td>
                                    <td><%=Classes.helpers.getUser(stock.getCuid()).getFirstname() + " " + Classes.helpers.getUser(stock.getCuid()).getLastname()%></td>
                                <td><%=stock.getCreatedAt()%></td>
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

<%
    } else {
        response.sendError(401);
    }
%>
