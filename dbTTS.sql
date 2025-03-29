CREATE DATABASE TiktokShop;

USE TiktokShop;

-- Bảng vai trò người dùng
CREATE TABLE [vai_tro] (
  [id] INT PRIMARY KEY,
  [ten_vai_tro] VARCHAR(20) UNIQUE
);
GO

-- Chèn dữ liệu vào bảng vai trò
INSERT INTO [vai_tro] (id, ten_vai_tro) VALUES
(1, 'nguoi_mua'),
(2, 'nguoi_ban'),
(3, 'quan_tri');
GO

-- Bảng người dùng
CREATE TABLE [nguoi_dung] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [ho_ten] VARCHAR(255),
  [email] VARCHAR(255) UNIQUE,
  [mat_khau] VARCHAR(255),
  [so_dien_thoai] VARCHAR(20),
  [vai_tro_id] INT FOREIGN KEY REFERENCES [vai_tro]([id]),
  [ngay_tao] DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO [nguoi_dung] (ho_ten, email, mat_khau, so_dien_thoai, vai_tro_id)
VALUES
('Nguyễn Văn A', 'nguyenvana@example.com', 'hashedpassword123', '0987654321', 2),
('Trần Thị B', 'tranthib@example.com', 'hashedpassword123', '0978123456', 2),
('Lê Văn C', 'levanc@example.com', 'hashedpassword123', '0967123456', 2),
('Hoàng Minh D', 'hoangminhd@example.com', 'hashedpassword123', '0956123456', 2),
('Phạm Thị E', 'phamthie@example.com', 'hashedpassword123', '0945123456', 2),
('Võ Quốc F', 'voquocf@example.com', 'hashedpassword123', '0934123456', 2),
('Đặng Kim G', 'dangkimg@example.com', 'hashedpassword123', '0923123456', 2),
('Bùi Hữu H', 'buihuuh@example.com', 'hashedpassword123', '0912123456', 2);
GO


-- Bảng cửa hàng
CREATE TABLE [cua_hang] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_nguoi_ban] INT UNIQUE NOT NULL FOREIGN KEY REFERENCES [nguoi_dung] ([id]),
  [ten_cua_hang] VARCHAR(255),
  [mo_ta] VARCHAR(MAX),
  [ngay_tao] DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO [cua_hang] (id_nguoi_ban, ten_cua_hang, mo_ta)
VALUES
(1, 'Thời Trang Việt', 'Chuyên kinh doanh thời trang nam nữ, phụ kiện.'),
(2, 'Ẩm Thực Ngon', 'Cung cấp thực phẩm sạch, đồ ăn vặt, bánh kẹo.'),
(3, 'Điện Tử 24h', 'Chuyên bán các thiết bị điện tử, phụ kiện công nghệ.'),
(4, 'Gia Dụng Thông Minh', 'Sản phẩm gia dụng tiện lợi, nội thất nhà bếp.'),
(5, 'Sách & Học Cụ ABC', 'Cung cấp văn phòng phẩm, dụng cụ học tập.'),
(6, 'Sức Khỏe Xanh', 'Chuyên thực phẩm chức năng, sản phẩm bảo vệ sức khỏe.'),
(7, 'SportPro', 'Cửa hàng đồ thể thao, dụng cụ tập luyện.'),
(8, 'Phụ Kiện Số XYZ', 'Chuyên bán các loại phụ kiện công nghệ, thiết bị số.');
GO

Select * from [cua_hang]
SELECT id FROM [cua_hang];


-- Bảng danh mục sản phẩm
CREATE TABLE [danh_muc] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [ten_danh_muc] VARCHAR(255)
);
GO

INSERT INTO [danh_muc] (ten_danh_muc) VALUES
('Thời trang'),
('Đồ ăn'),
('Đồ điện tử'),
('Đồ gia dụng'),
('Học tập'),
('Sức khỏe'),
('Đồ thể thao'),
('Phụ kiện số');
GO

