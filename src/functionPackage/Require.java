package functionPackage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Require {

    public static boolean requireStringNotEmpty(String ... strings){
        for(String string :strings){
            if(string == null || string.length() == 0) return false;
        }
        return true;
    }
}
