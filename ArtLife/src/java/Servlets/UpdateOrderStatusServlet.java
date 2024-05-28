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
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author chamal
 */
public class UpdateOrderStatusServlet extends HttpServlet {

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

            if (request.getParameter("edit-order_status-btn").equals("Update order status")) {

                int osid = Integer.parseInt(request.getParameter("orderStatus").toString());

                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria orderCriteria = hiberSession.createCriteria(Pojos.Orders.class);
                orderCriteria.add(Restrictions.eq("id", Integer.parseInt(request.getParameter("oid").toString())));

                if (orderCriteria.uniqueResult() != null) {
                    Pojos.Orders order = (Pojos.Orders) orderCriteria.uniqueResult();

                    try {
                        JSONParser jSONParser = new JSONParser();
                        Object obj = jSONParser.parse(order.getMeta());

                        JSONObject metaObj = (JSONObject) obj;
                        metaObj.put("orderStatusMsg", request.getParameter("orderstatusmsg").toString());
                        order.setMeta(metaObj.toString());

                    } catch (Exception e) {
                    }

                    order.setOrderStatus((Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, osid));
                    order.setUpdatedAt(new Date());
                    order.setUuid(Integer.parseInt(request.getSession().getAttribute("uid").toString()));

                    hiberSession.update(order);
                    hiberSession.beginTransaction().commit();

                    try {
                        Classes.sendOrderUpdateEmail.sendEmail(order.getUsers().getEmail(), order.getUsers().getFirstname(),
                                order.getUsers().getLastname(), order.getOrderStatus().getName());
                    } catch (Exception e) {
                    }

                    response.sendRedirect("orders/orders.jsp");

                } else {
                    response.sendError(403);
                }

            } else {
                response.sendError(403);
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
