package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Users_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userId")
    private int userId;

    @Column(name = "username", length = 50, nullable = false)
    private String username;

    @Column(name = "email", length = 100, nullable = false)
    private String email;

    @Column(name = "fullname", length = 50)
    private String fullname;

    @Column(name = "password", length = 50, nullable = false)
    private String password;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "status")
    private Integer status; // 0: unverified, 1: active

    @Column(name = "code", length = 50)
    private String code; // OTP code

    @Column(name = "roleId")
    private Integer roleId; // 1: ROLE_USER, 2: ROLE_ADMIN, 3: ROLE_SELLER

    @Column(name = "sellerId")
    private Integer sellerId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "roleId", insertable = false, updatable = false)
    private UserRole_24110257 role;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sellerId", insertable = false, updatable = false)
    private Seller_24110257 seller;
}
