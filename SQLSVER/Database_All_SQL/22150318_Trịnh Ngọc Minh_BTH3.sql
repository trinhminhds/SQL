

--                                                                                      BÀI THỰC HÀNH SỐ 3

-- Cho cơ sở dữ liệu có tên là QLTV gồm các quan hệ sau:

--  NhaXuatBan(manxb, tennxb)
--  TheLoai(matl, tentl)
--  Sach(masach, tuade, manxb, tacgia, sl, ngnhap, matl)
--  BanDoc(mathe, tenbandoc, diachi, sdt)
--  MuonSach(mathe, masach, ngaymuon, ngaytra)


CREATE DATABASE QLTHUVIEN
ON(
	NAME = 'QLTHUVIEN_Data',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH3\QLTHUVIEN_Data.mdf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)
LOG ON (
	NAME = 'QLTHUVIEN_Data_Log',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH3\QLTHUVIEN_Data_Log.ldf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)
GO

USE QLTHUVIEN

GO

CREATE TABLE NhaXuatBan (
	MaNXB char(4) NOT NULL PRIMARY KEY,
	TenNXB nvarchar(30) NOT NULL,
);

CREATE TABLE BanDoc (
	MaThe char(6) NOT NULL PRIMARY KEY,
	TenBanDoc nvarchar(30) NOT NULL,
	DiaChi nvarchar(30),
	SoDT char(10)
);
CREATE TABLE TheLoai (
	MaTL char(2) NOT NULL PRIMARY KEY,
	TenTL nvarchar(20) NOT NULL,
);
CREATE TABLE Sach (
	MaSach char(6) NOT NULL PRIMARY KEY,
	TuaDe nvarchar(30) NOT NULL,
	MaNXB char(4),
	TacGia	nvarchar(30),
	SoLuong int,
	NgayNhap Date,
	MaTL char(2) 
);

CREATE TABLE MuonSach (
	MaThe char(6),
	MaSach char(6),
	NgayMuon Date,
	NgayTra Date,
    PRIMARY KEY(MaThe,MaSach)
)

ALTER TABLE Sach
ADD CONSTRAINT FK_NhaXuatBan_Sach
FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB);

ALTER TABLE Sach
ADD CONSTRAINT FK_TheLoai_Sach
FOREIGN KEY (MaTL) REFERENCES TheLoai(MaTL);

ALTER TABLE MuonSach
ADD CONSTRAINT FK_MuonSach_BanDoc
FOREIGN KEY (MaThe) REFERENCES BanDoc(MaThe);

ALTER TABLE MuonSach
ADD CONSTRAINT FK_MuonSach_Sach
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);


GO

INSERT INTO NhaXuatBan VALUES 
('N001', N'Giáo dục'),
('N002', N'Khoa học kỹ thuật'),
('N003', N'Thống kê'),
('N004', N'Thanh niên');
GO

INSERT INTO BanDoc VALUES 
('050001',N'Trần Thị Xuân',N'17 Pauster' , '0392736451'),
('050002',N'Lê Hoài Nam',N'145 Nguyễn Thị Minh Khai' , '0382767201'),
('060001',N'Trần Xuân Hùng',N'20 Trần Phú' , '0392560097'),
('060002',N'Nguyễn Minh Hưng',N'102 Nguyễn Trãi' , '0896885422');
GO

INSERT INTO TheLoai VALUES 
('TH', N'Tin học'),
('HH', N'Hóa học'),
('KT', N'Kinh tế'),
('TN', N'Toán học')
GO

SET DATEFORMAT dmy
INSERT INTO Sach VALUES 
('TH0001',N'Nhập môn cơ sở dữ liệu','N003',N'Đinh Bá Tiến',6,'08/09/2022','TH'),
('TH0002',N'Giáo trình SQL Server','N001',N'Lê Quang Minh',3,'22/11/2021','TH'),
('TH0003',N'Chuyên đề Oracle','N002',N'Phan Thanh Tâm',5,'14/03/2023','TH'),
('TH0004',N'Kỹ thuật lập trình C/C++','N001',N'Đặng Bình Phương',4,'11/06/2022','TH'),
('TH0005',N'Giáo trình Khai phá dữ liệu','N003',N'Trần Hoài Ân',2,'01/12/2021','TH'),
('TH0006',N'Nhập môn phân tích dữ liệu','N003',N'Bùi Thị Ngọc Ngân',4,'23/07/2022','TH'),
('TH0007',N'Lập trình Python và ứng dụng','N001',N'Lê Đại Minh',1,'12/11/2022','TH'),
('TH0008',N'Trực quan hóa dữ liệu','N003',N'Lê Quang Đại',4,'29/11/2022','TH'),
('TH0009',N'Giáo trình Access 2022','N004',N'Thiện Tâm',3,'11/01/2023','TH'),
('TH0010',N'Kỹ thuật thiết kế hệ thống','N002',N'Phạm Minh Chính',2,'16/02/2023','TH')
GO


