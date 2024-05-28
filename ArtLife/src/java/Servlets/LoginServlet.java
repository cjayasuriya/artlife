/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pojos.ShopBag;
import Pojos.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author Chamal
 */
public class LoginServlet extends HttpServlet {

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

            String email = request.getParameter("useremail");
            String password = request.getParameter("userpassword").toString();

            request.getSession().setAttribute("loginErrorMsg", null);
            request.getSession().setAttribute("loginEmailErrorMsg", null);
            request.getSession().setAttribute("loginPasswordErrorMsg", null);
            request.getSession().setAttribute("loginBlockErrorMsg", null);

            if (request.getSession().getAttribute("uid") == null) {
                /**
                 * Back end validation
                 */
                if (!(email.equals(null) | password.equals(null))) {

                    /**
                     * Encrypting the password
                     */
                    String generatedPassword = null;
                    try {

                        MessageDigest md = MessageDigest.getInstance("MD5");
                        md.update(password.getBytes());
                        byte[] bytes = md.digest();
                        StringBuilder sb = new StringBuilder();

                        for (int i = 0; i < bytes.length; i++) {
                            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                        }

                        generatedPassword = sb.toString();

                    } catch (NoSuchAlgorithmException e) {
                        e.printStackTrace();
                    }

                    String enctyptedPassword = generatedPassword;

                    //Creating hibernate session
                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                    Criteria criteria = hiberSession.createCriteria(Pojos.Users.class);

                    //Checking the email criteria
                    Criteria criteriaEmailCheck = hiberSession.createCriteria(Pojos.Users.class);
                    criteriaEmailCheck.add(Restrictions.eq("email", email));

                    //Checking for a valid email
                    if (criteriaEmailCheck.uniqueResult() != null) {

                        //Checking the user is active or inacive
                        Pojos.Users userTypeCheck = (Pojos.Users) criteriaEmailCheck.uniqueResult();
                        if (userTypeCheck.getStatus() == 1) {

                            // Checking for the password
                            criteria.add(Restrictions.and(Restrictions.eq("email", email), Restrictions.eq("password", enctyptedPassword), Restrictions.eq("status", 1)));

                            /**
                             * Setting attributes to the session
                             */
                            if (criteria.uniqueResult() != null) {

                                Pojos.Users user = (Pojos.Users) criteria.uniqueResult();

                                //Setting attributes to the session
                                HttpSession session = request.getSession();
                                session.setAttribute("uid", user.getId().toString());
                                session.setAttribute("firstname", user.getFirstname().toString());
                                session.setAttribute("lastname", user.getLastname().toString());
                                session.setAttribute("email", user.getEmail().toString());
                                session.setAttribute("mobile", user.getMobile().toString());
                                session.setAttribute("type", user.getType().toString());

                                /**
                                 * Updating the login time
                                 */
                                Pojos.Users users = (Pojos.Users) hiberSession.get(Pojos.Users.class, user.getId());
                                Session hiberSforLoginTime = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cForLoginTime = hiberSforLoginTime.createCriteria(Pojos.LoginDetails.class).add(Restrictions.eq("users", users));

                                if (cForLoginTime.uniqueResult() != null) {
                                    Pojos.LoginDetails loginDetails = (Pojos.LoginDetails) cForLoginTime.uniqueResult();

                                    JSONObject metaObject = new JSONObject();
                                    metaObject.put("loginStaus", 1);

                                    loginDetails.setLoginAt(new Date());
                                    loginDetails.setMeta(metaObject.toString());
                                    hiberSforLoginTime.update(loginDetails);
                                }

                                hiberSforLoginTime.beginTransaction().commit();

                                /**
                                 * Add products to bag from session
                                 */
                                if (request.getSession().getAttribute("sessionCart") != null) {

                                    HashMap<String, String> hm = (HashMap<String, String>) request.getSession().getAttribute("sessionCart");
                                    JSONObject metaJSONObject = new JSONObject();

                                    for (String key : hm.keySet()) {

                                        Criteria bagCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                                        bagCriteria.add(Restrictions.and(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, Integer.parseInt((String) request.getSession().getAttribute("uid").toString()))),
                                                Restrictions.eq("products", (Pojos.Products) hiberSession.get(Pojos.Products.class, Integer.parseInt(key))),
                                                Restrictions.eq("type", 1), Restrictions.eq("status", 1)));

                                        Pojos.Products product = (Pojos.Products) hiberSession.load(Pojos.Products.class, Integer.parseInt(key));

                                        //Update from session cart
                                        if (bagCriteria.uniqueResult() != null) {
                                            Pojos.ShopBag selectedShopBag = (Pojos.ShopBag) bagCriteria.uniqueResult();

                                            int totqty = Integer.parseInt(hm.get(key)) + selectedShopBag.getQuantity();

                                            if (product.getQty() < totqty) {
                                                out.print("Can not add more product than the stock");
                                            } else {
                                                selectedShopBag.setQuantity(selectedShopBag.getQuantity() + Integer.parseInt(hm.get(key)));
                                                selectedShopBag.setAddedAt(new Date());
                                                metaJSONObject.put("sellingPrice", product.getSellingPrice().toString());
                                                selectedShopBag.setMeta(metaJSONObject.toString());

                                                hiberSession.update(selectedShopBag);
                                                hiberSession.beginTransaction().commit();

                                                response.sendRedirect("shop/bag.jsp");
                                            }

                                            //Add from session cart
                                        } else {
                                            if (product.getQty() < Integer.parseInt(hm.get(key))) {
                                                out.print("Can not add more product than the stock");
                                            } else {
                                                Pojos.ShopBag myBag = new ShopBag();
                                                myBag.setType(1); // 1--> Bag 2--> Fav
                                                myBag.setProducts((Pojos.Products) hiberSession.get(Pojos.Products.class, product.getId()));
                                                myBag.setUsers((Pojos.Users) hiberSession.get(Pojos.Users.class, Integer.parseInt(request.getSession().getAttribute("uid").toString())));
                                                myBag.setQuantity(Integer.parseInt(hm.get(key)));
                                                myBag.setAddedAt(new Date());
                                                myBag.setStatus(1); //In cart

                                                metaJSONObject.put("sellingPrice", product.getSellingPrice().toString());
                                                myBag.setMeta(metaJSONObject.toString());

                                                hiberSession.save(myBag);
                                                hiberSession.beginTransaction().commit();

                                                response.sendRedirect("shop/bag.jsp");
                                            }

                                        }
                                    }
                                } else {

                                    try {
                                        if (!request.getSession().getAttribute("checkoutStatus").equals(null)) {
                                            response.sendRedirect("shop/checkout.jsp");
                                        }
                                    } catch (Exception e) {
                                        if (user.getType() == 1 | user.getType() == 2) {
                                            response.sendRedirect("dashboard/dashboard.jsp");
                                        } else {
                                            response.sendRedirect("index.jsp");
                                        }
                                    }
                                }

                            } else {
                                request.getSession().setAttribute("loginPasswordErrorMsg", "The email and password you entered don't match.");
                                response.sendRedirect("auth/login.jsp");

                            }
                        } else {
                            request.getSession().setAttribute("loginBlockErrorMsg", "You've been blocked from this website.");
                            response.sendRedirect("auth/login.jsp");
                        }

                    } else {
                        request.getSession().setAttribute("loginEmailErrorMsg", "We don't recognize that email address.");
                        response.sendRedirect("auth/login.jsp");
                    }

                } else {
                    request.getSession().setAttribute("loginErrorMsg", "Text fields cannot be empty.");
                    response.sendRedirect("auth/login.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
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
