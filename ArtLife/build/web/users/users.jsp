<%-- 
    Document   : users
    Created on : Nov 17, 2016, 2:24:17 AM
    Author     : chamaljayasuriya
--%>

<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
        <style>
            .table thead th { 
                background-color: #67809F;
            </style>

        </style>
        <title>Users - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <%
            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

        %>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br><br><br></div>

                <ul class="breadcrumb">
                    <li><a href="users.jsp">Users Management</a></li>
                    <li class="active">Users</li>
                </ul>

                <div class="col-md-12">
                    <h1>Users</h1>
                </div>
                <%                    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1"))) {
                %>
                <div class="col-md-12">
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Actions
                            <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="create-admin.jsp">Add admin</a></li>
                        </ul>
                    </div>
                </div>
                <%
                    }
                %>


            </div>
            <div class="row">
                <div class="col-md-12">
                    <h3>
                        Active customers -
                        <%=hiberSession.createCriteria(Pojos.Users.class).add(Restrictions.and(Restrictions.eq("type", 3), Restrictions.eq("status", 1))).setProjection(Projections.rowCount()).uniqueResult()%>
                    </h3>
                </div>
                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>User name</th>
                                <th>Email</th>
                                <th>Contact number</th>
                                <th>Ban / Unban</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    for (Pojos.Users customer : Classes.helpers.getAllActiveUsers()) {
                            %>
                            <tr>
                                <td><%=customer.getFirstname() + " " + customer.getLastname()%></td>
                                <td><a href="mailto:<%=customer.getEmail()%>"><%=customer.getEmail()%></a></td>
                                <td><%=customer.getMobile()%></td>
                                <td><%
                                    if (customer.getStatus() == 1) {
                                    %>
                                    <form action="../userStatusChangeServlet" method="POST">
                                        <input type="hidden" name="userId" value="<%=customer.getId()%>">
                                        <input type="submit" class="btn btn-danger btn-block" name="deactiveBtn" value="Deactive">
                                    </form>
                                    <%
                                    } else {
                                    %>                                            
                                    <form action="../userStatusChangeServlet" method="POST">
                                        <input type="hidden" name="userId" value="<%=customer.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="activeBtn" value="Active">
                                    </form><%
                                        }
                                    %>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <%
                    } catch (Exception e) {
                    %>
                    <h4 class="text-center">Users are unavailable</h4>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                if (request.getSession().getAttribute("type") != null && request.getSession().getAttribute("type").equals("1")) {
            %>
            <div class="row">
                <div class="col-md-12">
                    <h3>
                        Active admins - 
                        <%=hiberSession.createCriteria(Pojos.Users.class).add(Restrictions.and(Restrictions.eq("type", 2), Restrictions.eq("status", 1))).setProjection(Projections.rowCount()).uniqueResult()%>
                    </h3>
                </div>
                <div class="col-md-12">
                    <table class="table table-bordered table-hover table-striped">
                        <thead class="thead-default text-uppercase" style="color:white;">
                            <tr>
                                <th>User name</th>
                                <th>Email</th>
                                <th>Contact number</th>
                                <th>Ban / Unban</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%try {
                                    for (Pojos.Users admin : Classes.helpers.getAllActiveAdmins()) {
                            %>
                            <tr>
                                <td><%=admin.getFirstname() + " " + admin.getLastname()%></td>
                                <td><a href="mailto:<%=admin.getEmail()%>"><%=admin.getEmail()%></a></td>
                                <td><%=admin.getMobile()%></td>
                                <td><%
                                    if (admin.getStatus() == 1) {
                                    %>
                                    <form action="../userStatusChangeServlet" method="POST">
                                        <input type="hidden" name="userId" value="<%=admin.getId()%>">
                                        <input type="submit" class="btn btn-danger btn-block" name="deactiveBtn" value="Deactive">
                                    </form>
                                    <%
                                    } else {
                                    %>                                            
                                    <form action="../userStatusChangeServlet" method="POST">
                                        <input type="hidden" name="userId" value="<%=admin.getId()%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="activeBtn" value="Active">
                                    </form><%
                                        }
                                    %>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <%
                    } catch (Exception e) {
                    %>
                    <h4 class="text-center">Users are unavailable</h4>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
<%} else {
        response.sendError(401);
    }%>
