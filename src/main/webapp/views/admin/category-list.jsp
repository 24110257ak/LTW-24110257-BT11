<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Danh Mục (Category) - Phân Trang</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-folder-tree text-primary me-2"></i>QUẢN LÝ DANH MỤC (CATEGORY)
            </h3>
            <span class="badge bg-primary px-3 py-1">Câu 5 (3.0 điểm) - CRUD & Phân trang Category</span>
        </div>
        <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary shadow-sm">
            <i class="fa-solid fa-plus me-1"></i>Thêm Danh Mục Mới
        </a>
    </div>

    <!-- TÌM KIẾM VÀ THỐNG KÊ -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-3">
            <form action="<c:url value='/admin/categories'/>" method="get" class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tên danh mục...">
                    </div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary px-3">
                        <i class="fa-solid fa-search me-1"></i>Tìm Kiếm
                    </button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary ms-1">Xóa tìm</a>
                    </c:if>
                </div>
                <div class="col-auto ms-auto text-muted small">
                    Tìm thấy: <strong>${totalCount}</strong> danh mục | Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                </div>
            </form>
        </div>
    </div>

    <!-- BẢNG DANH MỤC -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3" style="width: 80px;">ID</th>
                            <th style="width: 100px;">Hình Ảnh</th>
                            <th>Tên Danh Mục</th>
                            <th style="width: 150px;">Trạng Thái</th>
                            <th class="text-end pe-3" style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty categoryList}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">
                                        <i class="fa-regular fa-folder-open fs-2 mb-2 d-block"></i>
                                        Không tìm thấy danh mục nào phù hợp!
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${categoryList}" var="cat">
                                    <tr>
                                        <td class="ps-3 fw-bold text-secondary">#${cat.categoryId}</td>
                                        <td>
                                            <img src="<c:url value='/image?fname=${cat.images}'/>" class="rounded border p-1" style="width: 60px; height: 50px; object-fit: contain; background: #fff;" alt="${cat.categoryName}">
                                        </td>
                                        <td class="fw-semibold text-dark">${cat.categoryName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${cat.status == 1}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                                        <i class="fa-solid fa-circle-check me-1"></i>Hoạt động
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1">
                                                        <i class="fa-solid fa-circle-xmark me-1"></i>Tạm khóa
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-3">
                                            <a href="<c:url value='/admin/category/edit?id=${cat.categoryId}'/>" class="btn btn-outline-warning btn-sm me-1" title="Chỉnh sửa">
                                                <i class="fa-solid fa-pen-to-square"></i> Sửa
                                            </a>
                                            <a href="<c:url value='/admin/category/delete?id=${cat.categoryId}'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục #${cat.categoryId} - ${cat.categoryName}?')" title="Xóa">
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
        <nav aria-label="Phân trang danh mục" class="d-flex justify-content-center">
            <ul class="pagination shadow-sm">
                <!-- Nút Previous -->
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage - 1}&keyword=${keyword}'/>">
                        <i class="fa-solid fa-chevron-left me-1"></i>Trước
                    </a>
                </li>

                <!-- Danh sách các trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/admin/categories?page=${i}&keyword=${keyword}'/>">${i}</a>
                    </li>
                </c:forEach>

                <!-- Nút Next -->
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/admin/categories?page=${currentPage + 1}&keyword=${keyword}'/>">
                        Sau <i class="fa-solid fa-chevron-right ms-1"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>

</body>
</html>
