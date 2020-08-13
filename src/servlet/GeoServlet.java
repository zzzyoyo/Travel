package servlet;

import com.alibaba.fastjson.JSONObject;
import dao.GeoDao;
import dao.PictureDao;
import domain.GeoInformation;
import domain.Picture;
import functionPackage.Require;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

@WebServlet(name = "GeoServlet",urlPatterns = {"*.geo"})
public class GeoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String methodName = request.getServletPath().substring(1,request.getServletPath().indexOf('.'));
        try {
            Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this,request,response);
        } catch (NoSuchMethodException e) {
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

    private void allCountries(HttpServletRequest request, HttpServletResponse response) throws IOException{
        JSONObject jsonObject = new JSONObject();
        GeoDao geoDao = new GeoDao();
        List<GeoInformation> countries = geoDao.getAllCountries();
        jsonObject.put("countries",countries);
        response.getWriter().println(jsonObject);
    }
    private void cities(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if(!Require.requireStringNotEmpty(request.getParameter("countryID"))){
            request.getRequestDispatcher("/WEB-INF/jspFiles/error.jsp?message= required parameters are not provided").forward(request,response);
            return;
        }
        String countryID = request.getParameter("countryID");
        JSONObject jsonObject = new JSONObject();
        GeoDao geoDao = new GeoDao();
        List<GeoInformation> cities = geoDao.getCitiesByCountryID(countryID);
        jsonObject.put("cities",cities);
        response.getWriter().println(jsonObject);
    }

}
