/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

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
import javax.servlet.http.HttpSession;
import libraries.EmailHelper;
import libraries.FormHelper;
import models.ContactFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ContactReply extends HttpServlet {
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
        try {
            HttpSession session = request.getSession();
            String admin    =   session.getAttribute("admin").toString();
            int contactID   =   Integer.parseInt(request.getParameter("contact"));
            Contact c   =   contactFacade.find(contactID);
            c.setContactStatus((short)1);
            contactFacade.edit(c);
            request.setAttribute("contact", c);
            request.getRequestDispatcher("contactReply.jsp").forward(request, response);
        } catch(ServletException | NullPointerException | IOException e){
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
            int contactID   =   Integer.parseInt(request.getParameter("contact"));
            
            String replyMessage =   request.getParameter("replyMessage").trim();
            List errors =   new ArrayList();
            if(!FormHelper.isNotNull(replyMessage)){
                errors.add("Reply message cannot be blank");
            }
            if(errors.isEmpty()){
                try {
                    Contact c   =   contactFacade.find(contactID);
                    
                    EmailHelper emailHelper =   new EmailHelper();
                    emailHelper.replyContact(c.getContactName(), c.getContactSubject(), c.getContactEmail(), replyMessage);
                    
                    replyMessage    =   replyMessage.replaceAll("\n","<br />");
                    c.setContactReply(replyMessage);
                    c.setContactStatus((short)2);
                    c.setReplyDate(new java.sql.Date(System.currentTimeMillis()));
                    contactFacade.edit(c);

                    request.setAttribute("redirectMessage", "Your contact have been replied successful!<br>Back to mainpage...");
                    request.setAttribute("redirectLink", "ContactManage");
                    request.getRequestDispatcher("../redirect.jsp").forward(request, response);
                } catch (ServletException | IOException e) {
                    errors.add("System exception: "+e.getMessage());
                }
            }else{
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("contactReply.jsp").forward(request, response);
            }

        } catch (NumberFormatException | ServletException | IOException e) {
            response.sendRedirect("index.jsp");
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
