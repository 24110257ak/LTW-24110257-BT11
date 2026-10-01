package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.UserRole_24110257;

public interface IRoleDao_24110257 {
    UserRole_24110257 findById(int id);
    List<UserRole_24110257> findAll();
}
