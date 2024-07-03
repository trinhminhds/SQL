
--                                                                                      BÀI THỰC HÀNH SỐ 4

--  Cho cơ sở dữ liệu có tên là QLSV gồm các bảng sau:

--  Khoa(makhoa, tenkhoa, diachi, dienthoai)
--  SinhVien(masv, hoten, ngaysinh, makhoa)
--  MonHoc(mamon, tenmon, stc, tengv)
--  DangKyHoc(masv, mamon, hocky)


CREATE DATABASE QLSINHVIEN
ON(
	NAME = 'QLSINHVIEN_Data',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH4\QLSINHVIEN_Data.mdf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)
LOG ON (
	NAME = 'QLSINHVIEN_Data_Log',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH4\QLSINHVIEN_Data_Log.ldf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)
GO
USE QLSINHVIEN


CREATE TABLE Khoa (
	MaKhoa char(4) NOT NULL PRIMARY KEY,
	TenKhoa nvarchar(30) NOT NULL,
	DiaChi nvarchar(50) NULL,
	DienThoai varchar(10)
)

CREATE TABLE SinhVien (
	MaSV char(8) NOT NULL PRIMARY KEY,
	HoTen nvarchar(30) NOT NULL,
	NgaySinh Date,
	MaKhoa char(4)
)

ALTER TABLE SinhVien
ADD CONSTRAINT FK_Khoa_SinhVien
FOREIGN KEY (MaKhoa) REFERENCES Khoa (MaKhoa)

CREATE TABLE MonHoc (
	MaMon varchar(5) NOT NULL PRIMARY KEY,
	TenMon nvarchar(30) NOT NULL,
	SoTinChi SmallInt,
	TenGV nvarchar(30)
)

CREATE TABLE DangKyHoc (
	MaSV char (8),
	MaMon varchar(5),
	HocKy smallInt
)

ALTER TABLE DangKyHoc
ADD CONSTRAINT FK_SinhVien_DangKyHoc
FOREIGN KEY (MaSV) REFERENCES SinhVien (MaSV)

ALTER TABLE DangKyHoc
ADD CONSTRAINT FK_MonHoc_DangKyHoc
FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon)


GO

INSERT INTO Khoa VALUES 
('TOAN', N'Toán - Tin', N'Nhà C','0375473250'),
('CNTT', N'Công nghệ thông tin', N'Nhà C','0375471002'),
('DIAL',N'Địa lý',N'Nhà A1',NULL),
('HOAH', N'Hóa học',N'Nhà A2',NULL)

INSERT INTO SinhVien VALUES 
('K6100001',N'Phạm Văn Bình', '2003-2-24','TOAN'),
('K6100002',N'Nguyễn Thị Hoài','2002-4-12','CNTT'),
('K6100003',N'Trần Ngọc','2003-4-15','DIAL'),
('K6100004',N'Nguyễn Tấn Dũng','2002-12-23','CNTT'),
('K6100005',N'Trương Tấn Sang','2002-12-4','DIAL'),
('K6100006',N'Nguyễn Sinh Hùng','2002-3-13','HOAH')

INSERT INTO MonHoc VALUES
('GT1',N'Giải tích 1',2,N'Đỗ Đức Thái'),
('DSTT',N'Đại số tuyến tính',3,N'Nguyễn Văn Trào'),
('HH',N'Hình học Afin',2,N'Nguyễn Doãn Tuấn'),
('XSTK',N'Xác suất thống kê',2,N'Đỗ Đức Thái')

INSERT INTO DangKyHoc VALUES
('K6100001','GT1',1),
('K6100001','DSTT',2),
('K6100001','HH',1),
('K6100002','DSTT',1),
('K6100002','XSTK',2),
('K6100002','GT1',1),
('K6100003','HH',1),
('K6100003','GT1',1),
('K6100003','XSTK',2),
('K6100004','XSTK',3),
('K6100004','DSTT',3),
('K6100004','DSTT',1)

GO


--  1. Thủ tục có tên DSMonhoc hiển thị mã các môn đăng
--  ký học bởi sinh viên cho trước (ví dụ DSMonhoc
--  N’Nguyễn Thị Hoài’ sẽ in ra các môn học đăng ký
--  bởi ’Nguyễn Thị Hoài’)

CREATE PROCEDURE sp_DSMonHoc(@hoten NVARCHAR(30))
AS
BEGIN
    SELECT DangKyHoc.*
    FROM SinhVien
    JOIN DangKyHoc
    ON SinhVien.MaSV = DangKyHoc.MaSV
    WHERE SinhVien.HoTen = @hoten
END
GO
EXEC sp_DSMonHoc N'Nguyễn Thị Hoài'
GO    

--  2. Thủ tục DSSinhvien hiển thị danh sách các sinh viên
--  đăng ký học môn cho trước trong một học kỳ nào
--  đó. Ví dụ DSSinhvien (N’Giải tích 1’,1) sẽ in danh
--  sách sinh viên đăng ký học môn ‘Giải tích 1’ trong
--  học kỳ 1 (trong danh sách cần chứa các thông tin:
--  Mã sinh viên, Họ tên, Tên Khoa).
CREATE PROCEDURE sp_DSSinhVien(@tenmon NVARCHAR(30),@hocKy SMALLINT)
AS
BEGIN
    SELECT S.MaSV,S.HoTen,K.TenKhoa
    FROM MonHoc AS M
    JOIN DangKyHoc AS D
    ON M.MaMon = D.MaMon
    JOIN SinhVien AS S
    ON D.MaSV = S.MaSV
    JOIN Khoa AS K
    ON K.MaKhoa = S.MaKhoa
    WHERE M.TenMon = @tenmon AND D.HocKy = @hocKy
