package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Users_24110257;

public interface IUserService_24110257 {
    Users_24110257 login(String username, String password);
    boolean register(Users_24110257 user);
    boolean verifyOtp(String email, String otp);
    Users_24110257 findById(int id);
    Users_24110257 findByUsername(String username);
    Users_24110257 findByEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    void update(Users_24110257 user);
    List<Users_24110257> findAll();
}
