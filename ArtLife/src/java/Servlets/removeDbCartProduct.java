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

/**
 *
 * @author chamaljayasuriya
 */
public class removeDbCartProduct extends HttpServlet {

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
            out.println("<!DOCTYPE html>");

            if (request.getSession().getAttribute("uid") != null) {
                out.write(request.getParameter("productId"));

                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                Criteria myBaCriteria = hiberSession.createCriteria(Pojos.ShopBag.class);
                myBaCriteria.add(Restrictions.and(
                        Restrictions.eq("id", Integer.parseInt(request.getParameter("bagId"))),
                        Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, Integer.parseInt(request.getSession().getAttribute("uid").toString()))),
                        Restrictions.eq("products", (Pojos.Products) hiberSession.get(Pojos.Products.class, Integer.parseInt(request.getParameter("productId"))))));

                if (myBaCriteria.uniqueResult() != null) {
                    
                    Pojos.ShopBag bag = (Pojos.ShopBag) myBaCriteria.uniqueResult();
                    bag.setStatus(0);
                    
                    hiberSession.update(bag);
                    hiberSession.beginTransaction().commit();
                    response.sendRedirect("shop/bag.jsp");
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
