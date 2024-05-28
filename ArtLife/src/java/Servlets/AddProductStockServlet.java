/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Servlets;

import Connection.NewHibernateUtil;
import Pojos.Stock;
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
 * @author chamal
 */
public class AddProductStockServlet extends HttpServlet {

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
            
            Integer pid = Integer.parseInt(request.getParameter("productId").toString());
            Integer pQty = Integer.parseInt(request.getParameter("productqty").toString());
            String supplier = request.getParameter("supplier");
            String desc = request.getParameter("stockdesc");
            
            if (pQty != null || pQty >= 0) {

                //Creating hibernate session
                Session hiberSession = NewHibernateUtil.getSessionFactory().openSession();
                
                Criteria criteriaCheckProduct = hiberSession.createCriteria(Pojos.Products.class);
                criteriaCheckProduct.add(Restrictions.eq("id", pid));

                //Check the product is existing
                if (criteriaCheckProduct.uniqueResult() != null) {

                    //JSON Part for meta
                    JSONObject metaJObj = new JSONObject();
                    metaJObj.put("description", desc);

                    //Insert into stocks table
                    Pojos.Stock stock = new Stock();
                    stock.setProducts((Pojos.Products) hiberSession.get(Pojos.Products.class, pid));
                    stock.setQuantity(pQty);
                    stock.setSupplier(supplier);
                    stock.setMeta(metaJObj.toString());
                    stock.setCuid(Integer.parseInt(request.getSession().getAttribute("uid").toString()));
                    stock.setCreatedAt(new Date());
                    
                    hiberSession.save(stock);
                    hiberSession.beginTransaction().commit();

                    //Update products table
                    Pojos.Products product = (Pojos.Products) criteriaCheckProduct.uniqueResult();
                    product.setQty(product.getQty() + pQty);
                    
                    hiberSession.update(product);
                    hiberSession.beginTransaction().commit();
                    
                    response.sendRedirect("stocks/stocks.jsp");
                    
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
