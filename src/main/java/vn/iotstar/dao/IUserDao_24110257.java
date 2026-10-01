package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Users_24110257;

public interface IUserDao_24110257 {
    void insert(Users_24110257 user);
    void update(Users_24110257 user);
    void delete(int id);
    Users_24110257 findById(int id);
    Users_24110257 findByUsername(String username);
    Users_24110257 findByEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    List<Users_24110257> findAll();
}
