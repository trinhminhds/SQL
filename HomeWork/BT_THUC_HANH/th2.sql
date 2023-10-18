DROP DATABASE IF EXISTS th2qlgiaovu;
CREATE DATABASE IF NOT EXISTS th2qlgiaovu 
CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

USE th2qlgiaovu;

CREATE TABLE HOCVIEN(
	MAHV CHAR(5),
    HO VARCHAR(40),
    TEN VARCHAR(10),
    NGSINH DATE,
    GIOITINH VARCHAR(3),
    NOISINH VARCHAR(50),
    
    CONSTRAINT HV_MHV_PK PRIMARY KEY(MAHV)
);

CREATE TABLE GIAOVIEN(
	MAGV CHAR (4),
	HOTEN VARCHAR (40),
	HOCVI VARCHAR (10),
	HOCHAM VARCHAR (10),
	GIOITINH VARCHAR (3),
	NGSINH DATE,
	NGVL DATE,
	HESO DECIMAL(2,1),
	LUONG DECIMAL(8,3),
    
	CONSTRAINT GV_MGV_PK PRIMARY KEY(MAGV)

);

CREATE TABLE LOP(
	MALOP CHAR(3),
    TENLOP VARCHAR(40),
    TRGLOP CHAR(5),
    SISO TINYINT,
    MAGVCN CHAR(4),
    
    CONSTRAINT LOP_ML_PK PRIMARY KEY(MALOP),
    CONSTRAINT LOP_MGV_FK FOREIGN KEY(MAGVCN) REFERENCES GIAOVIEN(MAGV),
	CONSTRAINT LOP_MHV_FK FOREIGN KEY(TRGLOP) REFERENCES HOCVIEN(MAHV)
);


CREATE TABLE KHOA(
	MAKHOA VARCHAR(4),
	TENKHOA VARCHAR(40),
	NGTLAP DATE,
	TRGKHOA CHAR(4),
    
	CONSTRAINT KHOA_MK_PK PRIMARY KEY(MAKHOA),
	CONSTRAINT FK_TRGKHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)
);

CREATE TABLE MONHOC(
	MAMH VARCHAR(10),
	TENMH VARCHAR(40),
	TCTL TINYINT ,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
    
	CONSTRAINT MH_MMH_PK PRIMARY KEY (MAMH),
	CONSTRAINT MH_MK_FK FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA)
);

CREATE TABLE DIEUKIEN (
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
    
    
    CONSTRAINT DK_PK PRIMARY KEY (MAMH, MAMH_TRUOC),
    
	CONSTRAINT DK_MMH_FK FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT DK_MMHT_FK FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);



CREATE TABLE GIANGDAY(
	MALOP CHAR(3),
    MAMH VARCHAR(10),
    MAGV CHAR(4),
    HOCKY TINYINT,
    NAM INT,
    TUNGAY DATE,
    DENNGAY DATE,
    
    CONSTRAINT GD_PK PRIMARY KEY (MALOP, MAMH),
    
    CONSTRAINT GD_ML_FK FOREIGN KEY(MALOP) REFERENCES LOP(MALOP),
    CONSTRAINT GD_MAMH_FK FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH),
    CONSTRAINT GD_MGV_FK FOREIGN KEY(MAGV) REFERENCES GIAOVIEN(MAGV)
);

CREATE TABLE KETQUATHI(
	MAHV CHAR(5),
    MAMH VARCHAR(10),
    LANTHI TINYINT,
    NGTHI DATE,
    DIEM DECIMAL(4,2),
    KETQUA VARCHAR(10),
    
    CONSTRAINT KQ_PK PRIMARY KEY(MAHV,MAMH,LANTHI),
    
    CONSTRAINT KQ_MMH_FK FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH),
    CONSTRAINT KQ_MHV_FK FOREIGN KEY(MAHV) REFERENCES HOCVIEN(MAHV)
);


