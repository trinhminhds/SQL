DROP DATABASE IF EXISTS QLNCKH;
GO
CREATE DATABASE QLNCKH
GO    
USE QLNCKH
GO

	CREATE TABLE GIAOVIEN(
		MAGV CHAR(3),
		HOTEN NVARCHAR(50),
		LUONG  INT,
		GIOITINH NCHAR(5),
		NGAYSINH DATE,
		DIACHI NVARCHAR(50),
		DIENTHOAI CHAR(10),
		GVQLCM CHAR(3),
		MABM CHAR(4),
		CONSTRAINT PK_MAGV PRIMARY KEY(MAGV)
	);
    
GO
	CREATE TABLE BOMON
	(
		MABM CHAR(4),
		TENBM NVARCHAR(50),
		PHONG NCHAR(3),
		DIENTHOAI CHAR(11),
		TRUONGBM CHAR(3),
		MAKHOA CHAR(4),
		NGAYNHANCHUC DATE,
		CONSTRAINT PK_MABM PRIMARY KEY(MABM)
	);
GO

	CREATE TABLE KHOA
	(
		MAKHOA CHAR(4),
		TENKHOA NVARCHAR(50),
		NAMTL INT,
		PHONG CHAR(3),
		DIENTHOAI CHAR(10),
		TRUONGKHOA CHAR(3),
		NGAYNHANCHUC DATE,
		CONSTRAINT PK_MAKHOA PRIMARY KEY(MAKHOA)
	);

GO	

    CREATE TABLE CHUDE
	(
		MACD CHAR(4),
		TENCD NVARCHAR(30),
		CONSTRAINT PK_MACD PRIMARY KEY(MACD)
	);
GO

	CREATE TABLE DETAI
	(
		MADT CHAR(4),
		TENDT NVARCHAR(100),
		CAPQL NVARCHAR(20),
		KINHPHI INT,
		NGAYBD DATE,
		NGAYKT DATE,
		MACD NCHAR(4),
		GVCNDT NCHAR(3),
		CONSTRAINT PK_MADT PRIMARY KEY(MADT)
	);
    
GO

	CREATE TABLE CONGVIEC 
	(
		MADT CHAR(4),
		STT INT,
		TENCV NVARCHAR(50),
		NGAYBD DATE,
		NGAYKT DATE,
		CONSTRAINT PK_MADT_STT PRIMARY KEY(MADT,STT)
	);

GO	
	CREATE TABLE THAMGIADT
	(
		MAGV CHAR(3),
		MADT CHAR(4),
		STT INT,
		PHUCAP FLOAT,
		KETQUA NVARCHAR(10),
		CONSTRAINT PK_MAGV_MADT_STT PRIMARY KEY(MAGV,MADT,STT)
	);

	
		
