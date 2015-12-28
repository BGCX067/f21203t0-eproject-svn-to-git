/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Users;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import libraries.FormHelper;
import models.UsersFacadeLocal;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Hung Nguyen
 */
public class UpdateAvatar extends HttpServlet {
    @EJB
    private UsersFacadeLocal usersFacade;

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
        HttpSession session = request.getSession(false);
        int userID  =   Integer.parseInt(session.getAttribute("userID").toString());
        Users user  =   usersFacade.find(userID);
        List error = new ArrayList();
        List fileItemsList = null;
        float filesize = 0;
        String _fileLink = null;
        String _fileName = null;
        String _uploadDir;
        /*
         * Create upload dir by date
         */
        _uploadDir = getServletContext().getRealPath("/profiles/");

        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
                try {
                    fileItemsList = servletFileUpload.parseRequest(request);
                } catch (FileUploadException ex) {
                    Logger.getLogger(MyImage.class.getName()).log(Level.SEVERE, null, ex);
                    //Change above line replace FileUploadExample with your file name
                }
                String optionalFileName = String.valueOf(System.currentTimeMillis());
                FileItem fileItem = null;

                Iterator it;
                it = fileItemsList.iterator();
                while (it.hasNext()) {
                    FileItem fileItemTemp = (FileItem) it.next();
                    if (fileItemTemp.isFormField()) {
                    } else {
                        fileItem = fileItemTemp;
                    }
                }
                if (fileItem != null) {
                    long size_long = fileItem.getSize();
                    filesize = size_long / 1024;
                    filesize = filesize / 1000;
                    //If you want to limit the file size. Here 30MB file size is allowed you can change it
                    if (filesize > 30.0) {
                        //Pass error message in session.
                        error.add("File size can't be more than 30MB");
                    } else {
                        _fileName = fileItem.getName();
                        if (fileItem.getSize() > 0) {
                            if (optionalFileName.trim().equals("")) {
                                _fileName = FilenameUtils.getName(_fileName);
                            } else {
                                _fileName = FormHelper.hashPassword(user.getUserId().toString()) + "." + FilenameUtils.getExtension(_fileName);
                            }
                            _fileLink = _uploadDir + "/" + _fileName;
                            try {
                                // Create folder if not exits
                                File folder = new File(_uploadDir + "/");
                                folder.mkdirs();
                                File file = new File(folder, _fileName);
                                fileItem.write(file);
                                /*
                                 * @TODO
                                 */
                            } catch (Exception e) {
                                error.add(e.getMessage());
                            }
                            if(error.isEmpty() && FormHelper.isNotNull(_fileLink)){
                                try {
                                    user.setUserAvatar(_fileName);
                                    usersFacade.edit(user);
                                } catch (Exception e) {
                                    error.add("Error: "+e.getMessage());
                                }
                            }
                        }
                    }
                }
            }
        } catch(Exception e){
            error.add(e.getMessage());
        }
        if(error.isEmpty()){
            request.setAttribute("redirectMessage", "Your avatar updated successful!<br>Back to homepage...");
            request.setAttribute("redirectLink", "MyProfile");
            request.getRequestDispatcher("redirect.jsp").forward(request, response);
        }else{
            request.setAttribute("error", error);
            String referer = request.getHeader("Referer");
            response.sendRedirect("MyImage");
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
