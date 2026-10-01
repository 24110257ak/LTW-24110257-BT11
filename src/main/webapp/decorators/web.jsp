<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - HCMUTE Store (24110257)</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8fafc;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }
        .main-content {
            flex: 1 0 auto;
        }
        .navbar-brand {
            font-weight: 700;
            color: #0d6efd !important;
            letter-spacing: -0.5px;
        }
        .footer-custom {
            background-color: #1e293b;
            color: #cbd5e1;
            padding: 24px 0 16px 0;
            margin-top: 40px;
        }
        .badge-student {
            background-color: #0284c7;
            font-weight: 500;
        }
        .navbar .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff !important;
            border-radius: 6px;
            padding: 6px 14px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- HEADER / NAVIGATION THEO YÊU CẦU CÂU 1 -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/home'/>">
                <i class="fa-solid fa-graduation-cap text-primary me-2"></i>HCMUTE STORE
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-center">
                    <li class="nav-item me-1">
                        <a class="nav-link ${pageContext.request.requestURI.endsWith('/home') || pageContext.request.requestURI.endsWith('/') ? 'active fw-bold' : 'fw-medium'}" href="<c:url value='/home'/>">
                            <i class="fa-solid fa-house me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item me-1">
                        <a class="nav-link ${pageContext.request.requestURI.contains('product') ? 'active fw-bold' : 'fw-medium'}" href="<c:url value='/products-by-seller'/>">
                            <i class="fa-solid fa-boxes-stacked me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <!-- Trang quản trị: Chỉ hiển thị khi Admin đăng nhập (roleId == 2) theo yêu cầu Câu 1 -->
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 2}">
                        <li class="nav-item">
                            <a class="nav-link text-danger fw-bold" href="<c:url value='/admin/categories'/>">
                                <i class="fa-solid fa-screwdriver-wrench me-1"></i>Trang quản trị
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account != null && (sessionScope.account.roleId == 3 || sessionScope.account.sellerId != null)}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold" href="<c:url value='/seller/home'/>">
                                <i class="fa-solid fa-store me-1"></i>Kênh Người Bán
                            </a>
                        </li>
                    </c:if>
                    <!-- Lịch sử đặt hàng: Dành cho User đã đăng nhập -->
                    <c:if test="${sessionScope.account != null}">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.requestURI.contains('/orders') ? 'active fw-bold' : 'fw-medium'}" href="<c:url value='/orders'/>">
                                <i class="fa-solid fa-clock-rotate-left me-1"></i>Lịch Sử Đặt Hàng
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- USER AUTH STATUS & CART -->
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                    <!-- NÚT GIỎ HÀNG -->
                    <li class="nav-item me-3">
                        <a class="btn btn-outline-primary position-relative d-flex align-items-center px-3 py-1" href="<c:url value='/cart'/>" title="Xem giỏ hàng">
                            <i class="fa-solid fa-cart-shopping me-2"></i>
                            <span>Giỏ hàng</span>
                            <c:set var="cartTotalQty" value="0"/>
                            <c:if test="${not empty sessionScope.cart}">
                                <c:forEach items="${sessionScope.cart}" var="ci">
                                    <c:set var="cartTotalQty" value="${cartTotalQty + ci.value.quantity}"/>
                                </c:forEach>
                            </c:if>
                            <span class="badge bg-danger rounded-pill ms-2" id="cartCountBadge">${cartTotalQty}</span>
                        </a>
                    </li>

                    <c:choose>
                        <c:when test="${sessionScope.account == null}">
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-primary btn-sm px-3" href="<c:url value='/login'/>">
                                    <i class="fa-solid fa-right-to-bracket me-1"></i>Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary btn-sm px-3" href="<c:url value='/register'/>">
                                    <i class="fa-solid fa-user-plus me-1"></i>Đăng ký
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center fw-medium" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-circle-user text-primary fs-5 me-2"></i>
                                    <span>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}</span>
                                    <span class="badge bg-secondary ms-2">
                                        <c:choose>
                                            <c:when test="${sessionScope.account.roleId == 2}">Admin</c:when>
                                            <c:when test="${sessionScope.account.roleId == 3}">Seller</c:when>
                                            <c:otherwise>User</c:otherwise>
                                        </c:choose>
                                    </span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <li><a class="dropdown-item" href="<c:url value='/orders'/>"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>Lịch sử đặt hàng</a></li>
                                    <li><a class="dropdown-item" href="<c:url value='/cart'/>"><i class="fa-solid fa-cart-shopping me-2 text-primary"></i>Giỏ hàng của tôi</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <c:if test="${sessionScope.account.roleId == 2}">
                                        <li><a class="dropdown-item text-danger" href="<c:url value='/admin/categories'/>"><i class="fa-solid fa-shield-halved me-2"></i>Trang Quản Trị</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <c:if test="${sessionScope.account.roleId == 3 || sessionScope.account.sellerId != null}">
                                        <li><a class="dropdown-item text-warning" href="<c:url value='/seller/home'/>"><i class="fa-solid fa-store me-2"></i>Kênh Người Bán</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- MAIN BODY CONTENT -->
    <main class="main-content py-4">
        <div class="container">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- FOOTER THEO YÊU CẦU CÂU 1 (Họ tên, MSSV, Mã đề) -->
    <footer class="footer-custom">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start mb-2 mb-md-0">
                    <h6 class="text-white mb-1"><i class="fa-solid fa-laptop-code me-2 text-info"></i>BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB</h6>
                    <p class="small text-muted mb-0">Khoa CNTT - Bộ Môn Công Nghệ Phần Mềm - HCMUTE</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <span class="badge bg-primary px-3 py-2 me-2">Họ và tên: Nguyễn Văn Sinh Viên</span>
                    <span class="badge bg-success px-3 py-2 me-2">MSSV: 24110257</span>
                    <span class="badge bg-danger px-3 py-2">Mã đề: Đề 05</span>
                </div>
            </div>
            <hr class="border-secondary my-3">
            <p class="small text-muted mb-0">© 2026 - Bản quyền thuộc về Sinh viên MSSV 24110257 - Bài thi Quá trình Đề 05</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