-- Nhập data cho bảng GIAOVIEN
	--INSERT INTO GIAOVIEN(MAGV,HOTEN,LUONG,GIOITINH,NGAYSINH,DIACHI,DIENTHOAI,GVQLCM,MABM)
	--VALUES 
 --    ('001','Nguyễn Hoài An',2000,'Nam','1983-02-15','25/3 Lạc Long Quân, Q.10,TP HCM','003','MMT'),
	-- ('002','Trần Trà Hương',2500,'Nữ','1994-06-20','125 Trần Hưng Đạo, Q.1, TP HCM','005','HTTT'),
	-- ('003','Nguyễn Ngọc Ánh',2200,'Nữ','1975-05-11','12/21 Võ Văn Ngân Thủ Đức, TP HCM','002','HTTT'),
	-- ('004','Trương Nam Sơ',2300,'Nam','1999-06-20','215 Lý Thường Kiệt,TP Biên Hòa','008','CH'),
	-- ('005','Lý Hoàng Hà',2600,'Nam','1970-10-23','22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM','009','VLĐT'),
	-- ('006','Trần Bạch Tuyết',1500,'Nữ','1989-05-20','127 Hùng Vương, TP Mỹ Tho','004','TT'),
	-- ('007','Nguyễn An Trung',2100,'Nam','1990-06-05','234 3/2, TP Biên Hòa','010','KTPM'),
	-- ('008','Trần Trung Hiếu',1800,'Nam','1977-08-06','22/11 Lý Thường Kiệt,TP Mỹ Tho','007','HPT'),
	-- ('009','Trần Hoàng nam',2000,'Nam','1975-11-22','234 Trấn Não,An Phú, TP HCM','001','MMT'),
	-- ('010','Phạm Nam Thanh',1500,'Nam','1980-12-12','221 Hùng Vương,Q.5, TP HCM','007','TUD'),
 --    ('011','Trịnh Ngọc Minh',3000,'Nam','2003-09-23','300 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','020','CNTT'),
 --    ('012','Phạm Duy Khang',2500,'Nam','2004-01-22','301 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','019','CNTT'),
 --    ('013','Phùng Bảo Khang',2000,'Nam','2004-02-10','302 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','018','CNTT'),
 --    ('014','Khổng Minh Trí',4000,'Nam','2004-03-11','303 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','017','CNTT'),
 --    ('015','Lê Quốc Trinh',1500,'Nam','2004-04-12','304 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','016','CNTT'),
 --    ('016','Phạm Tấn Phát',2000,'Nam','2004-05-13','305 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','015','CNTT'),
 --    ('017','Trần Lê Thành',3000,'Nam','2004-06-14','306 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','014','CNTT'),
 --    ('018','Trần Nhật Quang',2500,'Nam','2004-07-15','307 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','013','CNTT'),
 --    ('019','Trần Thị Yến Nhi',2600,'Nữ','2004-08-16','308 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','012','CNTT'),
 --    ('020','Nguyễn Duy Khương',2300,'Nam','2004-09-17','309 Nguyễn Thái Sơn,Q.Gò Vấp, TP HCM','011','CNTT');
     
INSERT INTO GIAOVIEN (MAGV, HOTEN, LUONG, GIOITINH, NGAYSINH, DIACHI, DIENTHOAI, GVQLCM, MABM)
VALUES 
    ('001', 'Nguyễn Hoài An', 2000, 'Nam', '1983-02-15', '25/3 Lạc Long Quân, Q.10, TP HCM', '0838912009', '003', 'MMT'),
    ('002', 'Trần Trà Hương', 2500, 'Nữ', '1994-06-20', '125 Trần Hưng Đạo, Q.1, TP HCM', '0956462907', '005', 'HTTT'),
    ('003', 'Nguyễn Ngọc Ánh', 2200, 'Nữ', '1975-05-11', '12/21 Võ Văn Ngân Thủ Đức, TP HCM', '0838151075', '002', 'HTTT'),
    ('004', 'Trương Nam Sơ', 2300, 'Nam', '1999-06-20', '215 Lý Thường Kiệt, TP Biên Hòa','0838151076', '008', 'CH'),
    ('005', 'Lý Hoàng Hà', 2600, 'Nam', '1970-10-23', '22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM', '0838151077', '009', 'VLĐT'),
    ('006', 'Trần Bạch Tuyết', 1500, 'Nữ', '1989-05-20', '127 Hùng Vương, TP Mỹ Tho', '0937860731', '004', 'TT'),
    ('007', 'Nguyễn An Trung', 2100, 'Nam', '1990-06-05', '234 3/2, TP Biên Hòa', '0838151078', '010', 'KTPM'),
    ('008', 'Trần Trung Hiếu', 1800, 'Nam', '1977-08-06', '22/11 Lý Thường Kiệt, TP Mỹ Tho', '0653707189', '007', 'HPT'),
    ('009', 'Trần Hoàng Nam', 2000, 'Nam', '1975-11-22', '234 Trấn Não, An Phú, TP HCM', '0913214202', '001', 'MMT'),
    ('010', 'Phạm Nam Thanh', 1500, 'Nam', '1980-12-12', '221 Hùng Vương, Q.5, TP HCM', '0913214204', '007', 'TUD'),
    ('011', 'Trịnh Ngọc Minh', 3000, 'Nam', '2003-09-23', '300 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0913214206', '020', 'CNTT'),
    ('012', 'Phạm Duy Khang', 2500, 'Nam', '2004-01-22', '301 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0913214207', '019', 'CNTT'),
    ('013', 'Phùng Bảo Khang', 2000, 'Nam', '2004-02-10', '302 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0913214210', '018', 'CNTT'),
    ('014', 'Khổng Minh Trí', 4000, 'Nam', '2004-03-11', '303 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0838151085', '017', 'CNTT'),
    ('015', 'Lê Quốc Trinh', 1500, 'Nam', '2004-04-12', '304 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0838151175', '016', 'CNTT'),
    ('016', 'Phạm Tấn Phát', 2000, 'Nam', '2004-05-13', '305 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0838150075', '015', 'CNTT'),
    ('017', 'Trần Lê Thành', 3000, 'Nam', '2004-06-14', '306 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0838141075', '014', 'CNTT'),
    ('018', 'Trần Nhật Quang', 2500, 'Nam', '2004-07-15', '307 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0838051075', '013', 'CNTT'),
    ('019', 'Trần Thị Yến Nhi', 2600, 'Nữ', '2004-08-16', '308 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0818151075', '012', 'CNTT'),
    ('020', 'Nguyễn Duy Khương', 2300, 'Nam', '2004-09-17', '309 Nguyễn Thái Sơn, Q.Gò Vấp, TP HCM', '0938151075', '011', 'CNTT');


