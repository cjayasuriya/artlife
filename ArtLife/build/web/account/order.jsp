<%-- 
    Document   : order
    Created on : May 25, 2017, 2:02:43 PM
    Author     : chamal
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (request.getSession().getAttribute("type") != null) {
        Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
        if (user.getStatus() == 1) {
%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../CSS/orderPortlet.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>


        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>

        <title>Order profile - Art Life</title>

    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />

        <%try {
                NumberFormat nf = NumberFormat.getNumberInstance();
                DecimalFormat df = (DecimalFormat) nf;
                df.applyPattern("###,###.00");

                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria orderCriteria = hiberSession.createCriteria(Pojos.Orders.class);
                orderCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("orderId").toString().toString())));

                Pojos.Orders order = (Pojos.Orders) orderCriteria.uniqueResult();

                JSONParser jSONParser = new JSONParser();
                Object metaObject = jSONParser.parse(order.getMeta());
                JSONObject metaJObject = (JSONObject) metaObject;

                JSONArray productsArray = (JSONArray) metaJObject.get("products");
                JSONObject jsonAddresses = (JSONObject) metaJObject.get("addresses");
                JSONObject jsonShippingInfo = (JSONObject) metaJObject.get("shippingInfo");
                JSONObject jsonBillingInfo = (JSONObject) metaJObject.get("billingInfo");

                Date orderedDate = (Date) (order.getCreatedAt());
                SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy HH:mm:ss a");

        %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-first-order" style="color: #f3c200;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #f3c200;">Order details</span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <p>Order #: <b><%=order.getId()%></b></p>
                                <p>Ordered date & time: <b><%=sdf.format(orderedDate)%></b></p>
                                <p>Order status: 
                                    <%
                                        switch (order.getOrderStatus().getId()) {
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

                                </p>
                                <p>Grand total: <b>LKR <%=df.format(Double.parseDouble(order.getTotal().toString()))%></b></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-user" style="color: #67809F;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #67809F;">Customer information</span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <p>Customer name: <b><%=order.getUsers().getFirstname() + " " + order.getUsers().getLastname()%></b></p>
                                <p>Email : <b><%=order.getUsers().getEmail()%></b></p>
                                <p>Phone number: <b><%=order.getUsers().getMobile()%></b></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-truck" style="color: #1BBC9B;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #1BBC9B;">Shipping info</span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <%                            try {
                                        Criteria shippingCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
                                        shippingCriteria.add(Restrictions.eq("id", Integer.parseInt(jsonAddresses.get("shipping").toString())));

                                        if (shippingCriteria.uniqueResult() != null) {
                                            Pojos.Addresses shippingAddress = (Pojos.Addresses) shippingCriteria.uniqueResult();

                                %>
                                <p>Shipping to : <b><%=jsonShippingInfo.get("shippingName").toString()%></b></p>
                                <p>Primary tele : <b><%=jsonShippingInfo.get("shippingTele").toString()%></b></p>
                                <p>Shipping address : <b><%out.write(shippingAddress.getAddress1() + " ");
                                    out.write(shippingAddress.getAddress2() + " ");
                                    out.write(shippingAddress.getCity() + " ");
                                    out.write(shippingAddress.getState() + " ");
                                    out.write(shippingAddress.getZip() + " ");
                                    out.write(shippingAddress.getCountry().getName() + " ");%></b></p>
                                        <%if (jsonShippingInfo.get("shippingNotiEmail").toString() != null) {
                                        %>
                                <p>Notification email : <b><%=jsonShippingInfo.get("shippingNotiEmail").toString()%></b></p>
                                <%
                                    }%>
                                <%if (jsonShippingInfo.get("shippingNotTele").toString() != null) {
                                %>
                                <p>Notification tele : <b><%=jsonShippingInfo.get("shippingNotTele").toString()%></b></p>
                                <%
                                    }%>

                                <%
                                        }
                                    } catch (Exception e) {
                                        out.write("Unable to load shipping details");
                                    }
                                %> 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">
                                    <span class="fa fa-credit-card-alt" style="color: #E26A6A;"></span>
                                    <span class="caption-subject text-uppercase" style="color: #E26A6A;">Billing info</span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <%
                                    try {
                                        Criteria billingCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
                                        billingCriteria.add(Restrictions.eq("id", Integer.parseInt(jsonAddresses.get("billing").toString())));

                                        if (billingCriteria.uniqueResult() != null) {
                                            Pojos.Addresses billingAddress = (Pojos.Addresses) billingCriteria.uniqueResult();
                                %>
                                <p>Billing to : <b><%=jsonBillingInfo.get("billingName").toString()%></b></p>
                                <p>Primary tele : <b><%=jsonBillingInfo.get("billingTele").toString()%></b></p>
                                <p>Billing address : <b><%out.write(billingAddress.getAddress1() + " ");
                                    out.write(billingAddress.getAddress2() + " ");
                                    out.write(billingAddress.getCity() + " ");
                                    out.write(billingAddress.getState() + " ");
                                    out.write(billingAddress.getZip() + " ");
                                    out.write(billingAddress.getCountry().getName() + " ");%></b></p>

                                <%if (jsonBillingInfo.get("billingEmail").toString() != null) {
                                %>
                                <p>Email : <b><%=jsonBillingInfo.get("billingEmail").toString()%></b></p>
                                <%
                                    }%>
                                <%if (jsonBillingInfo.get("billingTele").toString() != null) {
                                %>
                                <p>Optional tele : <b><%=jsonBillingInfo.get("billingTele").toString()%></b></p>
                                <%
                                    }%>


                                <%
                                        }
                                    } catch (Exception e) {
                                        out.write("Unable to load billing details");
                                    }
                                %> 
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
            <div class="row col-md-12"><br/></div>
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>Product description</th>
                                <th>Quantity</th>
                                <th>Price (LKR)</th>
                                <th>Line total (LKR)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                for (int i = 0; i < productsArray.size(); i++) {
                                    JSONObject childJsonObject = (JSONObject) productsArray.get(i);
                                    Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                                    productCriteria.add(Restrictions.eq("id", Integer.parseInt(childJsonObject.get("id").toString())));

                                    Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
                            %>
                            <tr>
                                <td><%=product.getName()%></td>
                                <td><%=childJsonObject.get("qty")%></td>
                                <td style="text-align: right;"><%=df.format(Double.parseDouble(childJsonObject.get("unitprice").toString()))%></td>
                                <td style="text-align: right;"><%=df.format(Double.parseDouble(childJsonObject.get("tot").toString()))%> </td>
                            </tr>
                            <%                                }
                            %>

                        </tbody>
                    </table>

                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-8">
                            <div style="text-align: right">Net total :</div>
                        </div>
                        <div class="col-md-2">
                            <div style="text-align: right">LKR <%=df.format(Double.parseDouble(order.getTotal().toString()))%></div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-8">
                            <div style="text-align: right">Shipping :</div>
                        </div>
                        <div class="col-md-2">
                            <div style="text-align: right">LKR 0.00</div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-8">
                            <div style="text-align: right">Estimated tax :</div>
                        </div>
                        <div class="col-md-2">
                            <div style="text-align: right">LKR 0.00</div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4 col-md-offset-8">
                            <hr>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-2 col-md-offset-8">
                            <div style="text-align: right;font-size:20px;text-decoration-style: solid"><b>Grand total</b></div>
                        </div>
                        <div class="col-md-2">
                            <div style="text-align: right;font-size:20px;"><b>LKR <%=df.format(Double.parseDouble(order.getTotal().toString()))%></b></div>
                        </div>
                    </div>

                    <%} catch (Exception e) {
                            out.write("Error");
                        }
                    %>
                    <div class="col-md-12"><br></div>

                    <div class="col-md-12"><br></div>

                </div>
            </div>
        </div>
    </body>
</html>
<%        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("../auth/login.jsp");
    }%>
