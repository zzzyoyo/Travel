package functionPackage;

import java.io.*;

public class PictureFileOperation {
    private static String path = "resources\\travel-images\\";
    private static String[] paths = {"large","medium","small","square-medium","square-small","square-tiny","thumb"};
    public static boolean save(String contextRealPath, String fileName,InputStream is){
        try {
            OutputStream[] outputStreams = new OutputStream[paths.length];
            for(int i = 0;i < paths.length;i++){
                outputStreams[i] = new FileOutputStream(contextRealPath+path+paths[i]+"\\"+fileName);
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

    public static boolean delete(String contextRealPath,String fileName){
        for(int i = 0; i < paths.length; i++){
            File file = new File(contextRealPath+path+paths[i]+"\\"+fileName);
            if (file.isFile() && file.exists()){
                if(!file.delete()){
                    return false;
                }
            }
            else {
                System.out.println("no file or path is not file"+file.toString());
                return false;
            }
        }
        return true;
    }
//    public static void main(String args[]){
//        System.out.println(delete("logo.PNG"));
//    }
}