--Nhập data cho bảng BOMON
	INSERT INTO BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	VALUES 
     ('CNTT','Công nghệ tri thức','B15','0838126126','003','CNTT','2004-10-20'),
	 ('HHC','Hóa hữu cơ','B44','0838222222','010','TNMT','2004-09-20'),
	 ('CH','Cơ học','B42','0838878787','008','SH','2004-08-20'),
	 ('HPT','Hóa phân tích','B43','0838777777',NULL,'KHSK',NULL),
	 ('HTTT','Hệ thống thông tin','B13','0838125125','002','CNTT','2004-09-21'),
	 ('MMT','Mạng máy tính','B16','0838676767','001','CNTT','2005-05-15'),
	 ('TUD','Toán ứng dụng','B33','0838898989','006','KTQT','2004-09-22'),
	 ('VLĐT','Vật lý điện tử','B23','0838234234','009','VL','2004-09-23'),
	 ('KTPM','Kỹ thuật phần mềm','B24','0838454545','005','CNTT','2006-02-18'),
	 ('TT','Toán tin','B32','0838909090','004','TH','2007-02-01'),
     ('CNS','Công Nghệ Sinh','B11','0838909091','012','CNSH','2023-03-01'),
     ('KTO','Kỹ Thuật Ôtô','B12','0838909092','011','KT','2023-04-01'),
     ('IOT','Kết Nối Vạn Vật','B20','0838909093','013','CNTT','2023-05-01'),
     ('TKDH','Thiết Kế Đồ Họa','B14','0838909094','014','CNTT','2023-06-01'),
     ('TRR','Toán Rời Rạc','B20','0838909095','015','XHNV','2023-07-01'),
     ('TCC','Toán Cao Cấp','B16','0838909096','016','TH','2023-08-01'),
     ('NMLT','Nhập Môn Lập Trình','B17','0838909097','017','CNTT','2023-09-01'),
     ('CSDL','Cơ Sở Dữ Liệu','B18','0838909098','018','CNTT','2022-02-01'),
     ('GT','Giai Thuật','B19','0838909099','019','NNH','2021-01-01'),
     ('HDT','Hướng Đối Tượng','B33','0838909010','020','CNTT','2022-01-01');
	
--Nhập data cho bảng KHOA
	INSERT INTO KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	VALUES 
     ('CNTT','Công nghệ thông tin',1995,'B11','0838123456','002','2005-02-20'),
	 ('HH','Hóa học',1982,'B41','0838456456','007','2001-10-15'),
	 ('TH','Toán học',1980,'B31','0838454545','004','2000-10-11'),
	 ('VL','Vật lý',1976,'B21','0838223223','005','2003-09-18'),
     ('SH','Sinh học',1981,'B42','0838456451','008','2001-10-15'),
     ('THH','Tin học',1982,'B43','0838456452',NULL,NULL),
     ('KT','Kỹ thuật',1983,'B44','0838456453','011','2001-10-15'),
     ('KTQT','Kinh tế quản trị',1984,'B45','0838456454','006','2001-10-15'),
     ('XHNV','Xã hội và nhân văn',1985,'B46','0838456455','015','2001-10-15'),
     ('KHCS','Khoa học cơ bản',1982,'B47','0838456456',NULL,NULL),
     ('CNMT','Công nghệ môi trường',1982,'B48','0838456457',NULL,NULL),
     ('KTXD','Kỹ thuật xây dựng',1982,'B49','0838456458',NULL,NULL),
     ('NNH','Ngoại ngữ học',1982,'B50','0838456459','019','2001-10-15'),
     ('QTKD','Quản trị kinh doanh',1982,'B51','0838456460','015','2001-10-15'),
     ('TNMT','Tài nguyên và môi trường',1982,'B52','0838456461','010','2001-10-15'),
     ('TV','Thủy văn',1982,'B53','0838456462',NULL,NULL),
     ('HVH','Hải văn học',1982,'B54','0838456463',NULL,NULL),
     ('NN','Nông Nghiệp',1982,'B55','0838456464',NULL,NULL),
     ('KHSK','Khoa học sức khỏe',1982,'B56','0838456465','007','2001-10-15'),
     ('CNSH','Công nghệ sinh học',1982,'B57','0838456466','012','2001-10-15');
	
    
