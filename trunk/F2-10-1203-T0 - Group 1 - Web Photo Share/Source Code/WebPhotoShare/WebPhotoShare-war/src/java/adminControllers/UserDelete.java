/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.CommentsFacadeLocal;
import models.FeedbacksFacadeLocal;
import models.ImagesFacadeLocal;
import models.UserFriendsFacadeLocal;
import models.UsersFacadeLocal;

/**
 *
 * @author HD
 */
public class UserDelete extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;
    @EJB
    private FeedbacksFacadeLocal feedbacksFacade;
    @EJB
    private ImagesFacadeLocal imagesFacade;
    @EJB
    private CommentsFacadeLocal commentsFacade;
    @EJB
    private UsersFacadeLocal usersFacade;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        try {
            HttpSession session = request.getSession();
            String admin = session.getAttribute("admin").toString();
            String referer = request.getHeader("Referer");

            String UserDeleteID = request.getParameter("UserId");
            Users userDelete = usersFacade.find(Integer.parseInt(UserDeleteID));
            request.setAttribute("userDelete", userDelete);
            request.getRequestDispatcher("userDelete.jsp").forward(request, response);
        } catch (ServletException | NullPointerException | IOException e) {
            response.sendRedirect("login.jsp");
            return; // <--- Here.
        }
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String admin    =   session.getAttribute("admin").toString();
            
            String userId = request.getParameter("UserId");
            int userID  =   Integer.parseInt(userId);
            Users user = usersFacade.find(Integer.parseInt(userId));
            /*
                 * Delete comment on delete User
            */
            commentsFacade.deleteCommentByUser(userID);
            /*
                 * Delete image on delete User
            */
            imagesFacade.deleteImageByUser(userID);
            /*
                 * Delete feedback on delete User
            */
            feedbacksFacade.deleteFeedbackByUser(userID);
            /*
                  * Delete friend on delete User 
             */
            userFriendsFacade.deletFriendByUser(userID);
            /*
                  * Delete User 
             */ 
            usersFacade.remove(user);
            
            request.setAttribute("redirectMessage", "User deleted successful!");
            request.setAttribute("redirectLink", "UserManage");
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);
        } catch(ServletException | NullPointerException | IOException e){
            response.sendRedirect("login.jsp");
            return; // <--- Here.
        }
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
