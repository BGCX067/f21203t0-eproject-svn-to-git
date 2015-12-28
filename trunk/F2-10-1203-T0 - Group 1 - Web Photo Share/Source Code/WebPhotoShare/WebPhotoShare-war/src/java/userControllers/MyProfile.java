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
import libraries.UserHelper;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class MyProfile extends HttpServlet {

    @EJB
    private UsersFacadeLocal usersFacade;
    UserHelper userHelper = new UserHelper();

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
            request.getRequestDispatcher("userProfile.jsp").forward(request, response);
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String name = request.getParameter("name");
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String address = request.getParameter("userAddress");
            String email = request.getParameter("userEmail");
            String gender = request.getParameter("gender");
            boolean genderSQL = false;
            if (gender.equals("male")) {
                genderSQL = true;
            }
            String birth = request.getParameter("userYearOfBirth");

            List error = validateForm(name, email, birth, userID);
            
            if (error.isEmpty()) {
                try {
                    Users userEdit = usersFacade.find(userID);
                    userEdit.setName(name);
                    userEdit.setAddress(address);
                    userEdit.setEmail(email);
                    userEdit.setGender(genderSQL);
                    userEdit.setBirthYear(birth);
                    usersFacade.edit(userEdit);
                    request.setAttribute("redirectMessage", "Your profile updated successful!<br>Back to homepage...");
                    request.setAttribute("redirectLink", "MyProfile");
                    request.getRequestDispatcher("redirect.jsp").forward(request, response);
                } catch (ServletException | IOException e) {
                    error.add("Error: "+e.getMessage());
                }
            } else {
                Users user = usersFacade.find(userID);
                request.setAttribute("profile", user);
                request.setAttribute("errors", error);
                request.getRequestDispatcher("userProfile.jsp").forward(request, response);
            }
        } catch (NumberFormatException | ServletException | IOException e) {
            response.sendRedirect("Login");
        }
        processRequest(request, response);
    }

    private List validateForm(String name, String email, String birth, int userID) {
        List error = new ArrayList();
        if (!FormHelper.isNotNull(name)) {
            error.add("Your name is empty");
        }
        if (!FormHelper.isNotNull(email)) {
            error.add("Your email is empty");
        }
        if (!FormHelper.isNotNull(birth)) {
            error.add("You have to select your Year of Birth");
        }
        if (!FormHelper.checkEmail(email)) {
            error.add("Invalid Email Address");
        }
        if (usersFacade.isDuplidateEmail(userID, email)) {
            error.add("The email address is already in use by another member");
        }
        return error;
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
