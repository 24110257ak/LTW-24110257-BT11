package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.ICategoryDao_24110257;
import vn.iotstar.entity.Category_24110257;

public class CategoryDao_24110257 implements ICategoryDao_24110257 {

    @Override
    public void insert(Category_24110257 category) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category_24110257 category) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category_24110257 cat = em.find(Category_24110257.class, id);
            if (cat != null) {
                em.remove(cat);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Category_24110257 findById(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(Category_24110257.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Category_24110257> query = em.createQuery("SELECT c FROM Category_24110257 c ORDER BY c.categoryId DESC", Category_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110257> findAll(int page, int pageSize) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Category_24110257> query = em.createQuery("SELECT c FROM Category_24110257 c ORDER BY c.categoryId DESC", Category_24110257.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(c) FROM Category_24110257 c", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110257> search(String keyword) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Category_24110257> query = em.createQuery("SELECT c FROM Category_24110257 c WHERE c.categoryName LIKE :kw ORDER BY c.categoryId DESC", Category_24110257.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110257> search(String keyword, int page, int pageSize) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Category_24110257> query = em.createQuery("SELECT c FROM Category_24110257 c WHERE c.categoryName LIKE :kw ORDER BY c.categoryId DESC", Category_24110257.class);
            query.setParameter("kw", "%" + keyword + "%");
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countSearch(String keyword) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(c) FROM Category_24110257 c WHERE c.categoryName LIKE :kw", Long.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
