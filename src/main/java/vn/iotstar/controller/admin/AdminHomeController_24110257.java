package vn.iotstar.controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.IUserService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;
import vn.iotstar.service.impl.UserService_24110257;

@WebServlet(urlPatterns = {"/admin/home", "/admin"})
public class AdminHomeController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICategoryService_24110257 categoryService = new CategoryService_24110257();
    private IProductService_24110257 productService = new ProductService_24110257();
    private IUserService_24110257 userService = new UserService_24110257();
    private ISellerService_24110257 sellerService = new SellerService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categoryCount", categoryService.count());
        req.setAttribute("productCount", productService.count());
        req.setAttribute("userCount", userService.findAll().size());
        req.setAttribute("sellerCount", sellerService.findAll().size());

        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}
