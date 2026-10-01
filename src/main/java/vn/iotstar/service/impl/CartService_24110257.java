package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ICartDao_24110257;
import vn.iotstar.dao.ICartItemDao_24110257;
import vn.iotstar.dao.IProductDao_24110257;
import vn.iotstar.dao.impl.CartDao_24110257;
import vn.iotstar.dao.impl.CartItemDao_24110257;
import vn.iotstar.dao.impl.ProductDao_24110257;
import vn.iotstar.entity.CartItem_24110257;
import vn.iotstar.entity.Cart_24110257;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.service.ICartService_24110257;

public class CartService_24110257 implements ICartService_24110257 {

    private ICartDao_24110257 cartDao = new CartDao_24110257();
    private ICartItemDao_24110257 cartItemDao = new CartItemDao_24110257();
    private IProductDao_24110257 productDao = new ProductDao_24110257();

    @Override
    public void createOrder(Cart_24110257 cart, List<CartItem_24110257> items) {
        // 1. Lưu Cart
        cartDao.insert(cart);

        // 2. Lưu từng CartItem và cập nhật tồn kho sản phẩm
        if (items != null) {
            for (CartItem_24110257 item : items) {
                cartItemDao.insert(item);

                // Giảm tồn kho sản phẩm
                if (item.getProductId() != null) {
                    Product_24110257 product = productDao.findById(item.getProductId());
                    if (product != null) {
                        int qty = (item.getQuantity() != null) ? item.getQuantity() : 0;
                        if (product.getStock() != null) {
                            product.setStock(Math.max(0, product.getStock() - qty));
                        }
                        productDao.update(product);
                    }
                }
            }
        }
    }

    @Override
    public Cart_24110257 findById(String cartId) {
        return cartDao.findById(cartId);
    }

    @Override
    public List<Cart_24110257> getOrdersByUserId(int userId) {
        return cartDao.findByUserId(userId);
    }

    @Override
    public List<Cart_24110257> getOrdersByUserIdAndStatus(int userId, int status) {
        return cartDao.findByUserIdAndStatus(userId, status);
    }

    @Override
    public void updateOrderStatus(String cartId, int status) {
        cartDao.updateStatus(cartId, status);
    }

    @Override
    public boolean cancelOrder(String cartId, int userId) {
        Cart_24110257 cart = cartDao.findById(cartId);
        if (cart != null && cart.getUserId() != null && cart.getUserId() == userId) {
            // Chỉ cho phép hủy khi đơn hàng mới (status == 1)
            if (cart.getStatus() != null && cart.getStatus() == 1) {
                // Đổi trạng thái sang 7: Đơn hàng hủy
                cartDao.updateStatus(cartId, 7);

                // Hoàn lại tồn kho cho sản phẩm
                List<CartItem_24110257> items = cart.getItems();
                if (items == null || items.isEmpty()) {
                    items = cartItemDao.findByCartId(cartId);
                }

                if (items != null) {
                    for (CartItem_24110257 item : items) {
                        if (item.getProductId() != null) {
                            Product_24110257 prod = productDao.findById(item.getProductId());
                            if (prod != null) {
                                int qty = (item.getQuantity() != null) ? item.getQuantity() : 0;
                                if (prod.getStock() != null) {
                                    prod.setStock(prod.getStock() + qty);
                                }
                                productDao.update(prod);
                            }
                        }
                    }
                }
                return true;
            }
        }
        return false;
    }
}
