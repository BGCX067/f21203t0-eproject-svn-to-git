/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Feedbacks;
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
import models.FeedbacksFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class FeedbackReply extends HttpServlet {
    @EJB
    private FeedbacksFacadeLocal feedbacksFacade;

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
            int     fid     =   Integer.parseInt(request.getParameter("fid"));
            Feedbacks f     =   feedbacksFacade.find(fid);
            f.setStatus((short)1);
            feedbacksFacade.edit(f);
            request.setAttribute("feedback", f);
            request.getRequestDispatcher("feedbackReply.jsp").forward(request, response);
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e) {
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
            int     fid     =   Integer.parseInt(request.getParameter("fid"));
            
            List error      =   new ArrayList();
            
            String reply        =   request.getParameter("reply");
            String toName   =   request.getParameter("senderName");
            String toEmail  =   request.getParameter("senderEmail");
            String toSubject    =   request.getParameter("feedbackSubject");
            String date    =   request.getParameter("date");
            
            if(!FormHelper.isNotNull(reply))
                error.add("Reply message cannot be blank");
            
            if(error.isEmpty()){
                try {
                    Feedbacks f     =   feedbacksFacade.find(fid);
                    f.setReply(reply);
                    f.setStatus((short)2);
                    f.setReplyDate(new java.sql.Date(System.currentTimeMillis()));
                    feedbacksFacade.edit(f);
                    
                    EmailHelper email   =   new EmailHelper();
                    email.replyFeedback(toName, toEmail, toSubject, date, reply);
                    
                    request.setAttribute("redirectMessage", "Your feedback have been sent successful!<br>Back to homepage...");
                    request.setAttribute("redirectLink", "Dashboard");
                    request.getRequestDispatcher("../redirect.jsp").forward(request, response);
                } catch (ServletException | IOException e) {
                    error.add("Error: "+e.getMessage());
                }
            }else{
                request.setAttribute("errors", error);
                request.getRequestDispatcher("feedbackReply.jsp").forward(request, response);
            }
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e) {
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
