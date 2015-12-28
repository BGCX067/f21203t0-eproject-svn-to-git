/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package publicController;

import Entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import libraries.FormHelper;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class Login extends HttpServlet {
    @EJB
    private UsersFacadeLocal usersFacade;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
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
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
        String username =   request.getParameter("txtUsername");
        String password =   request.getParameter("txtPassword");
        password    =   FormHelper.hashPassword(password);
        if(usersFacade.Login(username, password)){
            HttpSession session = request.getSession(true);
            int userID  =   usersFacade.getUserIdFromUserName(username);
            session.setAttribute("userID", userID);
            session.setAttribute("user", username);
            request.setAttribute("redirectMessage", "Logged in successful!");
            request.setAttribute("redirectLink", "Home");
            request.getRequestDispatcher("redirect.jsp").forward(request, response);
        }else{
            request.setAttribute("error", "1");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
