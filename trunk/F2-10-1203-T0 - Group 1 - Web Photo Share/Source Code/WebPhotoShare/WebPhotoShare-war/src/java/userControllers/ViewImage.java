/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Comments;
import Entity.Images;
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
import models.CommentsFacadeLocal;
import models.ImagesFacadeLocal;
import models.UserFriendsFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class ViewImage extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;
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
        try {
            int imgID   =   Integer.parseInt(request.getParameter("image").toString());
            String overlay  =   request.getParameter("ovr");
            if (overlay != null && !overlay.isEmpty()){
                //processing here
                request.setAttribute("overlay", "yes");
            }
            Images  image   =   imagesFacade.find(imgID);
            
            alterViewCount(image);
            
            request.setAttribute("image", image);
            
            List<Comments> comments  =   commentsFacade.imageComment(imgID);
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("viewImage.jsp").forward(request, response);
        } catch(NumberFormatException | ServletException | IOException e){
            response.sendRedirect("index.jsp");
        } finally {            
            out.close();
        }
    }
    private void alterViewCount(Images image){
        int viewCount   =   image.getViewCount();
        viewCount += 1;
        image.setViewCount(viewCount);
        imagesFacade.edit(image);
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
        HttpSession session = request.getSession();
        String comment  =   request.getParameter("comment");
        String referer = request.getHeader("Referer");
        List    error   =   new ArrayList();
        try {
            int userId      =   Integer.parseInt(session.getAttribute("userID").toString());
            int imageID     =   Integer.parseInt(request.getParameter("image"));
            if(!comment.isEmpty()){
                try {
                    Comments commentObject  =   new Comments();

                    commentObject.setComment(comment);
                    commentObject.setCommentDate(new java.sql.Date(System.currentTimeMillis()));
                    commentObject.setUserId(new Users(userId));
                    commentObject.setImageId(new Images(imageID));
                    
                    commentsFacade.create(commentObject);
                    
                    response.sendRedirect(referer);
                    return;
                } catch (Exception e) {
                    error.add("Error: "+e.getMessage());
                }
            }else{
                error.add("Your coment cannot be blank");
            }
        } catch (Exception e) {
            error.add("Error: "+e.getMessage());
            request.setAttribute("errors", error);
            request.getRequestDispatcher(referer).forward(request, response);
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
