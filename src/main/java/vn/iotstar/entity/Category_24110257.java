package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "Category")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Category_24110257 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "categoryId")
    private int categoryId;

    @Column(name = "categoryName", length = 200, nullable = false)
    private String categoryName;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private Integer status;
}
