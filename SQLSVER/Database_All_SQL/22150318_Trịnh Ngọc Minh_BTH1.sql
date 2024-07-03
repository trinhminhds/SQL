
--                                                                                        BÀI THỰC HÀNH SỐ 1

-- Cho CSDL Quản lý nhân viên gồm có các bảng sau

CREATE DATABASE BTH1
ON(
	NAME = 'BTH1_Data',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH1\BTH1_Data.mdf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)
LOG ON (
	NAME = 'BTH1_Data_Log',
	FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH1\BTH1_Data_Log.ldf',
	SIZE = 10 MB,
	MAXSIZE = 80 MB,
	FILEGROWTH = 5 MB
)

USE BTH1

CREATE TABLE Phong (
    mahp CHAR(3) PRIMARY KEY,
    tenphG NVARCHAR(40),
    diachi NVARCHAR(50),
    tel CHAR(10)
)

CREATE TABLE DMNN(
    mann CHAR(3) PRIMARY KEY ,
    tennn NVARCHAR(20)
)


CREATE TABLE NhanVien(
    manv CHAR(5) PRIMARY KEY ,
    hoten NVARCHAR(40),
    gioitinh NCHAR(3),
    ngaysinh DATE,
    luong INT,
    mahp CHAR(3),
    sdt CHAR(10),
    ngaybc DATE
)

CREATE TABLE TDNN(
    manv CHAR(5),
    mann CHAR(3),
    tdo CHAR(1),
    CONSTRAINT PK_TDNN PRIMARY KEY (manv,mann)
)


-- 1. Nhập dữ liệu cho các bảng trong cơ sở dữ liệu QLNV
--  theo mẫu sau:

INSERT INTO Phong 
VALUES
    ('HCA', N'Hành chính', '371 NK', '0362588541'),
    ('KDA', N'Kinh doanh', '371 NK' ,'0362517395'),
    ('KTA', N'Kỹ thuật', '371NK', '0362567401'),
    ('QTA', N'Quản trị', '371 NK', '0362565788');


INSERT INTO DMNN 
VALUES
('01',N'ANH'),
('02',N'Nga'),
('03',N'Pháp'),
('04',N'Nhật'),
('05',N'Trung Quốc'),
('06',N'Hàn Quốc');


INSERT INTO NhanVien(manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc)
VALUES
('HC001', N'Nguyễn Thị Hà', N'Nữ', '1966-02-08', 7500000, 'HCA', '1995-02-08'),
('HC002', N'Trần Văn Nam', N'Nam', '1995-06-12', 8000000, 'HCA', '2017-06-08'),
('HC003', N'Nguyễn Thanh Huyền', N'Nữ', '1998-07-03', 6500000, 'HCA', '2019-04-09'),
('KD001', N'Lê Tuyết Anh', N'Nữ' ,'1992-02-03', 7500000 ,'KDA' ,'2021-10-02'),
('KD002', N'Nguyễn Anh Tú',N'Nam', '1962-07-04', 7600000, 'KDA', '2000-01-07'),
('KD003', N'Phạm An Thái', 'Nam', '1977-05-09',6600000, 'KDA', '2019-12-10'),
('KD004', N'Lê Văn Hải' ,'Nam', '1976-01-02' ,7900000 ,'KDA' ,'2017-06-08'),
('KD005', N'Nguyễn Phương Minh', 'Nam', '1980-01-01', 7000000, 'KDA', '2021-10-02'),
('KT001', N'Trần Đình Khâm', 'Nam', '1971-12-02', 7700000, 'KTA', '2022-01-01'),
('KT003', N'Phạm Thanh Sơn', 'Nam', '1994-02-08', 7100000, 'KTA' ,'2022-01-01'),
('KT004', N'Vũ Thị Hoài', N'Nữ', '1995-01-05', 7500000, 'KTA', '2021-10-02'),
('KT005', N'Nguyễn Thu Lan', N'Nữ', '1994-10-05', 8000000, 'KTA','2021-10-02'),
('KT006', N'Trần Hoài Nam','Nam','1978-07-02', 7800000, 'KTA', '2017-06-08'),
('TT007', N'Hoàng Nam Sơn', N'Nam', '1969-12-03', 8200000,NULL,'2015-07-02'),
('KT008', N'Lê Thu Trang', N'Nữ', '1970-07-06', 7500000, 'KTA', '2018-08-02'),
('KT009', N'Khúc Nam Hải','Nam', '1980-02-07',7000000,'KTA','2015-01-01'),
('TT010', N'PhùngTrungDũng', 'Nam', '1978-02-08', 7200000, NULL,'2012-04-09');


