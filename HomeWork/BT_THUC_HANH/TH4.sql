

-- 1

 DELIMITER //
CREATE PROCEDURE timNV(maNV1 VARCHAR(10))
BEGIN
  SELECT *
  FROM th3qlnv.nhanvien AS N 
  WHERE N.maNV = maNV1;
END//

CALL timNV('HC002'); 


-- 2
DELIMITER //
CREATE PROCEDURE DSNgoaiNgu(TENNV VARCHAR(40))
	BEGIN
		SELECT T.MANN
		FROM th3qlnv.NGHI_HUU AS N
		INNER JOIN th3qlnv.tdnn_nh AS T
		ON N.MANV = T.MANV
		WHERE N.HOTEN = TENNV;
	END//

CALL DSNGOAINGU('NGUYEN THI HA');


-- 3
DELIMITER //
CREATE PROCEDURE SLDH( IN TENNN VARCHAR(10), OUT SOLUONG VARCHAR(10))
BEGIN 
	SELECT COUNT(*) INTO SOLUONG
    FROM th3qlnv.NHANVIEN AS N
    INNER JOIN th3qlnv.tdnn AS T
    ON N.MANV = T.MANV
    INNER JOIN th3qlnv.dmnn AS D
    ON T.MANN = D.MANN
	WHERE D.TENNN = TENNN;
END//

CALL SLDH('ANH',@SOLUONG);
SELECT @SOLUONG;




-- 4
DELIMITER //
CREATE PROCEDURE CAPNHATSDT( IN MANV VARCHAR(10),SDT VARCHAR(11))
BEGIN
	DECLARE KQ INT;
	SELECT COUNT(*) INTO KQ 
    FROM th3qlnv.NHANVIEN AS N
    WHERE N.MANV = MANV;
    IF(KQ = 0) THEN
		SELECT 0;
    ELSE
		UPDATE TH3QLNV.NHANVIEN AS N1
        SET N1.SDT = SDT
        WHERE N1.MANV = MANV;
	SELECT 1;
    END IF;
END; // 
DELIMITER ;

CALL CAPNHATSDT('QT001', '0977122309');


-- 5
DELIMITER //
CREATE FUNCTION TIMNV(MANV VARCHAR(10))
RETURNS VARCHAR(50)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE TT VARCHAR(50);
    SET TT = '';

	SELECT N.HOTEN INTO TT
    FROM th3qlnv.NHANVIEN AS N
    WHERE N.MANV = MANV;
    RETURN TT; 
END; //
DELIMITER ;

SELECT TIMNV('HC002') AS KQ;




DELIMITER //
CREATE FUNCTION DSNGOAINGU(TENNV VARCHAR(40))
RETURNS VARCHAR(30)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE STEN VARCHAR(30);
    
	SELECT GROUP_CONCAT(T.MANN) INTO STEN
	FROM th3qlnv.NGHI_HUU AS N, th3qlnv.tdnn_nh AS T
	WHERE N.MANV = T.MANV AND N.HOTEN = TENNV;
    RETURN STEN;
END; //
DELIMITER ;

DROP FUNCTION DSNGOAINGU;
SELECT dsngoaingu('Nguyen Thi Ha') AS MANN;



DELIMITER //
CREATE FUNCTION SLDH(TENNN VARCHAR(10))
RETURNS VARCHAR(20)
READS SQL DATA DETERMINISTIC
BEGIN 
	DECLARE SOLUONG VARCHAR(20);
    SET SOLUONG = '';
    
	SELECT COUNT(*) INTO SOLUONG
    FROM th3qlnv.NHANVIEN AS N
    INNER JOIN th3qlnv.tdnn AS T
    ON N.MANV = T.MANV
    INNER JOIN th3qlnv.dmnn AS D
    ON T.MANN = D.MANN
	WHERE D.TENNN = TENNN;
    RETURN SOLUONG;
END; //
DELIMITER ;

SELECT SLDH('ANH') AS SOLUONG;



DELIMITER //
CREATE FUNCTION CAPNHATSDT( MANV VARCHAR(10),SDT VARCHAR(11))
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE KQ INT;
    IF EXISTS(
		SELECT *
		FROM th3qlnv.NHANVIEN AS N
		WHERE N.MANV = MANV) 
		THEN 
		UPDATE TH3QLNV.NHANVIEN AS N1
		SET N1.SDT = SDT
		WHERE N1.MANV = MANV;
		SET KQ = 1;
    ELSE
		SET KQ = 0;
    END IF;
    RETURN KQ;
END; // 
DELIMITER ;

SELECT CAPNHATSDT('QT001', '0977122309') AS KQ;



