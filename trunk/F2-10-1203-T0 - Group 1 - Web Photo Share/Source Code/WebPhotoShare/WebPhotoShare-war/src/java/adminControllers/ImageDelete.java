/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Collections;
import Entity.Images;
import Entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.CommentsFacadeLocal;
import models.ImagesFacadeLocal;

/**
 *
 * @author admin
 */
public class ImageDelete extends HttpServlet {

    @EJB
    private CommentsFacadeLocal commentsFacade;
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
        try {
            HttpSession session = request.getSession();
            String imageId = request.getParameter("imageId");
            Images images = imagesFacade.find(Integer.parseInt(imageId));
            request.setAttribute("images", images);
            request.getRequestDispatcher("imageDelete.jsp").forward(request, response);
        } catch (ServletException | NullPointerException | IOException e) {
            response.sendRedirect("login.jsp");
            return; // <--- Here.
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
        HttpSession session = request.getSession();
        String admin = session.getAttribute("admin").toString();
        String referer = request.getHeader("Referer");
        processRequest(request, response);
        try {
                int imageId = Integer.parseInt(request.getParameter("imageId"));
                Images imageDelete = imagesFacade.find(imageId);
                
                /*
                 * Delete comment on delete comments
                 */
                commentsFacade.deleteCommnetByImage(imageId);
                
                /*
                 * Delete image on delete image
                 */
                imagesFacade.remove(imageDelete);
                
                request.setAttribute("redirectMessage", "Image deleted successful!");
            } catch (Exception e) {
                request.setAttribute("redirectMessage", "Image delete failed!");
            }
            request.setAttribute("redirectLink", "ImageManage");
            request.getRequestDispatcher("../redirect.jsp").forward(request, response);

        } catch (ServletException | NullPointerException | IOException e) {
            response.sendRedirect("login.jsp");
            return; // <--- Here.
        }
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
