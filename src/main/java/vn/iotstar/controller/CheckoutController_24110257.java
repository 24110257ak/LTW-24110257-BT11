package vn.iotstar.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.CartItem_24110257;
import vn.iotstar.entity.Cart_24110257;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.model.CartItemModel_24110257;
import vn.iotstar.service.ICartService_24110257;
import vn.iotstar.service.impl.CartService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/checkout", "/checkout/success"})
public class CheckoutController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICartService_24110257 cartService = new CartService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        HttpSession session = req.getSession();
        Users_24110257 user = (Users_24110257) session.getAttribute(Constant_24110257.SESSION_ACCOUNT);

        if (user == null) {
            // Yêu cầu đăng nhập trước khi thanh toán
            resp.sendRedirect(req.getContextPath() + "/login?msg=require_login");
            return;
        }

        if (uri.endsWith("/checkout/success")) {
            String orderId = req.getParameter("orderId");
            Cart_24110257 order = cartService.findById(orderId);
            req.setAttribute("order", order);
            req.getRequestDispatcher("/views/web/checkout-success.jsp").forward(req, resp);
            return;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartWarning", "Giỏ hàng của bạn đang trống, vui lòng chọn sản phẩm trước khi thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double totalAmount = 0.0;
        int totalQuantity = 0;
        for (CartItemModel_24110257 item : cart.values()) {
            totalAmount += item.getTotalPrice();
            totalQuantity += item.getQuantity();
        }

        req.setAttribute("user", user);
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("totalQuantity", totalQuantity);
        req.getRequestDispatcher("/views/web/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        Users_24110257 user = (Users_24110257) session.getAttribute(Constant_24110257.SESSION_ACCOUNT);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?msg=require_login");
            return;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItemModel_24110257> cart = (Map<Integer, CartItemModel_24110257>) session.getAttribute(Constant_24110257.SESSION_CART);

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        // Tạo mã đơn hàng duy nhất
        String cartId = "ORD" + System.currentTimeMillis();

        Cart_24110257 order = new Cart_24110257();
        order.setCartId(cartId);
        order.setUserId(user.getUserId());
        order.setBuyDate(new Date());
        order.setStatus(1); // 1: Đơn hàng mới theo quy định đề thi

        List<CartItem_24110257> items = new ArrayList<>();
        for (CartItemModel_24110257 model : cart.values()) {
            CartItem_24110257 item = new CartItem_24110257();
            item.setCartItemId(UUID.randomUUID().toString());
            item.setCartId(cartId);
            item.setProductId(model.getProduct().getProductId());
            item.setQuantity(model.getQuantity());
            item.setUnitPrice(model.getUnitPrice());
            items.add(item);
        }

        // Thực hiện tạo đơn hàng và cập nhật tồn kho qua CartService
        cartService.createOrder(order, items);

        // Lưu thông tin người nhận vào session tạm để hiển thị trang success nếu cần
        session.setAttribute("order_receiver_name", fullname);
        session.setAttribute("order_receiver_phone", phone);
        session.setAttribute("order_receiver_address", address);
        session.setAttribute("order_receiver_note", note);

        // Xóa giỏ hàng trong session
        session.removeAttribute(Constant_24110257.SESSION_CART);

        // Điều hướng tới trang thông báo đặt hàng thành công
        resp.sendRedirect(req.getContextPath() + "/checkout/success?orderId=" + cartId);
    }
}
