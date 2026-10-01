package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.IProductDao_24110257;
import vn.iotstar.dao.impl.ProductDao_24110257;
import vn.iotstar.entity.Product_24110257;
import vn.iotstar.service.IProductService_24110257;

public class ProductService_24110257 implements IProductService_24110257 {
    private IProductDao_24110257 productDao = new ProductDao_24110257();

    @Override
    public void insert(Product_24110257 product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product_24110257 product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product_24110257 findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product_24110257> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product_24110257> findAll(int page, int pageSize) {
        return productDao.findAll(page, pageSize);
    }

    @Override
    public long count() {
        return productDao.count();
    }

    @Override
    public List<Product_24110257> findBySellerId(int sellerId) {
        return productDao.findBySellerId(sellerId);
    }

    @Override
    public List<Product_24110257> search(String keyword) {
        return productDao.search(keyword);
    }

    @Override
    public List<Product_24110257> search(String keyword, int page, int pageSize) {
        return productDao.search(keyword, page, pageSize);
    }

    @Override
    public long countSearch(String keyword) {
        return productDao.countSearch(keyword);
    }
}
