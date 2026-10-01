package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig_24110257 {
    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            factory = Persistence.createEntityManagerFactory("dataSource");
        }
        return factory.createEntityManager();
    }

    public static synchronized void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }

    public static void main(String[] args) {
        try {
            EntityManager em = getEntityManager();
            System.out.println(">>> JPA Connected successfully to DB_KT_24110257! <<<");
            em.close();
            shutdown();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
