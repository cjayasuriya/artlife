/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Connection.NewHibernateUtil;
import Pojos.LoginDetails;
import Pojos.Users;
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
 * @author chamaljayasuriya
 */
public class CreateAdminAccountServlet extends HttpServlet {

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

            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String email = request.getParameter("email").toLowerCase();
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");
            String mob = request.getParameter("mobilenumber");
            String mobile = request.getParameter("phonefull");

            request.getSession().setAttribute("createAdminErrorMsgNull", null);
            request.getSession().setAttribute("createAdminErrorEmailCheckMsg", null);
            request.getSession().setAttribute("createAdminErrorMsg", null);

            /**
             * Backend validation
             */
            if (!(firstName.equals(null) | lastName.equals(null) | email.equals(null) | mob.equals(null) | password.equals(null) | confirmPassword.equals(null) | !(password.equals(confirmPassword)))) {

                /**
                 * Encrypting password
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
                Session hiberSession = NewHibernateUtil.getSessionFactory().openSession();

                Criteria criteriaCheckAccount = hiberSession.createCriteria(Pojos.Users.class);
                criteriaCheckAccount.add(Restrictions.eq("email", email));

                /**
                 * User account validation when creating new one
                 */
                if (criteriaCheckAccount.uniqueResult() == null) {

                    //Current time
                    Date timeNow = new Date();

                    //INSERT INTO users TABLE
                    Pojos.Users user = new Users();
                    user.setType(2); //1 --> SAdmin 2 --> Admin 3 --> User
                    user.setFirstname(firstName);
                    user.setLastname(lastName);
                    user.setMobile(mobile);
                    user.setEmail(email);
                    user.setPassword(enctyptedPassword);
                    user.setStatus(1); // 1 --> Avtive 0 --> Inactive
                    user.setRememberToken("");
                    user.setMeta("");
                    user.setCreatedAt(timeNow);
                    user.setUpdatedAt(timeNow);

                    //INSERT INTO login_details TABLE
                    Pojos.LoginDetails loginDetails = new LoginDetails();
                    loginDetails.setUsers(user);
                    loginDetails.setMeta("");
                    loginDetails.setLoginAt(timeNow);

                    hiberSession.save(user);
                    hiberSession.save(loginDetails);

                    hiberSession.beginTransaction().commit();

                    response.sendRedirect("users/users.jsp");

                } else {
                    response.sendRedirect("users/create-admin.jsp");
                    request.getSession().setAttribute("createAdminErrorEmailCheckMsg", "An account is excisting from this email, try with different one.");
                }

            } else {
                response.sendError(403);
                //response.sendRedirect("users/create-admin.jsp");
                //request.getSession().setAttribute("createAdminErrorMsgNull", "Whops something went wrong. Check your cardenelities again.");

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
