package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Category_24110257;

public interface ICategoryService_24110257 {
    void insert(Category_24110257 category);
    void update(Category_24110257 category);
    void delete(int id);
    Category_24110257 findById(int id);
    List<Category_24110257> findAll();
    List<Category_24110257> findAll(int page, int pageSize);
    long count();
    List<Category_24110257> search(String keyword);
    List<Category_24110257> search(String keyword, int page, int pageSize);
    long countSearch(String keyword);
}
