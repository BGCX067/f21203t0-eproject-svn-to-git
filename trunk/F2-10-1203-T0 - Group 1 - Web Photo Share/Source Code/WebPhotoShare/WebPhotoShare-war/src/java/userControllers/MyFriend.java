/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.UserFriends;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class MyFriend extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;
    /**
     *
     * @param request the value of request
     * @param response the value of response
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            int userId  =   Integer.parseInt(session.getAttribute("userID").toString());
            List<UserFriends> friendRequests   =   userFriendsFacade.pendingFriendRequest(userId);
            request.setAttribute("friendRequests", friendRequests);
            
            List<UserFriends> friends   =   userFriendsFacade.listMyFriends(userId);
            request.setAttribute("friends", friends);
            request.getRequestDispatcher("userFriends.jsp").forward(request, response);
        } catch(NumberFormatException | NullPointerException | ServletException | IOException e){
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
