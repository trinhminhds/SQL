CREATE DATABASE QLNVBAI2;
USE QLNVBAI2;

-- Tạo Bảng
CREATE TABLE khachhang(
    makhachhang VARCHAR(10) NOT NULL UNIQUE,
    tencongty NVARCHAR(50),
    tengiaodich NVARCHAR(30),
    diachi NVARCHAR(50),
    email NVARCHAR(30),
    dienthoai CHAR(11),
    fax NVARCHAR(40)
);

CREATE TABLE dondathang(
    sohoadon INT NOT NULL,
    makhachhang VARCHAR(10) NOT NULL UNIQUE,
    manhanvien VARCHAR(10) NOT NULL UNIQUE,
    ngaydathang DATE,
    ngaygiaodich DATE,
    ngaychuyenhang DATE,
    noigiaodich NVARCHAR(50)

);

CREATE TABLE nhanvien(
    manhanvien VARCHAR(10) NOT NULL UNIQUE,
    ho NVARCHAR(20),
    ten NVARCHAR(20),
    ngaysinh DATE,
    ngaylamviec DATE,
    diachi NVARCHAR(50),
    dienthoai CHAR(11),
    luongcoban DECIMAL(10,3),
    phucap DECIMAL(18,3)
    
);


CREATE TABLE nhacungcap(
    macongty VARCHAR(20) NOT NULL,
    tencongty NVARCHAR(50),
    tengiaodich NVARCHAR(30),
    diachi NVARCHAR(50),
    dienthoai CHAR(11),
    fax NVARCHAR(30),
    email NVARCHAR(30)
    
);

CREATE TABLE chitietdathang(
    sohoadon INT NOT NULL,
    mahang VARCHAR(20) NOT NULL,
    giaban DECIMAL(18,3),
    soluong INT,
    mucgiamgia INT
);

CREATE TABLE mathang(
    mahang VARCHAR(20) NOT NULL,
    tenhang NVARCHAR(30),
    macongty VARCHAR(20) NOT NULL,
    maloaihang VARCHAR(20) NOT NULL,
    soluong INT,
    donvitinh VARCHAR(20),
    giahang DECIMAL(18,3)
);


CREATE TABLE loaihang(
    maloaihang VARCHAR(20) NOT NULL,
    tenloaihang VARCHAR(20)
);


-- Tạo Khóa Chính và khóa ngoại cho các bảng

ALTER TABLE khachhang
ADD CONSTRAINT PK_KHACHHANG PRIMARY KEY (makhachhang);


ALTER TABLE dondathang
ADD CONSTRAINT PK_DONDH PRIMARY KEY (sohoadon);

ALTER TABLE dondathang
ADD CONSTRAINT FK_DONDH_KH FOREIGN KEY (makhachhang) REFERENCES khachhang(makhachhang);

ALTER TABLE dondathang
ADD CONSTRAINT FK_DONDH_NV FOREIGN KEY (manhanvien) REFERENCES nhanvien(manhanvien);



ALTER TABLE nhanvien
ADD CONSTRAINT PK_NHANVIEN PRIMARY KEY (manhanvien);

ALTER TABLE nhacungcap
ADD CONSTRAINT PK_NHACUNGCAP PRIMARY KEY (macongty);



ALTER TABLE chitietdathang
ADD CONSTRAINT PK_CTDATHANG PRIMARY KEY (sohoadon,mahang);

ALTER TABLE chitietdathang
ADD CONSTRAINT FK_CTDT_DONDH FOREIGN KEY (sohoadon) REFERENCES dondathang(sohoadon);

ALTER TABLE chitietdathang
ADD CONSTRAINT FK_CTDH_MH FOREIGN KEY (mahang) REFERENCES mathang(mahang);



ALTER TABLE mathang
ADD CONSTRAINT PK_MATHANG PRIMARY KEY (mahang);

ALTER TABLE mathang
ADD CONSTRAINT FK_MH_NHACC FOREIGN KEY (macongty) REFERENCES nhacungcap(macongty);

ALTER TABLE mathang
ADD CONSTRAINT FK_MH_LOAIH FOREIGN KEY (maloaihang) REFERENCES loaihang(maloaihang);



ALTER TABLE loaihang
ADD CONSTRAINT PK_LOAIHANG PRIMARY KEY (maloaihang);


-- 1
ALTER TABLE chitietdathang
ADD CONSTRAINT DF_SOLUONG DEFAULT 1 FOR soluong;
-- 2
ALTER TABLE chitietdathang
ADD CONSTRAINT DF_MUCGG DEFAULT 0 FOR mucgiamgia;

-- 3
ALTER TABLE nhanvien
ADD CHECK ((DATEDIFF(YEAR,ngaysinh,GETDATE())) >= 18  AND (DATEDIFF(YEAR,ngaysinh,GETDATE())) <= 60);


