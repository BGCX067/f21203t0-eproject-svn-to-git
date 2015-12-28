/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package adminControllers;

import Entity.Collections;
import Entity.Images;
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
import models.CollectionsFacadeLocal;
import models.ImagesFacadeLocal;
import models.UsersFacadeLocal;

/**
 *
 * @author admin
 */
public class ImageEdit extends HttpServlet {
    @EJB
    private CollectionsFacadeLocal collectionsFacade;
    @EJB
    private UsersFacadeLocal usersFacade;
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
            List collections    =   collectionsFacade.getCollections(true);
            request.setAttribute("collections",collections);

            String imageId = request.getParameter("imageId");
            request.setAttribute("image", imagesFacade.find(Integer.parseInt(imageId))); 
            request.getRequestDispatcher("imageEdit.jsp").forward(request, response); 
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
            String admin    =   session.getAttribute("admin").toString().trim();
            
            String referer = request.getHeader("Referer");
            
            int imgID   =   Integer.parseInt(request.getParameter("imageId").toString());
            Images  image   =   imagesFacade.find(imgID);
            
            String  title   =   request.getParameter("imageTitle").trim();
            String  desc    =   request.getParameter("imageDesc").trim();
            int     coll    =   Integer.parseInt(request.getParameter("imageCollection"));
            int     status  =   Integer.parseInt(request.getParameter("imagePrivacy"));
            
            List    error       =   new ArrayList();
            if(!FormHelper.isNotNull(title)){
                error.add("Image title is empty");
            }else{
                try {
                    image.setTitle(title);
                    image.setDescription(desc);
                    image.setCollectionId(new Collections(coll));
                    image.setShareStatus((short)status);
                    image.setModifyDate(new java.sql.Date(System.currentTimeMillis()));
                    imagesFacade.edit(image);
                } catch (Exception e) {
                    error.add("Error: "+e.getMessage());
                }
            }
            if(error.isEmpty()){
                request.setAttribute("redirectMessage", "Image update successful!");
                request.setAttribute("redirectLink", referer);
                request.getRequestDispatcher("../redirect.jsp").forward(request, response);
            }else{
                request.setAttribute("error", error);
                request.getRequestDispatcher(referer).forward(request, response);
            }
        } catch (NumberFormatException | NullPointerException | ServletException | IOException e){
            response.sendRedirect("login.jsp");
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
