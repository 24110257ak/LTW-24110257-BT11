<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn - HCMUTE Store</title>
    <style>
        .cart-table th {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
        }
        .cart-item-img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            background: #fff;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            padding: 4px;
        }
        .qty-btn {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0;
            border-radius: 6px;
        }
        .qty-input {
            width: 55px;
            text-align: center;
            font-weight: 600;
        }
        .cart-summary-box {
            background: #ffffff;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
    </style>
</head>
<body>

    <!-- BREADCRUMB -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Giỏ hàng của bạn</li>
        </ol>
    </nav>

    <!-- THÔNG BÁO FLASH MESSAGE -->
    <c:if test="${not empty sessionScope.cartSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.cartSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.cartWarning}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i>${sessionScope.cartWarning}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartWarning" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.cartError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-xmark me-2"></i>${sessionScope.cartError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="cartError" scope="session"/>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">
                <i class="fa-solid fa-cart-shopping text-primary me-2"></i>GIỎ HÀNG CỦA BẠN
            </h3>
        </div>
        <c:if test="${not empty sessionScope.cart and sessionScope.cart.size() > 0}">
            <a href="<c:url value='/cart/clear'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm trong giỏ hàng?');">
                <i class="fa-solid fa-trash-can me-1"></i>Xóa tất cả
            </a>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
            <div class="card border-0 shadow-sm text-center py-5">
                <div class="card-body">
                    <i class="fa-solid fa-cart-arrow-down text-muted fs-1 mb-3" style="font-size: 4rem !important;"></i>
                    <h4 class="text-secondary fw-bold">Giỏ hàng của bạn đang trống!</h4>
                    <p class="text-muted mb-4">Hãy tiếp tục lựa chọn các sản phẩm ưng ý để thêm vào giỏ hàng nhé.</p>
                    <a href="<c:url value='/products-by-seller'/>" class="btn btn-primary px-4 py-2">
                        <i class="fa-solid fa-store me-2"></i>Tiếp tục mua hàng
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>

            <div class="row g-4">
                <!-- DANH SÁCH MẶT HÀNG TRONG GIỎ -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm overflow-hidden mb-3">
                        <div class="table-responsive">
                            <table class="table cart-table align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 45%;">Sản phẩm</th>
                                        <th scope="col" class="text-center" style="width: 15%;">Đơn giá</th>
                                        <th scope="col" class="text-center" style="width: 20%;">Số lượng</th>
                                        <th scope="col" class="text-end" style="width: 15%;">Thành tiền</th>
                                        <th scope="col" class="text-center" style="width: 5%;">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.cart}" var="entry">
                                        <c:set var="item" value="${entry.value}"/>
                                        <c:set var="p" value="${item.product}"/>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                                                        <img src="<c:url value='/image?fname=${p.images}'/>" class="cart-item-img me-3" alt="${p.productName}">
                                                    </a>
                                                    <div>
                                                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark fw-bold text-decoration-none">
                                                            ${p.productName}
                                                        </a>
                                                        <div class="small text-muted mt-1">
                                                            Mã SP: #${p.productCode}
                                                            <c:if test="${not empty p.seller}">
                                                                | Gian hàng: <span class="badge bg-light text-secondary border">${p.seller.sellername}</span>
                                                            </c:if>
                                                        </div>
                                                        <div class="small text-info mt-1">
                                                            <i class="fa-solid fa-boxes-stacked me-1"></i>Tồn kho còn: <strong>${p.stock}</strong>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center fw-semibold text-secondary">
                                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                            </td>
                                            <td class="text-center">
                                                <!-- FORM THAY ĐỔI SỐ LƯỢNG TRONG GIỚI HẠN TỒN KHO -->
                                                <form action="<c:url value='/cart/update'/>" method="post" class="d-flex align-items-center justify-content-center">
                                                    <input type="hidden" name="productId" value="${p.productId}"/>
                                                    
                                                    <!-- Nút giảm số lượng (-) -->
                                                    <a href="<c:url value='/cart/update?productId=${p.productId}&type=dec'/>" class="btn btn-outline-secondary btn-sm qty-btn me-1" title="Giảm số lượng">
                                                        <i class="fa-solid fa-minus"></i>
                                                    </a>

                                                    <!-- Ô input số lượng (giới hạn từ 1 đến stock) -->
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${p.stock}" 
                                                           class="form-control form-control-sm qty-input me-1" 
                                                           onchange="this.form.submit()" title="Nhập số lượng từ 1 đến ${p.stock}">

                                                    <!-- Nút tăng số lượng (+) -->
                                                    <a href="<c:url value='/cart/update?productId=${p.productId}&type=inc'/>" 
                                                       class="btn btn-outline-secondary btn-sm qty-btn ${item.quantity >= p.stock ? 'disabled' : ''}" 
                                                       title="${item.quantity >= p.stock ? 'Đã đạt giới hạn tồn kho' : 'Tăng số lượng'}">
                                                        <i class="fa-solid fa-plus"></i>
                                                    </a>
                                                </form>
                                                <c:if test="${item.quantity >= p.stock}">
                                                    <small class="text-danger d-block mt-1" style="font-size: 0.75rem;">(Tối đa kho)</small>
                                                </c:if>
                                            </td>
                                            <td class="text-end fw-bold text-danger fs-6">
                                                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                            </td>
                                            <td class="text-center">
                                                <a href="<c:url value='/cart/remove?productId=${p.productId}'/>" class="text-danger" title="Xóa mặt hàng này" onclick="return confirm('Bạn muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                    <i class="fa-regular fa-trash-can fs-5"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <a href="<c:url value='/products-by-seller'/>" class="btn btn-outline-primary">
                            <i class="fa-solid fa-arrow-left me-2"></i>Tiếp tục chọn thêm sản phẩm
                        </a>
                    </div>
                </div>

                <!-- TÓM TẮT ĐƠN HÀNG & TIẾN HÀNH THANH TOÁN -->
                <div class="col-lg-4">
                    <div class="cart-summary-box">
                        <h5 class="fw-bold border-bottom pb-3 mb-3 text-dark">
                            <i class="fa-solid fa-receipt text-primary me-2"></i>Tóm Tắt Đơn Hàng
                        </h5>

                        <div class="d-flex justify-content-between mb-2 text-secondary">
                            <span>Tổng số lượng:</span>
                            <span class="fw-semibold text-dark">${totalQuantity} sản phẩm</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2 text-secondary">
                            <span>Tạm tính:</span>
                            <span class="fw-semibold text-dark">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-3 text-secondary">
                            <span>Phí vận chuyển:</span>
                            <span class="text-success fw-semibold"><i class="fa-solid fa-truck-fast me-1"></i>Miễn phí</span>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                            <span class="fs-4 fw-bold text-danger">
                                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                            </span>
                        </div>

                        <a href="<c:url value='/checkout'/>" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow-sm">
                            <i class="fa-solid fa-money-bill-wave me-2"></i>Tiến Hành Thanh Toán COD
                        </a>

                        <div class="mt-3 text-center text-muted small">
                            <i class="fa-solid fa-shield-halved text-success me-1"></i>Thanh toán khi nhận hàng (COD) an toàn 100%
                        </div>
                    </div>
                </div>
            </div>

        </c:otherwise>
    </c:choose>

</body>
</html>
