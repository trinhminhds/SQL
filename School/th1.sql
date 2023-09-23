DROP DATABASE IF EXISTS TH1QUANLYBANHANG;
CREATE DATABASE TH1QUANLYBANHANG; 

USE TH1QUANLYBANHANG;

CREATE TABLE KHANHHANG(
	MAKH VARCHAR(5) NOT NULL UNIQUE,
    HOTEN NVARCHAR(40),
    DCHI NVARCHAR(50),
    SODT CHAR(10),
    NGSINH DATE,
    DOANHSO INT,
    NGDK DATE,
    PRIMARY KEY (MAKH)
);

INSERT INTO KHANHHANG
VALUES
	('KH01', 'Nguyễn Thành Nam', 'HCM','0398451950', '2003-10-20', 13060000 , '2022-07-22'),
	('KH02','Trần Ngọc Nga','Long An','0908256478', '1994-04-03', 980000 ,'2022-07-30'),
	('KH03', 'Vũ Quang Minh','HCM','0938776266', '1999-06-12',3860000,'2022-08-05'),
	('KH04','Trần Thành Long','Đồng Tháp', '0917325476','1995-09-03',250000, '2022-10-02'),
	('KH05','Lê Nhật Hào','Cần Thơ','0390164901', '2000-10-03', 821000 ,'2022-10-28'),
	('KH06', 'Nguyễn Thành Luân','HCM','0896317388', '1999-12-31', 915000, '2022-11-24'),
	('KH07', 'Nguyễn Thành Tài', 'An Giang', '0916783565', '2003-06-04', 529500,'2022-12-01'),
	('KH08', 'Trần Đăng Khoa','HCM','0938435706', '2002-10-01', 365000, '2022-12-13'),
	('KH09', 'Nguyễn Thị Trà My', 'LongAn' ,'0397628492', '1998-03-09', 710000,'2023-01-14'),
	('KH10', 'Đặng Thế Anh','HCM','0993810503', '2003-05-02', 667500, '2023-01-16');



CREATE TABLE NHANVIEN(
	MANV VARCHAR(5) NOT NULL UNIQUE,
    HOTEN NVARCHAR(40),
    SODT CHAR(10),
    NGVL DATE,
    PRIMARY KEY (MANV)
);
INSERT INTO NHANVIEN
VALUES
	('NV01', 'Nguyễn Thị Lan Anh','0392351468', '2022-02-16'),
	('NV02', 'Lê Hoài Thương','0987567390', '2022-04-21'),
	('NV03', 'Bùi Thị Ngọc Hân','0997047382', '2022-04-27'),
	('NV04', 'Vũ Minh Quân','0913758498', '2023-01-10'),
	('NV05', 'Nguyễn Thị Trúc Thanh', '0918590387', '2022-07-20');



CREATE TABLE SANPHAM(
	MASP VARCHAR(5) NOT NULL UNIQUE,
    TENSP NVARCHAR(50),
    DVT NVARCHAR(20),
    NUOCSX NVARCHAR(20),
    GIA INT,
    PRIMARY KEY (MASP)
);
INSERT INTO SANPHAM
VALUES 
	('BC01', 'Bút chì','cây','Singapore', 3000),
	('BC02', 'Bút chì','cây','Singapore', 5000),
	('BC03', 'Bút chì','cây','Việt Nam', 3500),
	('BC04', 'Bút chì','hộp','Việt Nam', 30000),
	('BB01', 'Bút bi','cây','Việt Nam',5000),
	('BB02', 'Bút bi','cây','Trung Quốc', 7000),
	('BB03', 'Bút bi','hộp','Thái Lan',100000),
	('TV01', 'Tập 100 giấy mỏng','quyển', 'TrungQuốc', 2500),
	('TV02', 'Tập 200 giấy mỏng', 'quyển', 'TrungQuốc', 4500),
	('TV03', 'Tập 100 giấy tốt','quyển', 'Việt Nam', 3000),
	('TV04', 'Tập 200 giấy tốt','quyển', 'Việt Nam',5500),
	('TV05', 'Tập 100 trang','chục','Việt Nam', 23000),
	('TV06', 'Tập 200 trang','chục','Việt Nam',53000),
	('TV07', 'Tập 100 trang','chục','Trung Quốc', 34000),
	('ST01', 'Sổ tay 500 trang', 'quyển', 'Trung Quốc', 40000),
    ('ST02', 'Sổ tay loại 1','quyển', 'Việt Nam',55000),
	('ST03', 'Sổ tay loại 2','quyển' ,'Việt Nam',51000),
	('ST04', 'Sổ tay tốt','quyển', 'Thái Lan', 55000),
	('ST05', 'Sổ tay mỏng','quyển' ,'Thái Lan',20000),
    ('PB01' ,'Phấn viết bảng','hộp','Việt Nam', 5000),
	('PB02', 'Phấn không bụi','hộp','Việt Nam', 7000),
	('PB03', 'Bông bảng','cái','Việt Nam', 1000),
	('BL01', 'Bút lông','cây','Việt Nam', 5000),
	('BL02', 'Bút lông','cây','Trung Quốc' ,7000);
    



