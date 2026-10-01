package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ISellerDao_24110257;
import vn.iotstar.dao.impl.SellerDao_24110257;
import vn.iotstar.entity.Seller_24110257;
import vn.iotstar.service.ISellerService_24110257;

public class SellerService_24110257 implements ISellerService_24110257 {
    private ISellerDao_24110257 sellerDao = new SellerDao_24110257();

    @Override
    public void insert(Seller_24110257 seller) {
        sellerDao.insert(seller);
    }

    @Override
    public void update(Seller_24110257 seller) {
        sellerDao.update(seller);
    }

    @Override
    public void delete(int id) {
        sellerDao.delete(id);
    }

    @Override
    public Seller_24110257 findById(int id) {
        return sellerDao.findById(id);
    }

    @Override
    public List<Seller_24110257> findAll() {
        return sellerDao.findAll();
    }
}
