<%-- 
    Document   : create-category
    Created on : Sep 21, 2016, 2:07:28 PM
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>

        <title>Add new category - Art Life</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Add new category</h2> 
                    </div> 
                </div>
            </div> 
            <form action="../CategoryManageServlet" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Category name <span style="color: red" class="required">*</span></label>
                                <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Category name" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Parent category</label>
                                <select class="form-control" name="parentcategory" id="parentcategory">
                                    <option value="0">Parent</option>
                                    <%
                                        try {
                                            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                            Criteria categoryCriteria = hiberSession.createCriteria(Pojos.Categories.class);
                                            List<Pojos.Categories> categoryLists = categoryCriteria.list();
                                            for (Pojos.Categories category : categoryLists) {
                                    %>
                                    <option value="<%out.write(category.getId().toString());%>"><%out.write(category.getName().toString());%></option>

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
                        <div class="col-md-8">
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
        </div>
    </body>
</html>
<%        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("errors/erroe401.jsp");
    }%>