-- Thêm dữ liệu cho bảng HOCVIEN
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH) VALUES
('K1101', 'Nguyễn Đức', 'Anh', '2003-1-27', 'Nam', 'HCM'),
('K1102' ,'Trần Thiên','Bảo' ,'2003-3-14' ,'Nam', 'Kiên Giang'),
('K1103','Nguyễn Kim','Biên','2003-4-18','Nam','Cần Thơ'),
('K1104','Lê Quang','Linh','2003-8-30','Nam','Tây Ninh'),
('K1105','Nguyễn Kim','Ngân','2003-2-27', 'Nữ', 'HCM'),
('K1106','Hoàng Kim','Minh','2003-11-24','Nam','HCM'),
('K1107','Trần Hữu','Nhân','2003-1-21','Nam','Đồng Nai'),
('K1108','Nguyễn Thanh','Tâm', '2003-6-16','Nam', 'Kiên Giang'),
('K1109', 'Bùi Thanh', 'Thanh', '2003-9-09','Nữ' ,'Vĩnh Long'),
('K1110', 'Lê Thị', 'Thương', '2003-2-5', 'Nữ', 'Cần Thơ'),
('K1111', 'Nguyễn Thu', 'Thảo', '2003-12-25', 'Nữ', 'Long An'),
('K1201', 'Nguyễn Thanh', 'Thảo' ,'2003-2-11', 'Nữ' ,'HCM'),
('K1202', 'Võ Kim', 'Duyên', '2003-1-18', 'Nữ','HCM'),
('K1203', 'Trần Thị' ,'Lụa', '2003-9-17', 'Nữ', 'HCM'),
('K1204', 'Trương Mỹ', 'Hạnh', '2003-5-19', 'Nữ', 'Đồng Nai'),
('K1205', 'Nguyễn Gia', 'Hân', '2003-4-17' ,'Nam', 'HCM'),
('K1206', 'Diệp Minh', 'Thanh','2002-3-4','Nữ','Long An'),
('K1207','Trần Thị Như','Ý','2003-2-8','Nữ','Đồng Tháp'),
('K1208','Đoàn','Thanh','2003-4-9','Nam','Tây Ninh'),
('K1209','Nguyễn Như','Mộng','2003-2-23','Nữ','HCM'),
('K1210','Trần Bá','Dương','2003-2-14','Nam','HCM'),
('K1211','Đỗ Thị','Xuân','2003-3-9','Nữ','Đồng Tháp'),
('K1212','Lê Phi','Yến','2003-3-12','Nữ','Trà Vinh'),
('K1301','Nguyễn Thị Kim','Cúc','2003-6-9','Nữ','An Giang'),
('K1302','Trương Thị Mỹ','Hiền','2003-3-18','Nữ','Cần Thơ'),
('K1303','Lê Đức','Dũng','2003-3-21','Nam','Tây Ninh'),
('K1304','Lê Quang','Hiển','2003-4-18','Nam','HCM'),
('K1305','Lê Thị','Hương','2003-3-27','Nữ','HCM'),
('K1306','Nguyễn Thái','Hiền','2003-3-30','Nam',' HCM'),
('K1307','Trần Minh','Trí','2003-5-28','Nam','HCM'),
('K1308','Nguyễn Hiếu','Nghĩa','2003-4-8','Nam','Tây Ninh'),
('K1309','Nguyễn Trung','Hiếu','2002-1-18','Nam','Đồng Nai'),
('K1310','Trần Thị Hồng','Thắm','2003-4-22','Nữ','Đồng Tháp'),
('K1311','Trần Minh','Thức','2003-4-4','Nam','HCM'),
('K1312','Nguyễn Thị Mỹ','Tâm','2003-9-7','Nữ','HCM');


-- Thêm dữ liệu cho bảng GIAOVIEN
INSERT INTO GIAOVIEN VALUES
('GV01','Hồ Thanh Sơn','TS','GS','Nam','1980-5-2','2015-1-11','5.0','2250.000'),
('GV02','Trần Thanh Tâm','TS','PGS','Nam','1975-12-17','2016-4-20','4.5','2025.000'),
('GV03','Đỗ Quốc Dũng','TS','GS','Nam','1969-8-1','2016-9-23','4.0','2100.000'),
('GV04','Trần Minh Nhật','TS','PGS','Nam','1961-2-22','2012-07-12','5.0','2525.000'),
('GV05','Mai Thành Danh','ThS','GV','Nam','1988-3-12','2018-1-10','3.0','1850.000'),
('GV06','Trần Hữu Nghĩa','TS','GV','Nam','1983-3-11','2017-1-12','4.5','2050.000'),
('GV07','Nguyễn Minh Tiến','ThS','GV','Nam','1981-11-23','2018-3-1','4.0','1800.000'),
('GV08','Lê Thị Tuyết','KS',NULL,'Nữ','1984-3-26','2019-3-10','1.6','1050.000'),
('GV09','Nguyễn Tố Lan','ThS','GV','Nữ','1990-12-31','2020-10-1','4.0','1800.000'),
('GV10','Lê Ánh Loan','KS',NULL,'Nữ','1972-7-17','2018-6-1','1.9','1250.000'),
('GV11','Hồ Thanh Tùng','CN','GV','Nam','1996-1-12','2021-5-15','2.6','1600.000'),
('GV12','Trần Văn Chương','CN',NULL,'Nam','1991-3-29','2020-5-15','1.8','1560.500'),
('GV13','Nguyễn Linh Đan','CN',NULL,'Nữ','1994-5-25','2021-09-10','2.6','1800.000'),
('GV14','Trương Minh Châu','ThS','GV','Nữ','1986-11-30','2018-5-15','3.5','1850.000'),
('GV15','Lê Thanh Hà','ThS','GV','Nam','1988-5-4','2018-5-16','3.0','1950.000');