INSERT INTO MuonSach VALUES 
('050001','TH0006','12/11/2022','01/02/2023'),
('050001','TH0007','12/11/2022',NULL),
('050002','TH0001','22/03/2023','10/05/2023'),
('050002','TH0004','22/03/2023',NULL),
('050002','TH0005','09/04/2023','15/06/2023'),
('050002','TH0008','19/01/2023',NULL),
('060002','TH0003','17/08/2022','01/04/2023'),
('060002','TH0009','22/09/2022',NULL),
('060002','TH0001','29/11/2022',NULL)
GO



--  1. Tạo khung nhìn vwNXBKHKT gồm các thuộc tính mã
--  sách, tên sách, tác giả của những cuốn sách xuất bản
--  bởi nhà xuất bản ‘Khoa học kỹ thuật’.

CREATE VIEW vwNXBKHKT 
AS 
    SELECT S.MaSach,S.TuaDe,S.TacGia
    FROM NhaXuatBan AS N
    JOIN Sach AS S
    ON N.MaNXB = S.MaNXB
    WHERE N.TenNXB = N'Khoa học kỹ thuật'
GO

-- 2. Tạo khung nhìn vwDSmuonTin gồm các thuộc tính
--  tenbandoc, diachi, sdt, masach, tuade của tất cả các
--  cuốn sách thuộc thể loại ‘Tin học’.
CREATE VIEW vwDSmuonTin 
AS 
    SELECT B.TenBanDoc,B.DiaChi,B.SoDT,S.MaSach,S.TuaDe
    FROM TheLoai AS T
    JOIN Sach AS S
    ON T.MaTL = s.MaTL
    JOIN MuonSach AS M
    ON M.MaSach = S.MaSach
    JOIN BanDoc AS B
    ON M.MaThe = B.MaThe
    WHERE T.TenTL = N'Tin học' 
GO

--  3. Tạo thủ tục sp_insach nhằm liệt kê danh sách các
--  sách có tựa đề chứa xâu con cho trước (ví dụ khi gọi
--  thủ tục sp_insach(‘dữ liệu’) sẽ in ra tất cả các
--  sách có tựa đề chứa xâu ‘dữ liệu’)
CREATE PROCEDURE sp_insach(@tuade NVARCHAR(30))
AS
BEGIN
    SELECT *
    FROM Sach
    WHERE TuaDe = @tuade
END
GO
EXEC sp_insach N'Nhập môn cơ sở dữ liệu'
GO  

--  4. Tạo thủ tục sp_insachmuon hiển thị danh sách các
--  sách mượn bởi bạn đọc có mãthẻ nào đó (trong danh
--  sách cần chứa các thông tin: Mã sách, Tựa đề, Ngày
--  mượn, Ngày trả).
CREATE PROCEDURE sp_insachmuon(@mathe CHAR(6))
AS
BEGIN
    SELECT Sach.MaSach,TuaDe,NgayMuon,NgayTra
    FROM MuonSach 
    JOIN Sach
    ON MuonSach.MaSach = Sach.MaSach
    WHERE MuonSach.MaThe = @mathe 
END
GO
EXEC sp_insachmuon '050001'
GO


