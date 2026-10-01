package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product_24110257;

public interface IProductDao_24110257 {
    void insert(Product_24110257 product);
    void update(Product_24110257 product);
    void delete(int id);
    Product_24110257 findById(int id);
    List<Product_24110257> findAll();
    List<Product_24110257> findAll(int page, int pageSize);
    long count();
    List<Product_24110257> findBySellerId(int sellerId);
    List<Product_24110257> search(String keyword);
    List<Product_24110257> search(String keyword, int page, int pageSize);
    long countSearch(String keyword);
}