END
GO
EXEC sp_DSSinhVien N'Giải tích 1',1
GO

--  3. Viết thủ tục DSMonhoc hiển thị danh sách các môn
--  học được sinh viên đăng ký trong một học kỳ nào
--  đó. Ví dụ DSMonhoc(1) sẽ in ra danh sách các môn
--  học được sinh viên đăng ký trong học kỳ 1.
CREATE PROCEDURE sp_DSMonhoc1(@hocKy SMALLINT)
AS
BEGIN
    SELECT *
    FROM DangKyHoc 
    WHERE HocKy = @hocKy
END
GO
EXEC sp_DSMonHoc1 1
GO  

--  4. Tạo khung nhìn có tên là DSSinhvientheokhoa hiển
--  thị danh sách sinh viên sắp xếp theo tên khoa, mỗi
--  khoa lại sắp xếp theo họ tên. Danh sách chứa các
--  thông tin sau: mã sinh viên, họ tên sinh viên, ngày
--  sinh, tên khoa.
CREATE VIEW vw_DSSinhVienTheoKhoa
AS
    SELECT S.MaSV,S.HoTen,S.NgaySinh,K.TenKhoa
    FROM SinhVien AS S
    JOIN Khoa AS K
    ON S.MaKhoa = K.MaKhoa
GO


SELECT *
FROM vw_DSSinhVienTheoKhoa
ORDER BY TenKhoa ASC, HoTen ASC

--  5. Hàm SoluongSV cho số lượng sinh viên của một
--  khoa. Ví dụ print SoluongSV(N’Công nghệ thông
--  tin’) trả về số lượng SV khoa Công nghệ thông tin.
GO

CREATE FUNCTION fc_SoluongNV(@tenkhoa NVARCHAR(30))
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SET @dem = (
        SELECT COUNT(SinhVien.MaSV)
        FROM Khoa 
        JOIN SinhVien 
        ON Khoa.MaKhoa = SinhVien.MaKhoa
        WHERE Khoa.TenKhoa = @tenkhoa 
    )

    RETURN @dem
END
GO
SELECT dbo.fc_SoluongNV(N'Công nghệ thông tin')
GO


--  6. Viết các hàm thay thế thủ tục trong câu 1,2,3.
CREATE FUNCTION fc_DSMonHoc(@hoten NVARCHAR(30))
RETURNS TABLE AS
RETURN(
    SELECT DangKyHoc.*
    FROM SinhVien
    JOIN DangKyHoc
    ON SinhVien.MaSV = DangKyHoc.MaSV
    WHERE SinhVien.HoTen = @hoten
)
GO
SELECT * FROM dbo.fc_DSMonHoc(N'Nguyễn Thị Hoài')
GO

CREATE FUNCTION fc_DSSinhVien(@tenmon NVARCHAR(30),@hocKy SMALLINT)
RETURNS TABLE AS
RETURN(
    SELECT S.MaSV,S.HoTen,K.TenKhoa
    FROM MonHoc AS M
    JOIN DangKyHoc AS D
    ON M.MaMon = D.MaMon
    JOIN SinhVien AS S
    ON D.MaSV = S.MaSV
    JOIN Khoa AS K
    ON K.MaKhoa = S.MaKhoa
    WHERE M.TenMon = @tenmon AND D.HocKy = @hocKy
)
GO
SELECT * FROM dbo.fc_DSSinhVien (N'Giải tích 1',1)
GO

CREATE FUNCTION fc_DSMonhoc1(@hocKy SMALLINT)
RETURNS TABLE AS
RETURN(    

    SELECT *
    FROM DangKyHoc 
    WHERE HocKy = @hocKy

)
GO
SELECT * FROM dbo.fc_DSMonHoc1(1)
GO  


--  7. Viết hàm hiển thị danh sách sinh viên đăng ký nhiều
--  môn học nhất
CREATE FUNCTION fc_DangKyNhieuMon()
RETURNS TABLE AS
RETURN(
    SELECT TOP 1 SinhVien.MaSV,SinhVien.HoTen,COUNT(DangKyHoc.MaSV) AS SLSINHVIEN
    FROM SinhVien 
    JOIN DangKyHoc
    ON SinhVien.MaSV = DangKyHoc.MaSV
    GROUP BY SinhVien.MaSV,SinhVien.HoTen
)
GO
SELECT * FROM dbo.fc_DangKyNhieuMon()
GO

--  8. Viết hàm hiển thị danh sách sinh viên đăng ký ít
--  môn học nhất

CREATE FUNCTION fc_DangKyItMon()
RETURNS TABLE AS
RETURN(
    SELECT SinhVien.MaSV,SinhVien.HoTen,COUNT(DangKyHoc.MaSV) AS SLSINHVIEN
    FROM SinhVien 
    JOIN DangKyHoc
    ON SinhVien.MaSV = DangKyHoc.MaSV
    GROUP BY SinhVien.MaSV,SinhVien.HoTen
)
GO
SELECT TOP 1 * FROM dbo.fc_DangKyItMon() 
ORDER BY SLSINHVIEN DESC
GO
