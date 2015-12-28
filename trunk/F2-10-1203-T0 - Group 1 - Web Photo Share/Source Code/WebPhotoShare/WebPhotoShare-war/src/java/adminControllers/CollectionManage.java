/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Collections;
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
import models.CollectionsFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class CollectionManage extends HttpServlet {
    @EJB
    private CollectionsFacadeLocal collectionsFacade;

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
            
            String collectionEditID  =   request.getParameter("edit");
            String collectionDeleteID   =   request.getParameter("delete");
            if(FormHelper.isNotNull(collectionEditID)){
                Collections collectionEdit  =   collectionsFacade.find(Integer.parseInt(collectionEditID));
                request.setAttribute("collectionEdit", collectionEdit);
            }
            if(FormHelper.isNotNull(collectionDeleteID)){
                Collections collectionDelete  =   collectionsFacade.find(Integer.parseInt(collectionDeleteID));
                collectionDelete.setStatus(false);
                collectionsFacade.edit(collectionDelete);
                request.setAttribute("redirectMessage", "Your collection deleted successful!");
                request.setAttribute("redirectLink", referer);
                request.getRequestDispatcher("../redirect.jsp").forward(request, response);
                return;
            }
            int page = 1;
            int recordsPerPage = 8;
            if(request.getParameter("page") != null)
                page = Integer.parseInt(request.getParameter("page"));
            List<Collections> collections   =   collectionsFacade.listCollectionByLimit((page-1)*recordsPerPage,recordsPerPage);
            int noOfRecords =   collectionsFacade.count();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
            
            request.setAttribute("collections", collections);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.getRequestDispatcher("collection.jsp").forward(request, response);
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
            String referer = request.getHeader("Referer");
            String title    =   request.getParameter("collectionTitle").trim();
            String desc     =   request.getParameter("collectionDescription").trim(); 
            String action   =   request.getParameter("action");
            
            if(action.equals("edit")){
                String status   =   request.getParameter("status");
                boolean collection_status   =   false;
                if(status.equals("1")){
                    collection_status   =   true;
                }
                int collectionID    =   Integer.parseInt(request.getParameter("edit"));
                Collections collection  =   collectionsFacade.find(collectionID);
                collection.setTitle(title);
                collection.setDescription(desc);
                collection.setStatus(collection_status);
                collectionsFacade.edit(collection);
                request.setAttribute("redirectMessage", "Your collection edited successful!");
            }else if(action.equals("insert")){
                Collections collection  =   new Collections();
                collection.setTitle(title);
                collection.setDescription(desc);
                collection.setStatus(true);
                collectionsFacade.create(collection);
                request.setAttribute("redirectMessage", "New collection inserted successful!");
            }
            request.setAttribute("redirectLink", referer);
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e) {
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
