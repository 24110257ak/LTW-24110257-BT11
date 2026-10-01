<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kênh Người Bán - Gian Hàng</title>
</head>
<body>

    <div class="card shadow-sm border-0 mb-4 bg-white">
        <div class="card-body p-4 d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center">
                <div class="bg-warning text-dark p-3 rounded-circle me-3 fs-3">
                    <i class="fa-solid fa-store"></i>
                </div>
                <div>
                    <span class="badge bg-warning text-dark mb-1">Mã Cửa Hàng: #${seller.sellerId}</span>
                    <h3 class="fw-bold mb-0 text-dark">${seller.sellername}</h3>
                    <p class="text-muted small mb-0">Chủ gian hàng: ${sessionScope.account.fullname} (${sessionScope.account.username})</p>
                </div>
            </div>
            <div>
                <a href="<c:url value='/products-by-seller'/>" class="btn btn-outline-primary">
                    <i class="fa-solid fa-eye me-1"></i>Xem hiển thị ngoài Store
                </a>
            </div>
        </div>
    </div>

    <!-- DANH SÁCH SẢN PHẨM CỦA GIAN HÀNG -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0 text-secondary"><i class="fa-solid fa-box-archive me-2"></i>Sản Phẩm Của Gian Hàng (${productList.size()} sản phẩm)</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Ảnh</th>
                            <th>Mã SP</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Danh Mục</th>
                            <th>Đơn Giá</th>
                            <th>Số Lượng (Amount)</th>
                            <th>Tồn Kho (Stock)</th>
                            <th>Chi Tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <tr>
                                <td>
                                    <img src="<c:url value='/image?fname=${p.images}'/>" class="rounded border" style="width: 50px; height: 50px; object-fit: contain;">
                                </td>
                                <td><code>#${p.productCode}</code></td>
                                <td class="fw-semibold">${p.productName}</td>
                                <td><span class="badge bg-light text-dark border">${p.category != null ? p.category.categoryName : 'N/A'}</span></td>
                                <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ</td>
                                <td>${p.amount}</td>
                                <td>${p.stock}</td>
                                <td>
                                    <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-sm btn-outline-info">
                                        <i class="fa-solid fa-circle-info"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
