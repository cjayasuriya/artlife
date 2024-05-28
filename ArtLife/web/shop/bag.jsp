<%-- 
    Document   : bag
    Created on : Oct 22, 2016, 9:14:45 AM
    Author     : Chamal
--%>

<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="Pojos.Products"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

        <style>

            caption, th {
                text-align: left;
            }
            table{
                max-width: 100%;
                width:100%;
                border-collapse: collapse;
                background-color: transparent
            }
            img {
                max-height: 150px;
                min-width: 50px;
            }
            th,td{
                border-bottom: 1px solid #ddd;
            }
            th{
                padding: 15px;
                alignment-adjust: middle;
                text-align: center;
            }
            td{
                padding: 20px;
                text-align: left;
            }
            .ltotal{
                text-align: right;
            }


        </style>

        <script>
            function calculateLineTotal() {
                var qty = document.getElementById('productQty').value;
                var uPrice = document.getElementById('proUnitPrice').value;

                var lTot = qty * uPrice;

                document.getElementById('lineTotal').value.innerHTML = lTot;
                //window.alert("sd");

            }
        </script>

        <title>My bag - Art Life </title>
    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />
        <div class="container-fluid">
            <form method="POST" action="../CheckoutServlet">
                <div class="row">
                    <div class="col-md-12 container-fluid">
                        <h3 style="color: #663300;" class="text-center">My Bag <span class="fa fa-shopping-bag"></span></h3>
                        <hr width="90%">
                        <%
                            NumberFormat nf = NumberFormat.getNumberInstance();
                            DecimalFormat df = (DecimalFormat) nf;
                            df.applyPattern("###,###.00");
                            double total = 0.00;
                            JSONParser jbagParser = new JSONParser();
                            Object obj;
                            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                            /**
                             * Database cart
                             */
                            if (request.getSession().getAttribute("uid") != null) {

                                Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                                bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, Integer.parseInt(request.getSession().getAttribute("uid").toString()))),
                                        Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

                                List<Pojos.ShopBag> bagList = bagCriteria.list();

                        %>
                        <div class="col-md-10 col-md-offset-1 table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th style="text-align: center;">Product</th>
                                        <th style="text-align: center;"> Category</th>
                                        <th style="text-align: center;">Brand name</th>
                                        <th style="text-align: center;">Quantity</th>
                                        <th style="text-align: right;">Price (LKR)</th>
                                        <th style="text-align: right;">Line total (LKR)</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (Pojos.ShopBag bagItem : bagList) {
                                            Object jObject = jbagParser.parse(bagItem.getMeta());
                                            JSONObject metaObj = (JSONObject) jObject;

                                            Pojos.Products itemProduct = (Pojos.Products) hiberSession.get(Pojos.Products.class, bagItem.getProducts().getId());
                                            if (itemProduct.getStatus() == 1) {
                                                total += Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString());
                                            }
                                            obj = jbagParser.parse(itemProduct.getMeta());
                                            JSONObject productjObj = (JSONObject) obj;
                                            JSONObject childManu = (JSONObject) productjObj.get("manufacturer");

                                    %>
                                    <tr>
                                        <th scope="row">
                                            <img src="../IMAGES/productImages/<%=productjObj.get("imgP")%>" class="img-fluid z-depth-0">
                                        </th>
                                        <td >
                                            <h5><strong>
                                                    <%=itemProduct.getName()%>
                                                    <%if (itemProduct.getStatus() == 0) {%><br><div style="color: red;">This product has been deactivated</div><%}%>
                                                </strong></h5>
                                            <p class="text-muted">by <%=childManu.get("manufacturer")%></p>
                                        </td>
                                        <td><%=itemProduct.getCategories().getName()%></td>
                                        <td><%=productjObj.get("brandname")%></td>
                                        <td class="ltotal">
                                            <input class="form-control" type="number" name="proQty" id="productQty" style="width:60px;" value="<%=bagItem.getQuantity()%>"/>
                                        </td>
                                        <td class="ltotal"><%=df.format(Double.parseDouble(metaObj.get("sellingPrice").toString()))%></td>
                                        <td class="ltotal"><%=df.format(Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString()))%></td>
                                        <td class="ltotal"><a href="../removeDbCartProduct?productId=<%=bagItem.getProducts().getId()%>&bagId=<%=bagItem.getId()%>">Remove</a></td>

                                    </tr>
                                    <%
                                        }%>
                                </tbody>
                            </table>
                            <div class="col-md-12">
                                <div class="col-md-2 col-md-offset-8">
                                    <div style="text-align: right">Bag subtotal</div>
                                </div>
                                <div class="col-md-2">
                                    <div style="text-align: right">LKR <%=df.format(total)%></div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-2 col-md-offset-8">
                                    <div style="text-align: right">Free shipping</div>
                                </div>
                                <div class="col-md-2">
                                    <div style="text-align: right">LKR 0.00</div>
                                </div>
                            </div>
                            <!--                            <div class="col-md-12">
                                                            <div class="col-md-2 col-md-offset-8">
                                                                <div style="text-align: right">Estimated tax</div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div style="text-align: right"><a href="#">Calculate</a></div>
                                                            </div>
                                                        </div>-->
                            <div class="col-md-12">
                                <div class="col-md-4 col-md-offset-8">
                                    <hr>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-2 col-md-offset-8">
                                    <div style="text-align: right;font-size:20px;text-decoration-style: solid"><b>Total</b></div>
                                </div>
                                <div class="col-md-2">
                                    <div style="text-align: right;font-size:20px;"><b>LKR <%=df.format(total)%></b></div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <hr>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-3 col-md-offset-9">
                                    <input type="hidden" name="ordertotal" value="<%=df.format(total)%>">
                                    <input type="submit" class="btn btn-primary btn-block" name="checkout" value="Checkout"/>


                                </div>
                            </div>





                            <%                            } else {
                                /**
                                 * Session cart
                                 */
                                if (request.getSession().getAttribute("sessionCart") != null) {
                                    try {
                            %>
                            <div class="col-md-10 col-md-offset-1 table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th style="text-align: center;">Product</th>
                                            <th style="text-align: center;"> Category</th>
                                            <th style="text-align: center;">Brand name</th>
                                            <th style="text-align: center;">Quantity</th>
                                            <th style="text-align: right;">Price (LKR)</th>
                                            <th style="text-align: right;">Line total (LKR)</th>
                                            <th></th>
                                        </tr>
                                    </thead>

                                    <%
                                        HashMap<String, String> hm = (HashMap<String, String>) request.getSession().getAttribute("sessionCart");
                                        org.json.simple.parser.JSONParser jParserMeta = new org.json.simple.parser.JSONParser();
                                        org.json.simple.parser.JSONParser jParserDesc = new org.json.simple.parser.JSONParser();

                                        //DecimalFormat df = new DecimalFormat("#.00");
                                        for (String key : hm.keySet()) {

                                            Pojos.Products p = (Pojos.Products) hiberSession.load(Pojos.Products.class, Integer.parseInt(key));
                                            Object metaObj = jParserMeta.parse(p.getMeta());
                                            JSONObject metaJObj = (JSONObject) metaObj;

                                            if (p.getStatus() == 1) {
                                                total += (p.getSellingPrice()).doubleValue() * (Double.parseDouble(hm.get(key)));
                                            }

                                    %>
                                    <tbody>
                                        <tr>
                                            <th scope="row">
                                                <img src="../IMAGES/productImages/<%=metaJObj.get("imgP")%>" class="img-fluid z-depth-0">
                                            </th>
                                            <td>
                                                <h5><strong>
                                                        <%=p.getName().toString()%>
                                                        <%if (p.getStatus() == 0) {%><br><div style="color: red;">This product has been deactivated</div><%}%>
                                                    </strong></h5>
                                                <p class="text-muted">
                                                    <%

                                                        try {

                                                            Object descObject = jParserDesc.parse(metaJObj.get("manufacturer").toString());
                                                            if (descObject != null) {
                                                                JSONObject desJObj = (JSONObject) descObject;
                                                                if (desJObj != null) {
                                                                    out.write("by " + (String) desJObj.get("manufacturer"));
                                                                }
                                                            }

                                                        } catch (Exception e) {
                                                        }
                                                    %>
                                                </p>
                                            </td>
                                            <td><%=p.getCategories().getName()%></td>
                                            <td>
                                                <%
                                                    if (metaJObj.get("brandname") != null) {
                                                        out.write(metaJObj.get("brandname").toString());
                                                    } else {
                                                        out.write("-");
                                                    }

                                                %>
                                            </td>

                                            <td><input class="form-control" type="number" name="proQty" id="productQty" style="width:60px;" value="<%=hm.get(key).toString()%>"/></td>
                                            <td class="ltotal"> <div id="proUnitPrice"><%=df.format(p.getSellingPrice())%></div></td>
                                            <td class="ltotal"> <div id="lintTotal"><%=df.format((p.getSellingPrice()).doubleValue() * Double.parseDouble(hm.get(key)))%></div></td>
                                            <td class="ltotal" >
                                                <a href="../CartManagementRemoveSession?proid=<%=p.getId()%>">
                                                    <!--                                                <a href="#">-->
                                                    Remove</a></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                                <div class="col-md-12">
                                    <div class="col-md-2 col-md-offset-8">
                                        <div style="text-align: right">Bag subtotal</div>
                                    </div>
                                    <div class="col-md-2">
                                        <div style="text-align: right">LKR <%=df.format(total)%></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-2 col-md-offset-8">
                                        <div style="text-align: right">Shipping</div>
                                    </div>
                                    <div class="col-md-2">
                                        <div style="text-align: right">LKR 0.00</div>
                                    </div>
                                </div>
                                <!--                                <div class="col-md-12">
                                                                    <div class="col-md-2 col-md-offset-8">
                                                                        <div style="text-align: right">Estimated tax</div>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <div style="text-align: right"><a href="#">Calculate</a></div>
                                                                    </div>
                                                                </div>-->
                                <div class="col-md-12">
                                    <div class="col-md-4 col-md-offset-8">
                                        <hr>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-2 col-md-offset-8">
                                        <div style="text-align: right;font-size:20px;text-decoration-style: solid"><b>Total</b></div>
                                    </div>
                                    <div class="col-md-2">
                                        <div style="text-align: right;font-size:20px;"><b>LKR <%=df.format(total)%></b></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <hr>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-3 col-md-offset-9">
                                        <input type="hidden" name="ordertotal" value="<%=df.format(total)%>">
                                        <input type="submit" class="btn btn-primary btn-block" name="checkout" value="Checkout"/>


                                    </div>
                                </div>

                                <%                } catch (Exception e) {
                                    e.printStackTrace();
                                %>
                                <%
                                    }

                                } else {%>
                                <h4 class="text-center">There's no items in your bag.</h4>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
