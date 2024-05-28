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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Chamal
 */
public class UpdatePasswordServlet extends HttpServlet {

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

            String email = request.getSession().getAttribute("email").toString();
            Integer uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());
            String oldPassword = request.getParameter("oldpassword");
            String newPassword = request.getParameter("newpassword");
            String confirmPassword = request.getParameter("confirmpassword");

            /**
             * Check passwords fields are null and password matches
             */
            if (!(oldPassword.equals(null) | newPassword.equals(null) | confirmPassword.equals(null) | !(newPassword.equals(confirmPassword)))) {

                /**
                 * Encrypting the old password
                 */
                String generatedPassword1 = null;
                try {

                    MessageDigest md = MessageDigest.getInstance("MD5");
                    md.update(oldPassword.getBytes());
                    byte[] bytes = md.digest();
                    StringBuilder sb = new StringBuilder();

                    for (int i = 0; i < bytes.length; i++) {
                        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                    }

                    generatedPassword1 = sb.toString();

                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }

                String enctyptedOldPassword = generatedPassword1;

                /**
                 * Encrypting the new password
                 */
                String generatedPassword2 = null;
                try {

                    MessageDigest md = MessageDigest.getInstance("MD5");
                    md.update(newPassword.getBytes());
                    byte[] bytes = md.digest();
                    StringBuilder sb = new StringBuilder();

                    for (int i = 0; i < bytes.length; i++) {
                        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                    }

                    generatedPassword2 = sb.toString();

                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }

                String enctyptedNewPassword = generatedPassword2;
                

                /**
                 * Validating the old password
                 */
                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria criteria = hiberSession.createCriteria(Pojos.Users.class);
                criteria.add(Restrictions.and(Restrictions.eq("id", uid), Restrictions.eq("email", email), Restrictions.eq("password", enctyptedOldPassword), Restrictions.eq("status", 1)));

                if (criteria.uniqueResult() != null) {

                    Pojos.Users user = (Pojos.Users) criteria.uniqueResult();

                    //Updating the password
                    user.setPassword(enctyptedNewPassword);
                    user.setUpdatedAt(new Date());

                    hiberSession.update(user);
                    hiberSession.beginTransaction().commit();
                    
                    Classes.sendUpdatePasswordEmail.sendEmail(email, request.getSession().getAttribute("firstname").toString(), request.getSession().getAttribute("lastname").toString());

                    response.sendRedirect("account/profile.jsp");

                } else {
                    out.write("The old password you entered is not match, try again");
                    //Send the error message saying old password isnt't same or something went wrong
                }

            }else{
                out.write("Fields cannot be empty");
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
