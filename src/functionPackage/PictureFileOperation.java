package functionPackage;

import java.io.*;

public class PictureFileOperation {
    private static String path = "E:\\大二下\\软件开发\\project\\shareYourTravel\\web\\resources\\travel-images\\";
    private static String[] paths = {"large","medium","small","square-medium","square-small","square-tiny","thumb"};
    public static boolean save(String fileName,InputStream is){
        try {
            OutputStream[] outputStreams = new OutputStream[paths.length];
            for(int i = 0;i < paths.length;i++){
                outputStreams[i] = new FileOutputStream(path+paths[i]+"\\"+fileName);
            }
            byte b[] = new byte[1024];
            int length = 0;
            while (-1 != (length = is.read(b))) {
                for(OutputStream outputStream:outputStreams){
                    outputStream.write(b, 0, length);
                }
            }
            for(OutputStream outputStream:outputStreams){
                outputStream.flush();
                outputStream.close();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
