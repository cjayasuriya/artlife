<%-- 
    Document   : edit-product
    Created on : Sep 30, 2016, 9:00:12 AM
    Author     : Chamal
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getSession().getAttribute("type") != null && (request.getSession().getAttribute("type").equals("1") | request.getSession().getAttribute("type").equals("2"))) {
        try {
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

        <title>Update product - Art Life </title>
    </head>
    <body>
        <jsp:include page="../adminNavbar.jsp" />
        <%
            JSONParser jSONParser = new JSONParser();
            Integer pid = Integer.parseInt(request.getParameter("pid"));
            Session hSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = hSession.createCriteria(Pojos.Products.class);
            productCriteria.add(Restrictions.eq("id", pid));

            if (productCriteria.uniqueResult() != null) {

                Pojos.Products productInfo = (Pojos.Products) productCriteria.uniqueResult();
                Object ojb = jSONParser.parse(productInfo.getMeta());
                JSONObject jObj = (JSONObject) ojb;

                JSONObject childDesc = (JSONObject) jObj.get("description");
                JSONObject childSup = (JSONObject) jObj.get("supplier");
                JSONObject childManu = (JSONObject) jObj.get("manufacturer");

                int manuCountry = Integer.parseInt(childManu.get("manufacturer_country").toString());
                int supCountry = Integer.parseInt(childSup.get("supplier_country").toString());

                Criteria selectedCategoryCriteria = hSession.createCriteria(Pojos.Categories.class);
                selectedCategoryCriteria.add(Restrictions.eq("id", Integer.parseInt(productInfo.getCategories().getId().toString())));

                Criteria supCountryCriteria = hSession.createCriteria(Pojos.Country.class);
                supCountryCriteria.add(Restrictions.eq("id", supCountry));

                Criteria manuCountryCriteria = hSession.createCriteria(Pojos.Country.class);
                manuCountryCriteria.add(Restrictions.eq("id", manuCountry));

        %>


        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                <div class="col-md-12"><br/></div>
                
                <ul class="breadcrumb">
                    <li><a href="products.jsp">Products Management</a></li>
                    <li><a href="products.jsp">Products</a></li>
                    <li><a href="product.jsp?pid=<%=request.getParameter("pid")%>&pname=<%=productInfo.getName()%>"><%=productInfo.getName()%></a></li>
                    <li class="active">Edit product</li>
                </ul>
                
                <div class="col-md-12">
                    <div class="col-md-12">
                        <h2>Edit product</h2> 
                    </div> 
                </div>
                <div class="col-md-12"><br/></div>
            </div>  
            <form action="../ProductUpdateServlet" method="POST">
                <input type="hidden" name="productId" id="productId" value="<%=request.getParameter("pid")%>"/>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>SKU code <span style="color: red" class="required">*</span></label>
                            <input type="text" class="form-control" id="categoryname" name="skucode" placeholder="SKU code" value="<%=productInfo.getSku()%>" required="required"/>
                        </div>
                        <div class="col-md-3">
                            <label>Barcode</label>
                            <input type="text" class="form-control" id="barcode" name="barcode" placeholder="Barcode" value="<%=productInfo.getBarcode()%>" />
                        </div>
                    </div>   
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Product category <span style="color: red" class="required">*</span></label>
                            <select class="form-control" name="productcategory" id="productcategory" required="required">
                                <option value="0" disabled></option>
                                <%try {
                                        if (selectedCategoryCriteria.uniqueResult() != null) {
                                            Pojos.Categories selectedCategory = (Pojos.Categories) selectedCategoryCriteria.uniqueResult();
                                %>
                                <option value="<%=selectedCategory.getId()%>"><%=selectedCategory.getName()%></option>
                                <%
                                    }

                                    for (Pojos.Categories category : Classes.helpers.getAllCategories()) {
                                %>
                                <option value="<%=category.getId()%>"><%=category.getName()%></option>
                                <%
                                    }
                                } catch (Exception e) {
                                %>
                                <option value="0" disabled></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Product name <span style="color: red" class="required">*</span></label>
                            <input type="text" class="form-control" id="productname" name="productname" placeholder="Product name" value="<%=productInfo.getName()%>" required="required"/>
                        </div>
                        <div class="col-md-3">
                            <label>Brand name</label>
                            <input type="text" class="form-control" id="brandname" name="brandname" placeholder="Brand name" value="<%=jObj.get("brandname")%>"/>
                        </div>    
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <label>Product short description</label>
                            <textarea class="form-control" id="productshortdesc" name="productshortdesc" placeholder="Product short description" rows="3"><%=childDesc.get("short")%></textarea>
                        </div>
                    </div>
                    <div class="col-md-12"></br></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <label>Product long description</label>
                            <textarea class="form-control" id="productlongdesc" name="productlongdesc" placeholder="Product long description" rows="5"><%=childDesc.get("long")%></textarea>
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Product price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="productprice" name="productprice" placeholder="00.00" required="required" value="<%=productInfo.getSellingPrice()%>"/>
                        </div>
                        <div class="col-md-3">
                            <label>Selling price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="sellingprice" name="sellingprice" placeholder="00.00" required="required" value="<%=productInfo.getSellingPrice()%>"/>
                        </div>
                        <div class="col-md-3">
                            <label>Shipping price <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="shippingprice" name="shippingprice" placeholder="00.00" required="required" value="<%=productInfo.getShippingPrice()%>"/>
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Quantity <span style="color: red" class="required">*</span></label>
                            <input type="number" class="form-control" id="qty" name="qty" placeholder="Quantity" required="required" value="<%=productInfo.getQty()%>"/>
                        </div>    
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Weight</label>
                            <input type="number" class="form-control" id="weight" name="weight" placeholder="00.00" value="<%=productInfo.getWeight()%>" />
                        </div>  
                        <div class="col-md-3">
                            <label>Weight unit</label>
                            <select class="form-control" name="weightunit" id="weightunit">
                                <option></option>
                            </select>
                        </div>  
                    </div>                   
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Height</label>
                            <input type="number" class="form-control" id="height" name="height" placeholder="00.00" value="<%=jObj.get("height")%>
                                   "/>
                        </div>  
                        <div class="col-md-3">
                            <label>Width</label>
                            <input type="number" class="form-control" id="width" name="width" placeholder="00.00" />
                        </div>  
                        <div class="col-md-3">
                            <label>Depth</label>
                            <input type="number" class="form-control" id="depth" name="depth" placeholder="00.00" value="<%=jObj.get("depth")%>" />
                        </div>  
                        <div class="col-md-3">
                            <label>Length unit</label>
                            <select class="form-control" name="lengthunit" id="lengthunit">
                                <option></option>
                            </select>
                        </div>  
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Manufacturer</label>
                            <input type="text" class="form-control" id="manufacturer" name="manufacturer" placeholder="Manufacturer" value="<%=childManu.get("manufacturer")%>" />
                        </div> 
                        <div class="col-md-3">
                            <label>Manufacturer country</label>
                            <select class="form-control" name="manucountry" id="manucountry">
                                <option value="0" disabled="disabled"></option>
                                <%if (manuCountryCriteria.uniqueResult() != null) {
                                        Pojos.Country manuCountryValue = (Pojos.Country) manuCountryCriteria.uniqueResult();
                                %>
                                <option value="<%=manuCountry%>"><%=manuCountryValue.getName()%></option>
                                <%
                                    }
                                    for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                %>
                                <option value="<%=country.getId()%>"><%=country.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Manufacturer email</label>
                            <input type="email" class="form-control" id="manuemail" name="manuemail" placeholder="Manufacturer email" value="<%=childManu.get("manufacturer_email")%>"  />
                        </div>  
                        <div class="col-md-3">
                            <label>Manufacturer website</label>
                            <input type="url" class="form-control" id="manuurl" name="manuurl" placeholder="Manufacturer website" value="<%=childManu.get("manufacturer_web")%>" />
                        </div>    
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-3">
                            <label>Supplier</label>
                            <input type="text" class="form-control" id="supplier" name="supplier" placeholder="Supplier" value="<%=childSup.get("supplier")%>"/>
                        </div> 
                        <div class="col-md-3">
                            <label>Supplier country</label>
                            <select class="form-control" name="supcountry" id="supcountry">
                                <option value="0" disabled="disabled"></option>
                                <%if (supCountryCriteria.uniqueResult() != null) {
                                        Pojos.Country supCountryValue = (Pojos.Country) supCountryCriteria.uniqueResult();
                                %>
                                <option value="<%=supCountry%>"><%=supCountryValue.getName()%></option>
                                <%
                                    }
                                    for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                %>
                                <option value="<%=country.getId()%>"><%=country.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label>Supplier email</label>
                            <input type="email" class="form-control" id="supemail" name="supemail" placeholder="Supplier email" value="<%=childSup.get("supplier_email")%>" />
                        </div>  
                        <div class="col-md-3">
                            <label>Supplier website</label>
                            <input type="url" class="form-control" id="supurl" name="supurl" placeholder="Supplier website" value="<%=childSup.get("supplier_web")%>" />
                        </div>    
                    </div>
                    <%}%>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <input type="submit" id="edit-product-btn" class="btn btn-primary btn-block" name="edit-product-btn" value="Edit product"/>       
                        </div>
                    </div>
                    <div class="col-md-12"><br/></div>
                    <div class="col-md-12"><br/></div>
                </div>
            </form>
        </div>
    </body>
</html>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="../https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../JS/jquery.min.js" type="text/javascript"></script>
<%
        } catch (Exception e) {//Send it to 500 error 
        }
    }else{
        response.sendError(401);
    }
%>