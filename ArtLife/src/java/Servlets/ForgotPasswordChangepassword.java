/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author chamal
 */
public class ForgotPasswordChangepassword extends HttpServlet {

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

            String password = request.getParameter("newPassword").toString();
            String confirmPassword = request.getParameter("confirmPassword").toString();

            //Check wheather the passwords are empty
            if (password != null | confirmPassword != null) {

                //Check the passwords are same
                if (password.equals(confirmPassword)) {

                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);

                    userCriteria.add(Restrictions.and(Restrictions.eq("email", request.getSession().getAttribute("fpEmail")), Restrictions.eq("status", 1)));

                    if (userCriteria.uniqueResult() != null) {
                        Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();

                        //Encrypt password
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

                        //Updating the password
                        user.setPassword(enctyptedPassword);
                        user.setMeta("");
                        user.setUpdatedAt(new Date());

                        hiberSession.update(user);
                        hiberSession.beginTransaction().commit();

                        //Setting attributes to the session
                        HttpSession session = request.getSession();
                        session.setAttribute("uid", user.getId().toString());
                        session.setAttribute("firstname", user.getFirstname().toString());
                        session.setAttribute("lastname", user.getLastname().toString());
                        session.setAttribute("email", user.getEmail().toString());
                        session.setAttribute("mobile", user.getMobile().toString());
                        session.setAttribute("type", user.getType().toString());

                        request.getSession().setAttribute("fpEmail", null);
                        request.getSession().setAttribute("fpChangePassword", null);
                        request.getSession().setAttribute("fpPasswordErrorMsg", null);
                        request.getSession().setAttribute("fpErrorMsg", null);

                        /**
                         * Updating the login time
                         */
                        Pojos.Users users = (Pojos.Users) hiberSession.get(Pojos.Users.class, user.getId());
                        Session hiberSforLoginTime = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria cForLoginTime = hiberSforLoginTime.createCriteria(Pojos.LoginDetails.class).add(Restrictions.eq("users", users));

                        if (cForLoginTime.uniqueResult() != null) {
                            Pojos.LoginDetails loginDetails = (Pojos.LoginDetails) cForLoginTime.uniqueResult();

                            loginDetails.setLoginAt(new Date());
                            hiberSforLoginTime.update(loginDetails);
                        }

                        hiberSforLoginTime.beginTransaction().commit();

                        if (user.getType() == 1 | user.getType() == 2) {
                            response.sendRedirect("dashboard/dashboard.jsp");
                        } else {
                            response.sendRedirect("index.jsp");
                        }

                    }

                } else {
                    request.getSession().setAttribute("fpPasswordErrorMsg", "The password you entered don't match.");
                    response.sendRedirect("auth/reset.jsp");
                }

            } else {
                request.getSession().setAttribute("fpErrorMsg", "Text fields cannot be empty.");
                response.sendRedirect("auth/reset.jsp");
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
