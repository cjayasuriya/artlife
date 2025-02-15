/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author chamal
 */
public class ForgotPasswordVerifyCodeServlet extends HttpServlet {

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

            String verificationCode = request.getParameter("verifivationCode");
            String email = request.getSession().getAttribute("fpEmail").toString();

            request.getSession().setAttribute("fpErrorMsg", null);

            Session hibSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

            Criteria userCriteria = hibSession.createCriteria(Pojos.Users.class);
            userCriteria.add(Restrictions.eq("email", email));
            Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();

            try {
                JSONParser jSONParser = new JSONParser();
                Object ojb = jSONParser.parse(user.getMeta());
                JSONObject jObj = (JSONObject) ojb;
                
                String veriCode = (String)jObj.get("fpGeneratedText").toString();

                if (veriCode.equals(verificationCode)) {
                    
                    request.getSession().setAttribute("fpChangePassword", "Active");
                    request.getSession().setAttribute("fpActiveToTypeRandomText", "Inactive");

                    response.sendRedirect("auth/reset.jsp");
                } else {
                    request.getSession().setAttribute("fpErrorMsg", "Verification code you've entered is wrong");
                    response.sendRedirect("auth/reset.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
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