-- Thêm dữ liệu cho bảng KHOA
INSERT INTO KHOA VALUES
('KHMT', 'Khoa học máy tính', '2018-6-7', 'GV01'),
('CNTT', 'Công nghệ thông tin', '2018-6-7', 'GV04'),
('HTTT', 'Hệ thống thông tin', '2018-6-7', 'GV02'),
('TTS', 'Truyền thông số','2018-10-20','GV03'),
('NNA','Ngôn ngữ Anh','2018-12-20', NULL);

-- Thêm dữ liệu cho bảng LOP
INSERT INTO LOP VALUES
('K11','Lớp K11 khóa 1','K1108','48','GV01'),
('K12','Lớp K12 khóa 1','K1205','42','GV05'),
('K13','Lớp K13 khóa 1','K1312','50','GV03');

-- Thêm dữ liệu cho bảng MONHOC
INSERT INTO MONHOC VALUES('THDC','Tin học đại cương','3','2','CNTT'),
('CTRR','Cấu trúc rời rạc','5','0','KHMT'),
('CSDL','Cơ sở dữ liệu','3','2','HTTT'),
('CTDLGT','Cấu trúc dữ liệu và giải thuật','3','2','CNTT'),
('PTTKTT','Phân tích thiết kế thuật toán','5','0','KHMT'),
('DHMT','Đồ hoạ máy tính','3','2','CNTT'),
('TKCSDL','Thiết kế cơ sở dữ liệu','3','2','HTTT'),
('PTTKHTTT','Phân tích thiết kế hệ thống thông tin','3','2','HTTT'),
('HDH','Hệ điều hành','3','2','KHMT'),
('MMT','Mạng máy tính','4','0','TTS'),
('TA1','Tiếng Anh 1','3','0','NNA'),
('TA2','Tiếng Anh 2','3','0','NNA'),
('TACN','Tiếng Anh chuyên ngành','3','0','CNTT');

-- Thêm dữ liệu cho bảng GIANGDAY
INSERT INTO GIANGDAY VALUES
('K11','THDC','GV07','1','2022','2022-1-2','2022-5-12'),
('K12','THDC','GV06','1','2022','2022-1-2','2022-5-12'),
('K13','THDC','GV15','1','2022','2022-1-2','2022-5-12'),
('K11','CTRR','GV02','1','2022','2022-1-9','2022-5-17'),
('K12','CTRR','GV02','1','2022','2022-1-9','2022-5-17'),
('K13','CTRR','GV08','1','2022','2022-1-9','2022-5-17'),
('K11','CSDL','GV05','2','2022','2022-6-1','2022-7-15'),
('K12','CSDL','GV09','2','2022','2022-6-1','2022-7-15'),
('K13','CTDLGT','GV15','2','2022','2022-6-1','2022-7-15'),
('K13','CSDL','GV05','3','2022','2022-8-1','2022-12-15'),
('K13','DHMT','GV07','3','2022','2022-8-1','2022-12-15'),
('K11','CTDLGT','GV15','3','2022','2022-8-1','2022-12-15'),
('K12','CTDLGT','GV15','3','2022','2022-8-1','2022-12-15'),
('K11','HDH','GV04','1','2023','2023-1-2','2023-2-18'),
('K12','HDH','GV04','1','2023','2023-1-2','2023-2-21'),
('K11','DHMT','GV07','1','2023','2023-2-18','2023-3-20'),
('K11','TA1','GV14','1','2023','2023-2-18','2023-3-20');

