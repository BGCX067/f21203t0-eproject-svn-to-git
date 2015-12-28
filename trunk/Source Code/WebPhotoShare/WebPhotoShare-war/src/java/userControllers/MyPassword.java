/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

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
public class MyPassword extends HttpServlet {
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
        try {
            HttpSession session = request.getSession(false);
            int userID = Integer.parseInt(session.getAttribute("userID").toString());
            Users user = usersFacade.find(userID);
            request.setAttribute("profile", user);
            request.getRequestDispatcher("userPassword.jsp").forward(request, response);
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e) {
            response.sendRedirect("index.jsp");
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
            HttpSession session = request.getSession(false);
            int userID = Integer.parseInt(session.getAttribute("userID").toString());
            Users user = usersFacade.find(userID);
            
            List errors =   new ArrayList();
            
            String currentPassword  =   request.getParameter("crPassword");
            String newPassword      =   request.getParameter("newPassword");
            String newPassword2     =   request.getParameter("newPassword2");
            
            if(user.getPassword() == null ? FormHelper.hashPassword(currentPassword) != null : !user.getPassword().equals(FormHelper.hashPassword(currentPassword))){
                errors.add("Your current password is incorrect");
            }
            if(!newPassword.equals(newPassword2)){
                errors.add("The passwords do not match");
            }
            if(currentPassword.equals(newPassword)){
                errors.add("Your new passwords have to different from current password");
            }
            
            if(errors.isEmpty()){
                try {
                    user.setPassword(FormHelper.hashPassword(newPassword));
                    usersFacade.edit(user);
                    request.setAttribute("redirectMessage", "Password changed successful!");
                    request.setAttribute("redirectLink", "MyProfile");
                    request.getRequestDispatcher("redirect.jsp").forward(request, response);
                } catch (ServletException | IOException e) {
                    errors.add("System error: "+e.getMessage());
                }
            }else{
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("userPassword.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
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
