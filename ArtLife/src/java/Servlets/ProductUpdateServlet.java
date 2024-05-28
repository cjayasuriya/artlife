/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Pojos.Products;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
 * @author chamaljayasuriya
 */
public class ProductUpdateServlet extends HttpServlet {

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
             * Edit product
             */

            if (request.getParameter("edit-product-btn").equals("Edit product")) {

                //Validation part
                if (!(request.getParameter("skucode").equals(null) | request.getParameter("productname").equals(null)
                        | request.getParameter("productprice").equals(null) | request.getParameter("sellingprice").equals(null)
                        | request.getParameter("qty").equals(null) | request.getParameter("shippingprice").equals(null))) {

                    Integer catgory, qty, uid, pid;
                    Double productPrice, sellingPrice, shippingPrice, weight, height, width, depth;

                    try {

                        uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());
                        pid = Integer.parseInt(request.getParameter("productId").toString());
                        productPrice = Double.parseDouble(request.getParameter("productprice"));
                        sellingPrice = Double.parseDouble(request.getParameter("sellingprice"));
                        catgory = Integer.parseInt(request.getParameter("productcategory"));
                        qty = Integer.parseInt(request.getParameter("qty"));

                        try {
                            shippingPrice = Double.parseDouble(request.getParameter("shippingprice"));
                            weight = Double.parseDouble(request.getParameter("weight"));
                            height = Double.parseDouble(request.getParameter("height"));
                            width = Double.parseDouble(request.getParameter("width"));
                            depth = Double.parseDouble(request.getParameter("depth"));

                        } catch (NumberFormatException e) {
                            shippingPrice = 00.00;
                            weight = 00.00;
                            height = 00.00;
                            width = 00.00;
                            depth = 00.00;
                        }

                        //Settingup meta
                        JSONObject metaProduct = new JSONObject();
                        metaProduct.put("brandname", request.getParameter("brandname"));

                        JSONObject metaDescription = new JSONObject();
                        metaDescription.put("short", request.getParameter("productshortdesc"));
                        metaDescription.put("long", request.getParameter("productlongdesc"));

                        metaProduct.put("description", metaDescription);

                        JSONObject metaManufacturer = new JSONObject();
                        metaManufacturer.put("manufacturer", request.getParameter("manufacturer"));
                        metaManufacturer.put("manufacturer_country", Integer.parseInt(request.getParameter("manucountry")));
                        metaManufacturer.put("manufacturer_email", request.getParameter("manuemail"));
                        metaManufacturer.put("manufacturer_web", request.getParameter("manuurl"));

                        metaProduct.put("manufacturer", metaManufacturer);

                        JSONObject metaSupplier = new JSONObject();
                        metaSupplier.put("supplier", request.getParameter("supplier"));
                        metaSupplier.put("supplier_country", Integer.parseInt(request.getParameter("supcountry")));
                        metaSupplier.put("supplier_email", request.getParameter("supemail"));
                        metaSupplier.put("supplier_web", request.getParameter("supurl"));

                        metaProduct.put("supplier", metaSupplier);

                        metaProduct.put("weight_unit", 1);
                        metaProduct.put("length_unit", 1);
                        metaProduct.put("height", height);
                        metaProduct.put("width", width);
                        metaProduct.put("depth", depth);

                        //Hibernate session part
                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

                        Pojos.Categories getCategoryId = (Pojos.Categories) hiberSession.get(Pojos.Categories.class, catgory);

                        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                        productCriteria.add(Restrictions.eq("id", pid));

                        if (productCriteria.uniqueResult() != null) {

                            //Update product table
                            Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();

                            product.setCategories(getCategoryId);
                            product.setSku(request.getParameter("skucode"));
                            product.setBarcode(request.getParameter("barcode"));
                            product.setName(request.getParameter("productname"));
                            product.setWeight(BigDecimal.valueOf(weight));
                            product.setQty(qty);
                            product.setProductPrice(BigDecimal.valueOf(productPrice));
                            product.setSellingPrice(BigDecimal.valueOf(sellingPrice));
                            product.setShippingPrice(BigDecimal.valueOf(shippingPrice));
                            product.setMeta(metaProduct.toJSONString());
                            product.setStatus(1);
                            product.setCuid(uid);
                            product.setUuid(uid);
                            product.setCreatedAt(new Date());
                            product.setUpdatedAt(new Date());

                            hiberSession.update(product);
                            hiberSession.beginTransaction().commit();

                            response.sendRedirect("products/products.jsp");

                        } else {
                            //Send to error page
                        }

                    } catch (Exception e) {
                        //Send to error page
                    }

                } else {
                    //Send to error page
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