-- Thêm dữ liệu cho bảng DIEUKIEN
INSERT INTO DIEUKIEN VALUES
('CSDL','CTRR'),
('CSDL','CTDLGT'),
('CTDLGT','THDC'),
('PTTKTT','THDC'),
('PTTKTT','CTDLGT'),
('DHMT','THDC'),
('MMT','THDC'),
('PTTKHTTT','CSDL'),
('TKCSDL','CSDL'),
('TA2','TA1'),
('TACN','TA2');



-- Thêm dữ liệu cho bảng KETQUATHI
INSERT INTO KETQUATHI VALUES
('K1101','CSDL','1','2022-7-20',10.00,'Đạt'),
('K1101','CTDLGT','1','2022-12-28',9.00,'Đạt'),
('K1101','THDC','1','2022-5-20',9.00,'Đạt'),
('K1101','CTRR','1','2022-5-13',9.50,'Đạt'), 

('K1102','CSDL','1','2022-7-20',4.00,'Không đạt'), 
('K1102','CSDL','2','2022-7-27',4.25,'Không đạt'), 
('K1102','CSDL','3','2022-8-10',4.50,'Không đạt'), 
('K1102','CTDLGT','1','2022-12-28',4.50,'Không đạt'), 
('K1102','CTDLGT','2','2023-1-5',4.00,'Không đạt'), 
('K1102','CTDLGT','3','2023-1-15',6.00,'Đạt'), 
('K1102','THDC','1','2022-5-20',5.00,'Đạt'), 
('K1102','CTRR','1','2022-5-13',7.00,'Đạt'),

('K1103','CSDL','1','2022-7-20',3.50,'Không đạt'), 
('K1103','CSDL','2','2022-7-27',8.25,'Đạt'), 
('K1103','CTDLGT','1','2022-12-28',7.00,'Đạt'), 
('K1103','THDC','1','2022-5-20',8.00,'Đạt'), 
('K1103','CTRR','1','2022-5-13',6.50,'Đạt'), 

('K1104','CSDL','1','2022-7-20',3.75,'Không đạt'), 
('K1104','CTDLGT','1','2022-12-28',4.00,'Không đạt'), 
('K1104','THDC','1','2022-5-20',4.00,'Không đạt'), 
('K1104','CTRR','1','2022-5-13',4.00,'Không đạt'), 
('K1104','CTRR','2','2022-5-20',3.50,'Không đạt'), 
('K1104','CTRR','3','2022-6-30',4.00,'Không đạt'), 

('K1201','CSDL','1','2022-7-20',6.00,'Đạt'), 
('K1201','CTDLGT','1','2022-12-28',5.00,'Đạt'), 
('K1201','THDC','1','2022-5-20',8.50,'Đạt'), 
('K1201','CTRR','1','2022-5-13',9.00,'Đạt'), 

('K1202','CSDL','1','2022-7-20',8.00,'Đạt'),
('K1202','CTDLGT','1','2022-12-28',4.00,'Không đạt'),
('K1202','CTDLGT','2','2023-1-5',5.00,'Đạt'), 
('K1202','THDC','1','2022-5-20',4.00,'Không đạt'), 
('K1202','THDC','2','2022-5-27',4.00,'Không đạt'), 
('K1202','CTRR','1','2022-5-13',3.00,'Không đạt'),
('K1202','CTRR','2','2022-5-20',4.00,'Không đạt'),
('K1202','CTRR','3','2022-6-30',6.25,'Đạt'),

('K1203','CSDL','1','2022-7-20',9.25,'Đạt'), 
('K1203','CTDLGT','1','2022-12-28',9.50,'Đạt'), 
('K1203','THDC','1','2022-5-20',10.00,'Đạt'), 
('K1203','CTRR','1','2022-5-13',10.00,'Đạt'), 

('K1204','CSDL','1','2022-7-20',8.50,'Đạt'), 
('K1204','CTDLGT','1','2022-12-28',6.75,'Đạt'), 
('K1204','THDC','1','2022-5-20',4.00,'Không đạt'), 
('K1204','CTRR','1','2022-5-13',6.00,'Đạt'), 

('K1301','CSDL','1','2022-12-20',4.25,'Không đạt'), 
('K1301','CTDLGT','1','2022-7-25',8.00,'Đạt'), 
('K1301','THDC','1','2022-5-20',7.75,'Đạt'), 
('K1301','CTRR','1','2022-5-13',8.00,'Đạt'), 

