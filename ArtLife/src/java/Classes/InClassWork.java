/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Classes;

import java.awt.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 *
 * @author chamaljayasuriya
 */


//SQL practise with hiernate 
public class InClassWork {
    public static void main(String[] args) {
        Session hiberSession = Connection.NewHibernateUtil.getSessionFactory().openSession();
        SQLQuery myLQuery =hiberSession.createSQLQuery("SELECT id FROM addresses ORDER"
                + " BY id DESC LIMIT 2");
        
        java.util.List l = myLQuery.list();
        
        for (Object k : l) {
            
            Integer i = Integer.parseInt(k.toString());
            
            System.out.println("Id is "+k);
        }
        System.out.println(l.toString());
    }
    
}
