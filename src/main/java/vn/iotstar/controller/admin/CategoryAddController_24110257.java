package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category_24110257;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/admin/category/add"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class CategoryAddController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110257 categoryService = new CategoryService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String categoryName = req.getParameter("categoryName");
        String statusStr = req.getParameter("status");

        Category_24110257 category = new Category_24110257();
        category.setCategoryName(categoryName);
        category.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);

        // Xử lý upload ảnh
        Part part = req.getPart("image");
        if (part != null && part.getSize() > 0) {
            String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String ext = "";
            int dotIdx = submittedFileName.lastIndexOf(".");
            if (dotIdx >= 0) {
                ext = submittedFileName.substring(dotIdx);
            }
            String newFileName = "cat_" + System.currentTimeMillis() + ext;

            File uploadDir = new File(Constant_24110257.getUploadDir());
            if (!uploadDir.exists()) uploadDir.mkdirs();

            part.write(Constant_24110257.getUploadDir() + File.separator + newFileName);
            category.setImages(newFileName);
        }

        categoryService.insert(category);
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
