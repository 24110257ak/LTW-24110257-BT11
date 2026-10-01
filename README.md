# BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB - ĐỀ SỐ 05
**Sinh viên thực hiện:** 24110257  
**Repository nộp bài:** [https://github.com/24110257ak/LTW-24110257-BT11.git](https://github.com/24110257ak/LTW-24110257-BT11.git)  

---

## 📌 Tổng Quan Các Chức Năng Hoàn Thành Cho Vai Trò User

### 1. Chức năng Giỏ hàng (Cart)
- **Thêm sản phẩm vào giỏ**:
  - Thêm từ trang Chi tiết sản phẩm (`/product/detail`) với ô chọn số lượng tăng/giảm.
  - Thêm nhanh từ trang Chủ (`/home`) hoặc trang Danh sách theo Seller (`/products-by-seller`).
  - **Kiểm soát giới hạn số lượng theo tồn kho (`stock`)**:
    - Không cho phép chọn hoặc thêm vượt quá số lượng hàng tồn trong kho.
    - Nếu sản phẩm đã hết hàng (`stock <= 0`), hiển thị trạng thái "Hết hàng" và vô hiệu hóa nút mua.
    - Cảnh báo rõ ràng cho người dùng nếu số lượng yêu cầu chạm ngưỡng tối đa.
- **Sửa / Thay đổi số lượng**:
  - Tăng (`+`) hoặc Giảm (`-`) số lượng ngay trên giao diện giỏ hàng.
  - Nhập trực tiếp số lượng: tự động kiểm tra `1 <= quantity <= stock`.
- **Xóa sản phẩm khỏi giỏ**:
  - Nút xóa từng sản phẩm có xác nhận.
  - Nút "Xóa tất cả" làm sạch toàn bộ giỏ hàng.
- **Tóm tắt đơn hàng**: Tự động tính số lượng, tạm tính, phí vận chuyển (Free ship), tổng tiền thanh toán.
- **Hiển thị Badge số lượng giỏ hàng trên Header/Navbar**: Cập nhật theo thời gian thực mỗi khi có thao tác với giỏ.

---

### 2. Chức năng Thanh toán đơn hàng bằng COD (Cash On Delivery)
- **Truy cập**: `/checkout` (Yêu cầu đăng nhập, nếu chưa đăng nhập sẽ chuyển hướng sang trang login).
- **Thông tin nhận hàng**:
  - Tự động điền thông tin tài khoản: Họ tên, Số điện thoại, Email.
  - Cho phép người dùng chỉnh sửa Họ tên, Số điện thoại, nhập Địa chỉ giao hàng chi tiết và Ghi chú đơn hàng.
- **Phương thức thanh toán**:
  - Chọn mặc định phương thức **Thanh toán khi nhận hàng (COD)**.
  - Hiển thị mô tả rõ ràng, an toàn 100%.
- **Xử lý lưu trữ CSDL & Trừ tồn kho**:
  - Sinh mã đơn hàng duy nhất `ORD...`.
  - Tạo bản ghi mới trong bảng `dbo.Cart` với `status = 1` (Đơn hàng mới).
  - Tạo các bản ghi chi tiết mặt hàng trong bảng `dbo.CartItem` (`cartItemId`, `cartId`, `productId`, `quantity`, `unitPrice`).
  - **Tự động trừ số lượng tồn kho (`stock`)** của các sản phẩm tương ứng trong bảng `dbo.Product`.
  - Làm trống giỏ hàng trong Session sau khi đặt thành công.
- **Trang thông báo hoàn tất đặt hàng**: `/checkout/success` hiển thị đầy đủ chi tiết đơn hàng vừa tạo, tổng tiền, mã đơn hàng.

---

### 3. Chức năng Lịch sử đặt hàng lọc theo 8 trạng thái
- **Truy cập**: `/orders` (hoặc dropdown menu tại thanh điều hướng).
- **Hệ thống lọc theo 8 trạng thái đề bài quy định**:
  1. `status = 1`: **Đơn hàng mới** (Màu xanh dương - `bg-primary`)
  2. `status = 2`: **Đã xác nhận** (Màu xanh lơ - `bg-info`)
  3. `status = 3`: **Chuẩn bị hàng** (Màu vàng cam - `bg-warning`)
  4. `status = 4`: **Vận chuyển** (Màu xám - `bg-secondary`)
  5. `status = 5`: **Giao hàng** (Màu lam viền - `bg-primary bg-opacity-75`)
  6. `status = 6`: **Đã giao** (Màu xanh lá - `bg-success`)
  7. `status = 7`: **Đơn hàng hủy** (Màu đỏ - `bg-danger`)
  8. `status = 8`: **Đơn hàng hoàn** (Màu tối - `bg-dark`)
  - Kèm tab **Tất cả** để xem toàn bộ lịch sử đơn hàng.
  - Trên mỗi tab hiển thị Badge số lượng đơn tương ứng với trạng thái đó.
- **Thông tin chi tiết hiển thị cho mỗi đơn hàng**:
  - Mã đơn hàng, Ngày giờ đặt mua (`buyDate`), Phương thức COD.
  - Badge trạng thái nổi bật với màu sắc riêng biệt.
  - Danh sách sản phẩm trong đơn (Hình ảnh, Tên sản phẩm, Mã SP, Đơn giá, Số lượng, Thành tiền).
  - Tổng số lượng và Tổng tiền thanh toán của đơn hàng.
- **Tính năng Hủy đơn hàng**:
  - Đối với các đơn hàng ở trạng thái **Đơn hàng mới (`status = 1`)**, người dùng có thể nhấn nút **"Hủy đơn hàng"**.
  - Hệ thống sẽ chuyển trạng thái đơn sang **Đơn hàng hủy (`status = 7`)** và **hoàn lại số lượng sản phẩm vào tồn kho (`stock`)**.
- **Tính năng Mua lại**: Nút "Mua lại" hỗ trợ thêm nhanh sản phẩm vào giỏ để đặt tiếp.

---

### 💡 Hướng dẫn kiểm thử thay đổi trạng thái trong CSDL
Để quan sát trạng thái đơn hàng thay đổi linh hoạt trên giao diện Web theo đúng yêu cầu bài kiểm tra:
1. Mở Microsoft SQL Server Management Studio (SSMS).
2. Chạy truy vấn thay đổi cột `status` trong bảng `Cart`:
```sql
USE DB_KT_24110257;

-- Đơn hàng mới (status = 1)
UPDATE Cart SET status = 1 WHERE cartId = 'ORD...';

-- Đã xác nhận (status = 2)
UPDATE Cart SET status = 2 WHERE cartId = 'ORD...';

-- Chuẩn bị hàng (status = 3)
UPDATE Cart SET status = 3 WHERE cartId = 'ORD...';

-- Vận chuyển (status = 4)
UPDATE Cart SET status = 4 WHERE cartId = 'ORD...';

-- Giao hàng (status = 5)
UPDATE Cart SET status = 5 WHERE cartId = 'ORD...';

-- Đã giao (status = 6)
UPDATE Cart SET status = 6 WHERE cartId = 'ORD...';

-- Đơn hàng hủy (status = 7)
UPDATE Cart SET status = 7 WHERE cartId = 'ORD...';

-- Đơn hàng hoàn (status = 8)
UPDATE Cart SET status = 8 WHERE cartId = 'ORD...';
```
3. Sau khi cập nhật, quay lại trang web `/orders` và nhấn F5 để xem đơn hàng tự động xuất hiện ở tab trạng thái tương ứng!

---

## 🛠 Công Nghệ Sử Dụng
- **Ngôn ngữ**: Java 17
- **Nền tảng**: Jakarta Servlet 6.0, Jakarta Server Pages (JSP), JSTL 3.0
- **ORM / Persistence**: Hibernate Core 6.6.1.Final, JPA 3.1
- **Layout Decorator**: SiteMesh 3.2.1
- **Hệ quản trị CSDL**: Microsoft SQL Server
- **Giao diện**: HTML5, CSS3, Bootstrap 5.3.3, FontAwesome 6.5.1
- **Quản lý dự án / Build Tool**: Apache Maven