CREATE TABLE HOADON (
    SOHD VARCHAR(5) NOT NULL,
    NGHD DATE,
    MAKH VARCHAR(5) ,
    MANV VARCHAR(5) NOT NULL ,
    TRIGIA INT,
    PRIMARY KEY (SOHD)
);
INSERT INTO HOADON
VALUES
	('1001', '2022-07-23', 'KH01', 'NV01', 320000),
	('1002', '2022-08-12', 'KH01', 'NV02', 840000),
	('1003', '2022-08-23', 'KH02', 'NV01', 100000),
	('1004', '2022-09-01', 'KH02', 'NV01', 180000),
	('1005', '2022-10-20', 'KH01', 'NV02', 3800000),
	('1006', '2022-10-16', 'KH01', 'NV03', 2430000),
	('1007', '2022-10-28', 'KH03', 'NV03', 510000),
	('1008', '2022-10-28', 'KH01', 'NV03', 440000),
	('1009', '2022-10-28', 'KH03', 'NV04', 200000),
	('1010', '2022-11-01', 'KH01', 'NV01', 5200000),
	('1011', '2022-11-04', 'KH04', 'NV03', 250000),
	('1012', '2022-11-30', 'KH05', 'NV03', 21000),
	('1013', '2022-12-12', 'KH06', 'NV01', 5000),
	('1014', '2022-12-31', 'KH03', 'NV02', 3150000),
	('1015', '2023-01-10', 'KH06', 'NV01', 910000),
	('1016', '2023-01-01', 'KH07', 'NV02', 12000),
	('1017', '2023-01-02', 'KH08', 'NV03', 35000),
	('1018', '2023-01-13', 'KH08', 'NV03', 330000),
	('1019', '2023-01-13', 'KH01', 'NV03', 30000),
	('1020', '2023-01-14', 'KH09', 'NV04', 70000),
	('1021', '2023-01-16', 'KH10', 'NV03', 67000),
	('1022', '2023-01-16', NULL, 'NV03', 7000),
	('1023', '2023-01-17', NULL, 'NV01', 330000);


