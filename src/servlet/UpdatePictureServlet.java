package servlet;

import dao.DetailedPictureDao;
import dao.PictureDao;
import domain.DetailedPicture;
import functionPackage.ReflectionUtils;
import functionPackage.PictureFileOperation;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "UpdatePictureServlet",urlPatterns = {"*.update"})
public class UpdatePictureServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //中文乱码问题
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");

        String methodName = request.getServletPath().substring(1,request.getServletPath().indexOf('.'));
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this,request,response);
        } catch (NoSuchMethodException e) {
            response.getWriter().println("invalid method");
            System.out.println("no method: "+methodName);
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= Do not support GET method").forward(request,response);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        System.out.println("add");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        boolean isSaved = false;

        factory.setSizeThreshold(1024 * 1024);
        List<FileItem> items = null;

        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        Map<String, Object> values = new HashMap<>();
        for(FileItem item:items){
            if(!item.isFormField()){
                //获得文件名
//                String fileName = item.getName();
                //防止文件名重复
                String initName = item.getName();
                initName = initName.substring(initName.lastIndexOf('.'));//后缀名
                String fileName = String.valueOf(new Date().getTime())+initName;
                values.put("path",fileName);
                // 保存文件
                isSaved = PictureFileOperation.save(request.getServletContext().getRealPath("/"),fileName,item.getInputStream());
            }
            else {
                String fieldName = item.getFieldName();
                Object value = item.getString();
                value = new String( ((String)value).getBytes("ISO-8859-1"), "UTF-8");
                if (fieldName.equals("cityId") || fieldName.equals("uid")) value = Integer.parseInt((String)value);
                values.put(fieldName,value);
            }
        }

        if(isSaved){
            DetailedPicture detailedPicture = new DetailedPicture();
            //若 Map 不为空集, 利用反射创建 clazz 对应的对象
            if(values.size()>0){
                for(Map.Entry<String, Object> entry: values.entrySet()){
                    String fieldName = entry.getKey();
                    Object value = entry.getValue();
                    ReflectionUtils.setFieldValue(detailedPicture, fieldName, value);
                }
            }
            DetailedPictureDao detailedPictureDao = new DetailedPictureDao();
            if(detailedPictureDao.savePicture(detailedPicture)){
                request.getRequestDispatcher("/update.jsp?successMessage= Upload successfully").forward(request,response);
            }
            else {
                request.getRequestDispatcher(request.getContextPath()+"/update.jsp?failureMessage= Fail to upload").forward(request,response);
            }
        }

    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        System.out.println("delete");
        int imageID = Integer.parseInt(request.getParameter("imageID"));
        PictureDao pictureDao = new PictureDao();
        String fileName = pictureDao.getPathByImageID(imageID);
        if(pictureDao.deletePictureByImageID(imageID) &&
                PictureFileOperation.delete(request.getServletContext().getRealPath("/"),fileName)){
            response.getWriter().println("success");
        }
        else {
            response.getWriter().println("error");
        }
    }

    private void set(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        System.out.println("set");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        boolean isOK = false;

        factory.setSizeThreshold(1024 * 1024);
        List<FileItem> items = null;

        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        Map<String, Object> values = new HashMap<>();
        FileItem pictureItem = null;
        String oldFileName = null;
        for(FileItem item:items){
            if(!item.isFormField()){
//                System.out.println(item);
                pictureItem = item;
            }
            else {
                String fieldName = item.getFieldName();
                String value = item.getString();
                value = new String( value.getBytes("ISO-8859-1"), "UTF-8");
//                System.out.println(fieldName+value);
                if(fieldName.equals("oldFileName")){
                    oldFileName = value;
                }
                else{
                    //java bean property
                    if (fieldName.equals("cityId") || fieldName.equals("uid")||fieldName.equals("id")){
                        values.put(fieldName,Integer.parseInt(value));
                    }
                    else {
                        values.put(fieldName,value);
                    }
                }
            }
        }
        //全部遍历完之后再进行文件操作
        if( pictureItem.getSize() == 0){
            //没有上传文件
            isOK = true;
            values.put("path",oldFileName);
        }
        else {
            //上传了文件
            //防止文件名重复
            String initName = pictureItem.getName();
            initName = initName.substring(initName.lastIndexOf('.'));//后缀名
            String fileName = new Date().getTime()+initName;
            values.put("path",fileName);
            // 保存和删除文件
            isOK = PictureFileOperation.save(request.getServletContext().getRealPath("/"),fileName,pictureItem.getInputStream())
                    && PictureFileOperation.delete(request.getServletContext().getRealPath("/"),oldFileName);
        }

        if(isOK){
            DetailedPicture detailedPicture = new DetailedPicture();
            //若 Map 不为空集, 利用反射创建 clazz 对应的对象
            if(values.size()>0){
                for(Map.Entry<String, Object> entry: values.entrySet()){
                    String fieldName = entry.getKey();
                    Object value = entry.getValue();
                    ReflectionUtils.setFieldValue(detailedPicture, fieldName, value);
                }
            }
            DetailedPictureDao detailedPictureDao = new DetailedPictureDao();
            if(detailedPictureDao.setPicture(detailedPicture)){
                request.getRequestDispatcher("/update.jsp?successMessage= Modify successfully").forward(request,response);
                return;
            }
        }
        request.getRequestDispatcher(request.getContextPath()+"/update.jsp?failureMessage= Fail to modify").forward(request,response);
    }
}
