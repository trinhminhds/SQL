


--                                                                                      BÀI THỰC HÀNH SỐ 2

--  Dựa trên CSDL quản lý nhân viên (bài thực hành số 1)
--  hãy thực hiện các yêu cầu sau:

--  1. Tạo thủ tục hoặc hàm tìm nhân viên theo mã nhân
--  viên (ví dụ timNV ’HC001’ sẽ in ra thông tin của
--  nhân viên này).
GO

CREATE PROCEDURE sp_timNV(@manv CHAR(5))
AS
BEGIN
    
    SELECT *
    FROM NhanVien
    WHERE manv = @manv
    
END

EXEC sp_timNV 'HC001'

--  2. Tạo thủ tục hoặc hàm có đếm số lượng nhân viên
--  nam hoặc nữ (ví dụ demNV N’Nam’ sẽ in ra số lượng
--  nhân viên nam).
GO
CREATE PROCEDURE sp_demNV(@gioitinh CHAR(5))
AS
BEGIN
    SELECT COUNT(*) AS SLNHANVIEN
    FROM NhanVien
    WHERE gioitinh = @gioitinh
END

EXEC sp_demNV N'Nam'

--  3. Tạo thủ tục hoặc hàm hiển thị mã các ngoại ngữ của
--  nhân viên (ví dụ DSNgoaiNngu N’Nguyễn Thị Hà’
--  sẽ in ra các ngoại ngữ của ’Nguyễn Thị Hà’).
GO
CREATE PROCEDURE sp_DSNgoaiNgu(@hoten NVARCHAR(50))
AS
BEGIN
    SELECT TDNN.mann
    FROM NhanVien
    JOIN TDNN 
    ON NhanVien.manv = TDNN.manv
    WHERE NhanVien.hoten = @hoten
END

EXEC sp_DSNgoaiNgu N'Nguyễn Thị Hà'

--  4. Tạo thủ tục hoặc hàm in ra danh sách nhân viên có
--  trình độ ngoại ngữ cầm tìm (ví dụ timNVNN N’Anh’
--  sẽ in ra những nhân viên có trình độ tiếng Anh).
GO
CREATE PROCEDURE sp_timNVNN(@tennn NVARCHAR(20))
AS
BEGIN
    SELECT N.*
    FROM NhanVien AS N
    JOIN TDNN AS T
    ON N.manv = T.manv
    JOIN DMNN AS D
    ON T.mann = D.mann
    WHERE @tennn = D.tennn    
END

EXEC sp_timNVNN N'ANH'

GO
--  5. Tạo thủ tục hoặc hàm cập nhật sdt cho các nhân
--  viên (thủ tục có hai tham số đầu vào gồm mã nhân
--  viên, số điện thoại). Nếu không tìm thấy nhân viên
--  cần cập nhật thì in ra ghi chú ’không tìm thấy nhân
--  viên’. Ngược lại, cho phép cập nhật.

CREATE PROCEDURE sp_capNhatSDT(@manv CHAR(5),@sdt CHAR(10))
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM NhanVien
        WHERE manv = @manv
    )
    BEGIN
        PRINT N'Không tìm thấy nhân viên'
        RETURN -1
    END
    ELSE
    BEGIN
        UPDATE NhanVien
        SET sdt = @sdt
        WHERE manv = @manv
    END
END

EXEC sp_capNhatSDT 'HC004','0977122307'
GO
--  6. Viết thủ tục hoặc hàm có tham số đưa vào là manv,
--  hoten, gioitinh, ngaysinh, luong, maph, sdt, ngaybc.
--  Trước khi chèn một bản ghi mới vào bảng NhanVien
--  thì phải kiểm tra xem manv và maph đã tồn tại bên
--  bảng Phong chưa.
CREATE PROCEDURE sp_themNhanVien(@manv CHAR(5),@hoten NVARCHAR(40), @gioitinh NVARCHAR(5),
@ngaysinh DATE,@luong INT,@mahp CHAR(3),@sdt CHAR(10),@ngaybc DATE)
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM Phong 
        WHERE mahp = @mahp
    )
    BEGIN
        PRINT N'Mã Phòng không tồn tại'
        RETURN -1
    END

    IF EXISTS(
        SELECT *
        FROM NhanVien
        WHERE NhanVien.manv = @manv
    )
    BEGIN
        PRINT N'Mã Nhân Viên này đã tồn tại'
        RETURN -1
    END
    
    INSERT INTO NhanVien
    VALUES(@manv,@hoten,@gioitinh,@ngaysinh,@luong,@mahp,@sdt,@ngaybc)

