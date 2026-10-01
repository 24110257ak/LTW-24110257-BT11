package vn.iotstar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Cart_24110257;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.service.ICartService_24110257;
import vn.iotstar.service.impl.CartService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/orders", "/orders/cancel"})
public class OrderHistoryController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICartService_24110257 cartService = new CartService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users_24110257 user = (Users_24110257) session.getAttribute(Constant_24110257.SESSION_ACCOUNT);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?msg=require_login");
            return;
        }

        String uri = req.getRequestURI();
        if (uri.endsWith("/orders/cancel")) {
            handleCancelOrder(req, resp, user);
            return;
        }

        handleViewOrders(req, resp, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void handleViewOrders(HttpServletRequest req, HttpServletResponse resp, Users_24110257 user)
            throws ServletException, IOException {
        int userId = user.getUserId();
        String statusParam = req.getParameter("status");

        // Lấy tất cả đơn hàng của user để đếm số lượng theo từng trạng thái
        List<Cart_24110257> allOrders = cartService.getOrdersByUserId(userId);
        Map<Integer, Integer> countByStatus = new HashMap<>();
        for (int i = 1; i <= 8; i++) {
            countByStatus.put(i, 0);
        }
        if (allOrders != null) {
            for (Cart_24110257 o : allOrders) {
                if (o.getStatus() != null && countByStatus.containsKey(o.getStatus())) {
                    countByStatus.put(o.getStatus(), countByStatus.get(o.getStatus()) + 1);
                }
            }
        }

        List<Cart_24110257> orders;
        Integer currentStatus = null;
        if (statusParam != null && !statusParam.trim().isEmpty() && !"all".equalsIgnoreCase(statusParam)) {
            try {
                currentStatus = Integer.parseInt(statusParam);
                orders = cartService.getOrdersByUserIdAndStatus(userId, currentStatus);
            } catch (NumberFormatException e) {
                orders = allOrders;
            }
        } else {
            orders = allOrders;
        }

        req.setAttribute("orders", orders);
        req.setAttribute("allOrdersCount", allOrders != null ? allOrders.size() : 0);
        req.setAttribute("countByStatus", countByStatus);
        req.setAttribute("currentStatus", currentStatus);

        req.getRequestDispatcher("/views/web/order-history.jsp").forward(req, resp);
    }

    private void handleCancelOrder(HttpServletRequest req, HttpServletResponse resp, Users_24110257 user)
            throws IOException {
        String orderId = req.getParameter("id");
        HttpSession session = req.getSession();

        if (orderId != null && !orderId.trim().isEmpty()) {
            boolean success = cartService.cancelOrder(orderId, user.getUserId());
            if (success) {
                session.setAttribute("orderSuccess", "Đã hủy đơn hàng #" + orderId + " thành công và hoàn trả số lượng vào kho!");
            } else {
                session.setAttribute("orderError", "Không thể hủy đơn hàng này (chỉ có thể hủy đơn khi ở trạng thái 'Đơn hàng mới')!");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/orders");
    }
}