INSERT INTO TDNN
VALUES
('HC001','01', 'A'),
('HC001','02', 'B'),
('HC002','01', 'C'),
('HC002','03', 'C'),
('HC003','01', 'D'),
('KD001','01', 'C'),
('KD001','02', 'B'),
('KD002','01', 'D'),
('KD002','02', 'A'),
('KD003','01', 'B'),
('KD003','02', 'C'),
('KD004','01', 'C'),
('KD004','04', 'A'),
('KD004','05', 'A'),
('KD005','01', 'B'),
('KD005','02', 'D'),
('KD005','03', 'B'),
('KD005','04', 'B'),
('KT001','01', 'D'),
('KT001','04', 'E'),
('KT003','01', 'D'),
('KT003','03', 'C'),
('KT004','01', 'D'),
('KT005','01', 'C');



-- 2. Hãy thêm vào database QLNV các thông tin sau: nhân
--  viên có mã QT001, họ tên là tên của bạn và các
--  thông tin tương ứng, mức lương 8.000.000đ, thuộc
--  phòng Quản trị, biết tiếng Anh (trình độ C), Tiếng
--  Nhật (trình độ A).

INSERT INTO NhanVien(manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc)
VALUES
('HC004', N'Trịnh Ngọc Minh', N'Nam', '2004-09-23', 8000000, 'HCA', '2024-04-08');
INSERT INTO TDNN
VALUES
('HC004','01', 'C'),
('HC004','04', 'A');

--  3. Thêm các ràng buộc notnull, default, unique, primary
--  key, foreign...reference vào các bảng.

ALTER TABLE TDNN
ADD CONSTRAINT FK_NHANVIEN_TDNN FOREIGN KEY (manv) REFERENCES NhanVien(manv)

GO 

ALTER TABLE TDNN
ADD CONSTRAINT FK_MANN_TDNN FOREIGN KEY (mann) REFERENCES DMNN(mann)

GO

ALTER TABLE NhanVien
ADD CONSTRAINT FK_PHONG_NHANVIEN FOREIGN KEY (mahp) REFERENCES Phong(mahp);


-- Viết câu lệnh SQL thực hiện các câu truy vấn sau:
--  4. Đưa ra thông tin của nhân viên có mã số KT001?
SELECT *
FROM NhanVien
WHERE manv = 'KT001'

--  5. Đưa ra danh sách các nhân viên nữ?
SELECT *
FROM NhanVien
WHERE gioitinh = N'Nữ'

--  6. Tìm những nhân viên có họ ‘Nguyễn’?
SELECT *
FROM NhanVien
WHERE hoten LIKE N'Nguyễn%'

--  7. Hãy thực hiện truy vấn các thông tin sau của người
--  có họ tên là tên của bạn: thuộc phòng ban nào, biết
--  ngoại ngữ gì, mức lương bao nhiêu?
SELECT P.tenphG,TDNN.mann,N.luong
FROM NhanVien AS N
JOIN Phong AS P
ON N.mahp = P.mahp
JOIN TDNN
ON N.manv = TDNN.manv
WHERE N.hoten LIKE N'Trịnh%'


--  8. Đưa ra danh sách các nhân viên có tên chứa từ ‘Văn’.
SELECT *
FROM NhanVien
WHERE hoten LIKE N'%Văn%'

--  9. Đưa ra những nhân viên có tuổi dưới 30? (Đưa ra
--  cả thông tin tuổi trong kết quả).
SELECT (YEAR(GETDATE()) - YEAR(ngaysinh)) AS Tuoi
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) < 30


--  10. Đưa ra danh sách các nhân viên có tuổi nằm trong
--  khoảng 25 đến 30 tuổi? (Đưa ra cả thông tin tuổi
--  trong kết quả).
SELECT (YEAR(GETDATE()) - YEAR(ngaysinh)) AS Tuoi
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) BETWEEN 25 AND 30

--  11. Đưa ra các mã nhân viên đã học các ngoại ngữ 01 ở
--  trình độ C trở lên?
SELECT TDNN.tdo,TDNN.manv
FROM TDNN
WHERE TDNN.mann = '01' AND tdo IN ('A','B') 


--  12. Nhân viên nào đã vào biên chế trước năm 2015?
SELECT *
FROM NhanVien
WHERE YEAR(ngaybc) = '2015'

--  13. Nhân viên nào đã vào biên chế hơn 10 năm?
SELECT *
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaybc)) > 10