END

EXEC sp_themNhanVien 'HC001', N'Nguyễn Thị Hòa', N'Nữ', '1999-02-08', 7500000, 'HCA',NULL,'2023-02-08'

GO

--  7. Tạo hàm có đầu vào là tennn và đầu ra là tổng số
--  lượng nhân viên đã học ngoại ngữ này.

CREATE FUNCTION fc_docTennn(@tennn NVARCHAR(20))
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SET @dem = (
        SELECT COUNT(*) AS SLNHANVIEN
        FROM NhanVien AS N
        JOIN TDNN AS T
        ON N.manv = T.manv
        JOIN DMNN AS D
        ON T.mann = D.mann
        WHERE @tennn = D.tennn
    )

    RETURN @dem
END
GO

SELECT dbo.sp_docTennn('ANH')
GO

-- 8. Tạo hàm có:
--  Đầu vào: Tuoi1, Tuoi2
--  Đầu ra: tổng số nhân viên trong cơ quan có độ tuổi
--  trong khoảng Tuoi1 và Tuoi2.
CREATE FUNCTION fc_demTuoiNhanVien(@tuoi1 INT,@tuoi2 INT)
RETURNS INT AS
BEGIN
    DECLARE @dem INT
    
    SET @dem = (
        SELECT COUNT(*) AS SLNHANVIEN
        FROM Nhanvien
        WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) BETWEEN @tuoi1 AND @tuoi2
    )

    RETURN @dem
END
GO
SELECT dbo.fc_demTuoiNhanVien (19,30)
GO


--  9. Viết hàm fc_timgioitinhNV cho biết giới tính của
--  nhân viên (Ví dụ fc_timgioitinhNV ’HC001’ sẽ
--  cho biết giới tính của nhân viên này).
CREATE FUNCTION fc_timgioitinhNV(@manv CHAR(5))
RETURNS NCHAR(5) AS
BEGIN
    DECLARE @gt NCHAR(5)
    
    SELECT @gt = gioitinh 
    FROM NhanVien
    WHERE manv = @manv
    
    RETURN @gt
END
GO
SELECT dbo.fc_timgioitinhNV('HC001')
GO


--  10. Viết hàm cho biết nhân viên nào có mức lương lớn
--  hơn mức lương trung bình của phòng Kinh doanh.
CREATE FUNCTION fc_luongLonHonLTB()
RETURNS TABLE AS
RETURN(
    SELECT manv,hoten
    FROM NhanVien
    WHERE luong > (
        SELECT AVG(luong) 
        FROM NhanVien
        WHERE mahp = 'KDA'
    )
)
GO
SELECT * FROM fc_luongLonHonLTB()
GO

--  11. Viết hàm fc_timSoluongNV cho biết số lượng nhân
--  viên của từng phòng.
CREATE FUNCTION fc_timSoluongNV()
RETURNS TABLE AS
RETURN(
    SELECT Phong.mahp,COUNT(NhanVien.manv) AS SLNHANVIEN
    FROM NhanVien
    JOIN Phong
    ON Nhanvien.mahp = Phong.mahp
    GROUP BY Phong.mahp
)
GO
SELECT * FROM fc_timSoluongNV()
GO


--  12. Viết hàm fc_timTongluongNV cho biết tổng lương
--  nhân viên của từng phòng.
CREATE FUNCTION fc_timTongluongNV()
RETURNS TABLE AS
RETURN(
    SELECT Phong.mahp ,SUM(NhanVien.luong) AS TongLuong
    FROM NhanVien
    JOIN Phong
    ON NhanVien.mahp = Phong.mahp
    GROUP BY Phong.mahp
)
GO
SELECT * FROM fc_timTongluongNV()
GO

