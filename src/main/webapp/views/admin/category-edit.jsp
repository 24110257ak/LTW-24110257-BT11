<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh Sửa Danh Mục - #${category.categoryId}</title>
</head>
<body>

    <div class="row justify-content-center py-2">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning text-dark py-3">
                    <h5 class="fw-bold mb-0"><i class="fa-solid fa-pen-to-square me-2"></i>CHỈNH SỬA DANH MỤC #${category.categoryId}</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/category/edit'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${category.categoryId}">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="categoryName" value="${category.categoryName}" required autofocus>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Trạng thái:</label>
                            <select class="form-select" name="status">
                                <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động (Active)</option>
                                <option value="0" ${category.status == 0 ? 'selected' : ''}>Tạm khóa (Inactive)</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Hình ảnh hiện tại:</label>
                            <div class="mb-2 text-center p-2 border rounded bg-light">
                                <img src="<c:url value='/image?fname=${category.images}'/>" alt="${category.categoryName}" class="img-fluid rounded border" style="max-height: 120px; object-fit: contain;">
                            </div>

                            <label class="form-label fw-semibold mt-2">Chọn ảnh mới thay thế (nếu có):</label>
                            <input type="file" class="form-control" name="image" id="catImageEditInput" accept="image/*" onchange="previewImage(this, 'catImageEditPreview')">
                            
                            <div class="mt-3 text-center p-2 border rounded bg-light" id="previewContainer" style="display: none;">
                                <span class="d-block small text-muted mb-2">Ảnh mới xem trước:</span>
                                <img id="catImageEditPreview" src="#" alt="Preview" class="img-fluid rounded border" style="max-height: 120px; object-fit: contain;">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between pt-2">
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i>Hủy & Quay lại
                            </a>
                            <button type="submit" class="btn btn-warning px-4 fw-bold">
                                <i class="fa-solid fa-floppy-disk me-1"></i>Cập Nhật Danh Mục
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
