package vn.iotstar.util;

import java.io.File;

public class Constant_24110257 {
    public static final String SESSION_ACCOUNT = "account";
    public static final String SESSION_CART = "cart";
    public static final String UPLOAD_DIR = "D:/lap_trinh_web/KT quá trình 24092026/uploads";
    public static final String FALLBACK_UPLOAD_DIR = "D:/upload/images";

    public static String getUploadDir() {
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return UPLOAD_DIR;
    }
}
