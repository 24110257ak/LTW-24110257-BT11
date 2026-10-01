package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Cart_24110257;

public interface ICartDao_24110257 {
    void insert(Cart_24110257 cart);
    void update(Cart_24110257 cart);
    void delete(String cartId);
    Cart_24110257 findById(String cartId);
    List<Cart_24110257> findAll();
    List<Cart_24110257> findByUserId(int userId);
    List<Cart_24110257> findByUserIdAndStatus(int userId, int status);
    void updateStatus(String cartId, int status);
}
