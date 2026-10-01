<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Hàng Thành Công - HCMUTE Store</title>
    <style>
        .success-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            max-width: 750px;
            margin: 0 auto;
        }
        .success-icon {
            font-size: 4.5rem;
            color: #198754;
        }
        .order-info-table td {
            padding: 10px 14px;
        }
    </style>
</head>
<body>

    <div class="success-card text-center my-4">
        <div class="mb-3">
            <i class="fa-solid fa-circle-check success-icon"></i>
        </div>
        <h2 class="fw-bold text-dark mb-2">ĐẶT HÀNG THÀNH CÔNG!</h2>
        <p class="text-muted fs-6 mb-4">
            Cảm ơn bạn đã mua sắm tại HCMUTE Store. Đơn hàng của bạn đã được tạo và lưu trữ an toàn trong CSDL.
        </p>

        <div class="alert alert-success text-start mb-4 p-3 border-0 bg-light">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary">Mã đơn hàng:</span>
                <span class="fw-bold text-primary fs-5">#${order.cartId}</span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary">Ngày đặt:</span>
                <span class="fw-medium text-dark"><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm:ss"/></span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary">Phương thức thanh toán:</span>
                <span class="badge bg-success fs-6"><i class="fa-solid fa-money-bill-wave me-1"></i>Thanh toán khi nhận hàng (COD)</span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary">Trạng thái ban đầu:</span>
                <span class="badge ${order.statusBadgeClass} fs-6">${order.statusName}</span>
            </div>
            <c:if test="${not empty sessionScope.order_receiver_name}">
                <hr class="my-2">
                <div class="small text-muted mb-1">
                    <strong>Người nhận:</strong> ${sessionScope.order_receiver_name} | <strong>ĐT:</strong> ${sessionScope.order_receiver_phone}
                </div>
                <div class="small text-muted">
                    <strong>Địa chỉ:</strong> ${sessionScope.order_receiver_address}
                </div>
            </c:if>
            <c:if test="${not empty order.items}">
                <hr class="my-2">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-dark">Tổng thanh toán:</span>
                    <span class="fw-bold text-danger fs-5">
                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                    </span>
                </div>
            </c:if>
        </div>

        <div class="alert alert-info text-start small mb-4">
            <i class="fa-solid fa-lightbulb text-warning me-2 fs-5 align-middle"></i>
            <strong>Gợi ý kiểm thử bài thi:</strong> Đơn hàng hiện đang ở trạng thái <code>status = 1</code> (Đơn hàng mới).
            Bạn có thể vào SQL Server chạy câu lệnh sau để quan sát sự thay đổi trạng thái trong trang Lịch sử:
            <div class="bg-dark text-white p-2 rounded mt-2 font-monospace">
                UPDATE Cart SET status = 2 WHERE cartId = '${order.cartId}'; -- Đã xác nhận<br>
                UPDATE Cart SET status = 3 WHERE cartId = '${order.cartId}'; -- Chuẩn bị hàng<br>
                UPDATE Cart SET status = 4 WHERE cartId = '${order.cartId}'; -- Vận chuyển<br>
                UPDATE Cart SET status = 5 WHERE cartId = '${order.cartId}'; -- Giao hàng<br>
                UPDATE Cart SET status = 6 WHERE cartId = '${order.cartId}'; -- Đã giao<br>
                UPDATE Cart SET status = 7 WHERE cartId = '${order.cartId}'; -- Đơn hàng hủy<br>
                UPDATE Cart SET status = 8 WHERE cartId = '${order.cartId}'; -- Đơn hàng hoàn
            </div>
        </div>

        <div class="d-flex justify-content-center gap-3">
            <a href="<c:url value='/orders'/>" class="btn btn-primary px-4 py-2">
                <i class="fa-solid fa-clock-rotate-left me-2"></i>Xem Lịch Sử Đặt Hàng
            </a>
            <a href="<c:url value='/home'/>" class="btn btn-outline-secondary px-4 py-2">
                <i class="fa-solid fa-house me-2"></i>Về Trang Chủ
            </a>
        </div>
    </div>

</body>
</html>
