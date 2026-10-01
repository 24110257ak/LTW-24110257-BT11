<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>

    <!-- HERO BANNER -->
    <div class="p-5 mb-4 bg-white rounded-3 shadow-sm border border-light">
        <div class="container-fluid py-2">
            <span class="badge bg-primary mb-2 px-3 py-2 fs-6">Học kỳ 1 - Năm học 2026-2027</span>
            <h1 class="display-6 fw-bold text-dark">BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB - ĐỀ SỐ 05</h1>
            <p class="col-md-9 fs-5 text-muted">
                Hệ thống thương mại điện tử xây dựng theo mô hình 3 tầng (Presentation - Business - Data Access) với công nghệ Jakarta Servlet 6.0, JPA Hibernate 6.6, Microsoft SQL Server và Sitemesh 3.
            </p>
            <div class="d-flex flex-wrap gap-2 pt-2">
                <a class="btn btn-primary btn-lg px-4" href="<c:url value='/products-by-seller'/>">
                    <i class="fa-solid fa-store me-2"></i>Khám Phá Gian Hàng
                </a>
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <a class="btn btn-outline-secondary btn-lg px-4" href="<c:url value='/login'/>">
                            <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập / Đăng Ký
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-outline-success btn-lg px-4" href="<c:url value='/cart'/>">
                            <i class="fa-solid fa-cart-shopping me-2"></i>Xem Giỏ Hàng
                        </a>
                        <a class="btn btn-outline-primary btn-lg px-4" href="<c:url value='/orders'/>">
                            <i class="fa-solid fa-clock-rotate-left me-2"></i>Lịch Sử Đặt Hàng
                        </a>
                    </c:otherwise>
                </c:choose>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 2}">
                    <a class="btn btn-outline-danger btn-lg px-4" href="<c:url value='/admin/categories'/>">
                        <i class="fa-solid fa-gear me-2"></i>Trang Quản Trị Hệ Thống
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- DANH MỤC NỔI BẬT -->
    <div class="mb-5">
        <h4 class="fw-bold mb-3 text-secondary"><i class="fa-solid fa-list me-2"></i>Danh Mục Sản Phẩm</h4>
        <div class="row g-3">
            <c:forEach items="${categoryList}" var="cat">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="card h-100 border-0 shadow-sm text-center p-3 hover-shadow">
                        <img src="<c:url value='/image?fname=${cat.images}'/>" class="img-fluid rounded mb-2 mx-auto" style="height: 60px; object-fit: contain;" alt="${cat.categoryName}">
                        <h6 class="fw-semibold text-dark small mb-0">${cat.categoryName}</h6>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- SẢN PHẨM MỚI NHẤT -->
    <div>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="fw-bold mb-0 text-secondary"><i class="fa-solid fa-fire text-danger me-2"></i>Sản Phẩm Nổi Bật</h4>
            <a href="<c:url value='/products-by-seller'/>" class="btn btn-sm btn-outline-primary">Xem tất cả theo Seller <i class="fa-solid fa-arrow-right ms-1"></i></a>
        </div>
        <div class="row g-4">
            <c:forEach items="${productList}" var="prod">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card h-100 shadow-sm border-0">
                        <a href="<c:url value='/product/detail?id=${prod.productId}'/>" class="text-decoration-none">
                            <img src="<c:url value='/image?fname=${prod.images}'/>" class="card-img-top p-2" style="height: 180px; object-fit: contain; background: #fff;" alt="${prod.productName}">
                        </a>
                        <div class="card-body d-flex flex-column">
                            <span class="badge bg-light text-dark border mb-2 text-start align-self-start">
                                Mã SP: #${prod.productCode}
                            </span>
                            <h6 class="card-title fw-bold text-dark text-truncate">
                                <a href="<c:url value='/product/detail?id=${prod.productId}'/>" class="text-dark text-decoration-none">
                                    ${prod.productName}
                                </a>
                            </h6>
                            <p class="small text-muted mb-2 text-truncate">${prod.description}</p>
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-danger fw-bold fs-5">
                                        <fmt:formatNumber value="${prod.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ
                                    </span>
                                    <span class="badge ${prod.stock > 0 ? 'bg-light text-secondary border' : 'bg-danger'}">
                                         <c:choose>
                                             <c:when test="${prod.stock > 0}">Kho: ${prod.stock}</c:when>
                                             <c:otherwise>Hết hàng</c:otherwise>
                                         </c:choose>
                                     </span>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="<c:url value='/product/detail?id=${prod.productId}'/>" class="btn btn-outline-primary btn-sm flex-fill">
                                        <i class="fa-solid fa-eye me-1"></i>Chi Tiết
                                    </a>
                                    <a href="<c:url value='/cart/add?productId=${prod.productId}&quantity=1'/>" class="btn btn-primary btn-sm" title="Thêm vào giỏ hàng">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>
