/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Images;
import Entity.UserFriends;
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
import libraries.UserHelper;
import models.CollectionsFacadeLocal;
import models.ImagesFacadeLocal;
import models.UserFriendsFacadeLocal;
import models.UsersFacadeLocal;

/**
 *
 * @author Hung Nguyen
 */
public class Home extends HttpServlet {
    @EJB
    private UserFriendsFacadeLocal userFriendsFacade;
    @EJB
    private UsersFacadeLocal usersFacade;
    @EJB
    private ImagesFacadeLocal imagesFacade;
    @EJB
    private CollectionsFacadeLocal collectionsFacade;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            UserHelper.authUser(session);
            int userId  =   Integer.parseInt(session.getAttribute("userID").toString());
            
            Users userForAvatar =   usersFacade.find(userId);
            session.setAttribute("myAvatar", userForAvatar.getUserAvatar());
            session.setAttribute("myName", userForAvatar.getName());
            
            List collections    =   collectionsFacade.getCollections(true);
            session.setAttribute("collections",collections);
            
            session.setAttribute("totalImage",imagesFacade.count());
            session.setAttribute("totalUser",usersFacade.count());
            
            List<UserFriends> friendRequests   =   userFriendsFacade.pendingFriendRequest(userId);
            session.setAttribute("newFriends",friendRequests.size());
            
            Users latestUser    =   usersFacade.getLastestUser();
            session.setAttribute("latestUser",latestUser);
            int page = 1;
            int recordsPerPage = 8;
            if(request.getParameter("page") != null)
                page = Integer.parseInt(request.getParameter("page"));
            
            List<Images> images =   imagesFacade.listImageByLimit((page-1)*recordsPerPage,recordsPerPage);
            int noOfRecords =   imagesFacade.imageTotalRows();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
            request.setAttribute("images", images);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            
            request.getRequestDispatcher("userHomepage.jsp").forward(request, response);
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
