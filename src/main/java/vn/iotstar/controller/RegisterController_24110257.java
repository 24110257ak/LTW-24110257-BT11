package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.service.ISellerService_24110257;
import vn.iotstar.service.IUserService_24110257;
import vn.iotstar.service.impl.SellerService_24110257;
import vn.iotstar.service.impl.UserService_24110257;

@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110257 userService = new UserService_24110257();
    private ISellerService_24110257 sellerService = new SellerService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Seller_24110257> sellerList = sellerService.findAll();
        req.setAttribute("sellerList", sellerList);
        req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String roleStr = req.getParameter("roleId");
        String sellerStr = req.getParameter("sellerId");

        Users_24110257 user = new Users_24110257();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setPhone(phone);

        int roleId = 1; // Mặc định USER
        if (roleStr != null && !roleStr.isEmpty()) {
            roleId = Integer.parseInt(roleStr);
        }
        user.setRoleId(roleId);

        if (sellerStr != null && !sellerStr.isEmpty()) {
            user.setSellerId(Integer.parseInt(sellerStr));
        }

        boolean success = userService.register(user);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + URLEncoder.encode(email, "UTF-8"));
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc Email đã tồn tại trong hệ thống!");
            req.setAttribute("user", user);
            req.setAttribute("sellerList", sellerService.findAll());
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
        }
    }
}
