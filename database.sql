-- BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB - ĐỀ SỐ 05
-- SINH VIÊN: 24110257
-- HỆ QUẢN TRỊ CSDL: MICROSOFT SQL SERVER

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DB_KT_24110257')
BEGIN
    CREATE DATABASE DB_KT_24110257;
END
GO

USE DB_KT_24110257;
GO

-- XÓA BẢNG NẾU ĐÃ TỒN TẠI (THEO THỨ TỰ RÀNG BUỘC KHÓA NGOẠI)
IF OBJECT_ID('dbo.CartItem', 'U') IS NOT NULL DROP TABLE dbo.CartItem;
IF OBJECT_ID('dbo.Cart', 'U') IS NOT NULL DROP TABLE dbo.Cart;
IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL DROP TABLE dbo.Product;
IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL DROP TABLE dbo.Category;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID('dbo.Seller', 'U') IS NOT NULL DROP TABLE dbo.Seller;
IF OBJECT_ID('dbo.UserRoles', 'U') IS NOT NULL DROP TABLE dbo.UserRoles;
GO

-- 1. BẢNG UserRoles
CREATE TABLE dbo.UserRoles (
    roleId INT IDENTITY(1,1) PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL
);
GO

-- 2. BẢNG Seller
CREATE TABLE dbo.Seller (
    sellerId INT IDENTITY(1,1) PRIMARY KEY,
    sellername NVARCHAR(50) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NULL DEFAULT 1
);
GO

-- 3. BẢNG Users
CREATE TABLE dbo.Users (
    userId INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    fullname NVARCHAR(50) NULL,
    password NVARCHAR(50) NOT NULL,
    images NVARCHAR(500) NULL,
    phone NVARCHAR(20) NULL,
    status INT NULL DEFAULT 1,
    code NVARCHAR(50) NULL,
    roleId INT NULL,
    sellerId INT NULL,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (roleId) REFERENCES dbo.UserRoles(roleId),
    CONSTRAINT FK_Users_Seller FOREIGN KEY (sellerId) REFERENCES dbo.Seller(sellerId)
);
GO

-- 4. BẢNG Category
CREATE TABLE dbo.Category (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryName NVARCHAR(200) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT NULL DEFAULT 1
);
GO

-- 5. BẢNG Product
CREATE TABLE dbo.Product (
    productId INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(200) NOT NULL,
    productCode BIGINT NULL,
    categoryId INT NULL,
    description NVARCHAR(500) NULL,
    price FLOAT NULL,
    amount INT NULL,
    stock INT NULL,
    images NVARCHAR(500) NULL,
    wishlist INT NULL DEFAULT 0,
    status INT NULL DEFAULT 1,
    createDate DATE NULL,
    sellerId INT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) REFERENCES dbo.Category(categoryId),
    CONSTRAINT FK_Product_Seller FOREIGN KEY (sellerId) REFERENCES dbo.Seller(sellerId)
);
GO

-- 6. BẢNG Cart
CREATE TABLE dbo.Cart (
    cartId NVARCHAR(50) PRIMARY KEY,
    userId INT NULL,
    buyDate DATETIME NULL,
    status INT NULL DEFAULT 1,
    CONSTRAINT FK_Cart_Users FOREIGN KEY (userId) REFERENCES dbo.Users(userId)
);
GO

-- 7. BẢNG CartItem
CREATE TABLE dbo.CartItem (
    cartItemId NVARCHAR(50) PRIMARY KEY,
    quantity INT NULL,
    unitPrice FLOAT NULL,
    productId INT NULL,
    cartId NVARCHAR(50) NULL,
    CONSTRAINT FK_CartItem_Product FOREIGN KEY (productId) REFERENCES dbo.Product(productId),
    CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cartId) REFERENCES dbo.Cart(cartId)
);
GO

-- CHÈN DỮ LIỆU MẪU ĐỂ TEST
-- Chèn UserRoles
SET IDENTITY_INSERT dbo.UserRoles ON;
INSERT INTO dbo.UserRoles (roleId, roleName) VALUES 
(1, N'ROLE_USER'),
(2, N'ROLE_ADMIN'),
(3, N'ROLE_SELLER');
SET IDENTITY_INSERT dbo.UserRoles OFF;
GO

-- Chèn Seller
SET IDENTITY_INSERT dbo.Seller ON;
INSERT INTO dbo.Seller (sellerId, sellername, images, status) VALUES 
(1, N'Nhà Sách Trí Tuệ (Seller 1)', 'seller1.jpg', 1),
(2, N'Siêu Thị Công Nghệ Số (Seller 2)', 'seller2.jpg', 1),
(3, N'Thời Trang Phong Cách (Seller 3)', 'seller3.jpg', 1);
SET IDENTITY_INSERT dbo.Seller OFF;
GO

