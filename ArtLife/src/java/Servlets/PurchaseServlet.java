/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pojos.Addresses;
import Pojos.Orders;
import Pojos.Purchase;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author chamal
 */
public class PurchaseServlet extends HttpServlet {

    static int productCount = 0;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            Integer uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());
            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

            Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
            if (user.getStatus() == 1) {
                //Shing address
                String shippingName = request.getParameter("firstname") + " " + request.getParameter("lastname");
                String shippingAreaCode = request.getParameter("shippingareacode");
                String shippingTele = request.getParameter("shippingptele");
                String shippingAddress1 = request.getParameter("shippingaddress1");
                String shippingAddress2 = request.getParameter("shippingaddress2");
                String shippingCity = request.getParameter("shippingtown");
                String shippingState = request.getParameter("shippingstate");
                String shippingZip = request.getParameter("shippingpostalcode");
                Integer shippingCountry = Integer.parseInt(request.getParameter("shippingcountry").toString());

                //Shipping notifications
                String shippingNotiEmail = request.getParameter("shippingnemail");
                String shippingNotAreaCode = request.getParameter("shippingnareacode");
                String shippingNotTele = request.getParameter("shippingnptele");

                //Billing contacts
                String BCName = request.getParameter("billingfirstname") + " " + request.getParameter("billinglastname");
                String BCAreaCode = request.getParameter("billingareacode");
                String BCPrimaryTele = request.getParameter("billingptele");
                String BCOpAreaCode = request.getParameter("billingoareacode");
                String BCOpTele = request.getParameter("billingoptele");
                String BCEmail = request.getParameter("billingmail");

                //Billing address
                String billingAddress1 = request.getParameter("billingaddress1");
                String billingAddress2 = request.getParameter("billingaddress2");
                String billingCity = request.getParameter("billingtown");
                String billingState = request.getParameter("billingstate");
                String billingZip = request.getParameter("billingpostalcode");
                Integer billingCountry = Integer.parseInt(request.getParameter("billingcountry"));

                /**
                 * Insert into address table
                 */
                //Insert shipping address
                Pojos.Addresses shippingAddress = new Addresses();

                shippingAddress.setType(1);
                shippingAddress.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, uid));
                shippingAddress.setAddress1(shippingAddress1);
                shippingAddress.setAddress2(shippingAddress2);
                shippingAddress.setCity(shippingCity);
                shippingAddress.setState(shippingState);
                shippingAddress.setZip(shippingZip);
                shippingAddress.setCountry((Pojos.Country) hiberSession.get(Pojos.Country.class, shippingCountry));
                shippingAddress.setStatus(1);
                shippingAddress.setCuid(uid);
                shippingAddress.setUuid(uid);
                shippingAddress.setCreatedAt(new Date());
                shippingAddress.setUpdatedAt(new Date());

                hiberSession.save(shippingAddress);
                hiberSession.beginTransaction().commit();

                //Insert billing address
                Pojos.Addresses billingAddress = new Addresses();

                billingAddress.setType(2);
                billingAddress.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, uid));
                billingAddress.setAddress1(billingAddress1);
                billingAddress.setAddress2(billingAddress2);
                billingAddress.setCity(billingCity);
                billingAddress.setState(billingState);
                billingAddress.setZip(billingZip);
                billingAddress.setCountry((Pojos.Country) hiberSession.get(Pojos.Country.class, billingCountry));
                billingAddress.setStatus(1);
                billingAddress.setCuid(uid);
                billingAddress.setUuid(uid);
                billingAddress.setCreatedAt(new Date());
                billingAddress.setUpdatedAt(new Date());

                hiberSession.save(billingAddress);
                hiberSession.beginTransaction().commit();

                //Get addresses ids
                SQLQuery getAddresses = hiberSession.createSQLQuery("SELECT id FROM addresses ORDER BY id DESC LIMIT 2");
                List addressesList = getAddresses.list();

                /**
                 * Insert into purchase table
                 */
                boolean pstatus = false;
                Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, uid)),
                        Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

                Pojos.Addresses getAddressId = (Pojos.Addresses) hiberSession.get(Pojos.Addresses.class, Integer.parseInt(addressesList.get(1).toString()));

                List<Pojos.ShopBag> bagList = bagCriteria.list();

                for (Pojos.ShopBag bagItem : bagList) {

                    Pojos.Purchase myPurchase = new Purchase();

                    if (bagItem.getProducts().getStatus() == 1) {

                        if (bagItem.getQuantity() > bagItem.getProducts().getQty()) {
                            out.write("Not enugh products are exiciting in the stock");
                        } else {
                            myPurchase.setProducts((Pojos.Products) hiberSession.get(Pojos.Products.class, bagItem.getProducts().getId()));
                            myPurchase.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, uid));
                            myPurchase.setQuantity(bagItem.getQuantity());
                            myPurchase.setEmail("");
                            myPurchase.setShippingNames(shippingName);
                            myPurchase.setBillingNames(BCName);
                            myPurchase.setAddresses(getAddressId);
                            myPurchase.setMeta("");
                            myPurchase.setPurchasedAt(new Date());

                            hiberSession.save(myPurchase);
                            hiberSession.beginTransaction().commit();

                            //Update from product table
                            Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                            productCriteria.add(Restrictions.eq("id", bagItem.getProducts().getId()));

                            if (productCriteria.uniqueResult() != null) {
                                Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
                                product.setQty(product.getQty() - bagItem.getQuantity());

                                hiberSession.update(product);
                                hiberSession.beginTransaction().commit();

                                pstatus = true;

                            } else {
                                //Send to error page 
                            }
                        }
                    }

                }

                if (pstatus == true) {
                    /**
                     * Insert into orders
                     */
                    Pojos.Orders myOrder = new Orders();

                    double total = 0.00;
                    JSONParser jSONParser = new JSONParser();
                    JSONObject metaObject = new JSONObject();
                    JSONArray jSONArray = new JSONArray();

                    productCount = 0;
                    for (Pojos.ShopBag bagItem : bagList) {

                        try {

                            if (bagItem.getProducts().getStatus() == 1) {

                                Object jObject = jSONParser.parse(bagItem.getMeta());
                                JSONObject metaObj = (JSONObject) jObject;

                                JSONObject childObject = new JSONObject();

                                childObject.put("id", bagItem.getProducts().getId());
                                childObject.put("qty", bagItem.getQuantity());
                                childObject.put("unitprice", metaObj.get("sellingPrice").toString());
                                childObject.put("tot", Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString()));

                                total = total + Double.parseDouble(metaObj.get("sellingPrice").toString()) * Double.parseDouble(bagItem.getQuantity().toString());

                                productCount++;

                                jSONArray.add(childObject);
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            //Send to error page
                        }

                    }

                    //Adiing payment methods
                    JSONObject paymentMethod = new JSONObject();
                    paymentMethod.put("cardNumber", request.getParameter("cardnumber"));

                    //Adding shipping info
                    JSONObject jsonShipppingInfo = new JSONObject();
                    jsonShipppingInfo.put("shippingName", shippingName);
                    jsonShipppingInfo.put("shippingTele", shippingAreaCode + " " + shippingTele);
                    jsonShipppingInfo.put("shippingNotiEmail", shippingNotiEmail);
                    jsonShipppingInfo.put("shippingNotTele", shippingNotAreaCode + " " + shippingNotTele);

                    //Adding billing info
                    JSONObject jsonBillingInfo = new JSONObject();
                    jsonBillingInfo.put("billingName", BCName);
                    jsonBillingInfo.put("billingTele", BCAreaCode + " " + BCPrimaryTele);
                    jsonBillingInfo.put("billingOpTele", BCOpAreaCode + " " + BCOpTele);
                    jsonBillingInfo.put("billingEmail", BCEmail);

                    //Adding addresses
                    JSONObject jsonAddresses = new JSONObject();
                    jsonAddresses.put("billing", addressesList.get(0));
                    jsonAddresses.put("shipping", addressesList.get(1));

                    metaObject.put("products", jSONArray);
                    metaObject.put("payment_method", paymentMethod);
                    metaObject.put("addresses", jsonAddresses);
                    metaObject.put("shippingInfo", jsonShipppingInfo);
                    metaObject.put("billingInfo", jsonBillingInfo);
                    metaObject.put("orderStatusMsg", "");

                    myOrder.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, uid));
                    myOrder.setNumberOfProducts(productCount);
                    myOrder.setTotal(BigDecimal.valueOf(total));
                    myOrder.setMeta(metaObject.toString());
                    myOrder.setOrderStatus((Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 1));
                    myOrder.setCuid(uid);
                    myOrder.setUuid(uid);
                    myOrder.setCreatedAt(new Date());
                    myOrder.setUpdatedAt(new Date());

                    hiberSession.save(myOrder);
                    hiberSession.beginTransaction().commit();


                    /*
                     *Remove products from the bag
                     */
                    for (Pojos.ShopBag bagItem : bagList) {
                        bagItem.setStatus(3);
                        hiberSession.update(bagItem);
                        hiberSession.beginTransaction().commit();
                    }

                    //Get addresses ids
                    SQLQuery getLastOrderId = hiberSession.createSQLQuery("SELECT id FROM orders ORDER BY id DESC LIMIT 1");
                    List ordersList = getLastOrderId.list();

                    //Send email
                    try {
                        Classes.sendPurchaseEmail.sendEmail(request.getSession().getAttribute("email").toString());
                    } catch (Exception e) {
                    }

                    response.sendRedirect("shop/invoice.jsp?orderId=" + ordersList.get(0) + "&cid=" + request.getSession().getAttribute("uid") + "customer=" + request.getSession().getAttribute("firstname") + " " + request.getSession().getAttribute("lastname") + "");
                } else {
                    //error
                }

            } else {
                out.print("You've been block from this website");
            }

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
