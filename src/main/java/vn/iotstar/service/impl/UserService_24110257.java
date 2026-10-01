package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IUserDao_24110257;
import vn.iotstar.dao.impl.UserDao_24110257;
import vn.iotstar.entity.Users_24110257;
import vn.iotstar.service.IUserService_24110257;
import vn.iotstar.util.EmailUtil_24110257;

public class UserService_24110257 implements IUserService_24110257 {
    private IUserDao_24110257 userDao = new UserDao_24110257();

    @Override
    public Users_24110257 login(String username, String password) {
        Users_24110257 user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            // Kiểm tra trạng thái đã kích hoạt
            if (user.getStatus() != null && user.getStatus() == 1) {
                return user;
            }
        }
        return null;
    }

    @Override
    public boolean register(Users_24110257 user) {
        if (userDao.checkExistUsername(user.getUsername()) || userDao.checkExistEmail(user.getEmail())) {
            return false;
        }

        // Tạo mã OTP 6 số ngẫu nhiên
        String otp = EmailUtil_24110257.generateOtp(6);
        user.setCode(otp);
        user.setStatus(0); // Chưa kích hoạt
        if (user.getRoleId() == null) {
            user.setRoleId(1); // Mặc định ROLE_USER
        }

        userDao.insert(user);

        // Gửi email OTP
        new Thread(() -> {
            EmailUtil_24110257.sendOtpEmail(user.getEmail(), otp, "Kích hoạt tài khoản");
        }).start();

        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        Users_24110257 user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otp.trim())) {
            user.setStatus(1); // Đã kích hoạt
            user.setCode(null); // Xóa OTP sau khi dùng
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public Users_24110257 findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public Users_24110257 findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public Users_24110257 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public void update(Users_24110257 user) {
        userDao.update(user);
    }

    @Override
    public List<Users_24110257> findAll() {
        return userDao.findAll();
    }
}
