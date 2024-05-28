<%-- 
    Document   : checkout
    Created on : Jan 15, 2017, 11:00:49 AM
    Author     : chamaljayasuriya
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
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
        <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <style>
            .box{
                padding: 10px;
                //box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                background-color:#f2f2f2; 
            } 
        </style>
        <title>Checkout - Art Life</title>
    </head>
    <body>
        <jsp:include page="../navbarinside.jsp" />
        <form method="POST" action="../PurchaseServlet">
            <div class="container-fluid">

                <%
                    Pojos.Orders order = Classes.helpers.getLastOrder(Integer.parseInt(request.getSession().getAttribute("uid").toString()));

                    Object metaOrderObj = null;
                    JSONObject metaOrderJObj = null;

                    Object addressObj = null;
                    JSONObject addressJObj = null;

                    Object shippingInfoObj = null;
                    JSONObject shippingInfoJObj = null;

                    Object billingInfoObj = null;
                    JSONObject billingInfoJObj = null;

                    Pojos.Addresses shippingAddress = null;
                    Pojos.Addresses billingAddress = null;

                    try {
                        if (order != null) {
                            JSONParser jSONParser = new JSONParser();

                            metaOrderObj = jSONParser.parse(order.getMeta());
                            metaOrderJObj = (JSONObject) metaOrderObj;

                            addressObj = jSONParser.parse(metaOrderJObj.get("addresses").toString());
                            addressJObj = (JSONObject) addressObj;

                            shippingInfoObj = jSONParser.parse(metaOrderJObj.get("shippingInfo").toString());
                            shippingInfoJObj = (JSONObject) shippingInfoObj;

                            billingInfoObj = jSONParser.parse(metaOrderJObj.get("billingInfo").toString());
                            billingInfoJObj = (JSONObject) billingInfoObj;

                            shippingAddress = Classes.helpers.getAddress(Integer.parseInt(addressJObj.get("shipping").toString()));
                            billingAddress = Classes.helpers.getAddress(Integer.parseInt(addressJObj.get("billing").toString()));

//                            out.write(shippingInfoJObj.get("shippingName").toString());
                        }

                %>

                <div class="row">
                    <div class="col-md-6 container-fluid">
                        <div class="col-md-12"><h4>Shipping address</h4></div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" id="fullname" class="form-control" name="firstname" placeholder="First name" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <input type="text" id="lastname" class="form-control" name="lastname" placeholder="Last name" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="text" id="shippingareacode" class="form-control" name="shippingareacode" placeholder="Area code" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input type="text" id="shippingptele" class="form-control" name="shippingptele" placeholder="Primary telephone" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="text" id="shippingaddress1" class="form-control" name="shippingaddress1" placeholder="Street address with home number" required="required" value=""/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="text" id="shippingaddress2" class="form-control" name="shippingaddress2" placeholder="Street address (optional)" value=""/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="shippingtown" class="form-control" name="shippingtown" placeholder="Town / City" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="shippingstate" class="form-control" name="shippingstate" placeholder="State"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="shippingpostalcode" class="form-control" name="shippingpostalcode" placeholder="Postal code" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <select class="form-control" name="shippingcountry" id="shippingcountry" required="required">
                                        <option  value = "0" >Country</option>
                                        <%                                            try {
                                                for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                        %>
                                        <option value="<%out.write(country.getId().toString());%>"><%out.write(country.getName().toString());%></option>

                                        <%
                                            }
                                        } catch (Exception e) { %>
                                        <option  value = "0" ></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12"><h4>Shipping notifications</h4></div>
                        <div class="col-md-12">
                            <div class="col-md-12"><p>Shipment notification email are sent to the billing contact. Another recipient email address may be added below.</p></div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="email" id="shippingnemail" class="form-control" name="shippingnemail" placeholder="Email address (optional)"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12"><p>For shipment updates via text messages, enter a mobile number below.</p></div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="text" id="shippingnareacode" class="form-control" name="shippingnareacode" placeholder="Area code"/>                             
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input type="text" id="shippingnptele" class="form-control" name="shippingnptele" placeholder="Mobile phone"/>                             
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-6 container-fluid">
                        <div class="col-md-12"><h4>Cart summary</h4></div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12 box container-fluid">
                            <div class="col-md-12">
                                <%
                                    try {
                                        NumberFormat nf = NumberFormat.getNumberInstance();
                                        DecimalFormat df = (DecimalFormat) nf;
                                        df.applyPattern("###,###.00");
                                        double total = 0.00;
                                        JSONParser jbagParser = new JSONParser();
                                        Object obj;
                                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                                        if (request.getSession().getAttribute("uid") != null) {

                                            Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                                            bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, Integer.parseInt(request.getSession().getAttribute("uid").toString()))),
                                                    Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

                                            List<Pojos.ShopBag> bagList = bagCriteria.list();

                                %>

                                <table class="table table-responsive">
                                    <tbody>
                                        <%     for (Pojos.ShopBag bagItem : bagList) {
                                                Object jObject = jbagParser.parse(bagItem.getMeta());
                                                JSONObject metaObj = (JSONObject) jObject;

                                                Pojos.Products itemProduct = (Pojos.Products) hiberSession.get(Pojos.Products.class, bagItem.getProducts().getId());
                                                total += Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString());
                                                obj = jbagParser.parse(itemProduct.getMeta());
                                                JSONObject productjObj = (JSONObject) obj;
                                                JSONObject childManu = (JSONObject) productjObj.get("manufacturer");

                                        %>

                                        <tr>
                                            <td><%=itemProduct.getName()%><%if(itemProduct.getStatus()==0){%><b> This has been deactivated</b><%}%></td>
                                            <td style="text-align: right"><%=bagItem.getQuantity()%></td>
                                            <td style="text-align: right">LKR <%=df.format(Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString()))%></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>


                                <%
                                    }
                                %>
                                <%
                                    } catch (Exception e) {
                                    }
                                %>

                            </div>
                            <div class="col-md-12"><br/></div>
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="submit" id="congirm" class="btn btn-primary btn-block" name="confirm" value="Confirm and pay"/>                             
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12"><br/></div>
                <div class="row">
                    <div class="col-md-6 container-fluid">
                        <div class="col-md-12"><h4>Billing contact</h4></div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" id="billingfullname" class="form-control" name="billingfirstname" placeholder="First name" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <input type="text" id="billinglastname" class="form-control" name="billinglastname" placeholder="Last name" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="text" id="billingareacode" class="form-control" name="billingareacode" placeholder="Area code" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input type="text" id="billingptele" class="form-control" name="billingptele" placeholder="Primary telephone" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="text" id="billingoareacode" class="form-control" name="billingoareacode" placeholder="Area code"/>                             
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input type="text" id="billingoptele" class="form-control" name="billingoptele" placeholder="Mobile phone (optional)"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="email" id="billingmail" class="form-control" name="billingmail" placeholder="Email address" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12"><h4>Billing address</h4></div>
                        <div class="col-md-12"><br/></div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="text" id="billingaddress1" class="form-control" name="billingaddress1" placeholder="Street address with home number" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <input type="text" id="billingaddress2" class="form-control" name="billingaddress2" placeholder="Street address (optional)"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="billingtown" class="form-control" name="billingtown" placeholder="Town / City" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="billingstate" class="form-control" name="billingstate" placeholder="State"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" id="billingpostalcode" class="form-control" name="billingpostalcode" placeholder="Postal code" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <select class="form-control" name="billingcountry" id="billingcountry" required="required">
                                        <option  value = "0" >Country</option>
                                        <%
                                            try {
                                                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                                Criteria countryCriteria = hiberSession.createCriteria(Pojos.Country.class);
                                                List<Pojos.Country> counttryList = countryCriteria.list();
                                                for (Pojos.Country country : Classes.helpers.getAllCountries()) {
                                        %>
                                        <option value="<%=country.getId()%>"><%=country.getName()%></option>

                                        <%
                                            }
                                        } catch (Exception e) { %>
                                        <option  value = "0" ></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12"><br/></div><div class="col-md-12"><br/></div>
                        </div>
                    </div>
                    <div class="col-md-6 container-fluid">
                        <div class="col-md-12"><h4>Payment method</h4></div>
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <img src="../IMAGES/payment-methods.jpg" alt="Payment method" width="40%" height="40%"/>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-9">
                                <div class="form-group">
                                    <input type="number" id="cardnumber" maxlength="16" class="form-control" name="cardnumber" placeholder="Card number" required="required"/>                             
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input type="number" id="securecode" maxlength="3" class="form-control" name="securecode" placeholder="Security code" required="required"/>                             
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-2">
                                <div>Expires</div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group"> 
                                    <select id="paymentmonth" class="form-control" name="paymentmonth" required="required">
                                        <option value="0" disabled>Month</option>
                                        <%
                                            String months[] = new DateFormatSymbols().getMonths();
                                            for (int y = 0; y < months.length; y++) {
                                        %>
                                        <option value="<%=months[y]%>"><%=months[y]%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <select class="form-control" name="payymentyear" id="payymentyear" required="required">
                                        <option value="0" disabled>Year</option>
                                        <%
                                            for (int i = 0; i < 10; i++) {
                                        %>
                                        <option value="<%=Calendar.getInstance().get(Calendar.YEAR) + i%>"><%=Calendar.getInstance().get(Calendar.YEAR) + i%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    } catch (Exception e) {
                    }
                %>
            </div>
        </form>

    </body>
</html>

<%        } else {
            out.print("You've been block from this website");
        }
    } else {
        response.sendRedirect("../auth/login.jsp");
    }%>