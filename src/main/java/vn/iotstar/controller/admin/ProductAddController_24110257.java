package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category_24110257;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.service.ICategoryService_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.impl.CategoryService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/admin/product/add"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProductAddController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService_24110257 productService = new ProductService_24110257();
    private ICategoryService_24110257 categoryService = new CategoryService_24110257();
    private ISellerService_24110257 sellerService = new SellerService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category_24110257> categoryList = categoryService.findAll();
        List<Seller_24110257> sellerList = sellerService.findAll();

        req.setAttribute("categoryList", categoryList);
        req.setAttribute("sellerList", sellerList);
        req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String productName = req.getParameter("productName");
        String productCodeStr = req.getParameter("productCode");
        String categoryIdStr = req.getParameter("categoryId");
        String sellerIdStr = req.getParameter("sellerId");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String amountStr = req.getParameter("amount");
        String stockStr = req.getParameter("stock");
        String statusStr = req.getParameter("status");

        Product_24110257 product = new Product_24110257();
        product.setProductName(productName);
        if (productCodeStr != null && !productCodeStr.isEmpty()) product.setProductCode(Long.parseLong(productCodeStr));
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) product.setCategoryId(Integer.parseInt(categoryIdStr));
        if (sellerIdStr != null && !sellerIdStr.isEmpty()) product.setSellerId(Integer.parseInt(sellerIdStr));
        product.setDescription(description);
        if (priceStr != null && !priceStr.isEmpty()) product.setPrice(Double.parseDouble(priceStr));
        if (amountStr != null && !amountStr.isEmpty()) product.setAmount(Integer.parseInt(amountStr));
        if (stockStr != null && !stockStr.isEmpty()) product.setStock(Integer.parseInt(stockStr));
        product.setStatus(statusStr != null ? Integer.parseInt(statusStr) : 1);
        product.setCreateDate(new Date());
        product.setWishlist(0);

        // Upload ảnh
        Part part = req.getPart("image");
        if (part != null && part.getSize() > 0) {
            String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String ext = "";
            int dotIdx = submittedFileName.lastIndexOf(".");
            if (dotIdx >= 0) {
                ext = submittedFileName.substring(dotIdx);
            }
            String newFileName = "prod_" + System.currentTimeMillis() + ext;

            File uploadDir = new File(Constant_24110257.getUploadDir());
            if (!uploadDir.exists()) uploadDir.mkdirs();

            part.write(Constant_24110257.getUploadDir() + File.separator + newFileName);
            product.setImages(newFileName);
        }

        productService.insert(product);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
