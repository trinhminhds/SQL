DROP DATABASE IF EXISTS th5QUANLYTHITOTNGHIEP;
CREATE DATABASE th5QUANLYTHITOTNGHIEP;

USE th5QUANLYTHITOTNGHIEP;

CREATE TABLE THISINH (
	SOBD VARCHAR(12), 
	HOTEN VARCHAR(50), 
	NGAYSINH Date, 
	NOISINH VARCHAR(100),
	NAMDUTHI INT,
	MaTruong INT 
);

create table TRUONG (
	MATRUONG INT NOT NULL UNIQUE,
	TENTRUONG VARCHAR(100) 
    
);

CREATE TABLE MONTHI(
	MAMT VARCHAR(10),
    TENMT VARCHAR(20)
);

CREATE TABLE KETQUA(
	SOBD VARCHAR(12),
    MAMT VARCHAR(10),
    DIEMTHI FLOAT,
    GHICHU VARCHAR(20)
);

# Thêm khoá chính sau khi đã tạo bảng
ALTER TABLE THISINH ADD PRIMARY KEY(SOBD);
ALTER TABLE MONTHI ADD PRIMARY KEY(MAMT);
ALTER TABLE TRUONG ADD PRIMARY KEY(MATRUONG);

# Thêm khoá ngoại sau khi đã tạo bảng
ALTER TABLE THISINH ADD FOREIGN KEY(MaTruong) REFERENCES TRUONG(MATRUONG);
ALTER TABLE KETQUA ADD FOREIGN KEY(SOBD) REFERENCES THISINH(SOBD);
ALTER TABLE KETQUA ADD FOREIGN KEY(MAMT) REFERENCES MONTHI(MAMT);



# THÊM DỮ LIỆU VÀO BẢNG TRUONG
INSERT INTO TRUONG VALUES (018,'LÊ HỒNG PHONG');
INSERT INTO TRUONG VALUES (019,'NGUYỄN THỊ MINH KHAI');
INSERT INTO TRUONG VALUES (020,'NGUYỄN THƯỢNG HIỀN');



INSERT INTO THISINH VALUES('080191000001', 'NGUYEN THI LAN ANH', '1982-12-15','',2010,018);
INSERT INTO THISINH VALUES('080191000002', 'TRẦN THỊ KIM HOÀN', '1982-01-31','',2010,018);
INSERT INTO THISINH VALUES('080191000003', 'VŨ MINH QUÂN', '1982-04-14','',2010,019);
INSERT INTO THISINH VALUES('080191000004', 'KHONG MINH HOANG LONG', '1982-05-15','',2010,019);
INSERT INTO THISINH VALUES('080191000005', 'TRAN LE HOANG DUNG', '1982-06-26','',2010,020);

UPDATE `th5quanlythitotnghiep`.`thisinh` SET `SOBD` = '19101' WHERE (`SOBD` = '080191000001');
UPDATE `th5quanlythitotnghiep`.`thisinh` SET `SOBD` = '19102' WHERE (`SOBD` = '080191000002');
UPDATE `th5quanlythitotnghiep`.`thisinh` SET `SOBD` = '19103' WHERE (`SOBD` = '080191000003');
UPDATE `th5quanlythitotnghiep`.`thisinh` SET `SOBD` = '19104' WHERE (`SOBD` = '080191000004');
UPDATE `th5quanlythitotnghiep`.`thisinh` SET `SOBD` = '19105' WHERE (`SOBD` = '080191000005');

UPDATE th5quanlythitotnghiep.thisinh 
SET NAMDUTHI = '2023'
WHERE NAMDUTHI = '2010';




# THÊM DỮ LIỆU VÀO BẢNG MONTHI
INSERT INTO MONTHI VALUES ('DIA','DIA LY');
INSERT INTO MONTHI VALUES ('HOA','HOA HOC');
INSERT INTO MONTHI VALUES ('LY','VAT LY');
INSERT INTO MONTHI VALUES ('NGOAINGU','NGOAI NGU');
INSERT INTO MONTHI VALUES ('SINH','SINH HOC');
INSERT INTO MONTHI VALUES ('SU','LICH SU');
INSERT INTO MONTHI VALUES ('TOAN','TOA HOC');
INSERT INTO MONTHI VALUES ('VAN','NGU VAN');



