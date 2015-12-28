/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

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
 * @author HD
 */
public class UserEdit extends HttpServlet {

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
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
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
            String UserId = request.getParameter("UserId");
            request.setAttribute("userE", usersFacade.find(Integer.parseInt(UserId)));
            request.getRequestDispatcher("userEdit.jsp").forward(request, response);
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
            
            int userID = Integer.parseInt(request.getParameter("UserId"));
            String name = request.getParameter("txtName").trim();
            String password = request.getParameter("confirm_password");
            String email = request.getParameter("txtEmail").trim();
            String address = request.getParameter("txtAddress").trim(); 
            String gender = request.getParameter("gender");

            boolean genderSQL = false;
            if (gender.equals("male")) {
                genderSQL = true;
            }
            String birthYear = request.getParameter("birthYear");

            List error = new ArrayList();
            if (!FormHelper.isNotNull(name)) {
                error.add("Your name is empty");
            }
            if (!FormHelper.isNotNull(email)) {
                error.add("Your email is empty");
            }
            if (!FormHelper.isNotNull(birthYear)) {
                error.add("You have to select your Year of Birth");
            }
            if (!FormHelper.checkEmail(email)) {
                error.add("Invalid Email Address");
            }
            if (usersFacade.isDuplidateEmail(userID, email)) {
                error.add("The email address is already in use by another member");
            }
            if (error.isEmpty()) {
                try {
                    Users user = usersFacade.find(userID);
                    if(FormHelper.isNotNull(password)){
                        password    =   FormHelper.hashPassword(password);
                        user.setPassword(password);
                    }
                    user.setUserId(userID);
                    user.setName(name);
                    user.setEmail(email);
                    user.setAddress(address);
                    user.setGender(genderSQL);
                    user.setBirthYear(birthYear);
                    usersFacade.edit(user);
                    request.setAttribute("redirectMessage", "User Edit successful!");
                    request.setAttribute("redirectLink", "UserManage");
                    request.getRequestDispatcher("../redirect.jsp").forward(request, response);
                } catch (ServletException | IOException e) {
                    error.add("Error: "+e.getMessage());
                }
            }else{
                request.setAttribute("errors", error);
                request.setAttribute("userE", usersFacade.find(userID));
                request.getRequestDispatcher("userEdit.jsp").forward(request, response);
            }
        } catch (NumberFormatException | ServletException | IOException e) {
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
