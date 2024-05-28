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
public class userStatusChangeServlet extends HttpServlet {

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

            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

            try {
                if (!request.getParameter("deactiveBtn").equals(null) & request.getParameter("deactiveBtn").equals("Deactive")) {

                    Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
                    userCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("userId").toString())));

                    if (userCriteria.uniqueResult() != null) {
                        
                        Pojos.Users userUpdate = (Pojos.Users) userCriteria.uniqueResult();

                        userUpdate.setStatus(0);
                        userUpdate.setUpdatedAt(new Date());

                        hiberSession.update(userUpdate);
                        hiberSession.beginTransaction().commit();

                        response.sendRedirect("users/users.jsp");
                    }

                }

            } catch (Exception e) {

                Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
                userCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("userId").toString())));

                if (userCriteria.uniqueResult() != null) {
                    Pojos.Users userUpdate = (Pojos.Users) userCriteria.uniqueResult();

                    userUpdate.setStatus(1);
                    userUpdate.setUpdatedAt(new Date());

                    hiberSession.update(userUpdate);
                    hiberSession.beginTransaction().commit();

                    response.sendRedirect("users/users.jsp");

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
