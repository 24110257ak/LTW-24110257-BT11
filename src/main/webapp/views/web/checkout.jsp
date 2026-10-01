<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng (COD) - HCMUTE Store</title>
    <style>
        .checkout-box {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .payment-method-card {
            border: 2px solid #0d6efd;
            background-color: #f0f7ff;
            border-radius: 10px;
            padding: 16px;
            cursor: pointer;
        }
        .order-summary-item-img {
            width: 50px;
            height: 50px;
            object-fit: contain;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            background: #fff;
            padding: 2px;
        }
    </style>
</head>
<body>

    <!-- BREADCRUMB -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/cart'/>">Giỏ Hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thanh Toán Đơn Hàng</li>
        </ol>
    </nav>

    <div class="mb-4">
        <h3 class="fw-bold text-dark mb-0">
            <i class="fa-solid fa-credit-card text-primary me-2"></i>THANH TOÁN ĐƠN HÀNG
        </h3>
    </div>

    <form action="<c:url value='/checkout'/>" method="post">
        <div class="row g-4">
            <!-- CỘT TRÁI: THÔNG TIN GIAO HÀNG & PHƯƠNG THỨC THANH TOÁN -->
            <div class="col-lg-7">
                <!-- THÔNG TIN GIAO HÀNG -->
                <div class="checkout-box mb-4">
                    <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">
                        <i class="fa-solid fa-location-dot text-danger me-2"></i>Thông Tin Giao Hàng
                    </h5>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" name="fullname" class="form-control" 
                               value="${user.fullname != null ? user.fullname : user.username}" required placeholder="Nhập họ và tên người nhận">
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" name="phone" class="form-control" 
                                   value="${user.phone != null ? user.phone : '0934567890'}" required placeholder="Số điện thoại nhận hàng">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email xác nhận</label>
                            <input type="email" class="form-control" value="${user.email}" readonly disabled>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                        <input type="text" name="address" class="form-control" 
                               value="Số 1 Võ Văn Ngân, P. Linh Chiểu, TP. Thủ Đức, TP. Hồ Chí Minh" required placeholder="Số nhà, tên đường, phường/xã, quận/huyện...">
                    </div>

                    <div class="mb-0">
                        <label class="form-label fw-semibold">Ghi chú đơn hàng (nếu có)</label>
                        <textarea name="note" class="form-control" rows="2" placeholder="Ví dụ: Giao giờ hành chính, gọi điện trước khi giao..."></textarea>
                    </div>
                </div>

                <!-- PHƯƠNG THỨC THANH TOÁN COD -->
                <div class="checkout-box">
                    <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">
                        <i class="fa-solid fa-money-bill-wave text-success me-2"></i>Phương Thức Thanh Toán
                    </h5>

                    <div class="payment-method-card d-flex align-items-center justify-content-between mb-3">
                        <div class="d-flex align-items-center">
                            <input class="form-check-input me-3" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
                            <div>
                                <label class="form-check-label fw-bold text-primary fs-6 mb-1" for="codPayment">
                                    Thanh toán khi nhận hàng (COD)
                                </label>
                                <div class="text-muted small">
                                    Quý khách sẽ thanh toán tiền mặt trực tiếp cho shipper khi nhận được hàng.
                                </div>
                            </div>
                        </div>
                        <span class="badge bg-success px-2 py-1"><i class="fa-solid fa-check me-1"></i>Được chọn</span>
                    </div>

                    <div class="p-3 bg-light rounded text-secondary small">
                        <i class="fa-solid fa-circle-info text-info me-1"></i>
                        Đơn hàng sẽ được tạo với trạng thái <strong>"Đơn hàng mới" (status = 1)</strong> và tự động lưu vào CSDL.
                    </div>
                </div>
            </div>

            <!-- CỘT PHẢI: TÓM TẮT ĐƠN HÀNG & NÚT XÁC NHẬN -->
            <div class="col-lg-5">
                <div class="checkout-box sticky-top" style="top: 80px;">
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="fa-solid fa-bag-shopping text-primary me-2"></i>Đơn Hàng Của Bạn
                        </h5>
                        <span class="badge bg-primary rounded-pill">${totalQuantity} món</span>
                    </div>

                    <!-- DANH SÁCH SẢN PHẨM TRONG ĐƠN -->
                    <div class="mb-3" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach items="${sessionScope.cart}" var="entry">
                            <c:set var="item" value="${entry.value}"/>
                            <c:set var="p" value="${item.product}"/>
                            <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                                <div class="d-flex align-items-center">
                                    <img src="<c:url value='/image?fname=${p.images}'/>" class="order-summary-item-img me-2" alt="${p.productName}">
                                    <div>
                                        <div class="fw-semibold text-dark small text-truncate" style="max-width: 200px;" title="${p.productName}">
                                            ${p.productName}
                                        </div>
                                        <div class="small text-muted">
                                            SL: x${item.quantity} | <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                        </div>
                                    </div>
                                </div>
                                <div class="fw-bold text-dark small">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- BẢNG TÍNH TIỀN -->
                    <div class="d-flex justify-content-between mb-2 text-secondary">
                        <span>Tạm tính:</span>
                        <span class="fw-semibold text-dark">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-2 text-secondary">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success fw-semibold">0 đ (Miễn phí)</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3 text-secondary">
                        <span>Hình thức:</span>
                        <span class="fw-semibold text-primary">COD (Tiền mặt)</span>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 fw-bold text-dark">Tổng thanh toán:</span>
                        <span class="fs-4 fw-bold text-danger">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                        </span>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow">
                        <i class="fa-solid fa-circle-check me-2"></i>Xác Nhận Đặt Hàng COD
                    </button>

                    <div class="text-center mt-3">
                        <a href="<c:url value='/cart'/>" class="text-secondary text-decoration-none small">
                            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại chỉnh sửa giỏ hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>
</html>
