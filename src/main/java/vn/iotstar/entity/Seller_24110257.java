package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Seller")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Seller_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerId")
    private int sellerId;

    @Column(name = "sellername", length = 50, nullable = false)
    private String sellername;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private Integer status;
}
