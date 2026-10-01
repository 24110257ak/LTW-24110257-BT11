package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "UserRoles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserRole_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "roleId")
    private int roleId;

    @Column(name = "roleName", length = 50, nullable = false)
    private String roleName;
}
