/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Connection.NewHibernateUtil;
import Pojos.LoginDetails;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdk.nashorn.internal.parser.JSONParser;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author Chamal
 */
public class SignOutServlet extends HttpServlet {

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

            //Getting userr id
            Integer uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());

            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

            Pojos.Users users = (Pojos.Users) hiberSession.get(Pojos.Users.class, uid);


            /**
             * Updating the sign out time
             */
            Criteria criteria = hiberSession.createCriteria(Pojos.LoginDetails.class).add(Restrictions.eq("users", users));

            if (criteria.uniqueResult() != null) {

                Pojos.LoginDetails loginDetails = (Pojos.LoginDetails) criteria.uniqueResult();
                
                JSONObject metaObject = new JSONObject();
                metaObject.put("loginStaus", 0);

                //Signout time
                Date signOutTime = new Date();

                loginDetails.setLogedoutAt(signOutTime);
                loginDetails.setMeta(metaObject.toString());
                hiberSession.update(loginDetails);
            }

            hiberSession.beginTransaction().commit();

            //Invalidating the session
            request.getSession().invalidate();

            //Redirect to index.jsp
            response.sendRedirect("index.jsp");
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