--  13. Viết hàm fc_kiemtraHuu cho biết nhân viên năm
--  nay đã đủ tuổi nghỉ hưu hay chưa (Nam >=60 tuổi,
--  Nữ >=55 tuổi).
CREATE FUNCTION fc_kiemtraHuu()
RETURNS TABLE AS
RETURN(
    SELECT *
    FROM NhanVien
    WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60 AND gioitinh = N'Nam' OR
        (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55 AND gioitinh = N'Nữ'
)
GO
SELECT * FROM fc_kiemtraHuu()
GO

--  14. Tạo khung nhìn tên là vwNVANH gồm các thuộc tính
--  mãnhân viên, tên nhân viên, trình độ tiếng Anh của
--  những nhân viên này.
CREATE VIEW vwNVANH 
AS
    SELECT NhanVien.manv,hoten,TDNN.tdo
    FROM NhanVien 
    JOIN TDNN
    ON NhanVien.manv = TDNN.manv
    WHERE TDNN.mann = '01'

GO
--  15. Tạo khung nhìn tên vwDSTA đưa ra danh sách các
--  nhân viên học tiếng Anh (mã nhân viên, họ tên,
--  ngày sinh, giới tính, tên phòng, trình độ. Sau đó
--  dựa vào khung nhìn này để thực hiện:

CREATE VIEW vwDSTA 
AS 
    SELECT N.manv,N.hoten,N.ngaysinh,N.gioitinh,P.tenphG,T.tdo
    FROM Phong AS P
    JOIN NhanVien AS N 
    ON N.mahp = P.mahp
    JOIN TDNN AS T
    ON N.manv = T.manv
    WHERE T.mann = '01'

GO

--  a. Đưa ra danh sách các nhân viên có trình độ
--  tiếng Anh từ loại C trở lên.
SELECT *
FROM vwDSTA 
WHERE tdo IN ('A','B')

--  b. Tạo khung nhìn tên vwTAKD đưa ra danh sách
--  nhân viên phòng Kinh doanh học tiếng Anh.
GO  
CREATE VIEW vwTAKD 
AS
    SELECT *
    FROM vwDSTA
    WHERE tenphG = N'Kinh Doanh'
    
GO
--  c. Thực hiện câu lệnh Insert, Delete, Update
--  vào khung nhìn.
INSERT INTO dbo.vwDSTA(N.manv,N.hoten,N.ngaysinh,N.gioitinh,P.tenphG,T.tdo)
VALUES('HC006',N'Trịnh Ngọc Minh','2003-09-23',N'Nam','Kỹ Thuật','A')

UPDATE vwDSTA
SET tdo = 'B'
WHERE manv = 'HC005'

DELETE FROM vwDSTA
WHERE manv = 'HC005' 

-- 16. Tạo khung nhìn có tên vwNV_TRE để đưa ra danh
--  sách các nhân viên có độ tuổi trong dưới 35. Sau đó
--  dựa trên khung nhìn thực hiện các công việc sau:
GO

CREATE VIEW vwNV_TRE 
AS 
    SELECT *
    FROM NhanVien
    WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) < 35

GO

--  a. In danh sách các nhân viên có độ tuổi từ 25 đến 30.
SELECT *
FROM vwNV_TRE
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) BETWEEN 25 AND 30

--  b. Thực hiện thử một câu lệnh Insert, Delete,
--  Update vào khung nhìn vwNV_TRE.

INSERT INTO vwNV_TRE(manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc)
VALUES('HC007', N'Nguyễn Ngọc Minh', N'Nam', '2003-09-08', 7500000, 'HCA', '2024-02-08');

UPDATE vwNV_TRE
SET hoten = N'Trịnh Ngọc Minh'
WHERE manv = 'HC007'

DELETE FROM vwNV_TRE
WHERE manv = 'HC007' 


--  c. Xóa vwNV_TRE sau đó tạo lại view này với mệnh
--  đề WITH CHECK OPTION và thực hiện các câu
--  lệnh Insert, Update, Delete trên view này.

DROP VIEW vwNV_TRE
GO

CREATE VIEW vwNV_TRE 
AS 
    SELECT *
    FROM NhanVien
    WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) < 35
    WITH CHECK OPTION
GO

INSERT INTO vwNV_TRE(manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc)
VALUES('HC007', N'Nguyễn Ngọc Minh', N'Nam', '2003-09-08', 7500000, 'HCA', '2024-02-08');

UPDATE vwNV_TRE
SET hoten = N'Trịnh Ngọc Minh'
WHERE manv = 'HC007'

DELETE FROM vwNV_TRE
WHERE manv = 'HC007' 
