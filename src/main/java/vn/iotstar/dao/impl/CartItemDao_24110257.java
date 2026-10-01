package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.ICartItemDao_24110257;
import vn.iotstar.entity.CartItem_24110257;

public class CartItemDao_24110257 implements ICartItemDao_24110257 {

    @Override
    public void insert(CartItem_24110257 item) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(item);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<CartItem_24110257> findByCartId(String cartId) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            String jpql = "SELECT ci FROM CartItem_24110257 ci WHERE ci.cartId = :cartId";
            TypedQuery<CartItem_24110257> query = em.createQuery(jpql, CartItem_24110257.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
