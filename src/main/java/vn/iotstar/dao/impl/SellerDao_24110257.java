package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.ISellerDao_24110257;
import vn.iotstar.entity.Seller_24110257;

public class SellerDao_24110257 implements ISellerDao_24110257 {

    @Override
    public void insert(Seller_24110257 seller) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(seller);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Seller_24110257 seller) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(seller);
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
            Seller_24110257 seller = em.find(Seller_24110257.class, id);
            if (seller != null) {
                em.remove(seller);
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
    public Seller_24110257 findById(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(Seller_24110257.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Seller_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Seller_24110257> query = em.createQuery(
                "SELECT s FROM Seller_24110257 s ORDER BY s.sellerId ASC", Seller_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
