package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CartItem")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartItem_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartItemId", length = 50)
    private String cartItemId;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "unitPrice")
    private Double unitPrice;

    @Column(name = "productId")
    private Integer productId;

    @Column(name = "cartId", length = 50)
    private String cartId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    private Product_24110257 product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cartId", insertable = false, updatable = false)
    private Cart_24110257 cart;

    public double getTotalPrice() {
        if (unitPrice != null && quantity != null) {
            return unitPrice * quantity;
        }
        return 0.0;
    }
}
