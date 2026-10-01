package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Cart")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cartId", length = 50)
    private String cartId;

    @Column(name = "userId")
    private Integer userId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "buyDate")
    private Date buyDate;

    @Column(name = "status")
    private Integer status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    private Users_24110257 user;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private java.util.List<CartItem_24110257> items = new java.util.ArrayList<>();

    public double getTotalPrice() {
        double total = 0.0;
        if (items != null) {
            for (CartItem_24110257 item : items) {
                if (item.getUnitPrice() != null && item.getQuantity() != null) {
                    total += item.getUnitPrice() * item.getQuantity();
                }
            }
        }
        return total;
    }

    public int getTotalItems() {
        int count = 0;
        if (items != null) {
            for (CartItem_24110257 item : items) {
                if (item.getQuantity() != null) {
                    count += item.getQuantity();
                }
            }
        }
        return count;
    }

    public String getStatusName() {
        if (status == null) return "Chưa xác định";
        switch (status) {
            case 1: return "Đơn hàng mới";
            case 2: return "Đã xác nhận";
            case 3: return "Chuẩn bị hàng";
            case 4: return "Vận chuyển";
            case 5: return "Giao hàng";
            case 6: return "Đã giao";
            case 7: return "Đơn hàng hủy";
            case 8: return "Đơn hàng hoàn";
            default: return "Khác (" + status + ")";
        }
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        switch (status) {
            case 1: return "bg-primary";
            case 2: return "bg-info text-dark";
            case 3: return "bg-warning text-dark";
            case 4: return "bg-secondary";
            case 5: return "bg-primary bg-opacity-75";
            case 6: return "bg-success";
            case 7: return "bg-danger";
            case 8: return "bg-dark";
            default: return "bg-secondary";
        }
    }
}
