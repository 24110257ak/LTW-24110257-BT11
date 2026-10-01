<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sản Phẩm Gom Theo Từng Seller - Câu 3</title>
    <style>
        .seller-block {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            margin-bottom: 30px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        .seller-header {
            background: linear-gradient(90deg, #0d6efd 0%, #0b5ed7 100%);
            color: #ffffff;
            padding: 14px 20px;
            font-size: 1.15rem;
            font-weight: 700;
        }
        .product-item-card {
            border: 1px solid #edf2f7;
            border-radius: 8px;
            padding: 16px;
            background: #fff;
            height: 100%;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .product-item-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .product-img {
            width: 100%;
            height: 160px;
            object-fit: contain;
            background-color: #f8fafc;
            border-radius: 6px;
            margin-bottom: 12px;
        }
        .product-field-label {
            font-weight: 600;
            color: #475569;
            font-size: 0.9rem;
        }
        .product-field-value {
            color: #0f172a;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-boxes-stacked text-primary me-2"></i>DANH SÁCH SẢN PHẨM GOM THEO TỪNG SELLER
            </h3>
            <span class="badge bg-primary px-3 py-1">Câu 3 (2.0 điểm) - Gom nhóm theo Mã cửa hàng SellerID</span>
        </div>
    </div>

    <!-- LẶP QUA TỪNG SELLER (GOM THEO MÃ CỬA HÀNG SELLERID) -->
    <c:forEach items="${sellerProductMap}" var="entry">
        <c:set var="seller" value="${entry.key}"/>
        <c:set var="products" value="${entry.value}"/>

        <div class="seller-block">
            <!-- TIÊU ĐỀ: MÃ CỬA HÀNG THEO ĐÚNG MẪU CÂU 3 -->
            <div class="seller-header d-flex justify-content-between align-items-center">
                <div>
                    <i class="fa-solid fa-shop me-2"></i>Mã cửa hàng: #${seller.sellerId} - ${seller.sellername}
                </div>
                <span class="badge bg-light text-dark fw-semibold">Tổng: ${products.size()} sản phẩm</span>
            </div>

            <!-- DANH SÁCH SẢN PHẨM THUỘC SELLER -->
            <div class="p-3">
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="alert alert-light text-center py-3 text-muted mb-0">
                            Gian hàng này hiện chưa có sản phẩm nào.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach items="${products}" var="p">
                                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                    <div class="product-item-card">
                                        <!-- [imageLink] bấm vào dẫn sang Câu 4 chi tiết -->
                                        <a href="<c:url value='/product/detail?id=${p.productId}'/>" title="Xem chi tiết: ${p.productName}">
                                            <img src="<c:url value='/image?fname=${p.images}'/>" class="product-img" alt="${p.productName}">
                                        </a>

                                        <!-- Tên sản phẩm: link sang Câu 4 chi tiết -->
                                        <div class="mb-2">
                                            <span class="product-field-label">Tên sản phẩm: </span>
                                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="product-field-value fw-bold text-primary text-decoration-none">
                                                ${p.productName}
                                            </a>
                                        </div>

                                        <!-- Mã sản phẩm: -->
                                        <div class="mb-1">
                                            <span class="product-field-label">Mã sản phẩm: </span>
                                            <span class="product-field-value fw-semibold text-secondary">#${p.productCode}</span>
                                        </div>

                                        <!-- Danh mục: -->
                                        <div class="mb-1">
                                            <span class="product-field-label">Danh mục: </span>
                                            <span class="product-field-value badge bg-light text-dark border">
                                                ${p.category != null ? p.category.categoryName : 'Chưa phân loại'}
                                            </span>
                                        </div>

                                        <!-- Giá: -->
                                        <div class="mb-1">
                                            <span class="product-field-label">Giá: </span>
                                            <span class="product-field-value fw-bold text-danger fs-6">
                                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                            </span>
                                        </div>

                                        <!-- Amount: -->
                                        <div class="mb-3">
                                            <span class="product-field-label">Amount: </span>
                                            <span class="product-field-value badge bg-info text-dark">${p.amount}</span>
                                        </div>

                                        <!-- Nút bấm xem chi tiết & thêm vào giỏ -->
                                        <div class="d-flex gap-2">
                                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary btn-sm flex-fill">
                                                <i class="fa-solid fa-arrow-up-right-from-square me-1"></i>Chi Tiết
                                            </a>
                                            <a href="<c:url value='/cart/add?productId=${p.productId}&quantity=1'/>" class="btn btn-primary btn-sm" title="Thêm vào giỏ hàng">
                                                <i class="fa-solid fa-cart-plus"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>

</body>
</html>
