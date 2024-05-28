/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pojos.ShopBag;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author Chamal
 */
public class CartManagementServlet extends HttpServlet {

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

            /**
             * Session cart
             */            
            if (request.getSession().getAttribute("uid") == null) {
                Session hirSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                HashMap<String, String> session_cart;
                if (request.getSession().getAttribute("sessionCart") != null) {

                    session_cart = (HashMap<String, String>) request.getSession().getAttribute("sessionCart");
//                    for (String ss : session_cart.keySet()) {

                    if (session_cart.get(request.getParameter("proid")) != null) {

                        Criteria productCritera = hirSession.createCriteria(Pojos.Products.class);
                        productCritera.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("proid").toString())));

                        Pojos.Products product = (Pojos.Products) productCritera.uniqueResult();

                        int qt = Integer.parseInt(session_cart.get(request.getParameter("proid"))) + Integer.parseInt(request.getParameter("pqty"));
                        System.out.println(qt);

                        if (qt > product.getQty()) {
                            out.print("Can not add more product than the stock");
                        } else {
                            session_cart.put(request.getParameter("proid"), qt + "");
                        }

                    } else {

                        session_cart.put(request.getParameter("proid"), request.getParameter("pqty"));

                    }

//                    }
                    response.sendRedirect("shop/bag.jsp");
                } else {
                    session_cart = new HashMap<>();
                    session_cart.put(request.getParameter("proid"), request.getParameter("pqty"));
                    request.getSession().setAttribute("sessionCart", session_cart);
                    response.sendRedirect("shop/bag.jsp");
                }

                /**
                 * DB cart
                 */
            } else {
                if (request.getSession().getAttribute("uid") != null) {

                    Pojos.Users user = Classes.helpers.getActiveUer(1, request.getSession().getAttribute("uid").toString());
                    if (user.getStatus() == 1) {

                        Integer productId = Integer.parseInt(request.getParameter("proid"));
                        Integer productQty = Integer.parseInt(request.getParameter("pqty"));
                        Integer uid = Integer.parseInt((String) request.getSession().getAttribute("uid"));

                        JSONObject metaJSONObject = new JSONObject();
                        metaJSONObject.put("sellingPrice", request.getParameter("proSellingPrice"));

                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                        Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                        bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, uid)),
                                Restrictions.eq("products", (Pojos.Products) hiberSession.get(Pojos.Products.class, productId)),
                                Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

                        //Update bag if the product is already added
                        if (bagCriteria.uniqueResult() != null) {
                            Pojos.ShopBag selectedShopBag = (Pojos.ShopBag) bagCriteria.uniqueResult();

                            Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                            productCriteria.add(Restrictions.eq("id", productId));
                            Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();

                            int totqty = selectedShopBag.getQuantity() + productQty;

                            if (product.getQty() < totqty) {
                                out.print("Can not add more product that the stock");
                            } else {
                                selectedShopBag.setQuantity(selectedShopBag.getQuantity() + productQty);
                                selectedShopBag.setAddedAt(new Date());
                                selectedShopBag.setMeta(metaJSONObject.toString());

                                hiberSession.update(selectedShopBag);
                                hiberSession.beginTransaction().commit();
                                response.sendRedirect("shop/bag.jsp");
                            }
                        } else {

                            //Insert into shop_bag
                            Pojos.ShopBag myBag = new ShopBag();
                            myBag.setType(1); // 1--> Bag 2--> Fav
                            myBag.setProducts((Pojos.Products) hiberSession.get(Pojos.Products.class, productId));
                            myBag.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, uid));
                            myBag.setQuantity(productQty);
                            myBag.setAddedAt(new Date());
                            myBag.setStatus(1); //In cart
                            myBag.setMeta(metaJSONObject.toString());

                            hiberSession.save(myBag);
                            hiberSession.beginTransaction().commit();

                            response.sendRedirect("shop/bag.jsp");
                        }
                    } else {
                        out.print("You've been bolck from this website");
                    }

                }

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
