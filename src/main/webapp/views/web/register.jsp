<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký Tài Khoản Kích Hoạt OTP</title>
</head>
<body>

    <div class="row justify-content-center py-3">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-success text-white text-center py-3 rounded-top-3">
                    <h4 class="fw-bold mb-0"><i class="fa-solid fa-user-plus me-2"></i>ĐĂNG KÝ TÀI KHOẢN</h4>
                    <p class="small text-white-50 mb-0">Kích hoạt mã OTP qua Email - Câu 2 (1.5 điểm)</p>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center mb-3" role="alert">
                            <i class="fa-solid fa-triangle-exclamation me-2 fs-5"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>

                    <form action="<c:url value='/register'/>" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="username" value="${user.username}" placeholder="Nhập username" required autofocus>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Địa chỉ Email nhận OTP <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                    <input type="email" class="form-control" name="email" value="${user.email}" placeholder="example@domain.com" required>
                                </div>
                                <div class="form-text text-muted">Mã OTP 6 số sẽ được gửi đến email này (và in ra console máy chủ).</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Họ và tên</label>
                                <input type="text" class="form-control" name="fullname" value="${user.fullname}" placeholder="Họ và tên sinh viên">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="tel" class="form-control" name="phone" value="${user.phone}" placeholder="0901234567">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Vai trò đăng ký</label>
                                <select class="form-select" name="roleId" id="roleSelect" onchange="toggleSellerField()">
                                    <option value="1" selected>Người mua hàng (User)</option>
                                    <option value="3">Người bán hàng (Seller)</option>
                                </select>
                            </div>
                            <div class="col-md-6" id="sellerField" style="display: none;">
                                <label class="form-label fw-semibold">Chọn Gian Hàng Của Bạn</label>
                                <select class="form-select" name="sellerId">
                                    <c:forEach items="${sellerList}" var="sel">
                                        <option value="${sel.sellerId}">${sel.sellername}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg fw-bold">
                                <i class="fa-solid fa-paper-plane me-2"></i>Tiếp Tục & Nhận Mã OTP
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <span class="text-muted">Đã có tài khoản?</span>
                        <a href="<c:url value='/login'/>" class="fw-bold text-decoration-none ms-1">Đăng nhập</a>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleSellerField() {
            var role = document.getElementById("roleSelect").value;
            var sellerDiv = document.getElementById("sellerField");
            if (role === "3") {
                sellerDiv.style.display = "block";
            } else {
                sellerDiv.style.display = "none";
            }
        }
    </script>

</body>
</html>