-- Bảng sản phẩm
CREATE TABLE [san_pham] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_cua_hang] INT NOT NULL FOREIGN KEY REFERENCES [cua_hang]([id]),
  [id_danh_muc] INT NOT NULL FOREIGN KEY REFERENCES [danh_muc]([id]),
  [ten_san_pham] VARCHAR(255),
  [mo_ta] VARCHAR(MAX),
  [gia_goc] DECIMAL(10,2),
  [giam_gia] DECIMAL(10,2) DEFAULT 0,
  [gia_khuyen_mai] AS (gia_goc - giam_gia) PERSISTED, 
  [so_luong_ton] INT,
  [ngay_tao] DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO [san_pham] (id_cua_hang, id_danh_muc, ten_san_pham, mo_ta, gia_goc, giam_gia, so_luong_ton)
VALUES

-- Thời trang (Cửa hàng 1 - Thời Trang Việt)
(1, 1, 'Áo thun nam cotton', 'Áo thun chất liệu cotton mềm mại, thoáng khí.', 200000, 50000, 100),
(1, 1, 'Quần jean nữ skinny', 'Quần jean nữ co giãn, tôn dáng.', 350000, 70000, 50),
(1, 1, 'Giày sneaker nam', 'Giày thể thao thời trang, năng động.', 600000, 100000, 40),

-- Đồ ăn (Cửa hàng 2 - Ẩm Thực Ngon)
(2, 2, 'Bánh trung thu thập cẩm', 'Bánh trung thu nhân thập cẩm truyền thống.', 120000, 20000, 80),
(2, 2, 'Trà ô long túi lọc', 'Trà ô long thơm ngon, tốt cho sức khỏe.', 80000, 15000, 120),
(2, 2, 'Cà phê rang xay', 'Cà phê nguyên chất từ Tây Nguyên.', 150000, 25000, 60),

-- Đồ điện tử (Cửa hàng 3 - Điện Tử 24h)
(3, 3, 'Tai nghe Bluetooth không dây', 'Tai nghe Bluetooth với chất lượng âm thanh sống động.', 550000, 100000, 30),
(3, 3, 'Pin sạc dự phòng 10000mAh', 'Pin sạc dự phòng nhỏ gọn, dung lượng lớn.', 300000, 50000, 70),
(3, 3, 'Camera giám sát wifi', 'Camera an ninh thông minh, kết nối wifi.', 800000, 150000, 20),

-- Đồ gia dụng (Cửa hàng 4 - Gia Dụng Thông Minh)
(4, 4, 'Bộ nồi inox 5 món', 'Bộ nồi inox cao cấp, phù hợp với mọi loại bếp.', 1500000, 200000, 40),
(4, 4, 'Máy hút bụi cầm tay', 'Máy hút bụi không dây nhỏ gọn, tiện lợi.', 800000, 150000, 25),
(4, 4, 'Quạt điều hòa không khí', 'Làm mát không khí, tiết kiệm điện năng.', 1800000, 300000, 15),

-- Học tập (Cửa hàng 5 - Sách & Học Cụ ABC)
(5, 5, 'Bút bi Thiên Long', 'Bút bi viết êm, chất lượng tốt.', 5000, 1000, 500),
(5, 5, 'Vở kẻ ngang 200 trang', 'Vở học sinh dày dặn, chất lượng giấy tốt.', 25000, 5000, 200),
(5, 5, 'Máy tính cầm tay Casio', 'Máy tính bỏ túi dùng cho học sinh, sinh viên.', 400000, 50000, 50),

-- Sức khỏe (Cửa hàng 6 - Sức Khỏe Xanh)
(6, 6, 'Vitamin C 500mg', 'Viên uống vitamin C giúp tăng cường miễn dịch.', 180000, 30000, 60),
(6, 6, 'Khẩu trang y tế 4 lớp', 'Khẩu trang y tế kháng khuẩn, an toàn.', 50000, 10000, 300),
(6, 6, 'Tinh dầu tràm nguyên chất', 'Tinh dầu thiên nhiên, hỗ trợ hô hấp.', 120000, 20000, 90),

