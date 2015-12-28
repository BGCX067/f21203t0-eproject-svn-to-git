/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package userControllers;

import Entity.Collections;
import Entity.Images;
import Entity.Users;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import libraries.UserHelper;
import models.ImagesFacadeLocal;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Hung Nguyen
 */
public class MyImage extends HttpServlet {

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
        HttpSession session = request.getSession(false);
//        UserHelper.authUser(session);
        try {
        } catch (Exception e) {
            out.println(e.getMessage());
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
            int userID = Integer.parseInt(session.getAttribute("userID").toString());
            List<Images> images = imagesFacade.getImagesByUser(userID);
            int myTotalImage = images.size();
            request.setAttribute("myTotalImage", myTotalImage);
            request.setAttribute("myImages", images);
            request.getRequestDispatcher("userMyImage.jsp").forward(request, response);
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        List fileItemsList = null;
        float filesize = 0;
        String _fileLink = null;
        String _fileName = null;
        String _uploadDir;
        List error = new ArrayList();
        String title = null;
        String description = null;
        int collection = 0;
        int share = 0;
        int myTotalImage = 0;
        /*
         * Create upload dir by date
         */
        _uploadDir = getServletContext().getRealPath("/uploads/" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        String path = "/uploads/" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
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
                        if (fileItemTemp.getFieldName().equals("imageTitle")) {
                            title = fileItemTemp.getString();
                        }
                        if (fileItemTemp.getFieldName().equals("imageDesc")) {
                            description = fileItemTemp.getString();
                        }
                        if (fileItemTemp.getFieldName().equals("imageCollection")) {
                            collection = Integer.parseInt(fileItemTemp.getString());
                        }
                        if (fileItemTemp.getFieldName().equals("imagePrivacy")) {
                            share = Integer.parseInt(fileItemTemp.getString());
                        }
                        if (fileItemTemp.getFieldName().equals("myTotalImage")) {
                            myTotalImage = Integer.parseInt(fileItemTemp.getString());
                        }
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
                                _fileName = FormHelper.hashPassword(optionalFileName) + "." + FilenameUtils.getExtension(_fileName);
                            }
                            _fileLink = _uploadDir + "/" + _fileName;
                            try {
                                // Create folder if not exits
                                File folder = new File(_uploadDir + "/");
                                folder.mkdirs();
                                File file = new File(folder, _fileName);
                                fileItem.write(file);
                                if (myTotalImage < 35) {
                                    try {
                                        Images img = new Images();
                                        img.setTitle(title);
                                        img.setUserId(new Users((Integer) session.getAttribute("userID")));
                                        img.setCollectionId(new Collections(collection));
                                        img.setDescription(description);
                                        img.setFilename(_fileName);
                                        img.setPath(path);
                                        img.setShareStatus((short) share);
                                        img.setUploadDate(new java.sql.Date(System.currentTimeMillis()));
                                        imagesFacade.create(img);
                                        request.setAttribute("success", "Yes");
                                    } catch (Exception e) {
                                        error.add(e.getMessage());
                                    }
                                }else{
                                    error.add("You've reached limitation of 35 images.");
                                }
                            } catch (Exception e) {
                                error.add(e.getMessage());
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            error.add(e.getMessage());
        } finally {
        }
        if (error.isEmpty()) {
            request.setAttribute("redirectMessage", "Your image uploaded successful!<br>Back to previous page...");
            request.setAttribute("redirectLink", "MyImage");
            request.getRequestDispatcher("redirect.jsp").forward(request, response);
        }else{
            request.setAttribute("error", error);
            request.getRequestDispatcher("userMyImage.jsp").forward(request, response);
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
