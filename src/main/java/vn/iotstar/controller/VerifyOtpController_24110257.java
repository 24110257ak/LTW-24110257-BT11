package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IUserService_24110257;
import vn.iotstar.service.impl.UserService_24110257;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24110257 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IUserService_24110257 userService = new UserService_24110257();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        boolean verified = userService.verifyOtp(email, otp);

        if (verified) {
            resp.sendRedirect(req.getContextPath() + "/login?msg=activated");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn! Vui lòng thử lại.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
        }
    }
}
