/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package libraries;

import Entity.Users;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.ImagesFacadeLocal;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class UserHelper extends HttpServlet{
    @EJB
    private ImagesFacadeLocal imagesFacade;
    @EJB
    private UsersFacadeLocal usersFacade;
    /*
     * Check if user is logged in
     */

    public static void authUser(HttpSession session) throws IOException {
        try {
            session.getAttribute("user");
        } catch (Exception e) {
            HttpServletResponse response = null;
            response.sendRedirect("index.jsp");
        }
    }
    /*
     * Count number of uploaded images per users
     * 
     * @param string String username
     * @return int Integer value of images
     */
    public static int countUserImage(Users user){
        return 0;
    }
    
    public Users fetchUsernameById(int useId){
        return (Users)usersFacade.find(useId);
    }
}
