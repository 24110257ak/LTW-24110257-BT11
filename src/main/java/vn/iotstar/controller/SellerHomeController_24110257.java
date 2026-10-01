package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/seller/home"})
public class SellerHomeController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ISellerService_24110257 sellerService = new SellerService_24110257();
    private IProductService_24110257 productService = new ProductService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users_24110257 user = (Users_24110257) session.getAttribute(Constant_24110257.SESSION_ACCOUNT);

        Seller_24110257 seller = null;
        List<Product_24110257> productList = null;

        if (user != null && user.getSellerId() != null) {
            seller = sellerService.findById(user.getSellerId());
            productList = productService.findBySellerId(user.getSellerId());
        } else {
            // Mặc định nạp Seller 1 cho chế độ xem hoặc kiểm thử
            seller = sellerService.findById(1);
            if (seller != null) {
                productList = productService.findBySellerId(1);
            }
        }

        req.setAttribute("seller", seller);
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/views/seller/home.jsp").forward(req, resp);
    }
}