-- Đồ thể thao (Cửa hàng 7 - SportPro)
(7, 7, 'Giày chạy bộ nam', 'Giày chạy bộ thoáng khí, chống trơn trượt.', 900000, 150000, 35),
(7, 7, 'Dây nhảy thể dục', 'Dây nhảy tập luyện giúp đốt cháy calo hiệu quả.', 120000, 20000, 90),
(7, 7, 'Găng tay tập gym', 'Găng tay bảo vệ tay khi tập gym.', 180000, 30000, 70),

-- Phụ kiện số (Cửa hàng 8 - Phụ Kiện Số XYZ)
(8, 8, 'Chuột không dây Logitech', 'Chuột máy tính không dây, kết nối Bluetooth.', 450000, 80000, 60),
(8, 8, 'Bàn phím cơ gaming RGB', 'Bàn phím cơ LED RGB dành cho game thủ.', 1200000, 200000, 20),
(8, 8, 'Đế tản nhiệt laptop', 'Giúp làm mát laptop, tăng tuổi thọ.', 350000, 50000, 50);
GO

ALTER TABLE san_pham ADD hinh_anh NVARCHAR(255) NULL;

UPDATE san_pham SET hinh_anh = 'https://product.hstatic.net/1000184601/product/men_trang__33__f573871e171f49798870158423d62ca9_master.jpg' WHERE id = 1;
-- Cập nhật ảnh cho sản phẩm thời trang (Cửa hàng 1 - Thời Trang Việt)
UPDATE san_pham SET hinh_anh = 'https://quanjeandep.com/images/thumbs/quan-jeans-nu-dang-xuong-dung-cap-cao-mau-xam-khoi-016-xam-11603.jpeg' WHERE id = 2;
UPDATE san_pham SET hinh_anh = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJXL1VREe27haqfL5Y5-5XFXcyagwizWXycA&s' WHERE id = 3;

-- Cập nhật ảnh cho sản phẩm đồ ăn (Cửa hàng 2 - Ẩm Thực Ngon)
UPDATE san_pham SET hinh_anh = 'https://cailonuong.com/wp-content/uploads/2024/08/hinh-banh-trung-thu-1-1024x1024.jpg' WHERE id = 4;
UPDATE san_pham SET hinh_anh = 'https://bizweb.dktcdn.net/100/217/773/files/nen-uong-tra-o-long-khi-nao.jpeg?v=1498549145697' WHERE id = 5;
UPDATE san_pham SET hinh_anh = 'https://cdnphoto.dantri.com.vn/Y67ZaA06rd6lm6txCSx7gMLriD4=/zoom/1200_630/2022/08/06/caphe-crop-1659747953858.jpeg' WHERE id = 6;

-- Cập nhật ảnh cho sản phẩm đồ điện tử (Cửa hàng 3 - Điện Tử 24h)
UPDATE san_pham SET hinh_anh = 'https://example.com/tai-nghe-bluetooth.jpg' WHERE id = 7;
UPDATE san_pham SET hinh_anh = 'https://example.com/pin-sac-du-phong.jpg' WHERE id = 8;
UPDATE san_pham SET hinh_anh = 'https://example.com/camera-giam-sat.jpg' WHERE id = 9;

-- Cập nhật ảnh cho sản phẩm đồ gia dụng (Cửa hàng 4 - Gia Dụng Thông Minh)
UPDATE san_pham SET hinh_anh = 'https://example.com/bo-noi-inox.jpg' WHERE id = 10;
UPDATE san_pham SET hinh_anh = 'https://example.com/may-hut-bui.jpg' WHERE id = 11;
UPDATE san_pham SET hinh_anh = 'https://example.com/quat-dieu-hoa.jpg' WHERE id = 12;

-- Cập nhật ảnh cho sản phẩm học tập (Cửa hàng 5 - Sách & Học Cụ ABC)
UPDATE san_pham SET hinh_anh = 'https://example.com/but-bi-thien-long.jpg' WHERE id = 13;
UPDATE san_pham SET hinh_anh = 'https://example.com/vo-ke-ngang.jpg' WHERE id = 14;
UPDATE san_pham SET hinh_anh = 'https://example.com/may-tinh-casio.jpg' WHERE id = 15;

