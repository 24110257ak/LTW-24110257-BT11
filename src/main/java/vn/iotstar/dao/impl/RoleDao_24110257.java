package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig_24110257;
import vn.iotstar.dao.IRoleDao_24110257;
import vn.iotstar.entity.UserRole_24110257;

public class RoleDao_24110257 implements IRoleDao_24110257 {

    @Override
    public UserRole_24110257 findById(int id) {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            return em.find(UserRole_24110257.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<UserRole_24110257> findAll() {
        EntityManager em = JpaConfig_24110257.getEntityManager();
        try {
            TypedQuery<UserRole_24110257> query = em.createQuery(
                "SELECT r FROM UserRole_24110257 r ORDER BY r.roleId ASC", UserRole_24110257.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
