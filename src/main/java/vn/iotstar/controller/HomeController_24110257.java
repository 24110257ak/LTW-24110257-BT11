package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category_24110257;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;

@WebServlet(urlPatterns = {"/home"})
public class HomeController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService_24110257 productService = new ProductService_24110257();
    private ICategoryService_24110257 categoryService = new CategoryService_24110257();
    private ISellerService_24110257 sellerService = new SellerService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product_24110257> productList = productService.findAll();
        List<Category_24110257> categoryList = categoryService.findAll();
        List<Seller_24110257> sellerList = sellerService.findAll();

        req.setAttribute("productList", productList);
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("sellerList", sellerList);

        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}
