<%-- 
    Document   : edit-category
    Created on : Sep 22, 2016, 12:07:17 PM
    Author     : Chamal
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="Pojos.Categories"%>
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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="../JS/jquery.min.js" type="text/javascript"></script>

        <title>Edit category - Art Life</title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Edit category</h2> 
                    </div> 
                </div>
            </div> 
            <div class="col-md-12"><br/></div>
                <%
                    Integer cid = Integer.parseInt(request.getParameter("cid"));

                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria categoryDetails = hiberSession.createCriteria(Pojos.Categories.class);
                    categoryDetails.add(Restrictions.eq("id", cid));

                    if (categoryDetails.uniqueResult() != null) {

                        Pojos.Categories categoryInfo = (Pojos.Categories) categoryDetails.uniqueResult();
                        org.json.simple.parser.JSONParser jparser = new org.json.simple.parser.JSONParser();
                        Object obj = jparser.parse(categoryInfo.getMeta());
                        JSONObject jObj = (JSONObject) obj;
                %>

            <form action="../CategoryUpdateServlet" method="POST">
                <input type="hidden" name="cid" value="<%=cid%>"/>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Category name <span style="color: red" class="required">*</span></label>
                                <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Category name" value="<%=categoryInfo.getName()%>" required="required"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Parent category</label>
                                <select class="form-control" name="parentcategory" id="parentcategory">
                                    <%
                                        if (categoryInfo.getParentid() == 0) {
                                    %>
                                    <option value="0">No parent</option>
                                    <%
                                    } else {
                                        Criteria getParentCategory = hiberSession.createCriteria(Pojos.Categories.class);
                                        getParentCategory.add(Restrictions.eq("id", categoryInfo.getParentid()));
                                        if (getParentCategory.uniqueResult() != null) {
                                            Pojos.Categories parentCategory = (Pojos.Categories) getParentCategory.uniqueResult();
                                    %>
                                    <option value="<%=categoryInfo.getParentid()%>"><%=parentCategory.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                    <option value="0">No parent</option>
                                    <% try {
                                            for (Pojos.Categories categoryParent : Classes.helpers.getAllCategories()) {
                                    %>
                                    <option value="<%=categoryParent.getId()%>"><%=categoryParent.getName()%></option>

                                    <%
                                        }
                                    } catch (Exception e) { %>
                                    <option  value = "0" > No parent</option>
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
                            <textarea class="form-control" id="categorydesc" name="categorydesc" placeholder="Category description" rows="3"><%=jObj.get("description")%></textarea>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <input type="submit" id="edit-category-btn" class="btn btn-primary btn-block" name="edit-category-btn" value="Edit category" />
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<%}else{
        response.sendError(401);
    }%>