CREATE TABLE CTHD(
	SOHD VARCHAR(5) NOT NULL,
    MASP VARCHAR(5) NOT NULL,
    SL TINYINT,
    PRIMARY KEY (SOHD,MASP)
);
INSERT INTO CTHD
VALUES 
 ('1001', 'TV02', 10),
 ('1001', 'ST01', 5),
 ('1001', 'BC01', 5),
 ('1001', 'BC02', 10),
 ('1001', 'PB03', 10),
 ('1002', 'BC04', 20),
 ('1002', 'BB01', 20),
 ('1002', 'BB02', 20),
 ('1003', 'BB03', 10),
 ('1004', 'TV01', 20),
 ('1004', 'TV02', 10),
 ('1004', 'TV03', 10),
 ('1004', 'TV04', 10),
 ('1005', 'TV05', 50),
 ('1005', 'TV06', 50),
 ('1006', 'TV07', 20),
 ('1006', 'ST01', 30),
 ('1006', 'ST02', 10),
 ('1007', 'ST03', 10),
 ('1008', 'ST04', 8),
 ('1009', 'ST05', 10),
 ('1010', 'TV07', 50),
 ('1010', 'PB02', 50),
 ('1010', 'PB03', 100),
 ('1010', 'ST04', 50),
 ('1010', 'TV03', 100),
 ('1011', 'PB01', 50),
 ('1012', 'PB01', 3),
 ('1013', 'PB03', 5),
 ('1014', 'BC02', 80),
 ('1014', 'BB02', 15),
 ('1014', 'BC04', 60),
 ('1014', 'BB01', 50),
 ('1015', 'BB02', 20),
 ('1016', 'TV01', 5),
 ('1017', 'TV02', 1),
 ('1017', 'TV03', 1),
 ('1017', 'TV04', 5),
 ('1018', 'ST04', 6),
 ('1019', 'ST05', 1),
 ('1019', 'PB01', 2),
 ('1020', 'PB02', 10),
 ('1021', 'PB03', 5),
 ('1021', 'TV01', 7),
 ('1021', 'TV02', 10),
 ('1022', 'PB02', 1),
 ('1023', 'ST04', 6),
 ('1023', 'BC03', 10);




-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
-- 2
ALTER TABLE SANPHAM
ADD GHICHU NVARCHAR(20);

-- 3
ALTER TABLE KHANHHANG
ADD LOAIKH TINYINT;

-- 4
ALTER TABLE SANPHAM
MODIFY COLUMN GHICHU NVARCHAR(100);  

-- 5

ALTER TABLE SANPHAM
DROP COLUMN GHICHU;

-- 6
ALTER TABLE KHANHHANG
MODIFY COLUMN LOAIKH NVARCHAR(30);

-- 7
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_DVT CHECK (DVT = 'cây' OR DVT = 'hộp'OR DVT = 'cái' OR DVT = 'quyển' OR DVT = 'chục');

-- 8
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_GIA CHECK (GIA >= 500);

-- 9
-- ALTER TABLE SANPHAM
-- ADD CONSTRAINT CHK_MAKH CHECK (MAKH >= 1 );



 -- II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language):
-- 2
USE TH1QUANLYBANHANG;
CREATE TABLE SANPHAM_COPY(
	MASP VARCHAR(5) NOT NULL UNIQUE,
    TENSP NVARCHAR(50),
    DVT NVARCHAR(20),
    NUOCSX NVARCHAR(20),
    GIA INT,
    PRIMARY KEY (MASP)
);
INSERT INTO SANPHAM_COPY
SELECT * FROM th1quanlybanhang.sanpham;

Drop TABLE th1quanlybanhang.sanpham_copy;

CREATE TABLE KHACHHANG_COPY(
	MAKH VARCHAR(5) NOT NULL UNIQUE,
    HOTEN NVARCHAR(40),
    DCHI NVARCHAR(50),
    SODT CHAR(10),
    NGSINH DATE,
    DOANHSO INT,
    NGDK DATE,
    LOAIKH NVARCHAR(30),
    PRIMARY KEY (MAKH)
);
INSERT INTO KHACHHANG_COPY
SELECT * FROM th1quanlybanhang.khachhang;


-- 3
UPDATE th1quanlybanhang.sanpham_copy
SET GIA = GIA * (1 + 5 / 100)
WHERE NUOCSX = 'Thái Lan';

UPDATE th1quanlybanhang.sanpham_copy
SET GIA = GIA / (1 + 5 /100)
WHERE (NUOCSX = 'TRUNG QUỐC' AND GIA <= 10000);



UPDATE th1quanlybanhang.khachhang_copy
SET LOAIKH = 'Vip'
WHERE  (NGDK < '2023-01-01' AND DOANHSO > 10000000) OR (NGDK > '2023-01-01' AND DOANHSO > 2000000);






