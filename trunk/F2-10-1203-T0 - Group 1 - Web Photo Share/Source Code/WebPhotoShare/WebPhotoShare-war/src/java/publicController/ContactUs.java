/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package publicController;

import Entity.Contact;
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
import models.ContactFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ContactUs extends HttpServlet {
    @EJB
    private ContactFacadeLocal contactFacade;

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
        request.getRequestDispatcher("contact.jsp").forward(request, response);
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
        
        String contactSubject  =   request.getParameter("contactSubject");
        String contactMessage  =   request.getParameter("contactMessage");
        String contactName  =   request.getParameter("contactName");
        String contactEmail  =   request.getParameter("contactEmail");

        List error  =   new ArrayList();

        if(!FormHelper.isNotNull(contactSubject)){
            error.add("Your subject cannot be blank");
        }
        if(!FormHelper.isNotNull(contactMessage)){
            error.add("Your message cannot be blank");
        }
        if(!FormHelper.isNotNull(contactName)){
            error.add("Your name cannot be blank");
        }
        if(!FormHelper.isNotNull(contactEmail)){
            error.add("Your email cannot be blank");
        }
        if(!FormHelper.checkEmail(contactEmail)){
            error.add("Invalid email address");
        }
        if(error.isEmpty()){
            try {
                Contact c   =   new Contact();
                c.setContactSubject(contactSubject);
                c.setContactMessage(contactMessage);
                c.setContactName(contactName);
                c.setContactEmail(contactEmail);
                c.setContactDate(new java.sql.Date(System.currentTimeMillis()));
                c.setContactStatus((short)0);
                contactFacade.create(c);
                request.setAttribute("redirectMessage", "Your contact have been sent successful!<br>Back to homepage...");
                request.setAttribute("redirectLink", "Home");
                request.getRequestDispatcher("redirect.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
                error.add("Error: " + e.getMessage());
            }
        }else{
            request.setAttribute("errors", error);
            request.getRequestDispatcher("contact.jsp").forward(request, response);
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
