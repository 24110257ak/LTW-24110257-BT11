<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng Điều Khiển Quản Trị</title>
</head>
<body>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1">
                <i class="fa-solid fa-gauge-high text-primary me-2"></i>BẢNG ĐIỀU KHIỂN HỆ THỐNG
            </h2>
            <p class="text-muted mb-0">Quản trị toàn diện CSDL - MSSV: 24110257 - Đề 05</p>
        </div>
        <span class="badge bg-danger fs-6 px-3 py-2">
            <i class="fa-solid fa-user-shield me-1"></i>Tài khoản: ${sessionScope.account.username}
        </span>
    </div>

    <!-- STATS CARDS -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-primary text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-2 small text-white-50">Tổng Danh Mục</h6>
                        <h2 class="fw-bold mb-0">${categoryCount}</h2>
                    </div>
                    <i class="fa-solid fa-folder-tree fs-1 text-white-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <a href="<c:url value='/admin/categories'/>" class="text-white text-decoration-none small">
                        Xem chi tiết <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-success text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-2 small text-white-50">Tổng Sản Phẩm</h6>
                        <h2 class="fw-bold mb-0">${productCount}</h2>
                    </div>
                    <i class="fa-solid fa-boxes-stacked fs-1 text-white-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <a href="<c:url value='/admin/products'/>" class="text-white text-decoration-none small">
                        Xem chi tiết <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-warning text-dark">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-2 small text-dark-50">Gian Hàng (Seller)</h6>
                        <h2 class="fw-bold mb-0">${sellerCount}</h2>
                    </div>
                    <i class="fa-solid fa-store fs-1 text-dark-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <a href="<c:url value='/products-by-seller'/>" class="text-dark text-decoration-none small">
                        Xem ngoài Web <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm bg-info text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-2 small text-white-50">Người Dùng (Users)</h6>
                        <h2 class="fw-bold mb-0">${userCount}</h2>
                    </div>
                    <i class="fa-solid fa-users fs-1 text-white-50"></i>
                </div>
                <div class="card-footer bg-transparent border-0 pt-0">
                    <span class="text-white-50 small">Đã kích hoạt</span>
                </div>
            </div>
        </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="card border-0 shadow-sm p-4">
        <h5 class="fw-bold mb-3 text-secondary"><i class="fa-solid fa-bolt me-2 text-warning"></i>Truy Cập Nhanh Quản Trị Hệ Thống</h5>
        <div class="row g-3">
            <div class="col-md-6">
                <div class="p-3 border rounded bg-light d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1">Quản Lý Danh Mục (Category)</h6>
                        <p class="small text-muted mb-0">Thêm, sửa, xóa, tìm kiếm và phân trang danh mục</p>
                    </div>
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-primary btn-sm px-3">Quản Lý</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 border rounded bg-light d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1">Quản Lý Sản Phẩm (Product)</h6>
                        <p class="small text-muted mb-0">Thêm, sửa, xóa, tải ảnh và phân trang sản phẩm</p>
                    </div>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-success btn-sm px-3">Quản Lý</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
