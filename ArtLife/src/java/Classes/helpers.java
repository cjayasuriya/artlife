/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author chamal
 */
public class helpers {

    static Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();

    /*  GET ALL COUNTRIES   */
    public static List<Pojos.Country> getAllCountries() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria countryCriteria = hiberSession.createCriteria(Pojos.Country.class);
        List<Pojos.Country> countriesList = countryCriteria.list();
        return countriesList;
    }

    /*  GET ALL CATEGORIES   */
    public static List<Pojos.Categories> getAllCategories() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria categoriesCriteria = hiberSession.createCriteria(Pojos.Categories.class);
        List<Pojos.Categories> categoriesList = categoriesCriteria.list();
        return categoriesList;
    }

    /*  GET ALL USERS   */
    public static List<Pojos.Users> getAllActiveUsers() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria customerCriteria = hiberSession.createCriteria(Pojos.Users.class);
        customerCriteria.add(Restrictions.and(Restrictions.eq("type", 3)));
        List<Pojos.Users> customersList = customerCriteria.list();
        return customersList;
    }

    /*  GET ALL ADMINS   */
    public static List<Pojos.Users> getAllActiveAdmins() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria adminCriteria = hiberSession.createCriteria(Pojos.Users.class);
        adminCriteria.add(Restrictions.and(Restrictions.eq("type", 2)));
        List<Pojos.Users> adminsList = adminCriteria.list();
        return adminsList;
    }

    /* GET ALL ORDERS */
    public static List<Pojos.Orders> getAllOrders() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /* GET ALL COMPLETED ORDERS */
    public static List<Pojos.Orders> getAllCompletedOrders() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        ordersCriteria.add(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 4)));
        ordersCriteria.addOrder(Order.desc("id"));
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /* GET ALL CANCELEED ORDERS */
    public static List<Pojos.Orders> getAllCancelledOrders() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        ordersCriteria.add(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 5)));
        ordersCriteria.addOrder(Order.desc("id"));
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /* GET ALL FILTERED ORDERS */
    public static List<Pojos.Orders> getAllFilteredOrders() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        ordersCriteria.add(Restrictions.or(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 1)),
                Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 2)),
                Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 3))));
        ordersCriteria.addOrder(Order.desc("id"));
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /* GET ALL ORDER STATUSES */
    public static List<Pojos.OrderStatus> getAllOrderStatuses() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersStatusesCriteria = hiberSession.createCriteria(Pojos.OrderStatus.class);
        List<Pojos.OrderStatus> orderStatusesList = ordersStatusesCriteria.list();
        return orderStatusesList;
    }

    /* GET ALL PRODUCTS */
    public static List<Pojos.Products> getAllProducts() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
        List<Pojos.Products> productsList = productCriteria.list();
        return productsList;
    }

    /* GET ALL ACTIVE PRODUCTS */
    public static List<Pojos.Products> getAllActiveProducts() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
        productCriteria.add(Restrictions.eq("status", 1));
        List<Pojos.Products> productsList = productCriteria.list();
        return productsList;
    }

    /* GET ALL INACTIVE PRODUCTS */
    public static List<Pojos.Products> getAllInactiveProducts() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
        productCriteria.add(Restrictions.eq("status", 0));
        List<Pojos.Products> productsList = productCriteria.list();
        return productsList;
    }

    /*  GET PRODUCT    */
    public static Pojos.Products getProduct(int pid) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productCriteria = hiberSession.createCriteria(Pojos.Products.class);
        productCriteria.add(Restrictions.eq("id", pid));
        Pojos.Products product = (Pojos.Products) productCriteria.uniqueResult();
        return product;
    }

    /*  GET ALL SUPPLIERS   */
    public static List<Pojos.Stock> getAllStocks() {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria stocksCriteria = hiberSession.createCriteria(Pojos.Stock.class);
        List<Pojos.Stock> stocksList = stocksCriteria.list();
        return stocksList;
    }

    /* GET USER */
    public static Pojos.Users getUser(int uid) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
        userCriteria.add(Restrictions.eq("id", uid));
        Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();
        return user;
    }

    /*  GET USER ORDERS   */
    public static List<Pojos.Orders> getUserOrders(int uid) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        ordersCriteria.add(Restrictions.or(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 1)),
                Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 2)),
                Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 3))));
        ordersCriteria.add(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, uid)));
        ordersCriteria.addOrder(Order.desc("id"));
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /*  GET USER COMPLETED ORDERS   */
    public static List<Pojos.Orders> getUserCompletedOrders(int uid) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria ordersCriteria = hiberSession.createCriteria(Pojos.Orders.class);
        ordersCriteria.add(Restrictions.eq("orderStatus", (Pojos.OrderStatus) hiberSession.get(Pojos.OrderStatus.class, 4)));
        ordersCriteria.add(Restrictions.eq("users", (Pojos.Users) hiberSession.get(Pojos.Users.class, uid)));
        ordersCriteria.addOrder(Order.desc("id"));
        List<Pojos.Orders> ordersList = ordersCriteria.list();
        return ordersList;
    }

    /*  GET ADDRESS */
    public static Pojos.Addresses getAddress(int aid) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria addressCriteria = hiberSession.createCriteria(Pojos.Addresses.class);
        addressCriteria.add(Restrictions.eq("id", aid));
        Pojos.Addresses address = (Pojos.Addresses) addressCriteria.uniqueResult();
        return address;
    }

    /* GET USER LAST ORDER  */
    public static Pojos.Orders getLastOrder(int uid) {
        try {
            hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
            SQLQuery getOrder = hiberSession.createSQLQuery("SELECT id FROM orders WHERE users_id='" + uid + "' ORDER BY id DESC LIMIT 1");
            List ordersList = getOrder.list();

            Criteria orderCriteria = hiberSession.createCriteria(Pojos.Orders.class);
            orderCriteria.add(Restrictions.eq("id", Integer.parseInt(ordersList.get(0).toString())));
            Pojos.Orders order = (Pojos.Orders) orderCriteria.uniqueResult();
            return order;
        } catch (Exception e) {
            return null;
        }
    }

    /* GET LAST 3 PRODUCTS */
    public static List<Pojos.Products> getLatestProducts(int count) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productsCriteria = hiberSession.createCriteria(Pojos.Products.class);
        productsCriteria.add(Restrictions.eq("status", 1));
        productsCriteria.addOrder(Order.desc("id"));
        productsCriteria.setMaxResults(count);
        List<Pojos.Products> productsList = productsCriteria.list();
        return productsList;

    }
    
    /* GET LESS PRODUCTS */
    public static List<Pojos.Products> getLessProducts(int count) {
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria productsCriteria = hiberSession.createCriteria(Pojos.Products.class);
        productsCriteria.add(Restrictions.lt("qty", count));
        List<Pojos.Products> productsList = productsCriteria.list();
        return productsList;

    }
    
    /*  GET USER*/
    
    public static Pojos.Users getActiveUer(int status, String id){
        hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria userCriteria = hiberSession.createCriteria(Pojos.Users.class);
        userCriteria.add(Restrictions.eq("id", Integer.parseInt(id)));
        Pojos.Users user = (Pojos.Users) userCriteria.uniqueResult();
        
        if(user.getStatus()==0){
        }
        
        return user;
    }
}
