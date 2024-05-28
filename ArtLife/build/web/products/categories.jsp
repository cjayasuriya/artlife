<%-- 
    Document   : categories
    Created on : Sep 21, 2016, 1:39:44 AM
    Author     : Chamal
--%>

<%@page import="jdk.nashorn.internal.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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

        <style>

            .table thead th { 
                background-color: #67809F;
            }

        </style>

        <title>Categories - Art Life</title>
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
                    <li class="active">Categories</li>
                </ul>

                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Categories</h2> 
                    </div> 
                </div>
            </div> 

            <div class="row">
                <div class="container-fluid">
                    <!--CATEGORIES TABLE START-->
                    <div class="col-md-6">
                        <div class="col-md-12"><br/></div>
                        <div class="row container-fluid">
                            <div class="col-md-12">
                                <%
                                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();
                                %>

                                <table class="table table-bordered table-hover table-striped">
                                    <thead class="thead-default text-uppercase" style="color:white;">
                                        <tr>
                                            <th>Name</th>
                                            <th>Parent category</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%                                            try {
                                                for (Pojos.Categories category : Classes.helpers.getAllCategories()) {%>

                                        <tr>
                                            <td><a href="edit-category.jsp?cid=<%=category.getId()%>"> <%=category.getName()%></a></td>
                                            <td>
                                                <%
                                                    if (category.getParentid() == 0) {
                                                %>
                                                No parent
                                                <%
                                                    } else {
                                                        Criteria patentC = hiberSession.createCriteria(Pojos.Categories.class);
                                                        patentC.add(Restrictions.eq("id", category.getParentid()));
                                                        if (patentC.uniqueResult() != null) {
                                                            Pojos.Categories categoryParent = (Pojos.Categories) patentC.uniqueResult();
                                                            out.write(categoryParent.getName().toString());
                                                        }
                                                    }
                                                %>
                                            </td>
                                            <td>
                                                <%
                                                    try {
                                                        Object obj = jparser.parse(category.getMeta());
                                                        JSONObject jObj = (JSONObject) obj;
                                                        out.write((String) jObj.get("description"));
                                                    } catch (Exception e) {
                                                    }
                                                %>
                                            </td>
                                        </tr> 

                                        <%}
                                        } catch (Exception e) {
                                        %>
                                        <tr>
                                            <td colspan="5">No categories to load</td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>

                            </div>
                        </div>

                        <!--CATEGORIES TABLE END-->
                    </div>

                    <div class="col-md-6">
                        <!--ADD NEW CATEGORY START-->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <h3>Add new category</h3> 
                                </div> 
                            </div>
                        </div> 
                        <form action="../CategoryManageServlet" method="POST">
                            <div class="row">
                                <div class="col-md-12"><br/></div>
                                <div class="col-md-12">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Category name <span style="color: red" class="required">*</span></label>
                                            <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Category name" required="required"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Parent category</label>
                                            <select class="form-control" name="parentcategory" id="parentcategory">
                                                <option value="0">Parent</option>
                                                <%
                                                    try {
                                                        for (Pojos.Categories category : Classes.helpers.getAllCategories()) {
                                                %>
                                                <option value="<%=category.getId()%>"><%=category.getName()%></option>

                                                <%
                                                    }
                                                } catch (Exception e) { %>
                                                <option  value = "0" >Parent</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12"></br></div>
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <label>Category description</label>
                                        <textarea class="form-control" id="categorydesc" name="categorydesc" placeholder="Category description" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12"><br/></div>
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <input type="submit" id="create-category-btn" class="btn btn-primary btn-block" name="create-category-btn" value="Add new category" />
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!--ADD NEW CATEGORY END-->
                    </div>
                </div>
            </div>
        </div>
    </body>
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

