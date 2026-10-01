package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category_24110257;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;

@WebServlet(urlPatterns = {"/admin/categories", "/admin/category/list"})
public class CategoryListController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110257 categoryService = new CategoryService_24110257();
    private static final int PAGE_SIZE = 3; // Phân trang mỗi trang 3 danh mục

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {
            }
        }

        String keyword = req.getParameter("keyword");
        List<Category_24110257> categoryList;
        long totalCount;

        if (keyword != null && !keyword.trim().isEmpty()) {
            keyword = keyword.trim();
            categoryList = categoryService.search(keyword, page, PAGE_SIZE);
            totalCount = categoryService.countSearch(keyword);
        } else {
            categoryList = categoryService.findAll(page, PAGE_SIZE);
            totalCount = categoryService.count();
        }

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;

        req.setAttribute("categoryList", categoryList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", totalCount);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
    }
}
