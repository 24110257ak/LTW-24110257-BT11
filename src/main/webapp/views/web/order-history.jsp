<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đặt Hàng - HCMUTE Store</title>
    <style>
        .order-card {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 24px;
            overflow: hidden;
        }
        .order-card-header {
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 14px 20px;
        }
        .order-item-img {
            width: 65px;
            height: 65px;
            object-fit: contain;
            background: #fff;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            padding: 4px;
        }
        .nav-pills .nav-link {
            color: #475569;
            font-weight: 500;
            border-radius: 8px;
            padding: 8px 14px;
            margin: 2px;
            white-space: nowrap;
            background: #fff;
            border: 1px solid #e2e8f0;
        }
        .nav-pills .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff;
            font-weight: 600;
            border-color: #0d6efd;
        }
        .sql-guide-box {
            background-color: #f8fafc;
            border-left: 4px solid #0d6efd;
            border-radius: 4px;
            padding: 14px 18px;
        }
    </style>
</head>
<body>

    <!-- BREADCRUMB -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Lịch sử đặt hàng</li>
        </ol>
    </nav>

    <!-- THÔNG BÁO FLASH MESSAGE -->
    <c:if test="${not empty sessionScope.orderSuccess}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${sessionScope.orderSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="orderSuccess" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.orderError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-xmark me-2"></i>${sessionScope.orderError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="orderError" scope="session"/>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-clock-rotate-left text-primary me-2"></i>LỊCH SỬ ĐẶT HÀNG
            </h3>
            <span class="badge bg-primary px-3 py-1">Lọc theo 8 trạng thái: Đơn hàng mới, Đã xác nhận, Chuẩn bị hàng, Vận chuyển, Giao hàng, Đã giao, Đơn hàng hủy, Đơn hàng hoàn</span>
        </div>
        <a href="<c:url value='/products-by-seller'/>" class="btn btn-outline-primary btn-sm">
            <i class="fa-solid fa-plus me-1"></i>Đặt thêm đơn mới
        </a>
    </div>

    <!-- HƯỚNG DẪN QUAN SÁT THAY ĐỔI TRẠNG THÁI TRONG CSDL -->
    <div class="sql-guide-box mb-4 shadow-sm">
        <div class="d-flex align-items-start">
            <i class="fa-solid fa-database text-primary fs-4 me-3 mt-1"></i>
            <div>
                <strong class="text-dark">Hướng dẫn quan sát thay đổi trạng thái theo yêu cầu đề bài:</strong>
                <p class="small text-muted mb-1 mt-1">
                    Vào SQL Server mở <code>SSMS</code> hoặc chạy truy vấn để đổi <code>status</code> cho đơn hàng tương ứng, sau đó tải lại trang này để xem kết quả phân loại:
                </p>
                <code class="small text-primary fw-bold">
                    UPDATE Cart SET status = 1 WHERE cartId = '...'; -- Đơn hàng mới (status=1)<br>
                    UPDATE Cart SET status = 2 WHERE cartId = '...'; -- Đã xác nhận (status=2)<br>
                    UPDATE Cart SET status = 3 WHERE cartId = '...'; -- Chuẩn bị hàng (status=3)<br>
                    UPDATE Cart SET status = 4 WHERE cartId = '...'; -- Vận chuyển (status=4)<br>
                    UPDATE Cart SET status = 5 WHERE cartId = '...'; -- Giao hàng (status=5)<br>
                    UPDATE Cart SET status = 6 WHERE cartId = '...'; -- Đã giao (status=6)<br>
                    UPDATE Cart SET status = 7 WHERE cartId = '...'; -- Đơn hàng hủy (status=7)<br>
                    UPDATE Cart SET status = 8 WHERE cartId = '...'; -- Đơn hàng hoàn (status=8)
                </code>
            </div>
        </div>
    </div>

    <!-- HỆ THỐNG TAB LỌC TRẠNG THÁI ĐƠN HÀNG -->
    <div class="mb-4 overflow-auto pb-2">
        <ul class="nav nav-pills flex-nowrap">
            <li class="nav-item">
                <a class="nav-link ${empty currentStatus ? 'active' : ''}" href="<c:url value='/orders'/>">
                    Tất cả <span class="badge ${empty currentStatus ? 'bg-light text-primary' : 'bg-secondary'} rounded-pill ms-1">${allOrdersCount}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 1 ? 'active' : ''}" href="<c:url value='/orders?status=1'/>">
                    Đơn hàng mới <span class="badge ${currentStatus == 1 ? 'bg-light text-primary' : 'bg-primary'} rounded-pill ms-1">${countByStatus[1]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 2 ? 'active' : ''}" href="<c:url value='/orders?status=2'/>">
                    Đã xác nhận <span class="badge ${currentStatus == 2 ? 'bg-light text-primary' : 'bg-info text-dark'} rounded-pill ms-1">${countByStatus[2]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 3 ? 'active' : ''}" href="<c:url value='/orders?status=3'/>">
                    Chuẩn bị hàng <span class="badge ${currentStatus == 3 ? 'bg-light text-primary' : 'bg-warning text-dark'} rounded-pill ms-1">${countByStatus[3]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 4 ? 'active' : ''}" href="<c:url value='/orders?status=4'/>">
                    Vận chuyển <span class="badge ${currentStatus == 4 ? 'bg-light text-primary' : 'bg-secondary'} rounded-pill ms-1">${countByStatus[4]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 5 ? 'active' : ''}" href="<c:url value='/orders?status=5'/>">
                    Giao hàng <span class="badge ${currentStatus == 5 ? 'bg-light text-primary' : 'bg-primary'} rounded-pill ms-1">${countByStatus[5]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 6 ? 'active' : ''}" href="<c:url value='/orders?status=6'/>">
                    Đã giao <span class="badge ${currentStatus == 6 ? 'bg-light text-primary' : 'bg-success'} rounded-pill ms-1">${countByStatus[6]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 7 ? 'active' : ''}" href="<c:url value='/orders?status=7'/>">
                    Đơn hàng hủy <span class="badge ${currentStatus == 7 ? 'bg-light text-primary' : 'bg-danger'} rounded-pill ms-1">${countByStatus[7]}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 8 ? 'active' : ''}" href="<c:url value='/orders?status=8'/>">
                    Đơn hàng hoàn <span class="badge ${currentStatus == 8 ? 'bg-light text-primary' : 'bg-dark'} rounded-pill ms-1">${countByStatus[8]}</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- DANH SÁCH CÁC ĐƠN HÀNG ĐƯỢC LỌC -->
    <c:choose>
        <c:when test="${empty orders or orders.size() == 0}">
            <div class="card border-0 shadow-sm text-center py-5">
                <div class="card-body">
                    <i class="fa-regular fa-folder-open text-muted fs-1 mb-3" style="font-size: 3.5rem !important;"></i>
                    <h5 class="text-secondary fw-bold">Chưa có đơn hàng nào trong trạng thái này!</h5>
                    <p class="text-muted mb-3">Bạn có thể chọn tab trạng thái khác hoặc đặt mua sản phẩm mới.</p>
                    <a href="<c:url value='/products-by-seller'/>" class="btn btn-primary btn-sm px-3">
                        <i class="fa-solid fa-bag-shopping me-1"></i>Khám phá sản phẩm
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>

            <c:forEach items="${orders}" var="order">
                <div class="order-card">
                    <!-- HEADER CARD ĐƠN HÀNG -->
                    <div class="order-card-header d-flex flex-wrap justify-content-between align-items-center">
                        <div class="d-flex align-items-center gap-3">
                            <span class="fw-bold text-dark fs-6">
                                <i class="fa-solid fa-receipt text-primary me-1"></i>Mã ĐH: #${order.cartId}
                            </span>
                            <span class="text-muted small">
                                <i class="fa-regular fa-calendar-days me-1"></i>
                                <fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                        <div class="d-flex align-items-center gap-2 mt-2 mt-sm-0">
                            <span class="badge bg-light text-dark border">
                                <i class="fa-solid fa-money-bill-wave text-success me-1"></i>COD
                            </span>
                            <!-- BADGE TRẠNG THÁI HIỂN THỊ ĐÚNG THEO DATABASE -->
                            <span class="badge ${order.statusBadgeClass} px-3 py-2 fs-6">
                                <i class="fa-solid fa-circle-dot me-1"></i>${order.statusName} (status: ${order.status})
                            </span>
                        </div>
                    </div>

                    <!-- DANH SÁCH SẢN PHẨM TRONG ĐƠN HÀNG -->
                    <div class="p-3">
                        <c:forEach items="${order.items}" var="item">
                            <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                                <div class="d-flex align-items-center">
                                    <a href="<c:url value='/product/detail?id=${item.productId}'/>">
                                        <img src="<c:url value='/image?fname=${item.product != null ? item.product.images : "default.png"}'/>" 
                                             class="order-item-img me-3" alt="${item.product != null ? item.product.productName : 'Sản phẩm'}">
                                    </a>
                                    <div>
                                        <a href="<c:url value='/product/detail?id=${item.productId}'/>" class="text-dark fw-bold text-decoration-none">
                                            ${item.product != null ? item.product.productName : 'Sản phẩm #' += item.productId}
                                        </a>
                                        <div class="small text-muted mt-1">
                                            Mã SP: #${item.product != null ? item.product.productCode : item.productId} | 
                                            Đơn giá: <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <div class="text-muted small">Số lượng: <strong>x${item.quantity}</strong></div>
                                    <div class="fw-bold text-danger">
                                        <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- FOOTER CARD ĐƠN HÀNG -->
                    <div class="p-3 bg-light d-flex flex-wrap justify-content-between align-items-center border-top">
                        <div>
                            <span class="text-muted small">Tổng số lượng: <strong>${order.totalItems} sản phẩm</strong></span>
                        </div>
                        <div class="d-flex align-items-center gap-3 mt-2 mt-sm-0">
                            <div>
                                <span class="text-secondary small me-2">Tổng thanh toán:</span>
                                <span class="fw-bold text-danger fs-5">
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                </span>
                            </div>

                            <!-- NÚT HỦY ĐƠN HÀNG: Chỉ khả dụng khi đơn hàng mới (status == 1) -->
                            <c:if test="${order.status == 1}">
                                <a href="<c:url value='/orders/cancel?id=${order.cartId}'/>" 
                                   class="btn btn-outline-danger btn-sm" 
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.cartId}? Tồn kho sản phẩm sẽ được tự động hoàn lại.');">
                                    <i class="fa-solid fa-ban me-1"></i>Hủy đơn hàng
                                </a>
                            </c:if>

                            <!-- NÚT MUA LẠI: Thêm lại sản phẩm vào giỏ -->
                            <c:if test="${not empty order.items}">
                                <a href="<c:url value='/cart/add?productId=${order.items[0].productId}&quantity=1'/>" class="btn btn-outline-primary btn-sm">
                                    <i class="fa-solid fa-arrow-rotate-right me-1"></i>Mua lại
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>

</body>
</html>
