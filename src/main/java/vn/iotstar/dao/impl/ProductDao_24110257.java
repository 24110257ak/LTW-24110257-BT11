package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.IProductDao_24110257;
import vn.iotstar.entity.Product_24110257;

public class ProductDao_24110257 implements IProductDao_24110257 {

    @Override
    public void insert(Product_24110257 product) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product_24110257 product) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
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
            Product_24110257 prod = em.find(Product_24110257.class, id);
            if (prod != null) {
                em.remove(prod);
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
    public Product_24110257 findById(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(Product_24110257.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Product_24110257> query = em.createQuery("SELECT p FROM Product_24110257 p ORDER BY p.productId DESC", Product_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110257> findAll(int page, int pageSize) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Product_24110257> query = em.createQuery("SELECT p FROM Product_24110257 p ORDER BY p.productId DESC", Product_24110257.class);
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
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product_24110257 p", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110257> findBySellerId(int sellerId) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Product_24110257> query = em.createQuery("SELECT p FROM Product_24110257 p WHERE p.sellerId = :sid ORDER BY p.productId ASC", Product_24110257.class);
            query.setParameter("sid", sellerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110257> search(String keyword) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Product_24110257> query = em.createQuery("SELECT p FROM Product_24110257 p WHERE p.productName LIKE :kw ORDER BY p.productId DESC", Product_24110257.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product_24110257> search(String keyword, int page, int pageSize) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Product_24110257> query = em.createQuery("SELECT p FROM Product_24110257 p WHERE p.productName LIKE :kw ORDER BY p.productId DESC", Product_24110257.class);
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
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product_24110257 p WHERE p.productName LIKE :kw", Long.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
