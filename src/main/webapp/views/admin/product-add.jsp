<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sản Phẩm Mới</title>
</head>
<body>

    <div class="row justify-content-center py-2">
        <div class="col-md-9 col-lg-8">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-box-open me-2"></i>THÊM SẢN PHẨM MỚI (PRODUCT)</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/product/add'/>" method="post" enctype="multipart/form-data">
                        
                        <div class="row g-3">
                            <div class="col-md-8">
                                <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="productName" placeholder="Nhập tên sản phẩm..." required autofocus>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Mã sản phẩm (Code)</label>
                                <input type="number" class="form-control" name="productCode" placeholder="Ví dụ: 10005" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Danh mục (Category) <span class="text-danger">*</span></label>
                                <select class="form-select" name="categoryId" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach items="${categoryList}" var="c">
                                        <option value="${c.categoryId}">${c.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Cửa hàng (Seller) <span class="text-danger">*</span></label>
                                <select class="form-select" name="sellerId" required>
                                    <option value="">-- Chọn cửa hàng --</option>
                                    <c:forEach items="${sellerList}" var="s">
                                        <option value="${s.sellerId}">Mã #${s.sellerId} - ${s.sellername}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" step="1000" class="form-control" name="price" placeholder="150000" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Số lượng (Amount)</label>
                                <input type="number" class="form-control" name="amount" value="50" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Tồn kho (Stock)</label>
                                <input type="number" class="form-control" name="stock" value="45" required>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả sản phẩm (Description)</label>
                                <textarea class="form-control" name="description" rows="3" placeholder="Nhập mô tả chi tiết sản phẩm..."></textarea>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Trạng thái:</label>
                                <select class="form-select" name="status">
                                    <option value="1" selected>Đang bán (Active)</option>
                                    <option value="0">Ngừng bán (Inactive)</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Hình ảnh sản phẩm:</label>
                                <input type="file" class="form-control" name="image" id="prodImageInput" accept="image/*" onchange="previewImage(this, 'prodImagePreview')">
                            </div>

                            <div class="col-12" id="previewContainer" style="display: none;">
                                <div class="text-center p-2 border rounded bg-light">
                                    <span class="d-block small text-muted mb-2">Xem trước ảnh sản phẩm:</span>
                                    <img id="prodImagePreview" src="#" alt="Preview" class="img-fluid rounded border" style="max-height: 150px; object-fit: contain;">
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between pt-4">
                            <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i>Hủy & Quay lại
                            </a>
                            <button type="submit" class="btn btn-success px-4 fw-bold">
                                <i class="fa-solid fa-floppy-disk me-1"></i>Lưu Sản Phẩm
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input, previewId) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var preview = document.getElementById(previewId);
                    preview.src = e.target.result;
                    document.getElementById('previewContainer').style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</body>
</html>
