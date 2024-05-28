/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
 * @author chamal
 */
public class UpdateAccountServlet extends HttpServlet {

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
            String mob = request.getParameter("mobile");
            Integer uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());

            /**
             * Backend validation
             */
            if (!(firstName.equals(null) | lastName.equals(null) | email.equals(null) | mob.equals(null))) {

                /**
                 * Validating user
                 */
                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
                userCriteria.add(Restrictions.and(Restrictions.eq("id", uid), Restrictions.eq("status", 1)));

                if (userCriteria.uniqueResult() != null) {

                    Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();

                    user.setFirstname(firstName);
                    user.setLastname(lastName);
                    user.setEmail(email);
                    user.setMobile(mob);
                    user.setUpdatedAt(new Date());

                    hiberSession.save(user);
                    hiberSession.beginTransaction().commit();

                    request.getSession().setAttribute("uid", user.getId().toString());
                    request.getSession().setAttribute("firstname", user.getFirstname().toString());
                    request.getSession().setAttribute("lastname", user.getLastname().toString());
                    request.getSession().setAttribute("email", user.getEmail().toString());
                    request.getSession().setAttribute("mobile", user.getMobile().toString());
                    request.getSession().setAttribute("type", user.getType().toString());
                    
                    //Send update email
                    Classes.sendUpdateAccountEmail.sendEmail(email, request.getSession().getAttribute("firstname").toString(), request.getSession().getAttribute("lastname").toString());
                    
                    response.sendRedirect("account/profile.jsp");

                } else {
                    out.write("Undefined user");
                }

            } else {
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
