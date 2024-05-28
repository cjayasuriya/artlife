<%-- 
    Document   : profile
    Created on : Sep 10, 2016, 3:55:40 PM
    Author     : Chamal
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (request.getSession().getAttribute("uid") != null) {

        Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
        if (user.getStatus() == 1) {
        
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 


        <style>
            .modal-header, h3, .close {
                background-color: #fff;
                color: #333 !important;
                text-align: center;
                font-size: 25px;
            }
            .modal-header, .modal-body {
                padding: 40px 60px;
            }

            .table thead th { 
                background-color: #67809F;
            }
        </style>


        <title>
            <%out.write(request.getSession().getAttribute("firstname").toString() + " " + request.getSession().getAttribute("lastname").toString());%> - Art Life
        </title>
    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />

        <div class="container-fluid">

            <div class="row">
                <div class="col-md-12">
                    <!--    PROFILE     -->
                    <div class="col-md-5">

                        <div class="portlet margin-bottom-30">
                            <div class="portlet-title">
                                <div class="caption">

                                    <h3>
                                        <span class="fa fa-user" style="color: #87D37C;"></span>
                                        <span class="caption-subject text-uppercase" style="color: #87D37C;">My info</span>
                                    </h3>
                                    <hr>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <div class="col-md-12 text-center">
                                    <img src="../IMAGES/userprofile.png" class="img-circle profpic" alt="Cinque Terre" width="150" height="150"/>
                                </div>
                                <div class="col-md-12"><br></div>
                                <div class="col-md-12 text-center">
                                    <p><b>Name : </b><%=request.getSession().getAttribute("firstname") + " " + request.getSession().getAttribute("lastname")%></p>
                                    <p><b>Email : </b><%=request.getSession().getAttribute("email")%></p>
                                    <p><b>Telephone : </b><%=request.getSession().getAttribute("mobile")%></p>
                                </div>
                                <div>
                                    <h4>
                                        <span class="fa fa-cogs" style="color: #336E7B;"></span>
                                        <span class="caption-subject text-uppercase" style="color: #336E7B;">Settings</span>
                                    </h4>
                                    <ul>
                                        <li><a href="#"  data-toggle="modal" data-target="#updatePasswordModal">Change my password</a></li>
                                        <li><a href="#"  data-toggle="modal" data-target="#updateAccountModal">Update account</a></li>
                                            <%
                                                if (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2")) {
                                            %>
                                        <li><a href="../dashboard/dashboard.jsp">Go to dashboard</a></li>

                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>


                    <!--    ORDERS AND PURCHASE HISTORY     -->
                    <%
                        NumberFormat nf = NumberFormat.getNumberInstance();
                        DecimalFormat df = (DecimalFormat) nf;
                        df.applyPattern("###,###.00");

                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    %>
                    <div class="col-md-7">
                        <!--    ORDERS     -->
                        <div class="col-md-12"><br></div>
                        <div class="col-md-12">
                            <div class="portlet margin-bottom-30">
                                <div class="portlet-title">
                                    <div class="caption text-center">

                                        <h4>
                                            <span class="fa fa-first-order" style="color: #f3c200;"></span>
                                            <span class="caption-subject text-uppercase" style="color: #f3c200;">My orders</span>
                                        </h4>
                                        <hr>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead class="thead-default text-uppercase" style="color:white;">
                                            <tr>
                                                <th>Order #</th>
                                                <th>Products</th>
                                                <th>Total (LKR)</th>
                                                <th>Status</th>
                                                <th>Ordered at</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (Pojos.Orders order : Classes.helpers.getUserOrders(Integer.parseInt(request.getSession().getAttribute("uid").toString()))) {

                                            %>
                                            <tr>
                                                <td><a href="order.jsp?orderId=<%=order.getId()%>"><%=order.getId()%></a></td>
                                                <td>
                                                    <%
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
                                                <td style="text-align: right"><%=df.format(Double.parseDouble(order.getTotal().toString()))%></td>
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
                                                <td>
                                                    <%=order.getCreatedAt()%>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!--    PURCHASE HISTORY -->
                        <div class="col-md-12">
                            <div class="portlet margin-bottom-30">
                                <div class="portlet-title">
                                    <div class="caption text-center">

                                        <h4>
                                            <span class="fa fa-history" style="color: #67809F;"></span>
                                            <span class="caption-subject text-uppercase" style="color: #67809F;">Purchase History </span>
                                        </h4>
                                        <hr>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead class="thead-default text-uppercase" style="color:white;">
                                            <tr>
                                                <th>Order #</th>
                                                <th>Products</th>
                                                <th>Total (LKR)</th>
                                                <th>Purchased at</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (Pojos.Orders order : Classes.helpers.getUserCompletedOrders(Integer.parseInt(request.getSession().getAttribute("uid").toString()))) {

                                            %>
                                            <tr>
                                                <td><a href="order.jsp?orderId=<%=order.getId()%>"><%=order.getId()%></a></td>
                                                <td>
                                                    <%
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
                                                <td style="text-align: right"><%=df.format(Double.parseDouble(order.getTotal().toString()))%></td>

                                                <td>
                                                    <%=order.getCreatedAt()%>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Modal for update password -->
        <div class="modal fade" id="updateAccountModal" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel"><span class="fa fa-circle-o-notch fa-spin fa-1x"></span> Update account</h3>
                    </div>
                    <div class="modal-body">
                        <form action="../UpdateAccountServlet" method="POST">
                            <div class="form-group">
                                <label for="first-name" class="form-control-label">First name</label>
                                <input type="text" class="form-control" id="firstname" name="firstname" placeholder="First name" required="required" value="<%=request.getSession().getAttribute("firstname")%>">
                            </div>
                            <div class="form-group">
                                <label for="last-name" class="form-control-label">Last name</label>
                                <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Last name" required="required" value="<%=request.getSession().getAttribute("lastname")%>">
                            </div>
                            <div class="form-group">
                                <label for="email" class="form-control-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required="required" value="<%=request.getSession().getAttribute("email")%>">
                            </div>
                            <div class="form-group">
                                <label for="mobile" class="form-control-label">Mobile</label>
                                <input type="mobile" class="form-control" id="mobile" name="mobile" placeholder="Mobile" required="required" value="<%=request.getSession().getAttribute("mobile")%>">
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="update-account-btn" value="Apply changes">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for update password -->
        <div class="modal fade" id="updatePasswordModal" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title" id="myModalLabel"><span class="fa fa-circle-o-notch fa-spin fa-1x"></span> Update password</h3>
                    </div>
                    <div class="modal-body">
                        <form action="../UpdatePasswordServlet" method="POST">
                            <div class="form-group">
                                <label for="old-password" class="form-control-label">Old password</label>
                                <input type="password" class="form-control" id="oldpassword" name="oldpassword" placeholder="Old pssword" required="required">
                            </div>
                            <div class="form-group">
                                <label for="new-password" class="form-control-label">New password</label>
                                <input type="password" class="form-control" id="newpassword" name="newpassword" placeholder="New password" required="required">
                            </div>
                            <div class="form-group">
                                <label for="confirm-password" class="form-control-label">Confirm password</label>
                                <input type="password" class="form-control" id="confirmpassword" name="confirmpassword" placeholder="Confirm password" required="required">
                            </div>
                            <input type="submit" class="btn btn-primary btn-block" name="update-password-btn" value="Apply changes">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div></div>
                    </div>
                </div>
            </div>
        </div>

    </body>

    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../JS/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 

</html>
<%
        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("../auth/login.jsp");
    }
%>