--Nhập data cho bảng CHUDE
	INSERT INTO CHUDE(MACD,TENCD)
	VALUES 
     ('NCPT', 'Nghiên cứu phát triển'),
	 ('QLGD', 'Quản lý giáo dục'),
	 ('UDC', 'Ứng dụng công nghệ'),
     ('KHC', 'Khoa học công nghệ'),
     ('CNS', 'Công nghệ sinh học'),
     ('CNH', 'Công nghệ hóa'),
     ('CNL', 'Công nghệ vật lý'),
     ('TTH', 'Thể Thao'),
     ('TT', 'Thời Trang'),
     ('DL', 'Du lịch'),
     ('NCT', 'Nghiên cứu thể thao'),
     ('SH', 'Sinh học'),
     ('HH', 'Hóa học'),
     ('TTN', 'Trí tuệ nhân tạo'),
     ('AN', 'Âm nhạc'),
     ('VL', 'Vật lý'),
     ('KGM', 'Không gian mạng'),
     ('ATT', 'An toàn thông tin'),
     ('NCD', 'Nghiên cứu dữ liệu'),
     ('PTD', 'Phân tích dữ liệu ');
	
    
--Nhập data cho bảng DETAI
	INSERT INTO DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	VALUES 
     ('001','HTTT quản lý các trường ĐH','ĐHQG',20,'2007-10-20','2008-10-20','QLGD','002'),
	 ('002','HTTT quản lý giáo vụ cho một Khoa','Trường',60,'2000-10-12','2001-10-12','QLGD','002'),
	 ('003','Nghiên cứu phương pháp tối ưu bài toán xấp xỉ đa thức','ĐHQG',100,'2008-05-15','2010-05-15','NCPT','005'),
	 ('004','Tạo vật liệu mới ứng dụng trong xây dựng công trình','Nhà nước',100,'2007-01-01','2009-10-31','NCPT','004'),
	 ('005','Ứng dụng hóa học xanh','Trường',200,'2003-10-10','2004-12-10','UDC','001'),
	 ('006','Nghiên cứu chuyển động của hệ mặt trời','Nhà nước',4000,'2006-10-12','2009-10-12','NCPT','004'),
	 ('007','HTTT quản lý ở các trường CĐ','Trường',9,'2009-05-10','2010-05-10','QLGD','001'),
	 ('008','HTTT quản lý thư viện ở các trường CĐ','Trường',9,'2009-05-10','2010-05-10','QLGD','002'),
     ('009','HTTT quản lý ở các trường THPT ','Trường',9,'2009-05-10','2010-05-10','QLGD','003'),
     ('010','HTTT quản lý thư viện ở các trường THPT','Trường',9,'2009-05-10','2010-05-10','QLGD','004'),
     ('011','HTTT quản lý thư viện ở các trường THCS','Trường',9,'2009-05-10','2010-05-10','QLGD','005'),
     ('012','HTTT quản lý ở các trường THCS','Trường',9,'2009-05-10','2010-05-10','QLGD','006'),
     ('013','HTTT quản lý ở các trường TH','Trường',9,'2009-05-10','2010-05-10','QLGD','007'),
     ('014','HTTT quản lý thư viện ở các trường TH','Trường',9,'2009-05-10','2010-05-10','QLGD','008'),
     ('015','HTTT quản lý thư viện ở các trường GDTX','Trường',9,'2009-05-10','2010-05-10','QLGD','009'),
     ('016','HTTT quản lý ở các trường GDTX','Trường',9,'2009-05-10','2010-05-10','QLGD','010'),
     ('017','HTTT quản lý thư viện ở các trường QT','Trường',9,'2009-05-10','2010-05-10','QLGD','001'),
     ('018','HTTT quản lý ở các trường QT','Trường',9,'2009-05-10','2010-05-10','QLGD','002'),
     ('019','Nghiên cứu khoa học dữ liệu','Nhà nước',100,'2009-05-10','2010-05-10','UDC','003'),
     ('020','Nghiên cứu trí tuệ nhân tạo','Nhà nước',200,'2009-05-10','2010-05-10','TTN','004');
    