--  14. Đưa ra danh sách các nhân viên năm nay đủ tuổi
--  nghỉ hưu (Nam >=60 tuổi, Nữ >=55 tuổi)?
SELECT *
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60 AND gioitinh = 'Nam' 
OR (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55 AND gioitinh = N'Nữ'


--  15. Cho biết thông tin (Mã phòng, tên phòng, điện thoại
--  liên hệ) về các phòng ban?
SELECT mahp,tenphG,tel
FROM Phong

--  16. Đưa ra tất cả thông tin về 2 nhân viên đầu tiên trong
--  bảng nhân viên?
SELECT TOP 2 *
FROM NhanVien

--  17. Cho biết mã nhân viên, họ tên, ngày sinh, lương
--  của các nhân viên có lương nằm trong khoảng từ
--  7.000.000 đồng đến 8.000.000 đồng?
SELECT manv,hoten,ngaysinh,luong
FROM NhanVien
WHERE luong BETWEEN 7000000 AND 8000000

--  18. Nhân viên nào chưa có số điện thoại?
SELECT *
FROM NhanVien
WHERE sdt IS NULL

--  19. Nhân viên nào có sinh nhật trong tháng 4.
SELECT *
FROM NhanVien
WHERE MONTH(ngaysinh) = '4'

--  20. Đưa ra danh sách nhân viên theo lương tăng dần?
SELECT *
FROM NhanVien
ORDER BY luong ASC

--  21. Cho biết lương trung bình của phòng Kinh doanh?
SELECT AVG(luong) AS LUONGTB
FROM NhanVien
WHERE mahp = 'KDA'

--  22. Cho biết tổng số nhân viên và lương trung bình của
--  phòng Kinh doanh?
SELECT COUNT(*) AS SLNHANVIEN,AVG(luong)AS LUONGTB
FROM NhanVien
WHERE mahp = 'KDA'

--  23. Cho biết tổng lương của mỗi phòng?
SELECT mahp,SUM(luong) AS TONGLUONG
FROM NhanVien
GROUP BY mahp

--  24. Chobiết các phòng cótổng lương lớn hơn 30.000.000?
SELECT mahp,SUM(luong) AS TONGLUONG
FROM NhanVien
GROUP BY mahp
HAVING SUM(luong) >= 30000000


--  25. Cho biết danh sách mã nhân viên, họ tên, mã phòng
--  và tên phòng họ làm việc?
SELECT manv,hoten,Phong.mahp,tenphG
FROM NhanVien
JOIN Phong 
ON Nhanvien.mahp = Phong.mahp

--  26. Đưa ra danh sách tất cả các nhân viên cùng với
--  thông tin về phòng ban của họ (kể cả các nhân viên
--  chưa ở phòng nào).
SELECT NhanVien.*,Phong.*
FROM NhanVien 
FULL JOIN Phong 
ON Nhanvien.mahp = Phong.mahp

--  27. Đưa ra danh sách tất cả các phòng cùng với thông
--  tin về các nhân viên của các phòng (kể cả các phòng
--  chưa có nhân viên nào).
SELECT Phong.*,NhanVien.*
FROM Phong
FULL JOIN NhanVien 
ON Nhanvien.mahp = Phong.mahp

--  28. Cho biết những nhân viên có tuổi lớn hơn độ tuổi
--  trung bình của tất cả các nhân viên.
SELECT (YEAR(GETDATE()) - YEAR(ngaysinh)) AS TUOI
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) > (
    SELECT AVG(YEAR(GETDATE()) - YEAR(ngaysinh))
    FROM NhanVien
)

--  29. Có bao nhiêu nhân viên có trình độ tiếng anh là C?
SELECT COUNT(*) AS SLNHANVIEN
FROM NhanVien
JOIN TDNN
ON NhanVien.manv = TDNN.manv
WHERE TDNN.tdo = 'C'

--  30. Có bao nhiêu nhân viên có nhiều hơn 2 ngoại ngữ?
SELECT NhanVien.manv ,COUNT(*) AS SLNGONNGU
FROM NhanVien
JOIN TDNN
ON NhanVien.manv = TDNN.manv
GROUP BY NhanVien.manv
HAVING COUNT(NhanVien.manv) >= 2


--  31. Cho biết địa chỉ và số điện thoại của phòng ban
--  “Kinh doanh”.
SELECT diachi,tel
FROM Phong
WHERE tenphG = 'Kinh Doanh'


--  32. Cho biết mã nhân viên, họ tên, ngày vào biên chế
--  của những nhân viên có lương <7.000.000?
SELECT manv,hoten,ngaybc
FROM NhanVien
WHERE luong < 7000000

--  33. Sắp xếp danh sách nhân viên trong bảng nhân viên
--  theo thứ tự tăng dần của trường tên nhân viên, nếu
--  tên trùng nhau thì sắp xếp theo thứ tự giảm dần của
--  trường ngày sinh.
SELECT *
FROM NhanVien
ORDER BY hoten ASC, ngaysinh DESC

--  34. Đưa ra danh sách nhân viên của phòng “Kỹ thuật”?
--  Thông tin gồm mã nhân viên, họ, tên, ngày sinh của
--  nhân viên.
SELECT NhanVien.manv,hoten,ngaysinh
FROM Phong
JOIN NhanVien
ON phong.mahp = Nhanvien.mahp
WHERE tenphG = N'Kỹ Thuật'

