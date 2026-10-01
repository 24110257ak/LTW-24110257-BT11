package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import org.apache.commons.io.IOUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/image"})
public class ImageController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname = req.getParameter("fname");
        if (fname == null || fname.trim().isEmpty()) {
            sendPlaceholder(resp, "No Image");
            return;
        }

        File file = new File(Constant_24110257.getUploadDir(), fname);
        if (!file.exists()) {
            file = new File(Constant_24110257.FALLBACK_UPLOAD_DIR, fname);
        }
        if (!file.exists()) {
            // Check subfolders in uploads: category, product, user
            file = new File(Constant_24110257.getUploadDir() + "/product", fname);
        }
        if (!file.exists()) {
            file = new File(Constant_24110257.getUploadDir() + "/category", fname);
        }

        if (file.exists() && file.isFile()) {
            String mime = getServletContext().getMimeType(file.getName());
            if (mime == null) {
                mime = "image/jpeg";
            }
            resp.setContentType(mime);
            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = resp.getOutputStream()) {
                IOUtils.copy(in, out);
            }
        } else {
            sendPlaceholder(resp, fname);
        }
    }

    private void sendPlaceholder(HttpServletResponse resp, String text) throws IOException {
        resp.setContentType("image/svg+xml;charset=UTF-8");
        String cleanText = text.replaceAll("[^a-zA-Z0-9_.-]", " ");
        if (cleanText.length() > 20) {
            cleanText = cleanText.substring(0, 20) + "...";
        }
        String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='240' height='180' viewBox='0 0 240 180'>"
                + "<rect width='100%' height='100%' fill='#f1f5f9'/>"
                + "<circle cx='120' cy='70' r='30' fill='#cbd5e1'/>"
                + "<path d='M60 140 C80 110, 160 110, 180 140' fill='#94a3b8'/>"
                + "<text x='50%' y='160' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='13' fill='#475569'>"
                + cleanText + "</text>"
                + "</svg>";
        resp.getOutputStream().write(svg.getBytes("UTF-8"));
    }
}
