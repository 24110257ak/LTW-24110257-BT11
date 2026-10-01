package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.IUserDao_24110257;
import vn.iotstar.entity.Users_24110257;

public class UserDao_24110257 implements IUserDao_24110257 {

    @Override
    public void insert(Users_24110257 user) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Users_24110257 user) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
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
            Users_24110257 user = em.find(Users_24110257.class, id);
            if (user != null) {
                em.remove(user);
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
    public Users_24110257 findById(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(Users_24110257.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public Users_24110257 findByUsername(String username) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Users_24110257> query = em.createQuery(
                "SELECT u FROM Users_24110257 u WHERE u.username = :username", Users_24110257.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public Users_24110257 findByEmail(String email) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Users_24110257> query = em.createQuery(
                "SELECT u FROM Users_24110257 u WHERE u.email = :email", Users_24110257.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        return findByUsername(username) != null;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return findByEmail(email) != null;
    }

    @Override
    public List<Users_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<Users_24110257> query = em.createQuery(
                "SELECT u FROM Users_24110257 u ORDER BY u.userId ASC", Users_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
