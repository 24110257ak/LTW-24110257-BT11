<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm - ${product.productName}</title>
    <style>
        .product-detail-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }
        .detail-img-box {
            background-color: #f8fafc;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
        }
        .detail-img {
            max-width: 100%;
            max-height: 380px;
            object-fit: contain;
        }
        .detail-label {
            font-weight: 700;
            color: #334155;
            min-width: 130px;
            display: inline-block;
        }
        .detail-value {
            font-size: 1.05rem;
            color: #0f172a;
        }
    </style>
</head>
<body>

    <!-- BREADCRUMB -->
    <nav aria-label="breadcrumb" class="mb-3">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/home'/>">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/products-by-seller'/>">Sản Phẩm Theo Gian Hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
        </ol>
    </nav>

    <c:choose>
        <c:when test="${empty product}">
            <div class="alert alert-warning text-center py-5">
                <i class="fa-solid fa-triangle-exclamation fs-1 text-warning mb-3"></i>
                <h4>Không tìm thấy sản phẩm yêu cầu!</h4>
                <p class="text-muted">Sản phẩm này có thể đã bị xóa hoặc không tồn tại trong hệ thống.</p>
                <a href="<c:url value='/products-by-seller'/>" class="btn btn-primary">Quay lại danh sách sản phẩm</a>
            </div>
        </c:when>
        <c:otherwise>

            <div class="product-detail-card p-4">
                <div class="border-bottom pb-3 mb-4 d-flex justify-content-between align-items-center">
                    <span class="badge bg-success px-3 py-2 fs-6"><i class="fa-solid fa-circle-info me-1"></i>Thông Tin Chi Tiết Sản Phẩm</span>
                    <a href="<c:url value='/products-by-seller'/>" class="btn btn-outline-secondary btn-sm">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>

                <div class="row g-4">
                    <!-- [imageLink] Hình ảnh sản phẩm -->
                    <div class="col-md-5">
                        <div class="detail-img-box">
                            <a href="<c:url value='/image?fname=${product.images}'/>" target="_blank" title="Xem ảnh gốc">
                                <img src="<c:url value='/image?fname=${product.images}'/>" class="detail-img" alt="${product.productName}">
                            </a>
                            <div class="mt-2 text-muted small"><i class="fa-solid fa-magnifying-glass-plus me-1"></i>Nhấn vào ảnh để phóng to</div>
                        </div>
                    </div>

                    <!-- THÔNG TIN THEO ĐÚNG MẪU ĐỀ BÀI CÂU 4 -->
                    <div class="col-md-7 d-flex flex-column">
                        <h2 class="fw-bold text-dark mb-3">${product.productName}</h2>

                        <div class="list-group list-group-flush mb-4">
                            <!-- Tên sản phẩm: -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Tên sản phẩm:</span>
                                <span class="detail-value fw-semibold text-primary">${product.productName}</span>
                            </div>

                            <!-- Mã sản phẩm: -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Mã sản phẩm:</span>
                                <span class="detail-value badge bg-secondary fs-6">#${product.productCode}</span>
                            </div>

                            <!-- Danh mục: -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Danh mục:</span>
                                <span class="detail-value badge bg-primary fs-6">
                                    ${product.category != null ? product.category.categoryName : 'Chưa phân loại'}
                                </span>
                            </div>

                            <!-- Giá: -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Giá:</span>
                                <span class="detail-value fw-bold text-danger fs-4">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> VNĐ
                                </span>
                            </div>

                            <!-- Tồn kho (Stock): -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Tình trạng:</span>
                                <c:choose>
                                    <c:when test="${product.stock != null && product.stock > 0}">
                                        <span class="detail-value badge bg-success-subtle text-success border border-success fs-6">
                                            <i class="fa-solid fa-box-open me-1"></i>Còn hàng (${product.stock})
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="detail-value badge bg-danger-subtle text-danger border border-danger fs-6">
                                            <i class="fa-solid fa-circle-xmark me-1"></i>Tạm hết hàng
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Gian hàng (Seller): -->
                            <div class="list-group-item px-0 py-2">
                                <span class="detail-label">Gian hàng:</span>
                                <span class="detail-value badge bg-warning text-dark fs-6">
                                    Mã #${product.sellerId} - ${product.seller != null ? product.seller.sellername : 'Chưa xác định'}
                                </span>
                            </div>

                            <!-- Description: -->
                            <div class="list-group-item px-0 py-3">
                                <span class="detail-label d-block mb-2">Description:</span>
                                <div class="p-3 bg-light rounded border text-secondary" style="line-height: 1.6;">
                                    ${product.description != null ? product.description : 'Chưa có mô tả chi tiết cho sản phẩm này.'}
                                </div>
                            </div>
                        </div>

                        <div class="mt-auto pt-2">
                            <c:choose>
                                <c:when test="${product.stock != null && product.stock > 0}">
                                    <form action="<c:url value='/cart/add'/>" method="post" class="mb-3">
                                        <input type="hidden" name="productId" value="${product.productId}"/>
                                        
                                        <div class="d-flex align-items-center mb-3">
                                            <span class="detail-label me-2">Chọn số lượng:</span>
                                            <div class="input-group" style="width: 140px;">
                                                <button type="button" class="btn btn-outline-secondary" onclick="let q=document.getElementById('buyQty'); if(parseInt(q.value)>1) q.value=parseInt(q.value)-1;">
                                                    <i class="fa-solid fa-minus"></i>
                                                </button>
                                                <input type="number" id="buyQty" name="quantity" value="1" min="1" max="${product.stock}" 
                                                       class="form-control text-center fw-bold" 
                                                       onchange="if(parseInt(this.value)<1) this.value=1; if(parseInt(this.value)>${product.stock}) this.value=${product.stock};">
                                                <button type="button" class="btn btn-outline-secondary" onclick="let q=document.getElementById('buyQty'); if(parseInt(q.value)<${product.stock}) q.value=parseInt(q.value)+1;">
                                                    <i class="fa-solid fa-plus"></i>
                                                </button>
                                            </div>
                                            <small class="text-muted ms-3">(Tối đa: ${product.stock})</small>
                                        </div>

                                        <div class="d-flex flex-wrap gap-2">
                                            <button type="submit" class="btn btn-primary btn-lg px-4 shadow-sm">
                                                <i class="fa-solid fa-cart-plus me-2"></i>Thêm Vào Giỏ Hàng
                                            </button>
                                            <button type="submit" name="action" value="buynow" class="btn btn-danger btn-lg px-4 shadow-sm">
                                                <i class="fa-solid fa-bolt me-2"></i>Mua Ngay (COD)
                                            </button>
                                            <a href="<c:url value='/cart'/>" class="btn btn-outline-success btn-lg">
                                                <i class="fa-solid fa-cart-shopping me-1"></i>Xem giỏ hàng
                                            </a>
                                        </div>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-danger mb-3">
                                        <i class="fa-solid fa-circle-exclamation me-2"></i>Sản phẩm này tạm thời đã hết hàng trong kho!
                                    </div>
                                    <button class="btn btn-secondary btn-lg disabled me-2">
                                        <i class="fa-solid fa-ban me-2"></i>Hết Hàng
                                    </button>
                                </c:otherwise>
                            </c:choose>
                            <a href="<c:url value='/products-by-seller'/>" class="btn btn-link text-decoration-none px-0 mt-2">
                                <i class="fa-solid fa-arrow-left me-1"></i>Xem thêm sản phẩm cùng gian hàng khác
                            </a>
                        </div>
                    </div>
                </div>
            </div>

        </c:otherwise>
    </c:choose>

</body>
</html>
