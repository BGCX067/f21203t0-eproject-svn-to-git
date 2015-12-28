/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Admins;
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
import models.AdminsFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ChangePassword extends HttpServlet {
    @EJB
    private AdminsFacadeLocal adminsFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String admin    =   session.getAttribute("admin").toString();
            String referer = request.getHeader("Referer");
            List error  =   new ArrayList();
            String current_password =   request.getParameter("password");
            String new_password     =   request.getParameter("newPassword");
            String new_password_2   =   request.getParameter("newPassword2");
            /*
             * Encrypt password
             */
            current_password    =   FormHelper.hashPassword(current_password);
            new_password        =   FormHelper.hashPassword(new_password);
            new_password_2      =   FormHelper.hashPassword(new_password_2);
            if( ! new_password.equals(new_password_2)){
                error.add("New password does not match !");
            }
            if(current_password.equals(new_password)){
                error.add("New password have to different with current password");
            }
            if(adminsFacade.Login(admin, current_password)){
                try {
                    Admins adminObject  =   new Admins(admin);
                    adminObject.setPassword(new_password);
                    adminsFacade.edit(adminObject);
                } catch (Exception e) {
                    error.add("Error: "+e.getMessage());
                }
            }else{
                error.add("Invalid current password");
            }
            if(error.isEmpty()){
                request.setAttribute("redirectMessage", "Your new password updated successful!");
                request.setAttribute("redirectLink", referer);
                request.getRequestDispatcher("../redirect.jsp").forward(request, response);
            }else{
                request.setAttribute("errors", error);
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            }
            
        } catch(ServletException | IllegalStateException | NullPointerException | IOException e){
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
        try {
            HttpSession session = request.getSession(false);
            String adminUser    =   session.getAttribute("admin").toString();
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } catch (ServletException | NullPointerException | IOException e) {
            response.sendRedirect("login.jsp");
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
