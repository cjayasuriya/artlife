<%-- 
    Document   : dashboard
    Created on : Nov 10, 2016, 7:52:26 PM
    Author     : Chamal
--%>

<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 

        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>

        <title>Dashboard - Art Life</title>
    </head>
    <body>
        <%            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

        %>
        <jsp:include page="../adminNavbar.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>

            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="portlet margin-bottom-30">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="fa fa-first-order" style="color: #f3c200;"></span>
                                <span class="caption-subject text-uppercase" style="color: #f3c200;">Number of orders - 
                                    <%=hiberSession.createCriteria(Pojos.Orders.class).add(Restrictions.not(Restrictions.or(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 4)), Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 5))))).setProjection(Projections.rowCount()).uniqueResult()%>
                                </span>
                                <hr>
                            </div>
                        </div>
                        <div class="portlet-body">
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="portlet margin-bottom-30">
                        <div class="portlet-title">
                            <div class="caption">
                                <span class="fa fa-first-order" style="color: #1BBC9B;"></span>
                                <span class="caption-subject text-uppercase" style="color: #1BBC9B;">Online users - 
                                    <%=Classes.sessionCounter.getAllActiveUsers()%>
                                </span>
                                <hr>
                            </div>
                        </div>
                        <div class="portlet-body">
                        </div>
                    </div>

                </div>
                <div class="col-md-4"></div>
            </div>
            <div class="row"></br></div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Latest products</h4>
                </div>
                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Product #</th>
                                <th>Product name</th>
                                <th>Quantity</th>
                                <th>Category</th>
                                <th>Added by</th>
                                <th>Added at</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%try {
                                    for (Pojos.Products product : Classes.helpers.getLatestProducts(5)) {%>

                            <tr>

                                <td><%=product.getId()%></td>
                                <td>
                                    <a href="../products/product.jsp?pid=<%=product.getId()%>&pname=<%=product.getName()%>">
                                        <%=product.getName()%>
                                    </a>
                                </td>
                                <td><%=product.getQty()%></td>
                                <td>
                                    <%=product.getCategories().getName()%>
                                </td>
                                <td><%=Classes.helpers.getUser(product.getCuid()).getFirstname() + " " + Classes.helpers.getUser(product.getCuid()).getLastname()%></td>
                                <td><%=product.getCreatedAt()%></td>
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
            <div class="row"></br></div>
            <div class="row">
                <div class="col-md-12">
                    <h4>Less quantity products</h4>
                </div>
                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Product #</th>
                                <th>Product name</th>
                                <th>Quantity</th>
                                <th>Category</th>
                                <th>Added by</th>
                                <th>Added at</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%try {
                                    for (Pojos.Products product : Classes.helpers.getLessProducts(10)) {%>

                            <tr>

                                <td><%=product.getId()%></td>
                                <td>
                                    <a href="../products/product.jsp?pid=<%=product.getId()%>&pname=<%=product.getName()%>">
                                        <%=product.getName()%>
                                    </a>
                                </td>
                                <td><%=product.getQty()%></td>
                                <td>
                                    <%=product.getCategories().getName()%>
                                </td>
                                <td><%=Classes.helpers.getUser(product.getCuid()).getFirstname() + " " + Classes.helpers.getUser(product.getCuid()).getLastname()%></td>
                                <td><%=product.getCreatedAt()%></td>
                                <td>
                                    <form action="../stocks/add-stock.jsp" method="POST">
                                        <input type="hidden" name="productId" value="<%=product.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="add-stock-btn" value="Add stock">
                                    </form>
                                </td>
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
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
<%
        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("errors/erroe401.jsp");
    }%>
