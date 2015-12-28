/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.UserFriends;
import Entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.UserFriendsFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class AddFriend extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;

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
        HttpSession session = request.getSession(false);
        String referer = request.getHeader("Referer");
        
        try {
            int userID  =   Integer.parseInt(session.getAttribute("userID").toString());
            int friend  =   Integer.parseInt(request.getParameter("friend"));
            if(!userFriendsFacade.isRequestSent(userID, friend)){
                UserFriends uf  =   new UserFriends();
                uf.setUserId(new Users(userID));
                uf.setFriend(new Users(friend));
                uf.setRequestStatus(false);
                userFriendsFacade.create(uf);
            }
            request.setAttribute("redirectMessage", "Friend request sent!");
            request.setAttribute("redirectLink", referer);
            request.getRequestDispatcher("redirect.jsp").forward(request, response);
        } catch(NumberFormatException | IOException e){
            response.sendRedirect("index.jsp");
        } finally {            
            out.close();
        }
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
