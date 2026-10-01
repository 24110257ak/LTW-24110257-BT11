package vn.iotstar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.model.CartItemModel_24110257;
import vn.iotstar.service.IProductService_24110257;
import vn.iotstar.service.impl.ProductService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove", "/cart/clear"})
public class CartController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IProductService_24110257 productService = new ProductService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/cart/add")) {
            handleAddCart(req, resp);
        } else if (uri.endsWith("/cart/update")) {
            handleUpdateCart(req, resp);
        } else if (uri.endsWith("/cart/remove")) {
            handleRemoveCart(req, resp);
        } else if (uri.endsWith("/cart/clear")) {
            handleClearCart(req, resp);
        } else {
            handleViewCart(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void handleViewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        double totalAmount = 0.0;
        int totalQuantity = 0;

        if (cart != null) {
            for (CartItemModel_24110257 item : cart.values()) {
                totalAmount += item.getTotalPrice();
                totalQuantity += item.getQuantity();
            }
        }

        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("totalQuantity", totalQuantity);
        req.getRequestDispatcher("/views/web/cart.jsp").forward(req, resp);
    }

    private void handleAddCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(Constant_24110257.SESSION_CART, cart);
        }

        int productId = 0;
        int quantity = 1;
        try {
            productId = Integer.parseInt(req.getParameter("productId"));
        } catch (Exception ignored) {}

        try {
            if (req.getParameter("quantity") != null) {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            }
        } catch (Exception ignored) {}

        if (quantity < 1) quantity = 1;

        Product_24110257 product = productService.findById(productId);
        if (product == null) {
            session.setAttribute("cartError", "Sản phẩm không tồn tại!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        int stock = (product.getStock() != null) ? product.getStock() : 0;
        if (stock <= 0) {
            session.setAttribute("cartError", "Sản phẩm \"" + product.getProductName() + "\" hiện tại đã hết hàng!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if (cart.containsKey(productId)) {
            CartItemModel_24110257 existingItem = cart.get(productId);
            int newQty = existingItem.getQuantity() + quantity;
            if (newQty > stock) {
                existingItem.setQuantity(stock);
                session.setAttribute("cartWarning", "Đã đạt giới hạn số lượng tồn kho (" + stock + ") của sản phẩm \"" + product.getProductName() + "\"!");
            } else {
                existingItem.setQuantity(newQty);
                session.setAttribute("cartSuccess", "Đã tăng số lượng sản phẩm \"" + product.getProductName() + "\" trong giỏ hàng!");
            }
        } else {
            if (quantity > stock) {
                quantity = stock;
                session.setAttribute("cartWarning", "Chỉ có thể thêm tối đa " + stock + " sản phẩm theo tồn kho!");
            } else {
                session.setAttribute("cartSuccess", "Đã thêm \"" + product.getProductName() + "\" vào giỏ hàng thành công!");
            }
            double price = (product.getPrice() != null) ? product.getPrice() : 0.0;
            cart.put(productId, new CartItemModel_24110257(product, quantity, price));
        }

        String action = req.getParameter("action");
        if ("buynow".equalsIgnoreCase(action)) {
            resp.sendRedirect(req.getContextPath() + "/checkout");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleUpdateCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        if (cart != null) {
            int productId = 0;
            try {
                productId = Integer.parseInt(req.getParameter("productId"));
            } catch (Exception ignored) {}

            String type = req.getParameter("type"); // inc, dec
            String qtyParam = req.getParameter("quantity");

            if (cart.containsKey(productId)) {
                CartItemModel_24110257 item = cart.get(productId);
                Product_24110257 product = productService.findById(productId);
                int stock = (product != null && product.getStock() != null) ? product.getStock() : 999;

                if ("inc".equalsIgnoreCase(type)) {
                    if (item.getQuantity() + 1 <= stock) {
                        item.setQuantity(item.getQuantity() + 1);
                        session.setAttribute("cartSuccess", "Đã tăng số lượng sản phẩm!");
                    } else {
                        session.setAttribute("cartWarning", "Không thể tăng thêm! Đã đạt giới hạn tồn kho (" + stock + ").");
                    }
                } else if ("dec".equalsIgnoreCase(type)) {
                    if (item.getQuantity() - 1 >= 1) {
                        item.setQuantity(item.getQuantity() - 1);
                        session.setAttribute("cartSuccess", "Đã giảm số lượng sản phẩm!");
                    } else {
                        cart.remove(productId);
                        session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
                    }
                } else if (qtyParam != null) {
                    try {
                        int q = Integer.parseInt(qtyParam);
                        if (q <= 0) {
                            cart.remove(productId);
                            session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
                        } else if (q > stock) {
                            item.setQuantity(stock);
                            session.setAttribute("cartWarning", "Số lượng điều chỉnh vượt quá tồn kho. Đã đặt về tối đa " + stock + "!");
                        } else {
                            item.setQuantity(q);
                            session.setAttribute("cartSuccess", "Đã cập nhật số lượng thành công!");
                        }
                    } catch (NumberFormatException ignored) {}
                }
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleRemoveCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        if (cart != null) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cart.remove(productId);
                session.setAttribute("cartSuccess", "Đã xóa sản phẩm khỏi giỏ hàng!");
            } catch (Exception ignored) {}
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleClearCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        if (cart != null) {
            cart.clear();
            session.setAttribute("cartSuccess", "Đã xóa toàn bộ giỏ hàng!");
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
