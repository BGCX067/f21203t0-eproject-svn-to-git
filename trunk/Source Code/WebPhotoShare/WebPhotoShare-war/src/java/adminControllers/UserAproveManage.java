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
import libraries.EmailHelper;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class UserAproveManage extends HttpServlet {
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
        try {
            String userId = request.getParameter("UserId");
            Users user = usersFacade.find(Integer.parseInt(userId));
            
            EmailHelper email   =   new EmailHelper();
            email.emailUserStatus(user.getName(), user.getEmail(), true);
            user.setUserStatus((short) 1);
            usersFacade.edit(user);
            request.setAttribute("redirectMessage", "User Aproved successful!"); 
            request.setAttribute("redirectLink", "UserManage");
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);
        } catch (ServletException | NullPointerException | IOException e) {
            response.sendRedirect("login.jsp");
            return; // <--- Here.
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
