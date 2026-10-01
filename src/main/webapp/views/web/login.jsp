<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập Tài Khoản</title>
</head>
<body>

    <div class="row justify-content-center py-4">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white text-center py-3 rounded-top-3">
                    <h4 class="fw-bold mb-0"><i class="fa-solid fa-right-to-bracket me-2"></i>ĐĂNG NHẬP</h4>
                    <p class="small text-white-50 mb-0">Hệ thống Lập Trình Web - MSSV: 24110257</p>
                </div>
                <div class="card-body p-4">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2 fs-5"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success d-flex align-items-center mb-3" role="alert">
                            <i class="fa-solid fa-circle-check me-2 fs-5"></i>
                            <div>${success}</div>
                        </div>
                    </c:if>

                    <form action="<c:url value='/login'/>" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" class="form-control" name="username" value="${username}" placeholder="Nhập username (ví dụ: admin, seller1, user1)" required autofocus>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                                <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu (mặc định: 123)" required>
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">
                                <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
                            </button>
                        </div>
                    </form>

                    <div class="text-center">
                        <span class="text-muted">Chưa có tài khoản?</span>
                        <a href="<c:url value='/register'/>" class="fw-bold text-decoration-none ms-1">Đăng ký kích hoạt OTP</a>
                    </div>

                    <!-- GỢI Ý TÀI KHOẢN MẪU ĐỂ CHẤM ĐIỂM NHANH -->
                    <div class="mt-4 pt-3 border-top">
                        <h6 class="fw-bold text-secondary mb-2"><i class="fa-solid fa-circle-info me-1"></i>Tài khoản mẫu để test phân quyền (Câu 2):</h6>
                        <ul class="list-unstyled small text-muted mb-0">
                            <li><span class="badge bg-danger me-1">Admin:</span> User: <code>admin</code> | Pass: <code>123</code> (Vào thẳng Quản trị)</li>
                            <li><span class="badge bg-warning text-dark me-1">Seller:</span> User: <code>seller1</code> | Pass: <code>123</code> (Vào Kênh người bán)</li>
                            <li><span class="badge bg-secondary me-1">User:</span> User: <code>user1</code> | Pass: <code>123</code> (Vào Trang chủ)</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>

</body>
</html>
