<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Trang Quản Trị Hệ Thống (24110257)</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f1f5f9;
        }
        .main-content {
            flex: 1 0 auto;
        }
        .admin-nav {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        }
        .footer-admin {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 20px 0;
            margin-top: 40px;
        }
        .admin-nav .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff !important;
            border-radius: 6px;
            padding: 6px 14px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- ADMIN HEADER NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark admin-nav shadow">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold text-white" href="<c:url value='/admin/home'/>">
                <i class="fa-solid fa-shield-halved text-warning me-2"></i>ADMIN PANEL (24110257)
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-center">
                    <li class="nav-item me-1">
                        <a class="nav-link ${pageContext.request.requestURI.endsWith('/admin/home') ? 'active fw-bold' : ''}" href="<c:url value='/admin/home'/>">
                            <i class="fa-solid fa-gauge-high me-1"></i>Bảng điều khiển
                        </a>
                    </li>
                    <li class="nav-item me-1">
                        <a class="nav-link ${pageContext.request.requestURI.contains('/admin/categor') ? 'active fw-bold' : ''}" href="<c:url value='/admin/categories'/>">
                            <i class="fa-solid fa-folder-tree me-1"></i>Quản Lý Category
                        </a>
                    </li>
                    <li class="nav-item me-1">
                        <a class="nav-link ${pageContext.request.requestURI.contains('/admin/product') ? 'active fw-bold' : ''}" href="<c:url value='/admin/products'/>">
                            <i class="fa-solid fa-box-open me-1"></i>Quản Lý Product
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3">
                        <a class="btn btn-sm btn-outline-light" href="<c:url value='/home'/>">
                            <i class="fa-solid fa-arrow-up-right-from-square me-1"></i>Xem trang web
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-sm btn-danger" href="<c:url value='/logout'/>">
                            <i class="fa-solid fa-right-from-bracket me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ADMIN CONTENT -->
    <main class="main-content py-4">
        <div class="container-fluid px-4">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- ADMIN FOOTER -->
    <footer class="footer-admin">
        <div class="container-fluid px-4 text-center">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start">
                    <span class="text-white fw-bold">HỆ THỐNG QUẢN TRỊ BÀI THI QUÁ TRÌNH</span> - Đề 05
                </div>
                <div class="col-md-6 text-md-end">
                    <span class="badge bg-primary px-3 py-2 me-2">Họ tên: Trần Vũ Anh Khoa</span>
                    <span class="badge bg-warning text-dark px-3 py-2 me-2">MSSV: 24110257</span>
                    <span class="badge bg-danger px-3 py-2">Mã đề: Đề 05</span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
