<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm (Product) - Phân Trang</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-boxes-stacked text-success me-2"></i>QUẢN LÝ SẢN PHẨM (PRODUCT)
            </h3>
            <span class="badge bg-success px-3 py-1">Quản lý sản phẩm & Phân trang</span>
        </div>
        <a href="<c:url value='/admin/product/add'/>" class="btn btn-success shadow-sm">
            <i class="fa-solid fa-plus me-1"></i>Thêm Sản Phẩm Mới
        </a>
    </div>

    <!-- TÌM KIẾM VÀ THỐNG KÊ -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-3">
            <form action="<c:url value='/admin/products'/>" method="get" class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tên sản phẩm...">
                    </div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-success px-3">
                        <i class="fa-solid fa-search me-1"></i>Tìm Kiếm
                    </button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary ms-1">Xóa tìm</a>
                    </c:if>
                </div>
                <div class="col-auto ms-auto text-muted small">
                    Tìm thấy: <strong>${totalCount}</strong> sản phẩm | Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                </div>
            </form>
        </div>
    </div>

    <!-- BẢNG SẢN PHẨM -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3" style="width: 70px;">ID</th>
                            <th style="width: 80px;">Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th style="width: 100px;">Mã SP</th>
                            <th style="width: 160px;">Danh Mục</th>
                            <th style="width: 160px;">Cửa Hàng (Seller)</th>
                            <th style="width: 120px;">Đơn Giá</th>
                            <th style="width: 90px;">Amount</th>
                            <th style="width: 90px;">Stock</th>
                            <th class="text-end pe-3" style="width: 160px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty productList}">
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">
                                        <i class="fa-regular fa-folder-open fs-2 mb-2 d-block"></i>
                                        Không tìm thấy sản phẩm nào phù hợp!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${productList}" var="p">
                                    <tr>
                                        <td class="ps-3 fw-bold text-secondary">#${p.productId}</td>
                                        <td>
                                            <img src="<c:url value='/image?fname=${p.images}'/>" class="rounded border p-1" style="width: 50px; height: 50px; object-fit: contain; background: #fff;" alt="${p.productName}">
                                        </td>
                                        <td class="fw-semibold text-dark">
                                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" target="_blank" class="text-dark text-decoration-none">
                                                ${p.productName}
                                            </a>
                                        </td>
                                        <td><code>#${p.productCode}</code></td>
                                        <td><span class="badge bg-light text-dark border">${p.category != null ? p.category.categoryName : 'N/A'}</span></td>
                                        <td><span class="badge bg-warning text-dark">Shop #${p.sellerId}</span></td>
                                        <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> đ</td>
                                        <td>${p.amount}</td>
                                        <td>${p.stock}</td>
                                        <td class="text-end pe-3">
                                            <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-outline-warning btn-sm me-1" title="Chỉnh sửa">
                                                <i class="fa-solid fa-pen-to-square"></i> Sửa
                                            </a>
                                            <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm #${p.productId} - ${p.productName}?')" title="Xóa">
                                                <i class="fa-solid fa-trash-can"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- THANH PHÂN TRANG (PAGINATION) THEO YÊU CẦU CÂU 5 -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Phân trang sản phẩm" class="d-flex justify-content-center">
            <ul class="pagination shadow-sm">
                <!-- Nút Previous -->
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/admin/products?page=${currentPage - 1}&keyword=${keyword}'/>">
                        <i class="fa-solid fa-chevron-left me-1"></i>Trước
                    </a>
                </li>

                <!-- Danh sách các trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/admin/products?page=${i}&keyword=${keyword}'/>">${i}</a>
                    </li>
                </c:forEach>

                <!-- Nút Next -->
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/admin/products?page=${currentPage + 1}&keyword=${keyword}'/>">
                        Sau <i class="fa-solid fa-chevron-right ms-1"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>

</body>
</html>
