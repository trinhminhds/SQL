---- Cách tạo Database ----

CREATE DATABASE MILO
ON
(
	NAME = 'milo_data',
	FILENAME = 'D:\Data\milo_data.mdf',
	SIZE = 10 MB,
	MAXSIZE = 100 MB,
	FILEGROWTH = 5 MB
)
LOG ON (
	NAME = 'milo_data_log',
	FILENAME = 'D:\Data\milo_data_log.ldf',
	SIZE = 10 MB,
	MAXSIZE = 100 MB,
	FILEGROWTH = 5 MB
)



USE MILO
GO
--CREATE TABLE NguyenLieu
--(	
--	Duong NVARCHAR(10),
--	CaCao NVARCHAR(10)
--)

-- SUA BANG
--ALTER 

-- XOA BANG
--DROP 
 
-- XOA DU LIEU BANG
--TRUNCATE TABLE


------------------------- Các kiểu dữ liệu SQL ---------------------------
-- CÁC KIỂU DỮ LIỆU HAY DÙNG
-- NVARCHAR
-- CHAR : BỘ NHỚ CẤP PHÁT CỨNG, KHÔNG VIẾT TIẾNG VIỆT ĐƯỢC
-- VARCHAR : BỘ NHỚ CẤP PHÁT ĐỘNG, KHÔNG VIẾT TIẾNG VIỆT ĐƯỢC
-- NCHAR : GIỐNG CHAR NHƯNG VIẾT ĐƯỢC TIẾNG VIỆT
-- NVARCHAR : GIỐNG VARCHAR NHƯNG CÓ THỂ VIẾT TIẾNG VIỆT ĐƯỢC
-- DATE : LƯU NGÀY, THÁNG NĂM GIỜ 
-- TIME : GIỜ PHÚT GIÂY
-- TEXT : LƯU VĂN BẢN LỚN
-- NTEXT : LƯU VĂN BẢN LỚN CÓ TIẾNG VIỆT 
-- BYTE : LƯU GIÁ TRỊ 0 VÀ 1







------------------ Insert, delete, update table| ----------------------------

-- THÊM DỮ LIỆU
INSERT DBO.NguyenLieu
(
    Duong,
    CaCao
)
VALUES
(   NULL, -- Duong - nvarchar(10)
    NULL  -- CaCao - nvarchar(10)
    )


-- XÓA DỮ LIỆU
-- DELETE dbo.NguyenLieu WHERE\




-- UPDATE 
--UPDATE dbo.NguyenLieu SET Duong = ? WHERE COLUM =   ?



--- VIEW
-- Tạo ra view TestView từ câu truy vấn
CREATE VIEW TESTVIEW AS VI
SELECT * FROM DBO.NguyenLieu





-- CHECK
CREATE TABLE TESTCHECK
(
	ID INT ,
	LUONG INT CHECK(LUONG > 3000 AND LUONG < 9000)
)
GO 
INSERT DBO.TESTCHECK
(
    ID,
    LUONG
)
VALUES
(   NULL, -- ID - int
    3400  -- LUONG - int 
    ) --ĐÚNG ĐIỀU KIỆN THÊM VÀO ĐÚNG ĐIỀU KIỆN LỚN HƠN 3000 VÀ NHỎ HƠN 9000






	--- KIỂU DỮ LIỆU TỰ ĐỊNH NGHĨA
EXEC sp_addtype 'NMINH', 'NVARCHAR','NOT NULL'

CREATE TABLE TESTTYPE 
(
	NNAME NMINH,
	ID INT 
)

-- Xóa kiểu dữ liệu tự định nghĩa
EXEC sp_droptype TESTTYPE









-- VÒNG LẬP
DECLARE @i INT = 0
DECLARE @j INT = 100

WHILE(@i < @j)
BEGIN
	INSERT DBO.NguyenLieu
	(
	    CaCao
	)
	VALUES
	(   
	    @i  -- CaCao - nvarchar(10)
	    )
		SET @i += 1
END






--- CON TRỎ
--KHI CÓ NHU CẦU DUYỆT TỪNG PHẦN TỬ CỦA BẢNG VỚI MỖI PHẦN TỬ CÓ KẾT QUẢ XỬ LÝ RIÊNG THÌ DÙNG CURSOR
-- DECLARE <TÊN CON TRỎ> CURSOR FOR <CÂU SELECT>
-- OPEN <TÊN CON TRỎ>

-- FETCH NEXT FROM <TÊN CON TRỎ> INTO <DANH SÁCH CÁC BIẾN TƯƠNG ỨNG KẾT QUẢ TRUY VẤN>

-- WHILE @@FETCH_STATUS = 0
-- BEGIN
-- CÂU LỆNH THỰC HIỆN 
-- FETCH NEXT LẠI LẦN NỮA 
-- FETCH NEXT FROM <TÊN CON TRỎ> INTO <DANH SÁCH CÁC BIẾN TƯƠNG ỨNG KẾT QUẢ TRUY VẤN>
-- END


-- CLOSE <TEN CON TRO>
-- DEALLOCATE < TÊN CON TRỎ>





