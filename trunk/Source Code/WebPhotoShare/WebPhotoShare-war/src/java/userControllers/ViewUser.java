package userControllers;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import Entity.Images;
import Entity.UserFriends;
import Entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.ImagesFacadeLocal;
import models.UserFriendsFacadeLocal;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ViewUser extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;
    @EJB
    private ImagesFacadeLocal imagesFacade;
    @EJB
    private UsersFacadeLocal usersFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession(false);
            int userID  =   Integer.parseInt(session.getAttribute("userID").toString());
            int     memberID    =   Integer.parseInt(request.getParameter("user"));
            Users   member      =   usersFacade.find(memberID);
            request.setAttribute("member", member);
            
            UserFriends friendObject    =   userFriendsFacade.getUserFriendStatus(userID, memberID);
            request.setAttribute("friend", friendObject);
            List<Images> images =   imagesFacade.getImagesByUser(memberID);
            request.setAttribute("image", images);
            
            request.getRequestDispatcher("viewUser.jsp").forward(request, response);
        } catch(NumberFormatException | NullPointerException | ServletException | IOException e){
            response.sendRedirect("index.jsp");
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
