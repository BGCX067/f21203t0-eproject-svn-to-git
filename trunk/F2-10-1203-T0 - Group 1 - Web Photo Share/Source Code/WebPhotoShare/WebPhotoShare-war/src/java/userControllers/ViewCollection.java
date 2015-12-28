/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Collections;
import Entity.Images;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import libraries.UserHelper;
import models.CollectionsFacadeLocal;
import models.ImagesFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ViewCollection extends HttpServlet {
    @EJB
    private CollectionsFacadeLocal collectionsFacade;
    @EJB
    private ImagesFacadeLocal imagesFacade;

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
            HttpSession session = request.getSession();
            UserHelper.authUser(session);
            int userId  =   Integer.parseInt(session.getAttribute("userID").toString());
            
            int colID   =   Integer.parseInt(request.getParameter("collection"));
            Collections collection =   collectionsFacade.find(colID);
            request.setAttribute("col", collection);
            
            int page = 1;
            int recordsPerPage = 8;
            if(request.getParameter("page") != null)
                page = Integer.parseInt(request.getParameter("page"));
            
            request.setAttribute("url", page);
            
            List<Images> images =   imagesFacade.listImageCollectionByLimit( colID, (page-1)*recordsPerPage, recordsPerPage);
            int noOfRecords =   imagesFacade.imageCollectionTotalRow(colID);
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
            request.setAttribute("collectionImages", images);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            
            request.getRequestDispatcher("viewCollection.jsp").forward(request, response);
        } catch(ServletException | NullPointerException | IOException e){
            HttpSession session = request.getSession(true);
            session.invalidate();
            response.sendRedirect("index.jsp");
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
