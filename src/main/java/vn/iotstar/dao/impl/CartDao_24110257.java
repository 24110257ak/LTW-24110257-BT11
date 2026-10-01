package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.ICartDao_24110257;
import vn.iotstar.entity.Cart_24110257;

public class CartDao_24110257 implements ICartDao_24110257 {

    @Override
    public void insert(Cart_24110257 cart) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cart);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Cart_24110257 cart) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(cart);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String cartId) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Cart_24110257 cart = em.find(Cart_24110257.class, cartId);
            if (cart != null) {
                em.remove(cart);
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
    public Cart_24110257 findById(String cartId) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(Cart_24110257.class, cartId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            String jpql = "SELECT c FROM Cart_24110257 c ORDER BY c.buyDate DESC";
            TypedQuery<Cart_24110257> query = em.createQuery(jpql, Cart_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110257> findByUserId(int userId) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            String jpql = "SELECT c FROM Cart_24110257 c WHERE c.userId = :userId ORDER BY c.buyDate DESC";
            TypedQuery<Cart_24110257> query = em.createQuery(jpql, Cart_24110257.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Cart_24110257> findByUserIdAndStatus(int userId, int status) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            String jpql = "SELECT c FROM Cart_24110257 c WHERE c.userId = :userId AND c.status = :status ORDER BY c.buyDate DESC";
            TypedQuery<Cart_24110257> query = em.createQuery(jpql, Cart_24110257.class);
            query.setParameter("userId", userId);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateStatus(String cartId, int status) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Cart_24110257 cart = em.find(Cart_24110257.class, cartId);
            if (cart != null) {
                cart.setStatus(status);
                em.merge(cart);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
