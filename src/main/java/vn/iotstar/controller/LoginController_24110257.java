package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.service.IUserService_24110257;
import vn.iotstar.service.impl.UserService_24110257;
import vn.iotstar.util.Constant_24110257;

@WebServlet(urlPatterns = {"/login"})
public class LoginController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110257 userService = new UserService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String msg = req.getParameter("msg");
        if ("activated".equals(msg)) {
            req.setAttribute("success", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
        }
        req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Users_24110257 user = userService.login(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute(Constant_24110257.SESSION_ACCOUNT, user);

            // Điều hướng theo vai trò (Admin -> /admin/categories, Seller -> /seller/home, User -> /home)
            if (user.getRoleId() != null && user.getRoleId() == 2) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            } else if ((user.getRoleId() != null && user.getRoleId() == 3) || user.getSellerId() != null) {
                resp.sendRedirect(req.getContextPath() + "/seller/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Sai tên đăng nhập, mật khẩu hoặc tài khoản chưa kích hoạt OTP!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
        }
    }
}
