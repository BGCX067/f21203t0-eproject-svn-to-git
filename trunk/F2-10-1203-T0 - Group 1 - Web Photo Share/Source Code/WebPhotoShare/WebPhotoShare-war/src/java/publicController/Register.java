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
public class Register extends HttpServlet {
    @EJB
    private UsersFacadeLocal usersFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        try {
        } catch (Exception ex){
            ex.printStackTrace();
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
        request.getRequestDispatcher("signup.jsp").forward(request, response);
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
        String  name        =   request.getParameter("txtName");
        String  username    =   request.getParameter("txtUsername");
        String  password    =   request.getParameter("txtPassword");
        String  email       =   request.getParameter("txtEmail");
        String  gender      =   request.getParameter("gender");
        boolean genderSQL   =   false;
        if(gender.equals("1")){
            genderSQL       =   true;
        }
        String  birth       =   request.getParameter("yearOfBirth");
        short   userStatus  =   0;
        List    error       =   validateForm(name, username, password, email, birth);
        
        if(error.isEmpty())
        {
            password    =   FormHelper.hashPassword(password);
            try {
                Users user =   new Users();
                user.setName(name);
                user.setUsername(username);
                user.setPassword(password);
                user.setEmail(email);
                user.setAddress(null);
                user.setGender(genderSQL);
                user.setBirthYear(birth);
                user.setUserStatus(userStatus);
                user.setResetPasswordKey(null);
                user.setJoinDate(new java.sql.Date(System.currentTimeMillis()));
                user.setUserAvatar(null);
                usersFacade.create(user);
                /*
                 * @TODO send admin email on registration
                 */
                request.setAttribute("name", name);
                request.getRequestDispatcher("signupDone.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
                error.add("Exception " + e.getMessage());
                
                request.setAttribute("errors", error);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
        }else{
            request.setAttribute("errors", error);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
        processRequest(request, response);
    }
    
    private List validateForm(String name, String username, String password, String email, String birth){
        List    error       =   new ArrayList();
        if(!FormHelper.isNotNull(name)){
            error.add("Your name is empty");
        }
        if(!FormHelper.isNotNull(username)){
            error.add("Your username is empty");
        }
        if(usersFacade.findByUserName(username).size() > 0){
            error.add("The username is already taken by another member");
        }
        if(!FormHelper.isNotNull(password)){
            error.add("Your password is empty");
        }
        if(!FormHelper.isNotNull(email)){
            error.add("Your email is empty");
        }
        if(!FormHelper.isNotNull(birth)){
            error.add("You have to select your Year of Birth");
        }
        if(!FormHelper.checkEmail(email)){
            error.add("Invalid Email Address");
        }
        if(null != usersFacade.findUserByEmail(email)){
            error.add("The email is already taken by another member");
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
