package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.CartItem_24110257;
import vn.iotstar.entity.Cart_24110257;

public interface ICartService_24110257 {
    void createOrder(Cart_24110257 cart, List<CartItem_24110257> items);
    Cart_24110257 findById(String cartId);
    List<Cart_24110257> getOrdersByUserId(int userId);
    List<Cart_24110257> getOrdersByUserIdAndStatus(int userId, int status);
    void updateOrderStatus(String cartId, int status);
    boolean cancelOrder(String cartId, int userId);
}