--Nhập data cho bảng CONGVIEC
	INSERT INTO CONGVIEC(MADT,STT,TENCV,NGAYBD,NGAYKT)
	VALUES 
	 ('001',1,'Khởi tạo và Lập kế hoạch','2007-10-20','2008-12-20'),
	 ('001',2,'Xác định yêu cầu','2008-12-21','2008-03-21'),
	 ('001',3,'Phân tích hệ thống','2008-03-22','2008-05-22'),
	 ('001',4,'Thiết kế hệ thống','2008-05-23','2008-06-23'),
	 ('001',5,'Cài đặt thử nghiệm','2008-06-24','2008-10-20'),
	 ('002',1,'Khởi tạo và lập kế hoạch','2009-05-10','2009-07-10'),
	 ('002',2,'Xác định yêu cầu','2009-07-11','2009-10-11'),
	 ('002',3,'Phân tích hệ thống','2009-10-12','2009-12-20'),
	 ('002',4,'Thiết kế hệ thống','2009-12-21','2010-03-22'),
	 ('002',5,'Cài đặt thử nghiệm','2010-03-23','2010-05-10'),
	 ('006',1,'Chế tạo sản phẩm','2006-10-20','2007-02-20'),
	 ('006',2,'Khởi tạo và Lập kế hoạch','2007-02-21','2008-09-21'),
     ('006',3,'Nghiên cứu khoa học','2007-02-21','2008-09-21'),
     ('006',4,'Xác định yêu cầu','2007-02-21','2008-09-21'),
     ('006',5,'Khởi tạo và Lập kế hoạch','2007-02-21','2008-09-21'),
     ('007',1,'Khởi tạo và Lập kế hoạch','2007-02-21','2008-09-21'),
     ('007',2,'Nghiên cứu khoa học','2007-02-21','2008-09-21'),
     ('007',3,'Xác định yêu cầu','2007-02-21','2008-09-21'),
     ('008',1,'Khởi tạo và Lập kế hoạch','2007-02-21','2008-09-21'),
     ('008',2,'Xác định yêu cầu','2007-02-21','2008-09-21'),
     ('008',3,'Nghiên cứu khoa học','2007-02-21','2008-09-21'),
     ('008',4,'Khởi tạo và Lập kế hoạch','2007-02-21','2008-09-21');
	
	
--Nhập data cho bảng THAMGIADT
	INSERT INTO THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	VALUES 
     ('001','001',1,0.0,''),
	 ('001','001',2,2.0,''),
	 ('002','001',4,2.0,'Đạt'),
	 ('003','001',1,1.0,'Đạt'),
	 ('003','001',2,0.0,'Đạt'),
	 ('003','001',4,1.0,'Đạt'),
	 ('003','002',2,0.0,''),
	 ('004','006',1,0.0,'Đạt'),
	 ('004','006',2,1.0,'Đạt'),
	 ('006','006',2,1.5,'Đạt'),
	 ('006','007',3,0.5,''),
	 ('007','008',4,1.5,''),
     ('008','001',4,1.5,''),
     ('009','002',4,1.5,''),
     ('010','006',4,1.5,''),
     ('011','007',2,1.5,''),
     ('012','008',4,1.5,''),
     ('014','001',4,1.5,''),
     ('001','002',4,1.5,''),
     ('004','006',4,1.5,'');
     
	

