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
import libraries.FormHelper;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ResetPassword extends HttpServlet {
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
        } catch(Exception e){
            
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
            String key  =   request.getParameter("key");
            if(null != key){
                request.setAttribute("key", key);
            }
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        } catch (Exception e) {
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
        List errors =   new ArrayList();
        try {
            String  key         =   request.getParameter("txtKey");
            String  password    =   request.getParameter("confirm_password");
            password    =   FormHelper.hashPassword(password);
            Users   user        =   usersFacade.findUserByKey(key);
            if(user != null){
                user.setPassword(password);
                user.setResetPasswordKey(null);
                usersFacade.edit(user);
                request.setAttribute("redirectMessage", "Your password changed successful!<br>Please login to continue");
                request.setAttribute("redirectLink", "Login");
                request.getRequestDispatcher("redirect.jsp").forward(request, response);
            }else{
                errors.add("Invalid reset code");
            }
        } catch (Exception e) {
            errors.add("Error: "+e.getMessage());
        }
        if(!errors.isEmpty()){
            String referer = request.getHeader("Referer");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
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