-- Cập nhật ảnh cho sản phẩm sức khỏe (Cửa hàng 6 - Sức Khỏe Xanh)
UPDATE san_pham SET hinh_anh = 'https://example.com/vitamin-c.jpg' WHERE id = 16;
UPDATE san_pham SET hinh_anh = 'https://example.com/khau-trang-y-te.jpg' WHERE id = 17;
UPDATE san_pham SET hinh_anh = 'https://example.com/tinh-dau-tram.jpg' WHERE id = 18;

-- Cập nhật ảnh cho sản phẩm đồ thể thao (Cửa hàng 7 - SportPro)
UPDATE san_pham SET hinh_anh = 'https://example.com/giay-chay-bo.jpg' WHERE id = 19;
UPDATE san_pham SET hinh_anh = 'https://example.com/day-nhay-the-duc.jpg' WHERE id = 20;
UPDATE san_pham SET hinh_anh = 'https://example.com/gang-tay-tap-gym.jpg' WHERE id = 21;

-- Cập nhật ảnh cho sản phẩm phụ kiện số (Cửa hàng 8 - Phụ Kiện Số XYZ)
UPDATE san_pham SET hinh_anh = 'https://example.com/chuot-khong-day.jpg' WHERE id = 22;
UPDATE san_pham SET hinh_anh = 'https://example.com/ban-phim-gaming.jpg' WHERE id = 23;
UPDATE san_pham SET hinh_anh = 'https://example.com/de-tan-nhiet-laptop.jpg' WHERE id = 24;





SELECT * FROM san_pham WHERE hinh_anh IS NULL OR mo_ta IS NULL;



SELECT * FROM [san_pham]

-- Bảng trạng thái đơn hàng (thay cho ENUM)
CREATE TABLE [trang_thai_don_hang] (
  [id] INT PRIMARY KEY,
  [mo_ta] VARCHAR(50) UNIQUE
);
GO

-- Chèn dữ liệu trạng thái đơn hàng
INSERT INTO [trang_thai_don_hang] (id, mo_ta) VALUES
(1, 'cho_xac_nhan'),
(2, 'da_xac_nhan'),
(3, 'dang_giao'),
(4, 'hoan_tat'),
(5, 'da_huy');
GO

-- Bảng đơn hàng
CREATE TABLE [don_hang] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_nguoi_mua] INT NOT NULL FOREIGN KEY REFERENCES [nguoi_dung]([id]),
  [tong_tien] DECIMAL(10,2),
  [trang_thai_id] INT NOT NULL FOREIGN KEY REFERENCES [trang_thai_don_hang]([id]),
  [ngay_tao] DATETIME DEFAULT GETDATE()
);
GO

-- Bảng chi tiết đơn hàng
CREATE TABLE [chi_tiet_don_hang] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_don_hang] INT NOT NULL FOREIGN KEY REFERENCES [don_hang]([id]),
  [id_san_pham] INT NOT NULL FOREIGN KEY REFERENCES [san_pham]([id]),
  [so_luong] INT,
  [gia] DECIMAL(10,2)
);
GO

-- Bảng phương thức thanh toán (thay cho ENUM)
CREATE TABLE [phuong_thuc_thanh_toan] (
  [id] INT PRIMARY KEY,
  [mo_ta] VARCHAR(50) UNIQUE
);
GO

INSERT INTO [phuong_thuc_thanh_toan] (id, mo_ta) VALUES
(1, 'COD');
GO

-- Bảng trạng thái thanh toán (thay cho ENUM)
CREATE TABLE [trang_thai_thanh_toan] (
  [id] INT PRIMARY KEY,
  [mo_ta] VARCHAR(50) UNIQUE
);
GO

INSERT INTO [trang_thai_thanh_toan] (id, mo_ta) VALUES
(1, 'cho_xu_ly'),
(2, 'hoan_tat'),
(3, 'that_bai');
GO

-- Bảng thanh toán
CREATE TABLE [thanh_toan] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_don_hang] INT NOT NULL FOREIGN KEY REFERENCES [don_hang]([id]),
  [phuong_thuc_id] INT NOT NULL FOREIGN KEY REFERENCES [phuong_thuc_thanh_toan]([id]),
  [trang_thai_id] INT NOT NULL FOREIGN KEY REFERENCES [trang_thai_thanh_toan]([id]),
  [ngay_tao] DATETIME DEFAULT GETDATE()
);
GO

