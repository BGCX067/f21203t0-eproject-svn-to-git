/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Faqs;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import libraries.FormHelper;
import models.FaqsFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class FAQManage extends HttpServlet {
    @EJB
    private FaqsFacadeLocal faqsFacade;

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
            String referer = request.getHeader("Referer");
            
            String  edit    =   request.getParameter("edit");
            String  delete  =   request.getParameter("delete");
            
            /*
             * Get FAQs for editing
             */
            if(FormHelper.isNotNull(edit)){
                Faqs    faqEdit =   faqsFacade.find(Integer.parseInt(edit));
                request.setAttribute("faqEdit", faqEdit);
            }
           if(FormHelper.isNotNull(delete)){
               Faqs    faqDelete =   faqsFacade.find(Integer.parseInt(delete));
               faqsFacade.remove(faqDelete);
               request.setAttribute("redirectMessage", "FAQ deleted successful!");
               request.setAttribute("redirectLink", "FAQManage");
               request.getRequestDispatcher("../redirect.jsp").forward(request, response);
               return;
           }
            
            int page = 1;
            int recordsPerPage = 8;
            if(request.getParameter("page") != null)
                page = Integer.parseInt(request.getParameter("page"));
            List<Faqs> faqs   =   faqsFacade.listFaqByLimit((page-1)*recordsPerPage,recordsPerPage);
            int noOfRecords =   faqsFacade.count();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
            
            request.setAttribute("faqs", faqs); 
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.getRequestDispatcher("faq.jsp").forward(request, response);
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
            String referer = request.getHeader("Referer");
            
            String question =   request.getParameter("question").trim();
            String answer   =   request.getParameter("answer").toString();
            answer          =   answer.replaceAll("\n","<br />");
            String action   =   request.getParameter("action");
            if(action.equals("edit")){
                int faqID    =   Integer.parseInt(request.getParameter("faqID"));
                Faqs    faqEdit =   faqsFacade.find(faqID);
                
                faqEdit.setAnswer(answer);
                faqEdit.setQuestion(question);
                faqsFacade.edit(faqEdit);
                request.setAttribute("redirectMessage", "FAQs edited successful!");
            }else if(action.equals("insert")){
                Faqs    faqInsert   =   new Faqs();
                faqInsert.setAnswer(answer);
                faqInsert.setQuestion(question);
                faqsFacade.create(faqInsert);
                request.setAttribute("redirectMessage", "FAQs insert successful!");
            }
            request.setAttribute("redirectLink", referer);
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);
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
