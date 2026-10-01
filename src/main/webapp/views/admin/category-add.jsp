<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Danh Mục Mới</title>
</head>
<body>

    <div class="row justify-content-center py-2">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-folder-plus me-2"></i>THÊM DANH MỤC MỚI (CATEGORY)</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/add'/>" method="post" enctype="multipart/form-data">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="categoryName" placeholder="Nhập tên danh mục..." required autofocus>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Trạng thái:</label>
                            <select class="form-select" name="status">
                                <option value="1" selected>Hoạt động (Active)</option>
                                <option value="0">Tạm khóa (Inactive)</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Hình ảnh đại diện:</label>
                            <input type="file" class="form-control" name="image" id="catImageInput" accept="image/*" onchange="previewImage(this, 'catImagePreview')">
                            <div class="form-text">Hỗ trợ các định dạng .jpg, .png, .jpeg.</div>
                            
                            <!-- Xem trước ảnh bằng JavaScript -->
                            <div class="mt-3 text-center p-2 border rounded bg-light" id="previewContainer" style="display: none;">
                                <span class="d-block small text-muted mb-2">Xem trước ảnh:</span>
                                <img id="catImagePreview" src="#" alt="Preview" class="img-fluid rounded border" style="max-height: 140px; object-fit: contain;">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between pt-2">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i>Hủy & Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="fa-solid fa-floppy-disk me-1"></i>Lưu Danh Mục
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
