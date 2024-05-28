<%-- 
    Document   : orders
    Created on : May 4, 2017, 8:53:12 AM
    Author     : chamal
--%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
        Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
        if (user.getStatus() == 1) {
%>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>


        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>

        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>

        <title>Orders - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />

        <%
            if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
        %>



        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br><br><br></div>

                <ul class="breadcrumb">
                    <li><a href="orders.jsp">Orders</a></li>
                    <li class="active">Orders</li>
                </ul>

                <div class="col-md-12"><h2>Orders</h2></div>
                <div class="col-md-12">
                    <%try {
                            NumberFormat nf = NumberFormat.getNumberInstance();
                            DecimalFormat df = (DecimalFormat) nf;
                            df.applyPattern("###,###.00");

                            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                    %>

                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Order #</th>
                                <th>Ordered customer</th>
                                <th>No. of products</th>
                                <th>Products</th>
                                <th>Total (LKR)</th>
                                <th>Shipping address</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%try {
                                    for (Pojos.Orders order : Classes.helpers.getAllFilteredOrders()) {
                            %>
                            <tr
                                ><td><a href="order.jsp?orderId=<%=order.getId()%>&cid=<%=order.getUsers().getId()%>&customer=<%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%>"><%=order.getId()%></a></td> 
                                <td><%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%></td> 
                                <td><%=order.getNumberOfProducts()%></td> 
                                <td><%
                                    JSONParser jSONParser = new JSONParser();
                                    Object metaObject = jSONParser.parse(order.getMeta());
                                    JSONObject metaJObject = (JSONObject) metaObject;
                                    JSONArray productsArray = (JSONArray) metaJObject.get("products");

                                    for (int i = 0; i < productsArray.size(); i++) {
                                        JSONObject childJsonObject = (JSONObject) productsArray.get(i);

                                        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                                        productCriteria.add(Restrictions.eq("id", Integer.parseInt(childJsonObject.get("id").toString())));

                                        Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
                                        out.write(product.getName() + "<br>");
                                    %>
                                    <%
                                        }
                                    %>
                                </td> 
                                <td><%=df.format(Double.parseDouble(order.getTotal().toString()))%></td> 
                                <td>
                                    <%
                                        JSONParser jParser = new JSONParser();
                                        Object mObject = jParser.parse(order.getMeta());
                                        JSONObject mJoObject = (JSONObject) mObject;

                                        JSONObject jsonAddresses = (JSONObject) mJoObject.get("addresses");
                                        Criteria shippingCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
                                        shippingCriteria.add(Restrictions.eq("id", Integer.parseInt(jsonAddresses.get("shipping").toString())));

                                        Pojos.Addresses shippingAddress = (Pojos.Addresses) shippingCriteria.uniqueResult();

                                        out.write(shippingAddress.getAddress1() + " ");
                                        out.write(shippingAddress.getAddress2() + " ");
                                        out.write(shippingAddress.getCity() + " ");
                                        out.write(shippingAddress.getState() + " ");
                                        out.write(shippingAddress.getZip() + " ");
                                        out.write(shippingAddress.getCountry().getName() + " ");


                                    %>
                                </td>
                                <td>

                                    <%                                        switch (order.getOrderStatus().getId()) {
                                            case 1:
                                    %>
                                    <span class="label label-warning"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 2:%>
                                    <span class="label label-info"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 3:%>
                                    <span class="label label-primary"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 4:%>
                                    <span class="label label-success"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 5:%>
                                    <span class="label label-danger"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                                break;
                                        }
                                    %>

                                </td> 
                            </tr>
                            <%
                                }
                            %>

                            <%} catch (Exception e) {
                                    out.write("Error is here");
                                }%>

                        </tbody>

                    </table>



                    <%} catch (Exception e) {
                            out.write("Error is here");
                        }%>
                </div>

                <!--COMPLETED ORDERS-->
                <div class="col-md-12"><h2>Completed orders</h2></div>
                <div class="col-md-12">
                    <%try {
                            NumberFormat nf = NumberFormat.getNumberInstance();
                            DecimalFormat df = (DecimalFormat) nf;
                            df.applyPattern("###,###.00");

                            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                    %>

                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Order #</th>
                                <th>Ordered customer</th>
                                <th>No. of products</th>
                                <th>Products</th>
                                <th>Total (LKR)</th>
                                <th>Shipping address</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%try {
                                    for (Pojos.Orders order : Classes.helpers.getAllCompletedOrders()) {
                            %>
                            <tr
                                ><td><a href="order.jsp?orderId=<%=order.getId()%>&cid=<%=order.getUsers().getId()%>&customer=<%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%>"><%=order.getId()%></a></td> 
                                <td><%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%></td> 
                                <td><%=order.getNumberOfProducts()%></td> 
                                <td><%
                                    JSONParser jSONParser = new JSONParser();
                                    Object metaObject = jSONParser.parse(order.getMeta());
                                    JSONObject metaJObject = (JSONObject) metaObject;
                                    JSONArray productsArray = (JSONArray) metaJObject.get("products");

                                    for (int i = 0; i < productsArray.size(); i++) {
                                        JSONObject childJsonObject = (JSONObject) productsArray.get(i);

                                        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                                        productCriteria.add(Restrictions.eq("id", Integer.parseInt(childJsonObject.get("id").toString())));

                                        Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
                                        out.write(product.getName() + "<br>");
                                    %>
                                    <%
                                        }
                                    %>
                                </td> 
                                <td><%=df.format(Double.parseDouble(order.getTotal().toString()))%></td> 
                                <td>
                                    <%
                                        JSONParser jParser = new JSONParser();
                                        Object mObject = jParser.parse(order.getMeta());
                                        JSONObject mJoObject = (JSONObject) mObject;

                                        JSONObject jsonAddresses = (JSONObject) mJoObject.get("addresses");
                                        Criteria shippingCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
                                        shippingCriteria.add(Restrictions.eq("id", Integer.parseInt(jsonAddresses.get("shipping").toString())));

                                        Pojos.Addresses shippingAddress = (Pojos.Addresses) shippingCriteria.uniqueResult();

                                        out.write(shippingAddress.getAddress1() + " ");
                                        out.write(shippingAddress.getAddress2() + " ");
                                        out.write(shippingAddress.getCity() + " ");
                                        out.write(shippingAddress.getState() + " ");
                                        out.write(shippingAddress.getZip() + " ");
                                        out.write(shippingAddress.getCountry().getName() + " ");


                                    %>
                                </td>
                                <td>

                                    <%                                        switch (order.getOrderStatus().getId()) {
                                            case 1:
                                    %>
                                    <span class="label label-warning"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 2:%>
                                    <span class="label label-info"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 3:%>
                                    <span class="label label-primary"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 4:%>
                                    <span class="label label-success"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 5:%>
                                    <span class="label label-danger"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                                break;
                                        }
                                    %>

                                </td> 
                            </tr>
                            <%
                                }
                            %>

                            <%} catch (Exception e) {
                                    out.write("Error is here");
                                }%>

                        </tbody>

                    </table>



                    <%} catch (Exception e) {
                            out.write("Error is here");
                        }%>
                </div>

                <!--CANCELED ORDERS-->
                <div class="col-md-12"><h2>Canceled orders</h2></div>
                <div class="col-md-12">
                    <%try {
                            NumberFormat nf = NumberFormat.getNumberInstance();
                            DecimalFormat df = (DecimalFormat) nf;
                            df.applyPattern("###,###.00");

                            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                    %>

                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Order #</th>
                                <th>Ordered customer</th>
                                <th>No. of products</th>
                                <th>Products</th>
                                <th>Total (LKR)</th>
                                <th>Shipping address</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%try {
                                    for (Pojos.Orders order : Classes.helpers.getAllCancelledOrders()) {
                            %>
                            <tr
                                ><td><a href="order.jsp?orderId=<%=order.getId()%>&cid=<%=order.getUsers().getId()%>&customer=<%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%>"><%=order.getId()%></a></td> 
                                <td><%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%></td> 
                                <td><%=order.getNumberOfProducts()%></td> 
                                <td><%
                                    JSONParser jSONParser = new JSONParser();
                                    Object metaObject = jSONParser.parse(order.getMeta());
                                    JSONObject metaJObject = (JSONObject) metaObject;
                                    JSONArray productsArray = (JSONArray) metaJObject.get("products");

                                    for (int i = 0; i < productsArray.size(); i++) {
                                        JSONObject childJsonObject = (JSONObject) productsArray.get(i);

                                        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                                        productCriteria.add(Restrictions.eq("id", Integer.parseInt(childJsonObject.get("id").toString())));

                                        Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
                                        out.write(product.getName() + "<br>");
                                    %>
                                    <%
                                        }
                                    %>
                                </td> 
                                <td><%=df.format(Double.parseDouble(order.getTotal().toString()))%></td> 
                                <td>
                                    <%
                                        JSONParser jParser = new JSONParser();
                                        Object mObject = jParser.parse(order.getMeta());
                                        JSONObject mJoObject = (JSONObject) mObject;

                                        JSONObject jsonAddresses = (JSONObject) mJoObject.get("addresses");
                                        Criteria shippingCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
                                        shippingCriteria.add(Restrictions.eq("id", Integer.parseInt(jsonAddresses.get("shipping").toString())));

                                        Pojos.Addresses shippingAddress = (Pojos.Addresses) shippingCriteria.uniqueResult();

                                        out.write(shippingAddress.getAddress1() + " ");
                                        out.write(shippingAddress.getAddress2() + " ");
                                        out.write(shippingAddress.getCity() + " ");
                                        out.write(shippingAddress.getState() + " ");
                                        out.write(shippingAddress.getZip() + " ");
                                        out.write(shippingAddress.getCountry().getName() + " ");


                                    %>
                                </td>
                                <td>

                                    <%                                        switch (order.getOrderStatus().getId()) {
                                            case 1:
                                    %>
                                    <span class="label label-warning"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 2:%>
                                    <span class="label label-info"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 3:%>
                                    <span class="label label-primary"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 4:%>
                                    <span class="label label-success"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                            break;
                                        case 5:%>
                                    <span class="label label-danger"><%=order.getOrderStatus().getName()%></span>
                                    <%
                                                break;
                                        }
                                    %>

                                </td> 
                            </tr>
                            <%
                                }
                            %>

                            <%} catch (Exception e) {
                                    out.write("Error is here");
                                }%>

                        </tbody>

                    </table>



                    <%} catch (Exception e) {
                            out.write("Error is here");
                        }%>
                </div>

            </div>

        </div>




        <%
            } else {
                response.sendError(401);
            }
        %>

    </body>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
<%        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("errors/erroe401.jsp");
    }%>
