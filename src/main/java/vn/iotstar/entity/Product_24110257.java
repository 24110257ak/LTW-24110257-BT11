package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Product")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private int productId;

    @Column(name = "productName", length = 200, nullable = false)
    private String productName;

    @Column(name = "productCode")
    private Long productCode;

    @Column(name = "categoryId")
    private Integer categoryId;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "price")
    private Double price;

    @Column(name = "amount")
    private Integer amount;

    @Column(name = "stock")
    private Integer stock;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "wishlist")
    private Integer wishlist;

    @Column(name = "status")
    private Integer status;

    @Temporal(TemporalType.DATE)
    @Column(name = "createDate")
    private Date createDate;

    @Column(name = "sellerId")
    private Integer sellerId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categoryId", insertable = false, updatable = false)
    private Category_24110257 category;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sellerId", insertable = false, updatable = false)
    private Seller_24110257 seller;
}
