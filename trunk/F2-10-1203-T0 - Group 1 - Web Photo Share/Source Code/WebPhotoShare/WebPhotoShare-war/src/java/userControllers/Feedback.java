/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Feedbacks;
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
import models.FeedbacksFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class Feedback extends HttpServlet {
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
            HttpSession session = request.getSession(false);
            int userID  =   Integer.parseInt(session.getAttribute("userID").toString());
            request.getRequestDispatcher("userFeedback.jsp").forward(request, response);
            processRequest(request, response);
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e) {
            response.sendRedirect("index.jsp");
        }
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
            int userID  =   Integer.parseInt(session.getAttribute("userID").toString());
            Feedbacks   f       =   new Feedbacks();
            List        error   =   new ArrayList();
            String      feedbackSubject =   request.getParameter("feedbackSubject");
            String      feedbacktMessage =   request.getParameter("feedbacktMessage");
            String      satisfyPage =   request.getParameter("satisfyPage");
            String      satisfySite =   request.getParameter("satisfySite");
            
            if(!FormHelper.isNotNull(feedbackSubject)){
                error.add("Please Briefly describe the area of the site that you are using");
            }
            if(!FormHelper.isNotNull(feedbacktMessage)){
                error.add("Please provide detail");
            }
            if(!FormHelper.isNotNull(satisfyPage)){
                error.add("Please provide your satisfiy page and/or feature");
            }
            if(!FormHelper.isNotNull(satisfySite)){
                error.add("Please provide your satisfiy site overall");
            }
            if(error.isEmpty()){
                try {
                    f.setUserId(new Users(userID));
                    f.setSubject(feedbackSubject);
                    feedbacktMessage    +=  "<br>Satisfiy with page and/or feature: " + satisfyPage;
                    feedbacktMessage    +=  "<br>Satisfiy site overall: " + satisfySite;
                    f.setMessage(feedbacktMessage);
                    f.setStatus((short)0);
                    f.setFeedbackDate(new java.sql.Date(System.currentTimeMillis()));
                    feedbacksFacade.create(f);
                    request.setAttribute("redirectMessage", "Your feedback have been sent successful!<br>Back to homepage...");
                    request.setAttribute("redirectLink", "Home");
                    request.getRequestDispatcher("redirect.jsp").forward(request, response);
                } catch (Exception e) {
                    error.add("Error: "+e.getMessage());
                }
            }else{
                request.setAttribute("errors", error);
                request.getRequestDispatcher("userFeedback.jsp").forward(request, response);
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
