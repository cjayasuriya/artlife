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

/**
 *
 * @author Chamal
 */
public class CategoryUpdateServlet extends HttpServlet {

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

            /**
             * UPdate a category
             */
            if (request.getParameter("edit-category-btn").equals("Edit category")) {

                //Validation of category name
                if (!(request.getParameter("categoryname").equals(null) | request.getParameter("categoryname").equals(" "))) {

                    String categoryName = request.getParameter("categoryname");
                    Integer parentId = Integer.parseInt(request.getParameter("parentcategory"));
                    Integer cid = Integer.parseInt(request.getParameter("cid"));
                    Integer uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());
                    String categoryDesc = request.getParameter("categorydesc");

                    if (categoryDesc.equals(null)) {
                        categoryDesc = "";
                    }

                    JSONObject metaJSONObject = new JSONObject();
                    metaJSONObject.put("description", categoryDesc);
                    metaJSONObject.put("status", 1);

                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria categoryCriteria = hiberSession.createCriteria(Pojos.Categories.class);
                    categoryCriteria.add(Restrictions.eq("id", cid));
                    if (categoryCriteria.uniqueResult() != null) {

                        //Update category table
                        Pojos.Categories categoryUpdate = (Pojos.Categories) categoryCriteria.uniqueResult();
                        categoryUpdate.setName(categoryName);
                        categoryUpdate.setCategoryKey(categoryName.toLowerCase());
                        categoryUpdate.setParentid(parentId);
                        categoryUpdate.setMeta(metaJSONObject.toString());
                        categoryUpdate.setUuid(uid);
                        categoryUpdate.setUpdatedAt(new Date());

                        hiberSession.update(categoryUpdate);
                        hiberSession.beginTransaction().commit();

                        response.sendRedirect("products/categories.jsp");
                    }

                } else {
                    //Pass the error that category name cannot be empty
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
