package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;

@WebServlet(urlPatterns = {"/admin/products", "/admin/product/list"})
public class ProductListController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService_24110257 productService = new ProductService_24110257();
    private static final int PAGE_SIZE = 4; // Phân trang mỗi trang 4 sản phẩm

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
        List<Product_24110257> productList;
        long totalCount;

        if (keyword != null && !keyword.trim().isEmpty()) {
            keyword = keyword.trim();
            productList = productService.search(keyword, page, PAGE_SIZE);
            totalCount = productService.countSearch(keyword);
        } else {
            productList = productService.findAll(page, PAGE_SIZE);
            totalCount = productService.count();
        }

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;

        req.setAttribute("productList", productList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", totalCount);
        req.setAttribute("keyword", keyword);

        req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
    }
}