('K1302','CSDL','1','2022-12-20',6.75,'Đạt'), 
('K1302','CTDLGT','1','2022-7-25',5.00,'Đạt'), 
('K1302','THDC','1','2022-5-20',8.00,'Đạt'), 
('K1302','CTRR','1','2022-5-13',8.50,'Đạt'),

('K1303','CSDL','1','2022-12-20',4.00,'Không đạt'), 
('K1303','CTDLGT','1','2022-7-25',4.50,'Không đạt'), 
('K1303','CTDLGT','2','2022-8-7',4.00,'Không đạt'), 
('K1303','CTDLGT','3','2022-8-15',4.25,'Không đạt'), 
('K1303','THDC','1','2022-5-20',4.50,'Không đạt'), 
('K1303','CTRR','1','2022-5-13',3.25,'Không đạt'), 
('K1303','CTRR','2','2022-5-20',5.00,'Đạt'), 

('K1304','CSDL','1','2022-12-20',7.75,'Đạt'), 
('K1304','CTDLGT','1','2022-7-25',9.75,'Đạt'), 
('K1304','THDC','1','2022-5-20',5.50,'Đạt'), 
('K1304','CTRR','1','2022-5-13',5.00,'Đạt'), 

('K1305','CSDL','1','2022-12-20',9.25,'Đạt'), 
('K1305','CTDLGT','1','2022-7-20',10.00,'Đạt'), 
('K1305','THDC','1','2022-5-20',8.00,'Đạt'), 
('K1305','CTRR','1','2022-5-13',10.00,'Đạt');




-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)

-- 1

ALTER TABLE th2qlgiaovu.hocvien
ADD GHICHU NVARCHAR(20),
ADD DIEMTB INT,
ADD XEPLOAI NVARCHAR(10);


-- 2
ALTER TABLE th2qlgiaovu.hocvien
ADD CONSTRAINT CK_MHV_ML 
CHECK (SUBSTRING(MAHV, 1, 3) IN ('K11', 'K12', 'K13')
);

-- CHUA RUN NHA ANH TRAI
-- 3
ALTER TABLE th2qlgiaovu.ketquathi
MODIFY COLUMN DIEM DECIMAL(5,2);

-- 4
ALTER TABLE th2qlgiaovu.ketquathi
ADD CONSTRAINT CK_KQ CHECK ( KETQUA IN ('Đạt' OR 'Không đạt') );


-- 5
ALTER TABLE th2qlgiaovu.KETQUATHI
ADD CONSTRAINT CK_LT CHECK(LANTHI <= 3);

-- 6
ALTER TABLE th2qlgiaovu.giangday
ADD CONSTRAINT CK_HK CHECK (HOCKY BETWEEN 1 AND 3);


-- 7
ALTER TABLE th2qlgiaovu.giaovien 
ADD CONSTRAINT CK_HVI CHECK(HOCVI IN ( 'CN'OR 'KS'OR 'Ths'OR 'TS' OR 'PTS'));

-- 8
ALTER TABLE th2qlgiaovu.hocvien
ADD CONSTRAINT CK_TUOI
CHECK (DATEDIFF(CURDATE(), NGSINH) >= 18*365);

-- 9
ALTER TABLE th2qlgiaovu.giangday 
ADD CONSTRAINT CK_NGAY CHECK(TUNGAY < DENNGAY);


-- 10
ALTER TABLE th2qlgiaovu.monhoc
ADD CONSTRAINT CK_TC_TH CHECK(abs(TCTL - TCTH) <= 5);


-- 11
ALTER TABLE th2qlgiaovu.lop
ADD CONSTRAINT CK_TRGLOP 
CHECK (SUBSTRING(TRGLOP, 1, 3) IN (MALOP));


-- 12

DELIMITER $$ 
CREATE TRIGGER check_HOCVI
BEFORE INSERT ON th2qlgiaovu.KHOA
FOR EACH ROW
BEGIN
  IF  (
		SELECT G.HOCVI
		FROM th2qlgiaovu.giaovien AS G
		INNER JOIN th2qlgiaovu.khoa AS K
		WHERE G.MAGV = K.TRGKHOA AND G.HOCVI = 'TS') THEN
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'hợp lệ';
  END IF;
END $$
DELIMITER ;



