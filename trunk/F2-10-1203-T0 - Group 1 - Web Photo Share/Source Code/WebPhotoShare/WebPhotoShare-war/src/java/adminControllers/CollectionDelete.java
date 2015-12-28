/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Collections;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.CollectionsFacadeLocal;
import models.CommentsFacadeLocal;
import models.ImagesFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class CollectionDelete extends HttpServlet {
    @EJB
    private ImagesFacadeLocal imagesFacade;
    @EJB
    private CommentsFacadeLocal commentsFacade;

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
            String admin = session.getAttribute("admin").toString();
            String referer = request.getHeader("Referer");

            String collectionDeleteID = request.getParameter("cid");
            Collections collectionDelete = collectionsFacade.find(Integer.parseInt(collectionDeleteID));
            request.setAttribute("collectionDelete", collectionDelete);
            request.getRequestDispatcher("collectionDelete.jsp").forward(request, response);

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
            String admin = session.getAttribute("admin").toString();
            String referer = request.getHeader("Referer");
            
            try {
                int cid = Integer.parseInt(request.getParameter("cid"));
                Collections collectionDelete = collectionsFacade.find(cid);
                
                /*
                 * Delete comment on delete collection
                 */
                commentsFacade.deleteCommentOnDeleteCollection(cid);
                
                /*
                 * Delete image on delete collection
                 */
                imagesFacade.deleteImageOnDeleteCollection(cid);
                
                collectionsFacade.remove(collectionDelete);
                request.setAttribute("redirectMessage", "Collection deleted successful!");
            } catch (Exception e) {
                request.setAttribute("redirectMessage", "Collection delete failed!");
            }
            request.setAttribute("redirectLink", "CollectionManage");
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);

        } catch (ServletException | NullPointerException | IOException e) {
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