--  35. Tìm những nhân viên học tiếng Anh hoặc tiếng
--  Pháp, đạt trình độ từ C trở lên? Thông tin đưa
--  ra gồm mã nhân viên, họ, tên, ngày sinh, tên ngoại
--  ngữ, trình độ ngoại ngữ
SELECT *
FROM NhanVien
JOIN TDNN
ON NhanVien.manv = TDNN.manv
WHERE TDNN.mann IN('01','03') AND TDNN.tdo IN ('A','B')


--  36. Tìm những nhân viên vào biên chế trước ngày 1/1/2017,
--  do phòng “Kỹ thuật” hoặc “Kinh doanh” quản lý.
SELECT *
FROM NhanVien
WHERE YEAR(ngaybc) < '2017' AND mahp IN('KDA','KTA')

--  37. Những ngoại ngữ nào chưa có nhân viên học?

SELECT DMNN.tennn
FROM  DMNN
WHERE DMNN.mann NOT IN (
    SELECT TDNN.mann
    FROM NhanVien
    JOIN TDNN
    ON NhanVien.manv = TDNN.manv
)

--  38. Những nhân viên nào chưa học bất kỳ một ngoại
--  ngữ nào?
SELECT *
FROM NhanVien
WHERE manv NOT IN(
    SELECT TDNN.manv
    FROM TDNN 
    JOIN DMNN
    ON TDNN.mann = DMNN.mann
)

--  39. Cho biết toàn cơ quan có bao nhiêu nhân viên nữ?
SELECT COUNT(*) SLNHANVIENNU
FROM NhanVien
WHERE gioitinh = N'Nữ'

--  40. Tìm những nhân viên biết từ 3 ngoại ngữ trở lên?
--  Thông tin đưa ra gồm mã nhânviên, họ tên, số ngoại
--  ngữ mà nhân viên này học.
SELECT NhanVien.manv ,COUNT(*) AS SLNGONNGU
FROM NhanVien
JOIN TDNN
ON NhanVien.manv = TDNN.manv
GROUP BY NhanVien.manv
HAVING COUNT(NhanVien.manv) >= 3


--  41. Tính tổng lương của mỗi phòng? Thông tin gồm mã
--  phòng, tên phòng, tổng lương của phòng đó.
SELECT Phong.mahp,tenphG,SUM(luong) AS TONGLUONG
FROM NhanVien
JOIN Phong 
ON NhanVien.mahp = Phong.mahp
GROUP BY Phong.mahp,tenphG


--  42. Cho biết lương lớn nhất, lương nhỏ nhất, lương trung
--  bình, số nhân viên của mỗi phòng?
SELECT Phong.mahp,MAX(luong) AS LUONGCAONHAT ,MIN(luong) AS LUONGTHAPNHAT,AVG(luong) AS LUONGTRUNGBINH,COUNT(*) AS SLNHANVIEN
FROM NhanVien
JOIN Phong
ON Phong.mahp = NhanVien.mahp   
GROUP BY Phong.mahp


--  43. Tăng lương nhân viên phòng Kỹ thuật thêm 15%.
UPDATE NhanVien
SET luong = luong * 0.15
WHERE mahp = 'KTA'


--  44. Tạo một bảng tên là NGHI_HUU có cấu trúc như bảng
--  nhân viên để lưu thông tin về các nhân viên đến tuổi
--  nghỉ hưu. Sau đó dùng lệnh Insert ... Select... để
--  sao chép danh sách các nhân viên đến tuổi nghỉ hưu
--  ở bảng NhanVien vào bảng nghỉ hưu. (Điều kiện về
--  hưu: Nam từ 60 tuổi trở lên, nữ từ 55 tuổi trở lên).
--  Sau đó, xóa thông tin về các nhân viên này trong
--  bảng NhanVien.

CREATE TABLE NGHI_HUU(
    manv CHAR(5) PRIMARY KEY ,
    hoten NVARCHAR(40),
    gioitinh NCHAR(3),
    ngaysinh DATE,
    luong INT,
    mahp CHAR(3),
    sdt CHAR(10),
    ngaybc DATE
)

INSERT INTO NGHI_HUU(manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc)
SELECT manv,hoten,gioitinh,ngaysinh,luong,mahp,ngaybc
FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60 AND gioitinh = 'Nam' 
OR (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55 AND gioitinh = N'Nữ'

DELETE FROM TDNN
WHERE manv IN('HC001','KD002')

DELETE FROM NhanVien
WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 60 AND gioitinh = 'Nam' 
OR (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 55 AND gioitinh = N'Nữ'

GO
--  45. Tạo thủ tục có tên sp_inDanhSachNV dùng để in
--  danh sách tất cả nhân viên
CREATE PROCEDURE sp_inDanhSachNV
AS
BEGIN
    SELECT *
    FROM NhanVien
END
