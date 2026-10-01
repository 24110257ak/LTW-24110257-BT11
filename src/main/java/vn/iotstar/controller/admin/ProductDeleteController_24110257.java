package vn.iotstar.controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;

@WebServlet(urlPatterns = {"/admin/product/delete"})
public class ProductDeleteController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService_24110257 productService = new ProductService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