-- 6
DELIMITER //
CREATE FUNCTION THEMNHANVIEN(MANV VARCHAR(10),HOTEN VARCHAR(40),
GIOITINH VARCHAR(4),NGAYSINH DATE, LUONG INT,
MAPH VARCHAR(10),SDT VARCHAR(11), NGAYBC DATE)
RETURNS INT 
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE CK_PH INT;
    IF EXISTS (
		SELECT P.MAPH
        FROM th3qlnv.PHONG AS P
        WHERE P.MAPH = MAPH
    )
	THEN
    INSERT INTO th3qlnv.NHANVIEN 
    VALUES
		(MANV,HOTEN,GIOITINH,NGAYSINH,LUONG,MAPH,SDT,NGAYBC);
	SET CK_PH = 1;
    ELSE 
    SET CK_PH = 0;
	END IF;
	RETURN CK_PH;
END; //
DELIMITER ;

SELECT ThemNhanVien ('QT002', 'Trinh Ngoc Minh', 'Nam', '1990-01-01',
10000000.00, 'P001', '0123456789', '2023-01-01') AS KetQua;


-- 7
DELIMITER //
CREATE FUNCTION TONGLUONGNV(MAPH VARCHAR(5))
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE LUONG INT;
	SET LUONG = 0;
    
		SELECT SUM(N.LUONG) INTO LUONG 
		FROM th3qlnv.NHANVIEN AS N
        INNER JOIN th3qlnv.phong AS P
        ON N.MAPH = P.MAPH
		WHERE N.MAPH = MAPH;
		
	RETURN LUONG;
END; //
DELIMITER ;

SELECT TONGLUONGNV('QTA') AS SUMLUONGPH;



-- 8
DELIMITER //
CREATE FUNCTION KIEMTRAHUU(MaNV VARCHAR(10))
RETURNS VARCHAR(30)
READS SQL DATA DETERMINISTIC
BEGIN
  DECLARE gioitinh VARCHAR(5);
  DECLARE ngaysinh DATE;
  DECLARE tuoi INT;
  DECLARE ketqua VARCHAR(20);
  
  SELECT N.GT, N.NgSinh INTO gioitinh, ngaysinh
  FROM th3qlnv.NhanVien AS N
  WHERE N.MaNV = MaNV;
  
  SET tuoi = YEAR(CURDATE()) - YEAR(ngaysinh);
  IF gioitinh = 'Nam' THEN
    IF tuoi >= 60 THEN
      SET ketqua = 'Đủ tuổi';
    ELSE
      SET ketqua = 'Chưa đủ';
  END IF;
    
  ELSEIF gioitinh = 'Nữ' THEN
    IF tuoi >= 55 THEN
      SET ketqua = 'Đủ tuổi';
    ELSE
      SET ketqua = 'Chưa đủ';
  END IF;
  
  ELSE
    SET ketqua = 'Không xác định';
  END IF;
  
  RETURN ketqua;
END; //
DELIMITER ;

SELECT KIEMTRAHUU('QT001');





-- 9
DELIMITER // 
CREATE FUNCTION TRINHDONN (MANV VARCHAR(5),MANN VARCHAR(3))
RETURNS VARCHAR(20)
READS SQL DATA DETERMINISTIC
BEGIN
    DECLARE TRINHDO VARCHAR(3);
	
    SELECT T.TDO INTO TRINHDO
    FROM th3qlnv.NHANVIEN AS N
    INNER JOIN th3qlnv.tdnn AS T
    ON N.MANV = T.MANV
    WHERE N.MANV = MANV AND T.MANN = MANN;
	
	RETURN TRINHDO;
END; //
DELIMITER ;

SELECT TRINHDONN('QT001','01');



-- 10
CREATE VIEW NV_TRE AS 
SELECT *
FROM th3qlnv.nhanvien AS N
WHERE year(curdate()) - year(N.NGSINH) < 35; 

SELECT *
FROM NV_TRE AS N
WHERE year(curdate()) - year(N.NGSINH) BETWEEN 25 AND 30;


INSERT INTO NV_TRE
VALUES 
	();

UPDATE NV_TRE
SET NGSINH = (year(curdate()) - year(NGSINH)) = 30
WHERE MANV = 'QT001';


DELETE FROM NV_TRE;


DROP VIEW NV_TRE;

CREATE VIEW NV_TRE AS
SELECT *
FROM th3qlnv.NHANVIEN AS N
WHERE (year(curdate()) - year(N.NGSINH)) < 35
WITH CHECK OPTION;

INSERT INTO NV_TRE
VALUES 
	();
    
UPDATE NV_TRE
SET NGSINH = (year(curdate()) - year(NGSINH)) = 30
WHERE MANV = 'QT001';

DELETE FROM NV_TRE;









