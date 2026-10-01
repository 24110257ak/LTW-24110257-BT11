package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ICategoryDao_24110257;
import vn.iotstar.dao.impl.CategoryDao_24110257;
import vn.iotstar.entity.Category_24110257;
import vn.iotstar.service.ICategoryService_24110257;

public class CategoryService_24110257 implements ICategoryService_24110257 {
    private ICategoryDao_24110257 categoryDao = new CategoryDao_24110257();

    @Override
    public void insert(Category_24110257 category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category_24110257 category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category_24110257 findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category_24110257> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category_24110257> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public long count() {
        return categoryDao.count();
    }

    @Override
    public List<Category_24110257> search(String keyword) {
        return categoryDao.search(keyword);
    }

    @Override
    public List<Category_24110257> search(String keyword, int page, int pageSize) {
        return categoryDao.search(keyword, page, pageSize);
    }

    @Override
    public long countSearch(String keyword) {
        return categoryDao.countSearch(keyword);
    }
}
