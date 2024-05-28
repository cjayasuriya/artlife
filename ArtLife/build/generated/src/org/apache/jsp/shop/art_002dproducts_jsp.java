package org.apache.jsp.shop;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.json.simple.parser.JSONParser;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;

public final class art_002dproducts_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("\n");
      out.write("        <link href=\"../bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\" type=\"text/css\"/>\n");
      out.write("        <script src=\"../bootstrap/js/bootstrap.min.js\" type=\"text/javascript\"></script>\n");
      out.write("        <script src=\"../JS/jquery.min.js\" type=\"text/javascript\"></script>\n");
      out.write("        <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js\"></script>\n");
      out.write("\n");
      out.write("        <style>\n");
      out.write("            .box{\n");
      out.write("                padding: 2px;\n");
      out.write("                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.1), 0 6px 20px 0 rgba(0, 0, 0, 0.1);\n");
      out.write("                height: 500px;\n");
      out.write("            } \n");
      out.write("            hr{\n");
      out.write("                color: #ac7339;\n");
      out.write("                background-color: #ac7339;\n");
      out.write("                height: 1px;\n");
      out.write("\n");
      out.write("            }\n");
      out.write("            .myImg{\n");
      out.write("                box-shadow: 0 1px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.1);\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("\n");
      out.write("            var xmlhttp;\n");
      out.write("            function createXHTTP() {\n");
      out.write("                if (window.XMLHttpRequest) {\n");
      out.write("                    xmlhttp = new XMLHttpRequest()\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function search() {\n");
      out.write("\n");
      out.write("                var name = document.getElementById(\"productname\").value;\n");
      out.write("                var cat = document.getElementById(\"categoryid\");\n");
      out.write("                var category = cat[cat.selectedIndex].value;\n");
      out.write("\n");
      out.write("                var url = \"../SearchProductServlet?productname=\" + name + \"&category=\" + category + \"\";\n");
      out.write("\n");
      out.write("                if (document.getElementById(\"cbname\").checked) {\n");
      out.write("                    url += \"&cbname=on\";\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                if (document.getElementById(\"cbcategory\").checked) {\n");
      out.write("                    url += \"&cbcategory=on\";\n");
      out.write("                }\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                createXHTTP();\n");
      out.write("\n");
      out.write("                xmlhttp.onreadystatechange = function() {\n");
      out.write("\n");
      out.write("                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {\n");
      out.write("                        document.getElementById(\"products\").innerHTML = xmlhttp.responseText;\n");
      out.write("                    }\n");
      out.write("\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                xmlhttp.open(\"GET\", url, true);\n");
      out.write("                xmlhttp.send();\n");
      out.write("\n");
      out.write("            }\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <title>Art products - Art Life</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../navbarinside.jsp", out, false);
      out.write("\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-12\">\n");
      out.write("                    <div class=\"col-md-12\">\n");
      out.write("                        <h2>Products</h2> \n");
      out.write("                    </div> \n");
      out.write("                </div>\n");
      out.write("            </div> \n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <!--TO PUT PRODUCT CATEGORIES-->\n");
      out.write("            <div class=\"col-md-12\">\n");
      out.write("                <div class=\"col-md-3\">\n");
      out.write("                    Categories\n");
      out.write("\n");
      out.write("                    ");

                        Session hSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria categotyCriteria = hSession.createCriteria(Pojos.Categories.class);
                        categotyCriteria.add(Restrictions.eq("parentid", 0));

                        List<Pojos.Categories> categoriesList = categotyCriteria.list();
                        for (Pojos.Categories categories : categoriesList) {
                    
      out.write("\n");
      out.write("                    <ul>\n");
      out.write("                        <li>");
      out.print(categories.getName());
      out.write("</li>\n");
      out.write("                    </ul>\n");
      out.write("                    ");

                        }

                    
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"col-md-9\">\n");
      out.write("                    <!--TO PUT PRODUCT CATEGORIES-->\n");
      out.write("\n");
      out.write("                    <div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">\n");
      out.write("                        <!-- Indicators -->\n");
      out.write("                        <ol class=\"carousel-indicators\">\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"1\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"2\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"3\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"4\"></li>\n");
      out.write("                            <li data-target=\"#myCarousel\" data-slide-to=\"5\"></li>\n");
      out.write("                        </ol>\n");
      out.write("\n");
      out.write("                        <!-- Wrapper for slides -->\n");
      out.write("                        <div class=\"carousel-inner\">\n");
      out.write("                            <div class=\"item active\">\n");
      out.write("                                <img src=\"../IMAGES/carousel-main1.png\" alt=\"Los Angeles\" style=\"width:100%; height: 50%;\">\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                            <div class=\"item\">\n");
      out.write("                                <img src=\"../IMAGES/carousel-main.png\" alt=\"Chicago\" style=\"width:100%; height: 50%;\">\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                            <div class=\"item\">\n");
      out.write("                                <img src=\"../IMAGES/carousel-main2.png\" alt=\"New york\" style=\"width:100%; height: 50%;\">\n");
      out.write("                            </div>\n");
      out.write("                            ");
                        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                for (Pojos.Products product : Classes.helpers.getLatestProducts(3)) {
                                    JSONParser jSONParser = new JSONParser();
                                    Object productObject = jSONParser.parse(product.getMeta());
                                    JSONObject metaObj = (JSONObject)productObject;
                            
      out.write("\n");
      out.write("                            <div class=\"item\">\n");
      out.write("                                <img src=\"../IMAGES/productImages/");
      out.print(metaObj.get("imgP"));
      out.write("\" alt=\"New york\" style=\"width:100%; height: 50%;\">\n");
      out.write("                                <div class=\"carousel-caption\">\n");
      out.write("                                    <h3>\n");
      out.write("                                        <a href=\"art-product.jsp?pid=");
      out.print(product.getId());
      out.write("&pname=");
      out.print(product.getName());
      out.write("\">\n");
      out.write("                                        ");
      out.print(product.getName());
      out.write(" | LKR ");
      out.print(product.getSellingPrice());
      out.write("\n");
      out.write("                                        </a>\n");
      out.write("                                    </h3>\n");
      out.write("                                    <p>");
      out.print(product.getCategories().getName());
      out.write("</p>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                            ");

                                }
                            
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                        \n");
      out.write("                        <!-- Left and right controls -->\n");
      out.write("                        <a class=\"left carousel-control\" href=\"#myCarousel\" data-slide=\"prev\">\n");
      out.write("                            <span class=\"glyphicon glyphicon-chevron-left\"></span>\n");
      out.write("                            <span class=\"sr-only\">Previous</span>\n");
      out.write("                        </a>\n");
      out.write("                        <a class=\"right carousel-control\" href=\"#myCarousel\" data-slide=\"next\">\n");
      out.write("                            <span class=\"glyphicon glyphicon-chevron-right\"></span>\n");
      out.write("                            <span class=\"sr-only\">Next</span>\n");
      out.write("                        </a>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-md-12 container-fluid\"><br/></div>\n");
      out.write("                    <div class=\"col-md-12 container-fluid\"><hr/></div>\n");
      out.write("                    <div class=\"col-md-12 container-fluid\"><br/></div>\n");
      out.write("\n");
      out.write("                    <!--TO PUT PRODUCT CARDS-->\n");
      out.write("\n");
      out.write("                    <div class=\"col-md-12\">\n");
      out.write("                        <div class=\"col-md-12\">\n");
      out.write("                            <div class=\"col-md-5\">\n");
      out.write("                                Search by name :\n");
      out.write("                                <input type=\"checkbox\" id=\"cbname\" name=\"cbname\"/>\n");
      out.write("                                <input type=\"text\" class=\"form-control\" id=\"productname\" name=\"productname\" placeholder=\"Product name\"/>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-4\">\n");
      out.write("                                Search by category :\n");
      out.write("                                <input type=\"checkbox\" id=\"cbcategory\" name=\"cbcategory\"/>\n");
      out.write("                                <select id=\"categoryid\" class=\"form-control\" name=\"category\"/>\n");
      out.write("                                ");
                                    for (Pojos.Categories category : Classes.helpers.getAllCategories()) {
                                
      out.write("\n");
      out.write("                                <option value=\"");
      out.print(category.getId());
      out.write('"');
      out.write('>');
      out.print(category.getName());
      out.write("</option>\n");
      out.write("                                ");

                                    }
                                
      out.write("\n");
      out.write("\n");
      out.write("                                </select>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"col-md-3\">\n");
      out.write("                                <br>\n");
      out.write("                                <!--                                    <input type=\"submit\"class=\"form-control btn btn-block btn-primary\" value=\"Search\"/>-->\n");
      out.write("                                <button onclick=\"search()\" class=\"form-control btn btn-block btn-primary\">Search</button>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"col-md-12\"><br></div>\n");
      out.write("                        <div class=\"col-md-12\">\n");
      out.write("\n");
      out.write("                            <div id=\"products\">\n");
      out.write("\n");
      out.write("                                <div class=\"row list-group\">\n");
      out.write("                                    ");
                                    for (Pojos.Products product : Classes.helpers.getAllActiveProducts()) {
                                            JSONParser jSONParser = new JSONParser();
                                            Object meta = jSONParser.parse(product.getMeta());
                                            JSONObject jObj = (JSONObject) meta;
                                    
      out.write("\n");
      out.write("                                    <div class=\"item  col-xs-4 col-lg-4\">\n");
      out.write("                                        <div class=\"thumbnail\">\n");
      out.write("                                            <img class=\"group list-group-image img-responsive\" src=\"../IMAGES/productImages/");
      out.print(jObj.get("imgP"));
      out.write("\" alt=\"\" />\n");
      out.write("                                            <div class=\"caption\">\n");
      out.write("                                                <h3 class=\"group inner list-group-item-heading text-center\"><a href=\"art-product.jsp?pid=");
      out.print(product.getId());
      out.write("&pname=");
      out.print(product.getName());
      out.write('"');
      out.write('>');
      out.print(product.getName());
      out.write("</a></h3>\n");
      out.write("                                                <h5 class=\"group inner list-group-item-heading text-center\">");
      out.print(product.getCategories().getName());
      out.write("</h5>\n");
      out.write("                                                <p class=\"group inner list-group-item-text small text-justify\">\n");
      out.write("                                                    ");

                                                        org.json.simple.parser.JSONParser jParserMeta = new org.json.simple.parser.JSONParser();
                                                        org.json.simple.parser.JSONParser jParserDesc = new org.json.simple.parser.JSONParser();

                                                        try {
                                                            Object metaObj = jParserMeta.parse(product.getMeta());
                                                            JSONObject metaJObj = (JSONObject) metaObj;
                                                            Object descObject = jParserDesc.parse(metaJObj.get("description").toString());
                                                            JSONObject desJObj = (JSONObject) descObject;
                                                            out.write((String) desJObj.get("short"));
                                                        } catch (Exception e) {
                                                        }

                                                    
      out.write("\n");
      out.write("                                                </p>\n");
      out.write("                                                <p class=\"text-muted text-center\" style=\"margin-top: 10px;font-size: 14px;\">\n");
      out.write("                                                    <strong>LKR ");
      out.print(product.getSellingPrice());
      out.write("</strong>\n");
      out.write("                                                </p>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    ");

                                        }
                                    
      out.write("\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-md-12 container-fluid\"><br/></div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-md-12\"><br></div>\n");
      out.write("\n");
      out.write("                    <div class=\"col-md-12\"><br></div>\n");
      out.write("\n");
      out.write("                </div> \n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
