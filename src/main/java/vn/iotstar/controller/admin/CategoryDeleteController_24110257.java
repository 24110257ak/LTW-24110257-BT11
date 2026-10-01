package vn.iotstar.controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;

@WebServlet(urlPatterns = {"/admin/category/delete"})
public class CategoryDeleteController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110257 categoryService = new CategoryService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                categoryService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
