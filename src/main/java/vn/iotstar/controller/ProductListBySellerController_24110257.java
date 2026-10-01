package vn.iotstar.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;

@WebServlet(urlPatterns = {"/products-by-seller", "/products"})
public class ProductListBySellerController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ISellerService_24110257 sellerService = new SellerService_24110257();
    private IProductService_24110257 productService = new ProductService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Seller_24110257> sellerList = sellerService.findAll();
        Map<Seller_24110257, List<Product_24110257>> sellerProductMap = new LinkedHashMap<>();

        for (Seller_24110257 seller : sellerList) {
            List<Product_24110257> products = productService.findBySellerId(seller.getSellerId());
            sellerProductMap.put(seller, products);
        }

        req.setAttribute("sellerProductMap", sellerProductMap);
        req.getRequestDispatcher("/views/web/products-by-seller.jsp").forward(req, resp);
    }
}