-- --Nhập data cho bảng GV_DT
-- 	INSERT INTO GV_DT(MAGV,DIENTHOAI)
-- 	VALUES 
--      ('001','0838912009'),
-- 	 ('001','0903532088'),
-- 	 ('002','0956462907'),
-- 	 ('003','0838151075'),
-- 	 ('003','0903530968'),
-- 	 ('003','0937125609'),
-- 	 ('006','0937860731'),
-- 	 ('008','0653707189'),
-- 	 ('008','0913214201'),
--      ('009','0913214202'),
--      ('009','0913214203'),
--      ('010','0913214204'),
--      ('010','0913214205'),
--      ('011','0913214206'),
--      ('012','0913214207'),
--      ('012','0913214208'),
--      ('012','0913214209'),
--      ('013','0913214210'),
--      ('013','0913214211');
     
	
-- -- Nhập data cho bảng NGUOITHAN
-- 	INSERT INTO NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
-- 	VALUES 
--      ('001','Hùng','1990-01-14','Nam'),
-- 	 ('001','Thủy','1994-12-08','Nữ'),
-- 	 ('003','Hà','1998-09-03','Nữ'),
-- 	 ('003','Thu','1998-09-03','Nữ'),
-- 	 ('007','Mai','2003-03-26','Nữ'),
-- 	 ('007','Vy','2000-02-14','Nữ'),
-- 	 ('008','Nam','1991-05-06','Nam'),
-- 	 ('009','An','1996-08-19','Nam'),
-- 	 ('010','Minh','2006-01-14','Nam'),
--      ('011','Khang','2006-01-14','Nam'),
--      ('012','Trí','2006-01-14','Nam'),
--      ('013','Quang','2006-01-14','Nam'),
--      ('014','Nhi','2006-01-14','Nữ'),
--      ('015','Thảo','2006-01-14','Nữ'),
--      ('016','Khương','2006-01-14','Nam'),
--      ('017','Trinh','2006-01-14','Nam'),
--      ('018','Binh','2006-01-14','Nam'),
--      ('019','Ý','2006-01-14','Nữ'),
--      ('020','My','2006-01-14','Nữ'),
--      ('002','Tân','2006-01-14','Nam');
     


--Tạo khóa ngoại ở bảng GIAOVIEN
-- ALTER TABLE GIAOVIEN
-- ADD CONSTRAINT FK2_MABM FOREIGN KEY (MABM) REFERENCES BOMON(MABM);

--Tạo khóa ngoại ở bảng BOMON
ALTER TABLE BOMON
ADD CONSTRAINT FK3_TRUONGBM FOREIGN KEY (TRUONGBM) REFERENCES GIAOVIEN(MAGV);
ALTER TABLE BOMON
ADD CONSTRAINT FK4_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);
     
--Tạo khóa ngoại ở bảng KHOA
-- ALTER TABLE KHOA
-- ADD CONSTRAINT FK_TRUONGKHOA_MAGV FOREIGN KEY (TRUONGKHOA) REFERENCES GIAOVIEN(MAGV);
     
	
--Tạo khóa ngoại ở bảng DETAI
ALTER TABLE DETAI
ADD CONSTRAINT FK_CHUDE_DETAI FOREIGN KEY (MACD) REFERENCES CHUDE(MACD);

-- ALTER TABLE DETAI 
-- ADD CONSTRAINT FK7_GVCNDT FOREIGN KEY (GVCNDT) REFERENCES GIAOVIEN(MAGV);

     
--Tạo khóa ngoại ở bảng CONGVIEC
ALTER TABLE CONGVIEC
ADD CONSTRAINT FK_DETAI_CONGVIEC FOREIGN KEY (MADT) REFERENCES DETAI(MADT);
        
        
--Tạo khoá ngoại ở bảng THAMGIADT
-- ALTER TABLE THAMGIADT
-- ADD CONSTRAINT FK_GIAOVIEN_THAMGIADT FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);

-- ALTER TABLE THAMGIADT
-- ADD CONSTRAINT FK_DETAI_THAMGIADT FOREIGN KEY (MADT) REFERENCES DETAI(MADT);

	
-- --Tạo khóa ngoại ở bảng GV_DT
-- ALTER TABLE GV_DT
-- ADD CONSTRAINT FK11_MAGV FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);
 

-- --Tạo khóa ngoại ở bảng NGUOITHAN
-- ALTER TABLE NGUOITHAN
-- ADD CONSTRAINT FK12_MAGV FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);
      