-- 13
ALTER TABLE th2qlgiaovu.giaovien
ADD CONSTRAINT CHK_LUONG
CHECK ( LUONG =
  (CASE
    WHEN HOCVI = 'TS' AND HOCHAM = 'GS' AND HESO = '5.0'  THEN  2250.000
	WHEN HOCVI = 'TS' AND HOCHAM = 'GS' AND HESO = '4.0' THEN  2100.000
    WHEN HOCVI = 'TS' AND HOCHAM = 'PGS'  AND HESO = '4.5' THEN  2025.000
    WHEN HOCVI = 'TS' AND HOCHAM = 'GV'  AND HESO = '4.5' THEN  2050.000
    WHEN HOCVI = 'ThS' AND HOCHAM = 'GV' AND HESO = '3.0' THEN 1850.000
    WHEN HOCVI = 'ThS' AND HOCHAM = 'GV'  AND HESO = '3.5' THEN  1850.000
    WHEN HOCVI = 'ThS' AND HOCHAM = 'GV'  AND HESO = '4.0' THEN  1800.000
    WHEN HOCVI = 'CN' AND HOCHAM = 'GV'  AND HESO = '2.6' THEN  1600.000
    WHEN HOCVI = 'CN' AND HOCHAM = ' '  AND HESO = '1.8'  THEN  1560.500
    WHEN HOCVI = 'CN' AND HOCHAM = ' '  AND HESO = '2.6'  THEN  1800.000
	WHEN HOCVI = 'KS' AND HOCHAM = ' '  AND HESO = '1.9' THEN  1250.000
    WHEN HOCVI = 'KS' AND HOCHAM = ' '  AND HESO = '1.6' THEN  1050.000
    ELSE  NULL
  END)
);

-- 14
ALTER TABLE th2qlgiaovu.ketquathi
ADD CONSTRAINT chk_thi_lai
CHECK ((LANTHI) <= 1 OR ((LANTHI) = 2 AND DIEM < 5));


-- 15
DELIMITER $$ 
CREATE TRIGGER CHK_NGTHI
BEFORE INSERT ON th2qlgiaovu.KETQUATHI
FOR EACH ROW
BEGIN
	SET @NGTHTR = (
		SELECT K.NGTHI 
		FROM th2qlgiaovu.ketquathi AS K
		WHERE K.MAHV = NEW.MAHV AND K.MAMH = NEW.MAMH
		ORDER BY K.NGTHI DESC
		LIMIT 1
        );
        
  IF (@NGTHITR IS NOT NULL AND NEW.NGTHI <= @NGTHITR) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước.';
  END IF;
END $$
DELIMITER ;
 
 
 
 
 -- II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language)
 
 -- 1 
 UPDATE th2qlgiaovu.giaovien
 SET LUONG = LUONG * 1.1
 WHERE (DATEDIFF(CURDATE(), NGVL) >= 5*365);


-- 2
UPDATE TH2QLGIAOVU.GIAOVIEN AS G
INNER JOIN TH2QLGIAOVU.KHOA AS K
SET G.HESO = G.HESO + 0.2
WHERE G.MAGV = K.TRGKHOA AND G.MAGV IN (K.TRGKHOA); 


-- 3
UPDATE TH2QLGIAOVU.HOCVIEN 
SET DIEMTB = (SELECT SUM(K1.DIEM) / COUNT(K1.MAMH) 
			FROM TH2QLGIAOVU.KETQUATHI AS K1 
			WHERE K1.LANTHI = (SELECT MAX(K2.LANTHI) 
								FROM TH2QLGIAOVU.KETQUATHI AS K2 	
								WHERE (K1.MAHV = K2.MAHV AND K1.MAMH = K2.MAMH)
								GROUP BY MAHV,MAMH)
			GROUP BY MAHV
			HAVING K1.MAHV = HOCVIEN.MAHV);


-- 4
UPDATE th2qlgiaovu.HOCVIEN 
SET GHICHU = 'Cấm thi' 
WHERE MAHV IN (SELECT MAHV 
				FROM th2qlgiaovu.ketquathi 
				WHERE LANTHI = 3 AND DIEM < 5);
                
                
                
-- 5
UPDATE th2qlgiaovu.hocvien
SET XEPLOAI = 
	(CASE
    WHEN DIEMTB >= 9 THEN  'XS'
    WHEN 8 <= DIEMTB AND DIEMTB < 9 THEN  'G'
    WHEN 6.5 <= DIEMTB AND DIEMTB < 8 THEN  'K'
	WHEN 5 <= DIEMTB AND DIEMTB < 6.5 THEN  'TB'		
	WHEN 5 > DIEMTB THEN 'Y'
    ELSE NULL
    END
);


