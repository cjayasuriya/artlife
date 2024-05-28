/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author chamalv
 */
public class addProductImageServlet extends HttpServlet {

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
             * Image uploading
             */
            try {

                if (ServletFileUpload.isMultipartContent(request)) {
                    FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);

                    List<FileItem> fileItemsList = upload.parseRequest(request);

                    String txt = "";
                    String thumb = "";
                    String fileP = "";

                    for (FileItem fileItem : fileItemsList) {
                        if (!fileItem.isFormField()) {
                            thumb = Math.random() + fileItem.getName();
                            File resourcePath = new File(getServletContext().getRealPath("/") + "/IMAGES/productImages/" + thumb);
                            fileItem.write(resourcePath);

                        } else {
                            if (fileItem.getFieldName().equals("proId")) {
                                txt = fileItem.getString();
                            }
                        }
                    }
                    
                    fileP=thumb;
                    Integer proId = Integer.parseInt(txt);
                    System.out.println("id---"+proId);
                    
                    
                    /**
                     * Adding image to the product table
                     */
                    Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                    productCriteria.add(Restrictions.eq("id", proId));
                    
                    
                    Pojos.Products product = (Pojos.Products)productCriteria.uniqueResult();
                    
                    JSONParser jSONParser = new JSONParser();
                    Object productObj = jSONParser.parse(product.getMeta());
                    JSONObject productJobj = (JSONObject)productObj;
                    
                    JSONObject productMetaJSONObject = new JSONObject();
                    
                    productMetaJSONObject.put("supplier", productJobj.get("supplier"));
                    productMetaJSONObject.put("description", productJobj.get("description"));
                    productMetaJSONObject.put("manufacturer", productJobj.get("manufacturer"));
                    
                    productMetaJSONObject.put("depth", productJobj.get("depth"));
                    productMetaJSONObject.put("weight_unit", productJobj.get("weight_unit"));
                    productMetaJSONObject.put("width", productJobj.get("width"));
                    productMetaJSONObject.put("brandname", productJobj.get("brandname"));
                    productMetaJSONObject.put("length_unit", productJobj.get("length_unit"));
                    productMetaJSONObject.put("height", productJobj.get("height"));
                    productMetaJSONObject.put("imgP", fileP);
                    
                    product.setMeta(productMetaJSONObject.toString());
                    hiberSession.update(product);
                    hiberSession.beginTransaction().commit();
                    
                    response.sendRedirect("products/product.jsp?pid="+proId+"&pname="+product.getName());

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
