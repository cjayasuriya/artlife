package Classes;


import com.sun.corba.se.spi.presentation.rmi.StubAdapter;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.hibernate.Session;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author chamal
 */
public class sessionCounter implements HttpSessionListener{
    
    public static int countUser = 0;
    

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        countUser++;
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        countUser--;
        
        
    }
    
    public static int getAllActiveUsers(){
        return countUser;
    }
    
}
