CREATE database QUANLINHANVIEN;
USE QUANLINHANVIEN

CREATE TABLE DonVi(
    madv INT PRIMARY KEY,
    tendv NVARCHAR(30) NOT NULL,
    dienthoai NVARCHAR(10) NULL,
)
CREATE TABLE NhanVien(
    manv NVARCHAR(10) PRIMARY KEY,
    hoten NVARCHAR(30) NOT NULL,
    ngaysinh DATE NULL,
    diachi NVARCHAR(50) NULL,
    madv INT FOREIGN KEY REFERENCES DonVi(madv) 
    ON DELETE CASCADE  ON UPDATE CASCADE
)
 
INSERT INTO DonVi(madv, tendv,dienthoai)
VALUES
(1,'P.Kinh doanh', '038726932'),
(2,'P.Tiep thi','038777301');

INSERT INTO NhanVien (manv, hoten, ngaysinh, diachi, madv)
VALUES
('NV01', 'Le Van A', '2/4/1995', '72 Tran Phu', 1),
('NV02', 'Mai Thi B', '12/7/1997','1 Nguyen Trai', 2),
('NV03', 'Tran Van C', '1/2/1990', NULL, 2);

GO

CREATE VIEW NV1 AS
SELECT  manv, hoten, madv
FROM NhanVien;

GO

INSERT INTO NV1 VALUES('NV04','Le Thi D',1);

GO

CREATE VIEW NV2 AS 
SELECT  manv, hoten, YEAR(ngaysinh) namsinh, madv 
FROM NhanVien

GO

INSERT INTO NV2(manv,hoten,madv) VALUES('NV05','Le Van E',1);

SELECT *
FROM NV1