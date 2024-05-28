/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class SearchProductServlet extends HttpServlet {

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

            try {
                String nameCBX = request.getParameter("cbname");
                String categoryCBX = request.getParameter("cbcategory");

                Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
                productCriteria.add(Restrictions.eq("status", 1));

                if (nameCBX != null) {
                    String name = request.getParameter("productname");
                    productCriteria.add(Restrictions.like("name", "%" + name + "%"));
                }

                if (categoryCBX != null) {
                    Integer categoryId = Integer.parseInt(request.getParameter("category"));
                    Criteria categoryCriteria = hiberSession.createCriteria(Pojos.Categories.class);
                    categoryCriteria.add(Restrictions.eq("id", categoryId));
                    Pojos.Categories category = (Pojos.Categories) categoryCriteria.uniqueResult();
                    productCriteria.add(Restrictions.eq("categories", category));
                }

                List<Pojos.Products> productsList = productCriteria.list();

                String htmlCardView = "<div class=row list-group>";

                for (Pojos.Products product : productsList) {

                    JSONParser jSONParser = new JSONParser();
                    Object meta = jSONParser.parse(product.getMeta());
                    JSONObject jObj = (JSONObject) meta;

                    JSONParser jParserDesc = new JSONParser();
                    Object descObject = jParserDesc.parse(jObj.get("description").toString());
                    JSONObject desJObj = (JSONObject) descObject;

                    htmlCardView += "<div class=item  col-xs-4 col-lg-4>";
                    htmlCardView += "<div class=thumbnail>";
                    htmlCardView += "<img class=group list-group-image img-responsive src=../IMAGES/productImages/" + jObj.get("imgP") + " />";
                    htmlCardView += "<div class=caption>";
                    htmlCardView += "<h3 class=group inner list-group-item-heading text-center>"
                            + "<a href=art-product.jsp?pid=" + product.getId() + "&pname=" + product.getName() + ">" + product.getName()
                            + "</a></h3>";
                    htmlCardView += "<h5 class=group inner list-group-item-heading text-center>" + product.getCategories().getName() + "</h5>";
                    htmlCardView += "<p class=group inner list-group-item-text small text-justify>";
                    htmlCardView += "" + desJObj.get("short").toString() + "</p>";
                    htmlCardView += "<p class=text-muted text-center style=margin-top:10px;font-size: 14px;>";
                    htmlCardView += " <strong>LKR " + product.getSellingPrice() + "</strong></p>";
                    htmlCardView += "</div></div></div>";

                }
                htmlCardView += "</div>";

                out.write(htmlCardView);

            } catch (Exception e) {
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
