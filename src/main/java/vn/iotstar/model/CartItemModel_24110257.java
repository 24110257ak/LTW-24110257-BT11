package vn.iotstar.model;

import java.io.Serializable;
import lombok.*;
import vn.iotstar.entity.Product_24110257;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartItemModel_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Product_24110257 product;
    private int quantity;
    private double unitPrice;

    public double getTotalPrice() {
        return quantity * unitPrice;
    }
}