# THÊM DỮ LIỆU VÀO BẢNG KETQUA
INSERT INTO KETQUA VALUES ('19101','DIA',5,'');
INSERT INTO KETQUA VALUES ('19101','HOA',5,'');	
INSERT INTO KETQUA VALUES ('19101','LY',5,'');
INSERT INTO KETQUA VALUES ('19101','SU',5,'');
INSERT INTO KETQUA VALUES ('19101','TOAN',5,'');
INSERT INTO KETQUA VALUES ('19101','VAN',5,'');
INSERT INTO KETQUA VALUES ('19102','DIA',8,'');
INSERT INTO KETQUA VALUES ('19102','HOA',8,'');	
INSERT INTO KETQUA VALUES ('19102','LY',8,'');
INSERT INTO KETQUA VALUES ('19102','SU',8,'');
INSERT INTO KETQUA VALUES ('19102','TOAN',8,'');
INSERT INTO KETQUA VALUES ('19102','VAN',9,'');
INSERT INTO KETQUA VALUES ('19103','DIA',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19103','HOA',0,'vắng thi');	
INSERT INTO KETQUA VALUES ('19103','LY',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19103','SU',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19103','TOAN',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19103','VAN',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19104','DIA',9,'');
INSERT INTO KETQUA VALUES ('19104','HOA',7,'');	
INSERT INTO KETQUA VALUES ('19104','LY',7,'');
INSERT INTO KETQUA VALUES ('19104','SU',9,'');
INSERT INTO KETQUA VALUES ('19104','TOAN',9,'');
INSERT INTO KETQUA VALUES ('19104','VAN',9,'');
INSERT INTO KETQUA VALUES ('19105','DIA',0,'vắng thi');
INSERT INTO KETQUA VALUES ('19105','HOA',10,'');	
INSERT INTO KETQUA VALUES ('19105','LY',10,'');
INSERT INTO KETQUA VALUES ('19105','SU',10,'');
INSERT INTO KETQUA VALUES ('19105','TOAN',10,'');
INSERT INTO KETQUA VALUES ('19105','VAN',10,'');

TRUNCATE TABLE th5quanlythitotnghiep.KETQUA;

-- 1
SELECT K.MAMT,K.DIEMTHI
FROM th5quanlythitotnghiep.ketqua AS K
WHERE K.SOBD = '19101';

-- 2
SELECT DISTINCT T.*
FROM th5quanlythitotnghiep.ketqua AS K,th5quanlythitotnghiep.thisinh AS T
WHERE K.GHICHU = 'VANG THI' AND K.SOBD = T.SOBD;


-- 3
SELECT T.HOTEN, T.SOBD
FROM th5quanlythitotnghiep.thisinh AS T
INNER JOIN th5quanlythitotnghiep.ketqua AS K
ON T.SOBD = K.SOBD 
WHERE T.NAMDUTHI = 2023 AND K.GHICHU = 'VANG THI'
GROUP BY T.HOTEN, T.SOBD
HAVING COUNT(K.GHICHU) = 6; 



-- 4
SELECT T.SOBD, T.HOTEN
FROM th5quanlythitotnghiep.thisinh AS T
INNER JOIN th5quanlythitotnghiep.ketqua AS K
ON T.SOBD = K.SOBD
WHERE K.DIEMTHI >= 8 
GROUP BY T.SOBD, T.HOTEN
HAVING COUNT(K.MAMT) = 6;



-- 5
SELECT T.HOTEN ,T.SOBD
FROM th5quanlythitotnghiep.thisinh AS T
INNER JOIN th5quanlythitotnghiep.ketqua AS K
ON T.SOBD = K.SOBD
WHERE K.GHICHU = 'VANG THI'
GROUP BY T.HOTEN ,T.SOBD
HAVING COUNT(K.GHICHU) >= 1;


-- 6
SELECT K.DIEMTHI, T.*
FROM th5quanlythitotnghiep.ketqua AS K
INNER JOIN th5quanlythitotnghiep.thisinh AS T
ON K.SOBD = T.SOBD 
WHERE T.MaTruong = '018';


-- 7 
SELECT M.MAMT, AVG(K.DIEMTHI)
FROM th5quanlythitotnghiep.ketqua AS K
INNER JOIN th5quanlythitotnghiep.monthi AS M
ON K.MAMT = M.MAMT
GROUP BY M.MAMT 
HAVING AVG(K.DIEMTHI) < 5;



-- 8
ALTER TABLE th5quanlythitotnghiep.KETQUA
ADD COLUMN DXTN FLOAT;

UPDATE th5quanlythitotnghiep.KETQUA
SET DXTN = ((5 + 5 + 5 + 5 + 5 + 5 )/6)
WHERE SOBD = '19101';

UPDATE th5quanlythitotnghiep.KETQUA
SET DXTN = ((8 + 8 + 8 + 8 + 8 + 9 )/6)
WHERE SOBD = '19102';

UPDATE th5quanlythitotnghiep.KETQUA
SET DXTN = ((0 + 0 + 0 + 0 + 0 + 0 )/6)
WHERE SOBD = '19103';

UPDATE th5quanlythitotnghiep.KETQUA
SET DXTN = ((9 + 7 + 7 + 9 + 9 + 9 )/6)
WHERE SOBD = '19104';

UPDATE th5quanlythitotnghiep.KETQUA
SET DXTN = ((10 + 10 + 10 + 10 + 10 + 0 )/6)
WHERE SOBD = '19105';


SELECT DISTINCT T.*
FROM th5quanlythitotnghiep.KETQUA AS K
INNER JOIN th5quanlythitotnghiep.thisinh AS T
ON K.SOBD = T.SOBD
WHERE K.DXTN >= 8 AND K.DIEMTHI >= 7; 


-- 9
SELECT T.SOBD,T.HOTEN,SUM(K.DIEMTHI) AS TONGDIEM
FROM th5quanlythitotnghiep.thisinh AS T
INNER JOIN th5quanlythitotnghiep.ketqua AS K
ON T.SOBD = K.SOBD
GROUP BY T.SOBD,T.HOTEN
ORDER BY SUM(K.DIEMTHI) DESC
LIMIT 1;



-- 10
SELECT COUNT(DISTINCT T.HOTEN) AS SOLUONG
FROM th5quanlythitotnghiep.THISINH AS T
INNER JOIN th5quanlythitotnghiep.ketqua AS K
ON T.SOBD = K.SOBD
WHERE K.GHICHU = 'VANG THI'
HAVING COUNT(K.GHICHU) >= 1; 