--4 Tạo 1 bảng sao để check thử có xóa được hay không ?
SELECT *
INTO nhacungcapcopy
FROM nhacungcap;

DROP TABLE nhacungcapcopy;
-- Kết quả xóa không được bởi đã có các khóa ràng buộc 
-- Nếu muốn bạn phải xóa các khóa chính khóa ngoại trước

-- Ví dụ:
-- CREATE TABLE Table1 (
--     ID INT PRIMARY KEY
-- );

-- CREATE TABLE Table2 (
--     ID INT PRIMARY KEY,
--     Table1_ID INT FOREIGN KEY REFERENCES Table1(ID) ON DELETE CASCADE
-- );

-- ON DELETE CASCADE được sử dụng trong ràng buộc ngoại của Table2, 
-- Điều này có nghĩa là khi một bản ghi trong Table1 được xóa,
-- Tất cả các bản ghi trong Table2 có Table1_ID trùng với ID của bản ghi bị xóa trong Table1 cũng sẽ bị xóa.


GO
-- 5
CREATE VIEW view_donhang AS
    SELECT DDH.sohoadon,makhachhang,manhanvien,ngaydathang,
    ngaygiaodich,ngaychuyenhang,noigiaodich,mahang,giaban,soluong,mucgiamgia
    FROM dondathang AS DDH 
    JOIN chitietdathang 
    ON DDH.sohoadon = chitietdathang.sohoadon;

-- a Việc thêm dữ liệu qua khung là không thể bởi nó chỉ là 1 cấu trúc ảo
-- Nếu muốn thêm thì ta có thể thêm vào 1 cách tự động từ bảng chính thông qua các lệnh
-- Ví dụ:

-- CREATE TRIGGER [Tên trigger]
-- ON [Tên bảng]
-- AFTER INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     -- Các lệnh SQL được thực thi khi trigger được kích hoạt
-- END;


-- CREATE PROCEDURE InsertData
--     @Parameter1 DataType1,
--     @Parameter2 DataType2
-- AS
-- BEGIN
--     INSERT INTO TableName (Column1, Column2) VALUES (@Parameter1, @Parameter2)
-- END;

-- EXEC InsertData @Parameter1 = 'Value1', @Parameter2 = 'Value2';


-- CREATE FUNCTION dbo.InsertDataFunction
-- (
--     @Parameter1 DataType1,
--     @Parameter2 DataType2
-- )
-- RETURNS DataType
-- AS
-- BEGIN
--     INSERT INTO TableName (Column1, Column2) VALUES (@Parameter1, @Parameter2)
--     RETURN @@IDENTITY; -- Trả về giá trị mong muốn
-- END;

-- DECLARE @Result DataType;
-- SET @Result = dbo.InsertDataFunction('Value1', 'Value2');


GO
-- 6
CREATE VIEW view_donhang1 AS
    SELECT DDH.sohoadon,makhachhang,manhanvien,ngaydathang,
    ngaygiaodich,ngaychuyenhang,noigiaodich,mahang,giaban*soluong AS thanhtien
    FROM dondathang AS DDH 
    JOIN chitietdathang
    ON DDH.sohoadon = chitietdathang.sohoadon;


--7
GO

CREATE VIEW view_sanpham_soluong AS
    SELECT *
    FROM mathang AS MH
    WHERE soluong >= 50;


GO
-- 8

UPDATE view_sanpham_soluong 
SET giahang = giahang - (giahang * 0.05)
WHERE mahang = 'SP01';

GO
--9
CREATE VIEW view_mucgiamgia AS
    SELECT *
    FROM chitietdathang
    WHERE mucgiamgia > (mucgiamgia * 0.05);

GO
--10

UPDATE view_mucgiamgia
SET mucgiamgia = mucgiamgia - (mucgiamgia * 0.06)
WHERE soluong > 10;


GO 
--11
CREATE VIEW view_chi_tiet_dat_hang AS
    SELECT CTDH.sohoadon,DDH.ngaydathang,SUM(CTDH.soluong * CTDH.giaban) AS TIENHOADON
    FROM chitietdathang AS CTDH
    JOIN dondathang AS DDH
    ON CTDH.sohoadon = DDH.sohoadon
    GROUP BY CTDH.sohoadon,DDH.ngaydathang;


GO
--12
CREATE VIEW view_mathang_congty AS
    SELECT CTDH.sohoadon,MH.mahang,MH.tenhang,MH.soluong,MH.giahang,MH.soluong * MH.giahang AS TONGTIEN
    FROM chitietdathang AS CTDH 
    JOIN mathang AS MH
    ON CTDH.mahang = MH.mahang
    WHERE MH.macongty = 'NCC001'
    GROUP BY CTDH.sohoadon,MH.mahang,MH.tenhang,MH.soluong,MH.giahang;