-- Chèn Users (Tài khoản mẫu: admin/123, seller1/123, seller2/123, user1/123)
SET IDENTITY_INSERT dbo.Users ON;
INSERT INTO dbo.Users (userId, username, email, fullname, password, images, phone, status, code, roleId, sellerId) VALUES 
(1, 'admin', 'admin@ute.edu.vn', N'Quản Trị Viên Hệ Thống', '123', 'admin.jpg', '0901234567', 1, NULL, 2, NULL),
(2, 'seller1', 'seller1@ute.edu.vn', N'Chủ Gian Hàng Sách Trí Tuệ', '123', 'seller1_avatar.jpg', '0912345678', 1, NULL, 3, 1),
(3, 'seller2', 'seller2@ute.edu.vn', N'Chủ Gian Hàng Công Nghệ Số', '123', 'seller2_avatar.jpg', '0923456789', 1, NULL, 3, 2),
(4, 'user1', 'user1@ute.edu.vn', N'Nguyễn Văn An', '123', 'user1.jpg', '0934567890', 1, NULL, 1, NULL);
SET IDENTITY_INSERT dbo.Users OFF;
GO

-- Chèn Category
SET IDENTITY_INSERT dbo.Category ON;
INSERT INTO dbo.Category (categoryId, categoryName, images, status) VALUES 
(1, N'Sách & Văn Phòng Phẩm', 'cat_book.jpg', 1),
(2, N'Thiết Bị Điện Tử & Công Nghệ', 'cat_tech.jpg', 1),
(3, N'Thời Trang & Phụ Kiện', 'cat_fashion.jpg', 1),
(4, N'Đồ Gia Dụng Thông Minh', 'cat_home.jpg', 1),
(5, N'Mỹ Phẩm & Chăm Sóc Sức Khỏe', 'cat_beauty.jpg', 1);
SET IDENTITY_INSERT dbo.Category OFF;
GO

-- Chèn Product (Ít nhất 10 sản phẩm thuộc các Seller và Category khác nhau)
SET IDENTITY_INSERT dbo.Product ON;
INSERT INTO dbo.Product (productId, productName, productCode, categoryId, description, price, amount, stock, images, wishlist, status, createDate, sellerId) VALUES 
(1, N'Lập Trình Web Với Java Servlet & JSP', 10001, 1, N'Giáo trình học chuyên sâu về Java Web Servlet, JPA, JSP và Tomcat 11.', 150000, 50, 48, 'book_java.jpg', 12, 1, '2026-09-01', 1),
(2, N'Lập Trình Cơ Sở Dữ Liệu SQL Server', 10002, 1, N'Hướng dẫn toàn diện về thiết kế CSDL, Stored Procedure và T-SQL.', 120000, 40, 35, 'book_sql.jpg', 8, 1, '2026-09-02', 1),
(3, N'Kiến Trúc Phần Mềm & Design Patterns', 10003, 1, N'Phân tích các mẫu thiết kế hướng đối tượng GoF ứng dụng thực tế.', 180000, 30, 25, 'book_pattern.jpg', 15, 1, '2026-09-03', 1),
(4, N'Bàn Phím Cơ Không Dây RGB Pro', 20001, 2, N'Bàn phím cơ cao cấp 3 chế độ kết nối, switch êm ái cho lập trình viên.', 850000, 20, 18, 'tech_keyboard.jpg', 25, 1, '2026-09-05', 2),
(5, N'Chuột Công Thái Học Không Dây Master', 20002, 2, N'Chuột thiết kế công thái học chống mỏi cổ tay, mắt đọc chính xác cao.', 650000, 35, 30, 'tech_mouse.jpg', 19, 1, '2026-09-06', 2),
(6, N'Tai Nghe Chống Ồn Chuyên Nghiệp', 20003, 2, N'Âm thanh vòm chất lượng studio, thời lượng pin lên đến 40 giờ liên tục.', 1250000, 15, 12, 'tech_headphone.jpg', 30, 1, '2026-09-07', 2),
(7, N'Màn Hình Đồ Họa 27 inch 4K Ultra HD', 20004, 2, N'Màn hình chuẩn màu sắc IPS 99% sRGB chuyên cho thiết kế và code.', 4500000, 10, 8, 'tech_monitor.jpg', 42, 1, '2026-09-08', 2),
(8, N'Áo Thun Cotton HCMUTE Đen Cao Cấp', 30001, 3, N'Chất liệu 100% Cotton thoáng mát, form rộng unisex trẻ trung năng động.', 199000, 100, 95, 'fashion_tshirt.jpg', 50, 1, '2026-09-10', 3),
(9, N'Áo Khoác Hoodie Unisex Mùa Thu', 30002, 3, N'Vải nỉ ngoại dày dặn, giữ ấm tốt, có nón rộng và túi tiện lợi.', 320000, 45, 40, 'fashion_hoodie.jpg', 28, 1, '2026-09-11', 3),
(10, N'Balo Chống Nước Laptop 15.6 inch', 30003, 3, N'Balo chuyên dụng đựng laptop có ngăn chống sốc và đệm lưng thoáng khí.', 390000, 60, 52, 'fashion_backpack.jpg', 33, 1, '2026-09-12', 3);
SET IDENTITY_INSERT dbo.Product OFF;
GO
