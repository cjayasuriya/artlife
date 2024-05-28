/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
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
 * @author chamal
 */
public class ForgotPasswordEmailVerifyServlet extends HttpServlet {

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

            String email = request.getParameter("useremail");

            request.getSession().setAttribute("fpErrorMsg", null);
            request.getSession().setAttribute("fpEmailErrorMsg", null);
            request.getSession().setAttribute("fpPasswordErrorMsg", null);
            request.getSession().setAttribute("fpBlockErrorMsg", null);
            request.getSession().setAttribute("fpActiveToTypeRandomText", null);

            Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria criteria = hiberSession.createCriteria(Pojos.Users.class);

            /**
             * Email validation
             */
            if (!email.equals(null)) {

                //Checking the wheather the email is there
                Criteria criteriaEmailCheck = hiberSession.createCriteria(Pojos.Users.class);
                criteriaEmailCheck.add(Restrictions.eq("email", email));

                if (criteriaEmailCheck.uniqueResult() != null) {

                    //Checking the user is active or inacive
                    Pojos.Users userTypeCheck = (Pojos.Users) criteriaEmailCheck.uniqueResult();
                    if (userTypeCheck.getStatus() == 1) {

                        //Generate random text
                        char[] chars = "abcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
                        StringBuilder sb = new StringBuilder();
                        Random random = new Random();

                        for (int i = 0; i < 100; i++) {
                            char c = chars[random.nextInt(chars.length)];
                            sb.append(c);
                        }

                        String randomText = sb.toString();

                        JSONObject metaJSONObject = new JSONObject();
                        metaJSONObject.put("fpGeneratedText", randomText+"");

                        userTypeCheck.setMeta(metaJSONObject.toString());

                        hiberSession.update(userTypeCheck);
                        hiberSession.beginTransaction().commit();
                        
                        request.getSession().setAttribute("fpActiveToTypeRandomText", "Active");
                        request.getSession().setAttribute("fpEmail", email);

                        //To email the verifycation code
                        try {
                            Classes.sendVerifycationCodeEmail.sendEmail(email, randomText);
                        } catch (Exception e) {
                        }
                        
                        response.sendRedirect("auth/reset.jsp");

                    } else {
                        request.getSession().setAttribute("fpBlockErrorMsg", "You've been blocked from this website.");
                        response.sendRedirect("auth/reset.jsp");
                    }

                } else {
                    request.getSession().setAttribute("fpEmailErrorMsg", "We don't recognize that email address.");
                    response.sendRedirect("auth/reset.jsp");
                }

            } else {
                request.getSession().setAttribute("fpErrorMsg", "Text field cannot be empty.");
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
