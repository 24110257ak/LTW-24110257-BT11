package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.CartItem_24110257;

public interface ICartItemDao_24110257 {
    void insert(CartItem_24110257 item);
    List<CartItem_24110257> findByCartId(String cartId);
}
