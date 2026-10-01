package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Seller_24110257;

public interface ISellerService_24110257 {
    void insert(Seller_24110257 seller);
    void update(Seller_24110257 seller);
    void delete(int id);
    Seller_24110257 findById(int id);
    List<Seller_24110257> findAll();
}