-- Bảng trạng thái vận chuyển (thay cho ENUM)
CREATE TABLE [trang_thai_van_chuyen] (
  [id] INT PRIMARY KEY,
  [mo_ta] VARCHAR(50) UNIQUE
);
GO

INSERT INTO [trang_thai_van_chuyen] (id, mo_ta) VALUES
(1, 'dang_xu_ly'),
(2, 'dang_giao'),
(3, 'da_giao');
GO

-- Bảng vận chuyển
CREATE TABLE [van_chuyen] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_don_hang] INT NOT NULL FOREIGN KEY REFERENCES [don_hang]([id]),
  [trang_thai_id] INT NOT NULL FOREIGN KEY REFERENCES [trang_thai_van_chuyen]([id]),
  [ngay_cap_nhat] DATETIME DEFAULT GETDATE()
);
GO

-- Bảng đánh giá sản phẩm
CREATE TABLE [danh_gia] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [id_san_pham] INT NOT NULL FOREIGN KEY REFERENCES [san_pham]([id]),
  [id_nguoi_mua] INT NOT NULL FOREIGN KEY REFERENCES [nguoi_dung]([id]),
  [so_sao] INT NOT NULL DEFAULT 5 CHECK (so_sao BETWEEN 1 AND 5),
  [noi_dung] VARCHAR(MAX),
  [hinh_anh] VARCHAR(MAX),
  [ngay_danh_gia] DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO danh_gia (id_san_pham, id_nguoi_mua, so_sao, noi_dung, hinh_anh, ngay_danh_gia) VALUES
(1, 1, 5, 'Sản phẩm rất đẹp, chất lượng tuyệt vời!', 'https://example.com/review1.jpg', GETDATE()),
(1, 2, 4, 'Mình thấy ổn, nhưng giao hàng hơi chậm', 'https://example.com/review2.jpg', GETDATE()),
(1, 3, 5, 'Hàng đúng mô tả, đóng gói chắc chắn!', NULL, GETDATE()),
(2, 4, 3, 'Sản phẩm bình thường, giá hơi cao', NULL, GETDATE()),
(2, 5, 5, 'Quá tuyệt vời, sẽ mua lại lần sau', 'https://example.com/review3.jpg', GETDATE()),
(3, 6, 4, 'Giao hàng nhanh, chất lượng tạm ổn', NULL, GETDATE()),
(3, 7, 5, 'Đúng hàng chính hãng, dùng rất thích', 'https://example.com/review4.jpg', GETDATE());

UPDATE danh_gia
SET hinh_anh = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaDLoNfkSY9VnIttStAIgIDX8DOmMjrHID_aEN7qUVtOm3fldGY2yVwFhqWBy_cAKgWTw&usqp=CAU'
WHERE id_san_pham = 1 AND id_nguoi_mua = 1;

UPDATE danh_gia
SET hinh_anh = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL0YdMWRKmFLjfXUleNefIbcJzdQbqWz0z_Faf6nCzrkOGajJMf5V_pa7anTysZsIn-K4&usqp=CAU'
WHERE id_san_pham = 1 AND id_nguoi_mua = 2;



-- Bảng banner
CREATE TABLE [banner] (
  [id] INT PRIMARY KEY IDENTITY(1,1),
  [tieu_de] VARCHAR(255),
  [hinh_anh] VARCHAR(255)
);
GO
INSERT INTO banner (tieu_de, hinh_anh) VALUES
('Khuyến mãi 50%', 'https://truyenthongdps.com/wp-content/uploads/2023/10/tai-lieu-tiktokshop-09.png'),
('Sản phẩm mới', 'https://media.tapchilaodongxahoi.vn/505/2024/4/12/tiktok-shop-1.jpg'),
('Mua ngay hôm nay', 'https://static.doanhnhan.vn/w400/images/upload/legiang/06082023/tik1.jpg');