-- III. Ngôn ngữ truy vấn dữ liệu

-- 1
SELECT H.MAHV, H.HO ,H.TEN ,H.NGSINH
FROM TH2QLGIAOVU.HOCVIEN AS H 
WHERE H.MAHV IN (SELECT L.TRGLOP
				FROM TH2QLGIAOVU.LOP AS L
                WHERE H.MAHV = L.TRGLOP );


-- 2
SELECT H.MAHV,H.HO,H.TEN,K.LANTHI,K.DIEM
FROM th2qlgiaovu.ketquathi AS K, th2qlgiaovu.hocvien AS H
WHERE K.MAMH = 'CTRR' AND H.MAHV LIKE'K12%' AND K.MAHV = H.MAHV
ORDER BY H.TEN,H.HO ASC;


-- 3
SELECT H.MAHV,H.HO,H.TEN,K.MAMH
FROM th2qlgiaovu.ketquathi AS K, th2qlgiaovu.hocvien AS H
WHERE K.LANTHI = 1 AND K.DIEM >= 5 AND K.MAHV = H.MAHV ;


-- 4
SELECT H.MAHV,H.HO,H.TEN
FROM th2qlgiaovu.ketquathi AS K, th2qlgiaovu.hocvien AS H
WHERE K.MAMH = 'CTRR' AND K.MAHV LIKE 'K11%' AND K.LANTHI = 1 AND K.DIEM < 5 AND K.MAHV = H.MAHV;


-- 5
SELECT DISTINCT H.MAHV,H.HO,H.TEN
FROM th2qlgiaovu.ketquathi AS K, th2qlgiaovu.hocvien AS H
WHERE K.MAMH = 'CTRR' AND K.MAHV LIKE 'K11%' AND K.LANTHI BETWEEN 1 AND 3 AND K.DIEM < 5 AND K.MAHV = H.MAHV;


-- 6
SELECT GD.MAMH
FROM th2qlgiaovu.giangday AS GD, th2qlgiaovu.giaovien AS GV
WHERE GV.HOTEN = 'Trần Thanh Tâm' AND GD.HOCKY = 1 AND GD.NAM = 2022 AND GD.MAGV = GV.MAGV;

-- 7
SELECT M.MAMH, M.TENMH
FROM th2qlgiaovu.monhoc AS M, th2qlgiaovu.giangday AS GD, th2qlgiaovu.lop AS L
WHERE L.MALOP = 'K12' AND GD.NAM AND M.MAMH = GD.MAMH AND GD.MAGV = L.MAGVCN ;


-- 8
SELECT DISTINCT H.HO,H.TEN
FROM th2qlgiaovu.hocvien AS H 
INNER JOIN th2qlgiaovu.lop AS L
ON H.MAHV = L.TRGLOP
INNER JOIN th2qlgiaovu.giaovien AS GV 
ON L.MAGVCN = GV.MAGV
INNER JOIN th2qlgiaovu.giangday AS G  
ON GV.MAGV = G.MAGV
WHERE GV.HOTEN = 'MAI THÀNH DANH' AND G.MAMH = 'CSDL';


-- 9
SELECT D.MAMH , MH.TENMH
FROM th2qlgiaovu.dieukien AS D , th2qlgiaovu.monhoc AS M, th2qlgiaovu.monhoc AS MH
WHERE M.MAMH = D.MAMH_TRUOC AND MH.MAMH = D.MAMH AND M.TENMH = 'CƠ SỞ DỮ LIỆU';  


-- 10
SELECT D.MAMH , MH.TENMH
FROM th2qlgiaovu.dieukien AS D , th2qlgiaovuY.monhoc AS M, th2qlgiaovu.monhoc AS MH
WHERE M.MAMH = D.MAMH_TRUOC AND MH.MAMH = D.MAMH AND M.TENMH = 'TIN HỌC ĐẠI CƯƠNG';  



-- 11
SELECT DISTINCT G.HOTEN
FROM th2qlgiaovu.giaovien AS G
INNER JOIN th2qlgiaovu.giangday AS D
ON G.MAGV = D.MAGV
WHERE D.MALOP IN ('K11','K12') AND D.MAMH = 'CTRR' AND D.HOCKY = 1 AND D.NAM = 2022;