--  5. Tạo thủ tục sp_sachbandocmuon liệt kê danh sách
--  các bạn đọc có mượn một đầu sách có mã sách nào
--  đó (ví dụ sp_sachbandocmuon(‘1001’) sẽ in ra tất cả
--  các bạn đọc đã mượn quyển sách này.
CREATE PROCEDURE sp_sachbandocmuon(@masach CHAR(6))
AS
BEGIN
    SELECT M.MaSach,B.*
    FROM MuonSach AS M
    JOIN BanDoc AS B
    ON M.MaThe = B.MaThe
    WHERE M.MaSach = @masach 
END
GO
EXEC sp_sachbandocmuon 'TH0001'
GO

--  6. Tạo thủ tục có tên sp_sachchuaduocmuon hiển thị
--  danh sách các sách chưa được mượn.
CREATE PROCEDURE sp_sachchuaduocmuon
AS
BEGIN
    SELECT *
    FROM Sach
    WHERE MaSach NOT IN (
        SELECT MaSach
        FROM MuonSach
    ) 
END
GO
EXEC sp_sachchuaduocmuon
GO

--  7. Hãy viết hàm thay thế các thủ tục trong câu 3 và 6.

CREATE FUNCTION fc_insach(@tuade NVARCHAR(30))
RETURNS TABLE AS
RETURN(
    SELECT *
    FROM Sach
    WHERE TuaDe = @tuade
)
GO
SELECT * FROM fc_insach(N'Nhập môn cơ sở dữ liệu')
GO  

CREATE FUNCTION fc_sachchuaduocmuon()
RETURNS TABLE AS
RETURN(
        SELECT *
        FROM Sach
        WHERE MaSach NOT IN (
            SELECT MaSach
            FROM MuonSach
        ) 
)
GO
SELECT * FROM fc_sachchuaduocmuon()
GO

--  8. Tạo hàm fc_soluongsach cho kết quả số lượng sách
--  có trong thư viện thuộc thể loại nào đó.
CREATE FUNCTION fc_soluongsach(@matl CHAR(2))
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SET @dem = (
        SELECT COUNT(S.MaSach)   
        FROM Sach AS S
        JOIN TheLoai AS T
        ON S.MaTL = T.MaTL
        WHERE T.MaTL = @matl
    )

    RETURN @dem
END
GO
SELECT dbo.fc_soluongsach('TH')
GO

--  9. Tạo hàmfc_soluongsachxuatban cho số lượng sách
--  có trong thư viện xuất bản bởi nhà xuất bản nào đó.
CREATE FUNCTION fc_soluongxuatban(@MaNXB CHAR(4))
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SET @dem = (
        SELECT COUNT(Sach.MaSach)
        FROM Sach
        JOIN NhaXuatBan 
        ON Sach.MaNXB = NhaXuatBan.MaNXB
        WHERE NhaXuatBan.MaNXB = @MaNXB
    )

    RETURN @dem
END
GO
SELECT dbo.fc_soluongxuatban('N001')
GO

--  10. Viết hàm fc_sachchuatra hiển thị danh sách các
--  đầu sách chưa được trả (thông tin cần: Mã sách,
--  Tựa đề, Mã thẻ, Tên bạn đọc, Ngày mượn).
CREATE FUNCTION fc_sachchuatra()
RETURNS TABLE AS
RETURN(
    SELECT Sach.MaSach,TuaDe,BanDoc.MaThe,BanDoc.TenBanDoc,NgayMuon
    FROM MuonSach
    JOIN Sach
    ON MuonSach.MaSach = Sach.MaSach
    JOIN BanDoc
    ON MuonSach.MaThe = BanDoc.MaThe 
    WHERE NgayTra IS NULL
)
GO
SELECT * FROM dbo.fc_sachchuatra()
GO


--  11. Viết hàm liệt kê các đầu sách được nhập trong năm
--  2023.
CREATE FUNCTION fc_sachnhapnam2023()
RETURNS TABLE AS
RETURN(
    SELECT *
    FROM Sach
    WHERE YEAR(NgayNhap) = 2023
)
GO
SELECT * FROM dbo.fc_sachnhapnam2023()
GO

--  12. Viết hàm cho biết có bao nhiêu đầu sách được mượn
--  trong năm 2022.
CREATE FUNCTION fc_sachmuonnam2022()
RETURNS TABLE AS
RETURN(
    SELECT COUNT(*) AS SoLuong
    FROM MuonSach
    WHERE YEAR(NgayMuon) = 2022
)
GO
SELECT * FROM dbo.fc_sachmuonnam2022()
GO

--  13. Viết hàm hiển thị danh sách các đầu sách được mượn
--  trong năm 2022 nhưng vẫn chưa trả.
CREATE FUNCTION fc_sachmuonnam2022_chuatra()
RETURNS TABLE AS
RETURN(
    SELECT *
    FROM MuonSach
    WHERE YEAR(NgayMuon) = 2022 AND NgayTra IS NULL 
)
GO
SELECT * FROM dbo.fc_sachmuonnam2022_chuatra()
GO

--  14. Viết hàm cho biết có bao nhiêu đầu sách được mượn
--  từ tháng 01/10/2022 đến 01/05/2023.
CREATE FUNCTION fc_muonsach()
RETURNS TABLE AS
RETURN(
    SELECT COUNT(*) SLMUON
    FROM MuonSach
    WHERE NgayMuon BETWEEN '2022-01-10' AND '2023-01-05'
)
GO
SELECT * FROM dbo.fc_muonsach()
GO

--  15. Viết hàm sắp xếp danh sách bạn đọc theo số lượng
--  sách đã mượn giảm dần (thông tin cần: Mã thẻ, tên
--  bạn đọc, số lượng sách đã mượn)
CREATE FUNCTION fc_sapxepbandoc()
RETURNS TABLE AS
RETURN(
    SELECT B.MaThe,B.TenBanDoc,COUNT(S.MaThe) AS SLANMUON
    FROM MuonSach AS S
    JOIN BanDoc AS B
    ON S.MaThe = B.MaThe
    GROUP BY B.MaThe,B.TenBanDoc
)
GO
SELECT * FROM dbo.fc_sapxepbandoc()
ORDER BY SLANMUON DESC 
GO

--  16. Viết hàm cho biết những sách được nhập sau năm
--  2021 của nhà xuất bản giáo dục.
CREATE FUNCTION fc_nhapsau2021vaNXBGD()
RETURNS TABLE AS
RETURN(
    SELECT Sach.*
    FROM Sach
    JOIN NhaXuatBan 
    ON Sach.MaNXB = NhaXuatBan.MaNXB
    WHERE NhaXuatBan.TenNXB = N'Giáo dục' AND YEAR(NgayNhap) > 2021 
)
GO
SELECT * FROM dbo.fc_nhapsau2021vaNXBGD()
GO