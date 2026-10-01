<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác Thực Mã OTP</title>
</head>
<body>

    <div class="row justify-content-center py-4">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow border-0 rounded-3 text-center">
                <div class="card-header bg-warning text-dark py-3 rounded-top-3">
                    <h4 class="fw-bold mb-0"><i class="fa-solid fa-key me-2"></i>KÍCH HOẠT MÃ OTP</h4>
                    <p class="small mb-0">Xác thực tài khoản qua Email (Câu 2)</p>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mb-3" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                        </div>
                    </c:if>

                    <p class="text-muted mb-3">
                        Hệ thống đã gửi một mã xác thực 6 số đến email: <br>
                        <strong class="text-primary">${email}</strong>
                    </p>

                    <div class="alert alert-info py-2 small mb-3">
                        <i class="fa-solid fa-lightbulb me-1"></i>
                        <em>Nếu test offline, mã OTP cũng đã được in trực tiếp ra Console của Server!</em>
                    </div>

                    <form action="<c:url value='/verify-otp'/>" method="post">
                        <input type="hidden" name="email" value="${email}">

                        <div class="mb-4">
                            <label class="form-label fw-bold">Nhập mã OTP 6 chữ số:</label>
                            <input type="text" class="form-control form-control-lg text-center fw-bold letter-spacing-lg" 
                                   name="otp" maxlength="6" placeholder="______" required autofocus
                                   style="font-size: 28px; letter-spacing: 8px;">
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-warning btn-lg fw-bold">
                                <i class="fa-solid fa-circle-check me-2"></i>Xác Nhận Kích Hoạt
                            </button>
                        </div>
                    </form>

                    <div>
                        <a href="<c:url value='/login'/>" class="text-decoration-none small text-muted">
                            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại trang Đăng nhập
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>

</body>
</html>