-- 12
SELECT DISTINCT H.MAHV,H.HO,H.TEN
FROM th2qlgiaovu.HOCVIEN AS H 
INNER JOIN th2qlgiaovu.ketquathi AS K
ON H.MAHV = K.MAHV
WHERE K.MAMH = 'CSDL' AND K.DIEM < 5 AND K.LANTHI = 1 AND NOT EXISTS
	(SELECT *
    FROM th2qlgiaovu.ketquathi AS K1
	WHERE H.MAHV = K1.MAHV AND K1.MAMH = 
			(SELECT M.MAMH
			FROM th2qlgiaovu.monhoc AS M 
			WHERE M.MAMH = 'CSDL' AND K1.LANTHI > 1)
	);


-- 13
SELECT G.MAGV,G.HOTEN 
FROM th2qlgiaovu.giaovien AS G 
WHERE G.MAGV NOT IN 
		(SELECT D.MAGV
		FROM th2qlgiaovu.giangday AS D
		WHERE G.MAGV = D.MAGV);


-- 14
SELECT H.HO, H.TEN
FROM th2qlgiaovu.ketquathi AS K1,th2qlgiaovu.HOCVIEN AS H
WHERE K1.LANTHI = 3 AND K1.DIEM < 5 AND K1.MAHV = H.MAHV
UNION 
SELECT V1.HO, V1.TEN
FROM th2qlgiaovu.ketquathi AS K1, th2qlgiaovu.hocvien AS V1
WHERE K1.MAMH = 'CTRR' AND K1.DIEM = 5 AND K1.LANTHI = 2 AND K1.MAHV = V1.MAHV;




-- 15
SELECT G.HOTEN
FROM th2qlgiaovu.giaovien AS G
INNER JOIN th2qlgiaovu.giangday AS D
ON G.MAGV = D.MAGV  
WHERE D.MAMH = 'CTRR' AND D.HOCKY BETWEEN 1 AND 3 AND D.NAM BETWEEN 2022 AND 2023
GROUP BY G.HOTEN 
HAVING COUNT(D.MALOP) >= 2;


-- 16
SELECT *
FROM th2qlgiaovu.HOCVIEN AS H 
INNER JOIN (
	SELECT A.MAHV, A.DIEM  
	FROM th2qlgiaovu.KETQUATHI AS A
	WHERE NOT EXISTS (
		SELECT 1 
		FROM th2qlgiaovu.KETQUATHI AS B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) AND A.MAMH = 'CSDL'
) AS DIEM_CSDL
ON H.MAHV = DIEM_CSDL.MAHV;



-- 17
SELECT *
FROM th2qlgiaovu.HOCVIEN AS H 
	INNER JOIN (
	SELECT K.MAHV, MAX(K.DIEM) AS DIEM 
    FROM th2qlgiaovu.KETQUATHI AS K
	WHERE K.MAMH IN (
		SELECT M.MAMH 
        FROM th2qlgiaovu.MONHOC  AS M
		WHERE M.TENMH = 'Co So Du Lieu'
	) 
	GROUP BY K.MAHV, K.MAMH
) AS DIEM_CSDL_MAX
ON H.MAHV = DIEM_CSDL_MAX.MAHV;

-- 18 
SELECT *
FROM th2qlgiaovu.HOCVIEN AS H
	INNER JOIN (		
	SELECT K.MAHV, SUM(K.DIEM)/COUNT(K.MAMH) AS DIEM
    FROM th2qlgiaovu.KETQUATHI AS K
	WHERE DIEM <= K.DIEM AND K.MAMH IN (
		SELECT M.MAMH 
        FROM th2qlgiaovu.MONHOC  AS M
		WHERE M.TENMH = 'Co So Du Lieu'
	) 
	GROUP BY K.MAHV, K.MAMH, K.DIEM
) AS DIEM_CSDL_MAX
ON H.MAHV = DIEM_CSDL_MAX.MAHV;


-- 19
SELECT K.MAKHOA, K.TENKHOA 
FROM (
	SELECT MAKHOA, TENKHOA, RANK() OVER(ORDER BY NGTLAP) AS SOMNHAT 
    FROM th2qlgiaovu.KHOA 
) AS K
WHERE K.SOMNHAT = 1;



-- 20
SELECT G.HOCHAM, COUNT(G.HOCHAM) AS SL 
FROM th2qlgiaovu.GIAOVIEN AS G 
WHERE G.HOCHAM IN ('GS', 'PGS') 
GROUP BY G.HOCHAM

