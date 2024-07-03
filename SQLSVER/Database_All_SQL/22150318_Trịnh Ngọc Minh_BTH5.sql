
--                                                                                          BÀI THỰC HÀNH SỐ 5

--  Cho cơ sở dữ liệu Quản lý đơn đặt hàng như sau:
--  Các quy định hoạt động của hệ thống:


--                                              1. DATABASE (CƠ SỞ DỮ LIỆU)

--  a. Cài đặt CSDLQuảnlýđơnđặthàngcótênlà QLDDH.
--  Lưu ý, trước khi tạo CSDL nên kiểm tra CSDL đã
--  tồn tại chưa, nếu đã tồn tại rồi thì không cho phép
--  tạo mới CSDL.

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QLDONHANG')
BEGIN
    CREATE DATABASE QLDONHANG
    ON(
        NAME = 'QLDONHANG_Data',
        FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH5\QLDONHANG_Data.mdf',
        SIZE = 10 MB,
        MAXSIZE = 80 MB,
        FILEGROWTH = 5 MB
    )
    LOG ON (
        NAME = 'QLDONHANG_Data_Log',
        FILENAME = 'D:\DataBase\SQLSVER\Database_All_SQL\Data_BTH5\QLDONHANG_Data_Log.ldf',
        SIZE = 10 MB,
        MAXSIZE = 80 MB,
        FILEGROWTH = 5 MB
    )
    PRINT 'Cơ sở dữ liệu QLDONHANG đã được tạo.';
END
ELSE
BEGIN
    PRINT 'Cơ sở dữ liệu QLDONHANG đã tồn tại.';
END

GO
USE QLDONHANG
GO

CREATE TABLE KhachHang(
    makh CHAR(4) NOT NULL PRIMARY KEY,
    tenkh NVARCHAR(40),
    diachi NVARCHAR(30),
    dienthoai CHAR(10)
)

CREATE TABLE HangHoa(
    mahh CHAR(3) NOT NULL PRIMARY KEY,
    tenhh NVARCHAR(40),
    dvt NVARCHAR(20),
    slcon SMALLINT,
    dongiahh INT
)

CREATE TABLE LichSuGia(
    mahh CHAR(3),
    ngayhl DATE,
    dongia INT
)
ALTER TABLE LichSuGia
ADD CONSTRAINT FK_HangHoa_LichSuGia
FOREIGN KEY (mahh) REFERENCES HangHoa(mahh)

CREATE TABLE DonDatHang(
    madat CHAR(4) NOT NULL PRIMARY KEY,
    ngaydat DATE,
    makh CHAR(4),
    tinhtrang BIT
)
ALTER TABLE DonDatHang
ADD CONSTRAINT FK_KhachHang_DonDatHang
FOREIGN KEY (makh) REFERENCES KhachHang(makh)

CREATE TABLE PhieuGiaoHang(
    magiao CHAR(4) NOT NULL PRIMARY KEY,
    ngaygiao DATE,
    madat CHAR(4)
)
ALTER TABLE PhieuGiaoHang
ADD CONSTRAINT FK_DonDatHang_PhieuGiaoHang
FOREIGN KEY (madat) REFERENCES DonDatHang(madat)


CREATE TABLE ChiTietGiaoHang(
    magiao CHAR(4),
    mahh CHAR(3),
    slgiao SMALLINT,
    dongiaohang INT,
    CONSTRAINT PK_ChiTietGiaoHang PRIMARY KEY(magiao,mahh)
)
ALTER TABLE ChiTietGiaoHang
ADD CONSTRAINT FK_PhieuGiaoHang_ChiTietGiaoHang
FOREIGN KEY (magiao) REFERENCES PhieuGiaoHang(magiao)

ALTER TABLE ChiTietGiaoHang
ADD CONSTRAINT FK_HangHoa_ChiTietGiaoHang
FOREIGN KEY (mahh) REFERENCES HangHoa(mahh)


CREATE TABLE ChiTietDatHang(
    madat CHAR(4),
    mahh CHAR(3),
    SLDat TINYINT
)
ALTER TABLE ChiTietDatHang
ADD CONSTRAINT FK_DonDatHang_ChiTietDatHang
FOREIGN KEY (madat) REFERENCES DonDatHang(madat)

ALTER TABLE ChiTietDatHang
ADD CONSTRAINT FK_HangHoa_ChiTietDatHang
FOREIGN KEY (mahh) REFERENCES HangHoa(mahh)

--  b. Thêmràngbuộcduynhất(UNIQUE)chotrường tenhh
--  trong bảng HangHoa, thử nhập dữ liệu để kiểm tra
--  ràng buộc.

ALTER TABLE HangHoa
ADD UNIQUE(tenhh)

--  c. Thêmràng buộc kiểm tra (CHECK) cho trường slcon,
--  yêu cầu là trường này chỉ nhận giá trị ≥ 0, thử nhập
--  dữ liệu để kiểm tra ràng buộc.

ALTER TABLE HangHoa
ADD CHECK (slcon >= 0)

--  d. Thêmràngbuộcmặcđịnh(DEFAULT)chocộtngaydat
--  trong DonDatHang với giá trị mặc định là ngày hiện
--  tại, thử nhập dữ liệu để kiểm tra ràng buộc.

ALTER TABLE DonDatHang
ADD CONSTRAINT DF_NGAYDAT
DEFAULT (GETDATE()) FOR ngaydat

--  e. Xóa bảng KhachHang? Nếu không xóa được thì nêu
--  lý do? Muốn xóa được thì phải làm sao?

-- Không xóa được bởi vì có rằng buộc khóa ngoại 
-- nếu muốn xóa thì phải xóa khóa ngoại đó
ALTER TABLE DonDatHang
DROP CONSTRAINT FK_KhachHang_DonDatHang

DROP TABLE KhachHang

--  f. Xóa cột diachi trong bảng KhachHang, sau đó tạo
--  lại cột này với ràng buộc mặc định là "HCM".
ALTER TABLE KhachHang
DROP COLUMN diachi

ALTER TABLE KhachHang
ADD diachi NVARCHAR(30) DEFAULT 'HCM'


--  g. Xóa khóa ngoại madat trong PhieuGiaoHang tham
--  chiếu tới madat trong DonDatHang, sau đó tạo lại
--  khóa ngoại này

ALTER TABLE PhieuGiaoHang
DROP CONSTRAINT FK_DonDatHang_PhieuGiaoHang

ALTER TABLE PhieuGiaoHang
ADD CONSTRAINT FK_DonDatHang_PhieuGiaoHang
FOREIGN KEY (madat) REFERENCES DonDatHang(madat);
 

--  h. Nhập dữ liệu cho các bảng như sau:

INSERT INTO KhachHang
VALUES
('KH01', N'Cửa hàng Lộc Phú', 'HCM' ,'0398451950'),
('KH02', N'Cửa hàng Hoàng Gia', N'Long An','0938776266'),
('KH03', N'Nguyễn Lan Anh', N'Cần Thơ','0896317388'),
('KH04', N'Cty TNHH An Phước', N'Long An', '0993810503'),
('KH05', N'Huỳnh Ngọc Trung' ,'HCM' ,'0916783565'),
('KH06', N'Cửa hành Trung Tín', N'Tây Ninh', '0938435706');


INSERT INTO HangHoa
VALUES
('BU1', N'Bàn ủi Phillip', N'Cái', 60, 350000),
('BU2', N'Bàn ủi Sharp', N'Cái', 100, 250000),
('DM1', N'Đầu máy Sharp', N'Cái', 100, 700000),
('CD1', N'Nồi cơm điện Sharp', 'Cái', 75 , 1200000),
('MG1', N'Máy giặt Sanyo', N'Cái', 10, 4700000),
('MQ1' ,N'Máy quạt Senko', N'Cái' ,40, 400000),
('MQ2', N'Máy quạt Daikin', N'Cái', 60, 600000),
('TL1' ,N'Tủ lạnh Hitachi', N'Cái', 50, 5500000),
('TV1', N'Tivi Samsung', N'Cái', 33, 7800000),
('TV2', N'Tivi LG', N'Cái', 20, 7500000),
('TV3', N'Tivi Sony', N'Cái',60,8000000);


INSERT INTO LichSuGia
VALUES
('BU1', '2022-01-01', 300000),
('BU1', '2022-01-01', 350000),
('BU2', '2023-06-01', 250000),
('CD1', '2023-06-01', 650000),
('CD1', '2023-01-01', 700000),
('DM1', '2022-01-01', 1000000),
('DM1', '2023-01-01', 1200000),
('MG1', '2022-06-01', 4700000),
('MQ1', '2023-06-01', 400000),
('MQ2', '2022-01-01', 450000),
('MQ2', '2023-01-01', 600000),
('TL1', '2023-01-01', 5500000),
('TV1', '2023-01-01', 7800000),
('TV2', '2023-01-01', 7500000),
('TV3', '2023-01-01', 8000000);


INSERT INTO DonDatHang
VALUES
('DH01', '2022-02-02', 'KH01', 1),
('DH02', '2022-02-02', 'KH03', 1),
('DH03', '2023-03-02', 'KH03', 1),
('DH04', '2023-01-04', 'KH02', 0),
('DH05', '2023-09-05', 'KH05', 1),
('DH06', '2023-06-05', 'KH03', 1),
('DH07', '2023-09-06', 'KH05', 0),
('DH08', '2023-06-06', 'KH01' ,0);


INSERT INTO PhieuGiaoHang
VALUES
('GH01', '2022-02-02', 'DH01'),
('GH02', '2022-05-02', 'DH02'),
('GH03', '2023-04-02', 'DH03'),
('GH05', '2023-10-05', 'DH05'),
('GH06', '2023-08-06', 'DH06'),
('GH07', '2023-10-07', 'DH07'),
('GH08', '2023-02-08', 'DH08');


INSERT INTO ChiTietGiaoHang
VALUES
('GH01', 'BU1', 15, 300000),
('GH01', 'DM1', 10, 1000000),
('GH01', 'TL1', 4 ,5000000),
('GH02', 'BU2', 10, 300000),
('GH03', 'MG1', 8, 4700000),
('GH05', 'BU2', 12, 350000),
('GH05', 'DM1', 15, 1200000),
('GH05', 'MG1', 5, 4700000),
('GH05', 'TL1', 5, 5500000),
('GH06', 'BU1', 20, 350000),
('GH06', 'MG1', 30, 4700000),
('GH06', 'MQ1', 10, 400000),
('GH06', 'MQ2', 15, 450000),
('GH07', 'BU1', 20, 300000),
('GH08', 'MQ1', 30, 400000);


INSERT INTO ChiTietDatHang
VALUES
('DH01','BU1',15),
('DH01','DM1',10),
('DH01','TL1', 4),
('DH02','BU2',20),
('DH02','TL1', 3),
('DH03','MG1', 8),
('DH04','TL1', 5),
('DH04','TV1', 5),
('DH05','BU2',12),
('DH05','DM1',15),
('DH05','MG1',10),
('DH05','TL1', 5),
('DH06','BU1',30),
('DH06','MG1',30),
('DH06','MQ1',30),
('DH06','MQ2',30),
('DH07','BU1',20),
('DH08','MQ1',50),
('DH08','TL1',10);


--  1. Khi thêm mới một đơn đặt hàng thì tình trạng của
--  đơn đặt hàng mặc định là chưa giao (tinhtrang=0),
--  khi đơn đặt hàng được giao thì tình trạng đơn đặt
--  hàng được cập nhật lại là đã giao (tinhtrang=1).
GO
CREATE TRIGGER trg_tinhTrangDatHang
ON DonDatHang
FOR INSERT AS
BEGIN

    UPDATE DonDatHang
    SET tinhtrang = 0
    FROM DonDatHang
    JOIN inserted ON DonDatHang.madat = inserted.madat;

    IF EXISTS(
        SELECT 1
        FROM PhieuGiaoHang
        JOIN inserted 
        ON inserted.madat = PhieuGiaoHang.madat
    )
    BEGIN
        UPDATE DonDatHang
        SET tinhtrang = 1
        FROM DonDatHang
        JOIN inserted 
        ON DonDatHang.madat = inserted.madat
    END
END
GO


--  2. Mỗi đơn đặt hàng chỉ có tối đa 1 phiếu giao hàng
--  (cũng có những đơn đặt không được giao), ngày giao
--  hàng phải bằng hoặc sau ngày đặt hàng nhưng không
--  được quá 30 ngày.
CREATE TRIGGER trg_checkDonHang
ON DonDatHang
FOR INSERT AS
BEGIN

    DECLARE @ngaygiao DATE,@ngaydat DATE

    SELECT @ngaydat = ngaydat FROM inserted

    SELECT @ngaygiao = ngaygiao 
    FROM PhieuGiaoHang
    WHERE madat IN(
        SELECT madat
        FROM inserted
    )
    
    IF EXISTS(
        SELECT COUNT(madat) AS SLDAT
        FROM PhieuGiaoHang
        WHERE madat IN (
            SELECT madat
            FROM inserted
        )
        HAVING COUNT(madat) > 1
    )
    BEGIN
        PRINT N'Mỗi đơn đặt hàng chỉ có tối đa 1 phiếu giao hàng'
        ROLLBACK TRANSACTION 
    END

    IF @ngaydat >= @ngaygiao AND (DAY(GETDATE()) - DAY(@ngaygiao)) > 30
    BEGIN
        PRINT N'Ngày giao hàng phải bằng hoặc sau ngày đặt hàng và không quá được quá 30 ngày'
        ROLLBACK TRANSACTION
    END
END
GO

--  3. Số lượng giao của một hàng hóa trong chi tiết phiếu
--  giao hàng phải nhỏ hơn hoặc bằng số lượng đặt của
--  chi tiết đặt hàng ứng với phiếu giao hàng đó. Khi cập
--  nhật (thêm, xóa, sửa) một chi tiết phiếu giao hàng
--  phải cập nhật lại số lượng còn (slcon) của hàng hóa
--  được giao.

CREATE TRIGGER trg_check_chitietgiaohang
ON ChiTietGiaoHang
FOR INSERT,UPDATE AS
BEGIN
    
    IF EXISTS (
        SELECT *
        FROM HangHoa 
        JOIN ChiTietDatHang
        ON HangHoa.mahh = ChiTietDatHang.mahh
        JOIN inserted 
        ON HangHoa.mahh = inserted.mahh
        WHERE inserted.slgiao > ChiTietDatHang.SLDat
    )
    BEGIN
        PRINT N'Số lượng giao phải nhỏ hơn hoặc bằng số lượng đặt'
        ROLLBACK TRANSACTION
    END

    UPDATE HangHoa
    SET slcon = slcon - slgiao
    FROM HangHoa
    JOIN inserted
    ON HangHoa.mahh = inserted.mahh

    UPDATE HangHoa
    SET slcon = slcon + slgiao
    FROM HangHoa
    JOIN deleted
    ON HangHoa.mahh = deleted.mahh

    IF UPDATE(slgiao)
    BEGIN
        UPDATE HangHoa
        SET slcon = slcon + (deleted.slgiao - inserted.slgiao)
        FROM HangHoa
        JOIN deleted
        ON HangHoa.mahh = deleted.mahh
        JOIN inserted
        ON HangHoa.mahh = inserted.mahh
    END

END

GO

--  4. dongiahh trong bảng HangHoa là đơn giá hiện hành,
--  đơn giá này dùng để tham khảo khi giao hàng và
--  được cập nhật theo lịch sử giá của hàng hóa đó. Chỉ
--  được phép thêm (hay sửa) lịch sử giá của hàng hóa
--  mà ngày hiệu lực của dòng dữ liệu được thêm (hay
--  sửa) phải là lớn hơn so với tất cả các ngày hiệu lực
--  còn lại của lịch sử giá ứng với hàng hóa đó.

CREATE TRIGGER trg_check_lichSuGia
ON LichSuGia
FOR INSERT,UPDATE AS
BEGIN
    
    IF EXISTS(
        SELECT *
        FROM inserted 
        JOIN LichSuGia 
        ON inserted.mahh = LichSuGia.mahh
        WHERE inserted.ngayhl <= LichSuGia.ngayhl AND inserted.mahh = LichSuGia.mahh
    )
    BEGIN
        PRINT N'Ngày hiệu lực của dòng dữ liệu phải lớn hơn so với tất cả các ngày hiệu lực còn lại'
        ROLLBACK TRANSACTION
        RETURN
    END
END


--                                                              2. QUERY (TRUY VẤN)


--  a. Cho biết chi tiết giao hàng của đơn đặt hàng DH01
--  (tên hàng hóa, số lượng giao và đơn giá giao).

SELECT tenhh,slgiao,dongiaohang
FROM ChiTietGiaoHang 
JOIN PhieuGiaoHang
ON ChiTietGiaoHang.magiao = PhieuGiaoHang.magiao
JOIN HangHoa 
ON ChiTietGiaoHang.mahh = HangHoa.mahh
WHERE madat = 'DH01'


GO
--  b. Cho biết thông tin các đơn hàng không được giao,
--  hiển thị: mã đặt, ngày đặt, tên khách hàng.

SELECT madat,ngaydat,tenkh
FROM DonDatHang
JOIN KhachHang
ON DonDatHang.makh = KhachHang.makh
WHERE madat NOT IN(
    SELECT madat
    FROM PhieuGiaoHang
)

--  c. Cho biết hàng hóa nào có đơn giá hiện hành cao
--  nhất, hiển thị: tên hàng hóa, đơn giá hiện hành.
SELECT TOP 1 tenhh,dongiahh
FROM HangHoa
ORDER BY dongiahh DESC


--  d. Chobiết sốlần đặt hàng củatừngkháchhàng, những
--  khách hàng không đặt hàng thì phải hiển thị số lần
--  đặt hàng bằng 0. Hiển thị: Mã khách hàng, tên khách
--  hàng, số lần đặt.
SELECT KhachHang.makh,tenkh,COUNT(madat) AS SLDAT
FROM KhachHang
JOIN DonDatHang
ON KhachHang.makh = DonDatHang.makh
GROUP BY KhachHang.makh,tenkh


--  e. Cho biết tổng tiền của từng phiếu giao hàng trong
--  năm 2023, hiển thị: mã giao, ngày giao, tổng tiền,
--  với tổng tiền = SUM(slgiao*dongiagiao)
SELECT PhieuGiaoHang.magiao,ngaygiao, SUM(slgiao*dongiaohang) AS TongTien
FROM PhieuGiaoHang
JOIN ChiTietGiaoHang
ON PhieuGiaoHang.magiao = ChiTietGiaoHang.magiao
WHERE YEAR(ngaygiao) = 2023
GROUP BY PhieuGiaoHang.magiao,ngaygiao

--  f. Cho biết khách hàng nào có 2 lần đặt hàng trở lên,
--  hiển thị: mã khách hàng, tên khách hàng, số lần đặt.
SELECT KhachHang.makh,tenkh,COUNT(madat) AS SLDAT
FROM KhachHang
JOIN DonDatHang
ON KhachHang.makh = DonDatHang.makh
GROUP BY KhachHang.makh,tenkh
HAVING COUNT(madat) > 2

--  g. Cho biết mặt hàng nào đã được giao với tổng số
--  lượng giao nhiều nhất, hiển thị: mã hàng, tên hàng
--  hóa, tổng số lượng đã giao.
SELECT TOP 1 HangHoa.mahh,tenhh,SUM(slgiao) AS TONGSLGIAO
FROM HangHoa
JOIN ChiTietGiaoHang
ON HangHoa.mahh = ChiTietGiaoHang.mahh
GROUP BY HangHoa.mahh,tenhh
ORDER BY TONGSLGIAO DESC

--  h. Tăng số lượng còn của mặt hàng có mã bắt đầu bằng
--  ký tự ’M’ lên 10.
UPDATE HangHoa
SET slcon = slcon + 10
WHERE mahh LIKE 'M%'


--  i. Copy dữliệu bảng HangHoa sang mộtbảng HangHoa1,
--  sau đó xóa những mặt hàng chưa được đặt trong
--  bảng HangHoa. Chèn lại vào bảng HangHoa những
--  dòng bị xóa từ bảng HangHoa1.

SELECT * INTO HangHoa1 FROM HangHoa

DELETE FROM HangHoa1
WHERE mahh NOT IN(
    SELECT mahh
    FROM ChiTietDatHang
)

INSERT INTO HangHoa
SELECT * FROM HangHoa1 
WHERE mahh NOT IN(
    SELECT mahh
    FROM HangHoa
)


--  j. Thêm cột thanhtien cho bảng ChiTietGiaoHang và
--  cập nhật thanhtien = slgiao*dongiagiao.
ALTER TABLE ChiTietGiaoHang
ADD thanhtien INT

UPDATE ChiTietGiaoHang
SET thanhtien = slgiao *dongiaohang

GO
--                                                                      3. VIEW (KHUNG NHÌN)
--  a. Tạo view thống kê doanh số giao hàng của từng mặt
--  hàng trong 6 tháng đầu năm 2023

CREATE VIEW vw_DoanhSoGiaoHang_6thang
AS
    SELECT hh.mahh,tenhh,SUM(slgiao*dongiaohang)
    AS tongtien
    FROM(PhieuGiaoHang pg 
        JOIN ChiTietGiaoHang ctg
        ON pg.magiao = ctg.magiao
        ) 
    JOIN HangHoa hh
    ON ctg.mahh = hh.mahh
    WHERE MONTH(ngaygiao) BETWEEN 1 AND 6
    AND YEAR(ngaygiao) = 2023
    GROUP BY hh.mahh,tenhh

GO   
SELECT * FROM vw_DoanhSoGiaoHang_6thang

GO
--  b. Tạo view cho biết mặt hàng nào có tổng số lượng
--  được đặt lớn nhất trong năm 2023
CREATE VIEW vw_matHang_DatHangLon
AS
    SELECT TOP 1 HangHoa.mahh,tenhh,SUM(SLDat) AS TONGSLDAT
    FROM HangHoa
    JOIN ChiTietDatHang
    ON HangHoa.mahh = ChiTietDatHang.mahh
    JOIN DonDatHang
    ON ChiTietDatHang.madat = DonDatHang.madat
    WHERE YEAR(DonDatHang.ngaydat) = 2023
    GROUP BY HangHoa.mahh,tenhh
    ORDER BY TONGSLDAT DESC
GO

--  c. Tạo view cho biết danh sách khách hàng ở HCM có
--  sử dụng WITH CHECK OPTION, sau đó chèn 2 khách
--  hàng vào view này, một khách hàng có địa chỉ HCM
--  và một khách hàng có địa chỉ ở Long An, có nhận
--  xét gì trong 2 trường hợp này

CREATE VIEW vw_danhsachKhachHangHCM
AS
    SELECT *
    FROM KhachHang
    WHERE diachi = 'HCM'
    WITH CHECK OPTION
GO

INSERT INTO vw_danhsachKhachHangHCM
VALUES
('KH07', N'Cửa hàng Lộc Phát', 'HCM' ,'0398451951'),
('KH08', N'Cửa hàng Hoàng Phú', N'Long An','0938776264');
-- Không thể chèn Khách hàng có địa chỉ Long An vào được bởi vì điều kiện để thêm vào là địa chỉ ở HCM



--                                                                                      4. CURSOR (CON TRỎ)


--  a. Thêm cột tongtien vào phiếu giao hàng, sau đó
--  dùng con trỏ cập nhập giá trị cho cột tongtien, với
--  tongtien=SUM(slgiao*dongiagiao) hay nói cách
--  khác tongtien = SUM(thanhtien)

-- Thêm cột tổng tiền
 ALTER TABLE PhieuGiaoHang ADD tongtien money
 GO
 BEGIN
    DECLARE @magiao char(4), @tongtien int
    DECLARE cur_PG CURSOR FOR
    SELECT magiao FROM PhieuGiaoHang
    OPEN cur_PG
    FETCH NEXT FROM cur_PG INTO @magiao
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @tongtien = SUM(slgiao*dongiaohang)
        FROM ChiTietGiaoHang
        WHERE magiao = @magiao
        UPDATE PhieuGiaoHang
        SET tongtien = @tongtien
        WHERE magiao=@magiao
        FETCH NEXT FROM cur_PG INTO @magiao
    END
    CLOSE cur_PG
    DEALLOCATE cur_PG
 END

--  b. Thêm mới cột thuong2023 vào bảng KhachHang để
--  lưu giữ số tiền khách hàng được thưởng trong năm
--  2023. Dùng con trỏ để cập nhật giá trị cho cột này
--  như sau:
--  - Thưởng 3 triệu đối với khách mua hàng trên 50
--  triệu trong năm 2023
--  - Thưởng 2 triệu đối với khách hàng mua hàng trên
--  35 triệu trong năm 2023 và có mua Máy giặt
--  - Thưởng 1 triệu đối với những khách hàng có mua
--  hàng trong cả 2 năm 2023 và 2022
--  - Tiền thưởng = 0 cho các trường hợp còn lại.
--  Lưu ý là mỗi khách hàng chỉ nhận một mức tiền thưởng cao nhất.

ALTER TABLE KhachHang 
ADD thuong2023 INT
GO
BEGIN
    DECLARE @tongtien INT,@makh CHAR(4),@muaMayGiat BIT
    DECLARE cur_KH CURSOR FOR
    
    SELECT K.makh,SUM(tongtien) AS tongtien, MAX(CASE WHEN C.mahh = 'MG1' THEN 1 ELSE 0 END) AS muaMayGiat
    FROM ChiTietGiaoHang AS C
    FULL JOIN  PhieuGiaoHang AS P
    ON C.magiao = P.magiao
    FULL JOIN DonDatHang AS D
    ON P.madat = D.madat
    FULL JOIN KhachHang AS K
    ON D.makh = K.makh
    WHERE YEAR(ngaydat) = 2023
    GROUP BY K.makh
    
    OPEN cur_KH
    FETCH NEXT FROM cur_KH INTO @makh,@tongtien,@muaMayGiat
    WHILE @@FETCH_STATUS = 0
    BEGIN 

        IF @tongtien > 50000000
            UPDATE KhachHang 
            SET thuong2023 = 3000000 
            WHERE makh = @makh
        ELSE IF @tongtien > 35000000 AND @muaMayGiat = 1 
            UPDATE KhachHang
            SET thuong2023 = 2000000
            WHERE makh  = @makh
        ELSE IF EXISTS(
            SELECT * 
            FROM DonDatHang 
            WHERE makh = @makh AND YEAR(ngaydat) = 2022 
        )
            UPDATE KhachHang
            SET thuong2023 = 1000000
            WHERE makh = @makh
        ELSE 
            UPDATE KhachHang
            SET thuong2023 = 0
            WHERE makh = @makh

        FETCH NEXT FROM cur_KH INTO @makh,@tongtien,@muaMayGiat
    END

    CLOSE cur_KH
    DEALLOCATE cur_KH

END

--  c. Vào ngày 1/1/2024, cần tăng giá của tất cả các mặt
--  hàng lên 10% so với đơn giá hiện hành. Song song
--  với việc tăng giá tất cả các mặt hàng là việc chèn 1
--  dòng dữ liệu vào LichSuGia ứng với mỗi hàng hóa,
--  có nghĩa là có bao nhiêu hàng hóa sẽ có bấy nhiêu
--  dòng dữ liệu được chèn vào bảng LichSuGia với các
--  giá trị tương ứng. Dùng con trỏ để thực hiện công
--  việc này
GO

DECLARE @mahh CHAR(3),@dongia INT,@ngaycapnhat DATE

DECLARE cur_capnhatgia CURSOR FOR

SELECT mahh,dongiahh
FROM HangHoa

OPEN cur_capnhatgia
FETCH NEXT FROM cur_capnhatgia INTO @mahh,@dongia

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @dongia = @dongia * 1.1

    UPDATE HangHoa
    SET dongiahh = @dongia
    WHERE mahh = @mahh

    SET @ngaycapnhat = '2024-01-01'

    INSERT INTO LichSuGia(mahh,ngayhl,dongia)
    VALUES(@mahh,@ngaycapnhat,@dongia)

    FETCH NEXT FROM cur_capnhatgia INTO @mahh,@dongia
END

CLOSE cur_capnhatgia
DEALLOCATE cur_capnhatgia

GO

--                                                                                          5. THỦ TỤC


--  a. Tạo thủ tục truyền vào mã đơn đặt hàng và mã hàng
--  hóa, xuất ra số lượng hàng hóa được đặt trong đơn.
CREATE PROCEDURE sp_soLuonghhdat(@madat CHAR(4),@mahh CHAR(3))
AS
BEGIN
    SELECT SLDat
    FROM ChiTietDatHang
    JOIN HangHoa
    ON ChiTietDatHang.mahh = HangHoa.mahh
    WHERE ChiTietDatHang.madat = @madat AND HangHoa.mahh = @mahh
END
GO
EXEC sp_soLuonghhdat 'DH01','BU1'
GO
--  b. Tạo thủ tục truyền vào mã phiếu giao hàng, xuất ra
--  tổng tiền của phiếu giao hàng đó.
CREATE PROCEDURE sp_tongtiengiaohang(@magiao CHAR(4))
AS
BEGIN
    SELECT SUM(slgiao * dongiaohang) AS TongTien
    FROM ChiTietGiaoHang 
    WHERE magiao = @magiao
END
GO
EXEC sp_tongtiengiaohang 'GH01'
GO

--  c. Tạo thủ tục truyền vào mã khách hàng, hiển thị các
--  đơn đặt hàng của khách hàng đó, gồm các thông tin:
--  Mã đặt, ngày đặt, mã giao, ngày giao.
CREATE PROCEDURE sp_hienthidondathang(@makh CHAR(4))
AS
BEGIN
    SELECT D.madat,D.ngaydat,P.magiao,P.ngaygiao
    FROM KhachHang AS K
    JOIN DonDatHang AS D
    ON K.makh = D.makh
    JOIN PhieuGiaoHang AS P
    ON D.madat = P.madat
    WHERE K.makh = @makh
END
GO
EXEC sp_hienthidondathang 'KH01'
GO

--  d. Tạo thủ tục truyền vào ngày1 và ngày2, đếm xem có
--  bao nhiêu phiếu giao hàng được giao trong khoảng
--  thời gian từ ngày1 đến ngày2.
CREATE PROCEDURE sp_demphieugiaohangtheongay(@ngay1 DATE,@ngay2 DATE)
AS
BEGIN
    SELECT COUNT(*) AS SLPHIEUGIAOHANG
    FROM PhieuGiaoHang
    WHERE ngaygiao BETWEEN @ngay1 AND @ngay2
END
GO
EXEC sp_demphieugiaohangtheongay '2022-01-01','2023-01-01'
GO

--  e. Viết lại câu 4a, 4b, 4c bằng cách dùng thủ tục.

--  4.a Thêm cột tongtien vào phiếu giao hàng, sau đó
--  dùng con trỏ cập nhập giá trị cho cột tongtien, với
--  tongtien=SUM(slgiao*dongiagiao) hay nói cách
--  khác tongtien = SUM(thanhtien)
CREATE PROCEDURE sp_themtongtien(@magiao INT)
AS
BEGIN

    UPDATE PhieuGiaoHang
    SET tongtien = (
        SELECT SUM(slgiao * dongiaohang) 
        FROM ChiTietGiaoHang
        WHERE magiao = @magiao
        )
    WHERE @magiao = magiao

END
GO
--  4.b Thêm mới cột thuong2023 vào bảng KhachHang để
--  lưu giữ số tiền khách hàng được thưởng trong năm
--  2023. Dùng con trỏ để cập nhật giá trị cho cột này
--  như sau:
--  - Thưởng 3 triệu đối với khách mua hàng trên 50
--  triệu trong năm 2023
--  - Thưởng 2 triệu đối với khách hàng mua hàng trên
--  35 triệu trong năm 2023 và có mua Máy giặt
--  - Thưởng 1 triệu đối với những khách hàng có mua
--  hàng trong cả 2 năm 2023 và 2022
--  - Tiền thưởng = 0 cho các trường hợp còn lại.
--  Lưu ý là mỗi khách hàng chỉ nhận một mức tiền thưởng cao nhất.

CREATE PROCEDURE sp_themcotthuong2023
AS
BEGIN
    DECLARE @tongtien2023 INT,@tongtien2023_mayGiat INT,@tongtien2022 INT,@makh CHAR(4)

    DECLARE cur_thuong2023 CURSOR FOR
    SELECT makh FROM KhachHang
    OPEN cur_thuong2023
    FETCH NEXT FROM cur_thuong2023 INTO @makh

    WHILE @@FETCH_STATUS = 0
    BEGIN

        SET @tongtien2023 = (
            SELECT SUM(tongtien)
            FROM DonDatHang dd
            JOIN ChiTietDatHang ctdh 
            ON dd.madat = ctdh.madat
            JOIN PhieuGiaoHang pgh
            ON dd.madat = pgh.madat
            WHERE YEAR(dd.ngaydat) = 2023 AND dd.makh = @makh
        )

        -- Tính tổng tiền mua máy giặt của khách hàng trong năm 2023
        SET @tongtien2023_maygiat = (
            SELECT SUM(tongtien)
            FROM DonDatHang dd
            JOIN ChiTietDatHang ctdh 
            ON dd.madat = ctdh.madat
            JOIN PhieuGiaoHang pgh
            ON dd.madat = pgh.madat
            WHERE YEAR(dd.ngaydat) = 2023 AND dd.makh = @makh AND ctdh.mahh = 'MG1'
        )

        -- Tính tổng tiền mua hàng của khách hàng trong năm 2022
        SET @tongtien2022 = (
            SELECT SUM(tongtien)
            FROM DonDatHang dd
            JOIN ChiTietDatHang ctdh 
            ON dd.madat = ctdh.madat
            JOIN PhieuGiaoHang pgh
            ON dd.madat = pgh.madat
            WHERE YEAR(dd.ngaydat) = 2022 AND dd.makh = @makh
        )

        UPDATE KhachHang
        SET thuong2023 = 
            CASE
                WHEN @tongtien2023 > 50000000 THEN 3000000
                WHEN @tongtien2023 > 35000000 AND @tongtien2023_maygiat > 0 THEN 2000000
                WHEN @tongtien2022 > 0 AND @tongtien2023 > 0 THEN 1000000
                ELSE 0
            END
        WHERE makh = @makh

        FETCH NEXT FROM cur INTO @makh
    END
    CLOSE cur_thuong2023
    DEALLOCATE cur_thuong2023
END
GO

--  4.c Vào ngày 1/1/2024, cần tăng giá của tất cả các mặt
--  hàng lên 10% so với đơn giá hiện hành. Song song
--  với việc tăng giá tất cả các mặt hàng là việc chèn 1
--  dòng dữ liệu vào LichSuGia ứng với mỗi hàng hóa,
--  có nghĩa là có bao nhiêu hàng hóa sẽ có bấy nhiêu
--  dòng dữ liệu được chèn vào bảng LichSuGia với các
--  giá trị tương ứng. Dùng con trỏ để thực hiện công
--  việc này
CREATE PROCEDURE sp_capnhatgia_lichsu
AS
BEGIN
    DECLARE @mahh CHAR(3),@dongia INT,@ngaycapnhat DATE
    SET @ngaycapnhat = '2024-01-01'

    DECLARE cur_capnhatgia CURSOR FOR
    
    SELECT mahh,dongiahh
    FROM HangHoa

    OPEN cur_capnhatgia
    FETCH NEXT FROM cur_capnhatgia INTO @mahh,@dongia

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @dongia = @dongia * 1.1

            UPDATE HangHoa
            SET dongiahh = @dongia
            WHERE mahh = @mahh

            INSERT INTO LichSuGia(mahh,ngayhl,dongia)
            VALUES(@mahh,@ngaycapnhat,@dongia)

            FETCH NEXT FROM cur_capnhatgia INTO @mahh,@dongia
        END
    CLOSE cur_capnhatgia
    DEALLOCATE cur_capnhatgia
END
GO


--  f. Tạo thủ tục thêm mới một hàng hóa với tham số đầu
--  vào là: mã hàng, tên hàng, đơn vị tính, số lượng, đơn
--  giá. Yêu cầu:
-- - Kiểm tra khóa chính, nếu vi phạm thì báo lỗi và chấm dứt thủ tục.
-- - Kiểm tra tên hàng phải là duy nhất (có nghĩa tên hàng nếu khác null phải khác với tất cả các tên hàng
--   đã tồn tại trong bảng HangHoa), nếu không duy nhất thì báo lỗi và chấm dứt thủ tục.
-- - Kiểm tra số lượng nếu khác null thì phải ≥0, ngược lại thì báo lỗi và chấm dứt thủ tục.
-- - Kiểm tra đơn giá nếu khác null thì phải ≥0, ngược lại thì báo lỗi và chấm dứt thủ tục.
-- - Nếu các điều kiện trên thỏa thì cho thêm hàng hóa.

CREATE PROCEDURE sp_check_themvaohoadon(@mahh CHAR(3),@tenhh NVARCHAR(40),@dvt NVARCHAR(20),@slcon SMALLINT,@dongiahh INT)
AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM HangHoa 
        WHERE @mahh = mahh
    )
    BEGIN
        PRINT N'Không thể thêm vào vì mã hàng hóa này đã tồn tại'
        RETURN -1
    END
    ELSE IF EXISTS(
        SELECT *
        FROM HangHoa
        WHERE tenhh = @tenhh OR @tenhh IS NULL
    )
    BEGIN
        PRINT N'Không thể thêm vào vì tên hàng hóa này đã tồn tại hoặc tên hàng hóa của bạn khác null'
        RETURN -1
    END
    ELSE IF @slcon <= 0
    BEGIN
        PRINT N'Số lượng phải lớn hơn hoặc bằng 0'
        RETURN -1
    END
    ELSE IF @dongiahh <= 0 
    BEGIN
        PRINT N'Đơn giá phải lớn hơn hoặc bằng 0'
        RETURN -1
    END
    ELSE
    BEGIN 
        INSERT INTO HangHoa
        VALUES(@mahh,@tenhh,@dvt,@slcon,@dongiahh)
        PRINT N'Thêm thành công'
    END

END
GO

--  g. Tạo thủ tục thêm mới một ChiTietGiaoHang với các
--  tham số đầu vào là: mã giao, mã hàng hóa, số lượng
--  giao. Yêu cầu:
-- - Kiểm tra hàng hóa này có được đặt không, có nghĩa
--  mã hàng hóa truyền vào có tồn tại trong ChiTietDatHang
--  của đơn đặt hàng tương ứng với phiếu giao hàng này
--  không? Nếu không thì báo lỗi và chấm dứt procedure.
-- - Kiểm tra số lượng giao có nhỏ hơn số lượng đặt ứng
--  với hàng hóa này không? Nếu không thì báo lỗi và
--  chấm dứt procedure.
-- - Kiểm tra số lượng giao có nhỏ hơn số lượng còn
--  của hàng hóa này không? Nếu không thì báo lỗi và
--  chấm dứt procedure.
-- - Nếu thỏa 3 điều kiện trên thì cho thêm mới vào chi
--  tiết giao hàng, với đơn giá giao được lấy từ đơn giá
--  hiện hành của hàng hóa này. Sau khi thêm mới phải
--  cập nhập lại cột số lượng còn của HangHoa: slcon = slcon-slgiao.
--  Cần phải lưu ý với 2 hành động thêm
--  mới chi tiết giao hàng và cập nhật lại số lượng còn,
--  nếu một trong hai hành động thất bại thì cả hai cùng
--  thất bại. Cần phải sử dụng giao dịch (transaction)
--  để giải quyết vấn đề này

CREATE PROCEDURE sp_themchitietgiaohang(@magiao CHAR(4),@mahh CHAR(3),@slgiao SMALLINT)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF NOT EXISTS(
                SELECT *
                FROM ChiTietGiaoHang
                WHERE @mahh IN(
                    SELECT ChiTietDatHang.mahh
                    FROM HangHoa
                    JOIN ChiTietDatHang
                    ON HangHoa.mahh = ChiTietDatHang.mahh
                    JOIN DonDatHang
                    ON ChiTietDatHang.madat = DonDatHang.madat
                    JOIN PhieuGiaoHang 
                    ON DonDatHang.madat = PhieuGiaoHang.madat
                    WHERE ChiTietDatHang.mahh = @mahh AND PhieuGiaoHang.magiao = @magiao
                )
            )
            BEGIN
                PRINT N'Mã hàng hóa phải có tồn tại trong ChiTietDatHang của đơn đặt hàng tương ứng với phiếu giao hàng này'
                ROLLBACK TRANSACTION
                RETURN -1
            END
            ELSE IF @slgiao > (
                SELECT SLDat
                FROM ChiTietDatHang
                WHERE madat = (
                    SELECT madat
                    FROM DonDatHang
                    JOIN PhieuGiaoHang
                    ON DonDatHang.madat = PhieuGiaoHang.madat
                    WHERE @magiao = magiao 
                ) AND mahh = @mahh
            )
            BEGIN
                PRINT N'Số lượng đặt phải nhỏ hơn số lượng còn của hàng hóa này'
                ROLLBACK TRANSACTION
                RETURN -1
            END
            ELSE IF @slgiao > (
                SELECT slcon
                FROM HangHoa
                WHERE mahh = @mahh
            )
            BEGIN
                PRINT N'Số lượng giao phải nhỏ hơn số lượng còn của hàng hóa này'
                ROLLBACK TRANSACTION
                RETURN -1
            END

            INSERT INTO ChiTietGiaoHang(magiao,mahh,slgiao,dongiaohang)
            VALUES(@magiao,@mahh,@slgiao,(SELECT dongiahh FROM HangHoa WHERE mahh = @mahh))

            UPDATE HangHoa
            SET slcon = slcon - @slgiao
            WHERE mahh = @mahh
            
        COMMIT TRANSACTION
        PRINT N'Thêm thành công'

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        PRINT N'Không thêm vào được' + ERROR_MASSAGE();
    END CATCH
END
GO



--                                                                                  6. HÀM

-- Viết lại các yêu cầu trong câu 5 bằng cách dùng hàm

--  a. Tạo thủ tục truyền vào mã đơn đặt hàng và mã hàng
--  hóa, xuất ra số lượng hàng hóa được đặt trong đơn.
CREATE FUNCTION fc_demslhanghoa(@madat CHAR(4),@mahh CHAR(3))
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SELECT @dem = SLDat
    FROM ChiTietDatHang
    WHERE madat = @madat AND mahh = @mahh

    RETURN @dem 
END
GO
SELECT dbo.fc_demslhanghoa('DH01','BU1')
GO
--  b. Tạo thủ tục truyền vào mã phiếu giao hàng, xuất ra
--  tổng tiền của phiếu giao hàng đó.

 CREATE FUNCTION fc_tongtien_PG(@mapg char(10))
 RETURNS money
 AS
 BEGIN
    DECLARE @tongtien money
    --Kiểm tra @mapg tồn tại chưa
    -- Nếu chưa tồn tại return 0
    IF NOT EXISTS(
        SELECT * 
        FROM ChiTietGiaoHang
        WHERE magiao = @mapg
    )
    RETURN 0 

    --Nếu @mapg tồn tại thì
    SELECT @tongtien = SUM(slgiao * dongiaohang)
    FROM dbo.ChiTietGiaoHang
    WHERE magiao = @mapg

    RETURN @tongtien
 END
GO


--  c. Tạo thủ tục truyền vào mã khách hàng, hiển thị các
--  đơn đặt hàng của khách hàng đó, gồm các thông tin:
--  Mã đặt, ngày đặt, mã giao, ngày giao.
CREATE FUNCTION fc_hienthidathang(@makh CHAR(4))
RETURNS TABLE AS
RETURN(
    SELECT D.madat,D.ngaydat,P.magiao,P.ngaygiao
    FROM KhachHang AS K
    JOIN DonDatHang AS D
    ON K.makh = D.makh
    JOIN PhieuGiaoHang AS P
    ON d.madat = P.madat
    WHERE K.makh = @makh
)
GO
SELECT * FROM dbo.fc_hienthidathang('KH01')
GO

--  d. Tạo thủ tục truyền vào ngày1 và ngày2, đếm xem có
--  bao nhiêu phiếu giao hàng được giao trong khoảng
--  thời gian từ ngày1 đến ngày2.
CREATE FUNCTION fc_demphieugiaohang(@ngay1 DATE,@ngay2 DATE)
RETURNS INT AS
BEGIN
    DECLARE @dem INT

    SET @dem = (
        SELECT COUNT(*) AS SLPHIEUGIAOHANG
        FROM PhieuGiaoHang
        WHERE ngaygiao BETWEEN @ngay1 AND @ngay2
    )

    RETURN @dem
END
GO
SELECT dbo.fc_demphieugiaohang('2022-01-01','2023-01-01')
GO

--  e. Viết lại câu 4a, 4b, 4c bằng cách dùng thủ tục.

--  4.a Thêm cột tongtien vào phiếu giao hàng, sau đó
--  dùng con trỏ cập nhập giá trị cho cột tongtien, với
--  tongtien=SUM(slgiao*dongiagiao) hay nói cách
--  khác tongtien = SUM(thanhtien)

CREATE FUNCTION fc_themtongtien(@magiao CHAR(4))
RETURNS INT AS
BEGIN
    DECLARE @tongtien INT

    SELECT @tongtien = SUM(slgiao * dongiaohang) 
    FROM ChiTietGiaoHang
    WHERE magiao = @magiao

    RETURN @tongtien
END
GO
DECLARE @magiao CHAR(4)
SET @magiao = 'GH05'
DECLARE @tongtien INT
SET @tongtien =  dbo.fc_themtongtien(@magiao) 
SELECT @tongtien
IF @tongtien IS NOT NULL
BEGIN
    UPDATE PhieuGiaoHang
    SET tongtien = @tongtien
    WHERE magiao = @magiao
END
GO

--  4.b Thêm mới cột thuong2023 vào bảng KhachHang để
--  lưu giữ số tiền khách hàng được thưởng trong năm
--  2023. Dùng con trỏ để cập nhật giá trị cho cột này
--  như sau:
--  - Thưởng 3 triệu đối với khách mua hàng trên 50
--  triệu trong năm 2023
--  - Thưởng 2 triệu đối với khách hàng mua hàng trên
--  35 triệu trong năm 2023 và có mua Máy giặt
--  - Thưởng 1 triệu đối với những khách hàng có mua
--  hàng trong cả 2 năm 2023 và 2022
--  - Tiền thưởng = 0 cho các trường hợp còn lại.
--  Lưu ý là mỗi khách hàng chỉ nhận một mức tiền thưởng cao nhất.

CREATE FUNCTION fc_tinhThuong2023(@makh CHAR(4))
RETURNS INT
AS
BEGIN
    DECLARE @thuong INT = 0

    DECLARE @tongtien2023 INT
    DECLARE @tongtien2023_maygiat INT
    DECLARE @tongtien2022 INT


    SELECT @tongtien2023 = SUM(pg.tongtien)
    FROM DonDatHang dd
    JOIN PhieuGiaoHang pg
    ON dd.madat = pg.madat
    WHERE YEAR(dd.ngaydat) = 2023 AND dd.makh = @makh


    SELECT @tongtien2023_maygiat = SUM(pg.tongtien)
    FROM DonDatHang dd
    JOIN PhieuGiaoHang pg
    ON dd.madat = pg.madat
    JOIN ChiTietDatHang ctdh 
    ON dd.madat = ctdh.madat
    WHERE YEAR(dd.ngaydat) = 2023 AND dd.makh = @makh AND ctdh.mahh = 'MG1'

    SELECT @tongtien2022 = SUM(pg.tongtien)
    FROM DonDatHang dd
    JOIN PhieuGiaoHang pg
    ON dd.madat = pg.madat
    WHERE YEAR(dd.ngaydat) = 2022 AND dd.makh = @makh

    IF @tongtien2023 > 50000000
        SET @thuong = 3000000
    ELSE IF @tongtien2023 > 35000000 AND @tongtien2023_maygiat > 0
        SET @thuong = 2000000
    ELSE IF @tongtien2022 > 0 AND @tongtien2023 > 0
        SET @thuong = 1000000
    ELSE
        SET @thuong = 0

    RETURN @thuong
END
GO
DECLARE @thuong INT,@makh CHAR(4)
SET @makh = 'KH06'
SET @thuong = dbo.fc_tinhThuong2023(@makh)
IF @thuong IS NOT NULL
BEGIN
    UPDATE KhachHang
    SET thuong2023 = @thuong
    WHERE makh = @makh
END
GO


--  4.c Vào ngày 1/1/2024, cần tăng giá của tất cả các mặt
--  hàng lên 10% so với đơn giá hiện hành. Song song
--  với việc tăng giá tất cả các mặt hàng là việc chèn 1
--  dòng dữ liệu vào LichSuGia ứng với mỗi hàng hóa,
--  có nghĩa là có bao nhiêu hàng hóa sẽ có bấy nhiêu
--  dòng dữ liệu được chèn vào bảng LichSuGia với các
--  giá trị tương ứng. Dùng con trỏ để thực hiện công
--  việc này

CREATE FUNCTION fc_tangGia(@mahh CHAR(3),@giacu INT)
RETURNS INT AS
BEGIN
    DECLARE @giaMoi INT
    SET @giacu = (
        SELECT dongiahh
        FROM HangHoa
        WHERE mahh = @mahh
    ) 
    SET @giaMoi = @giacu * 1.1
    
    RETURN @giaMoi
END
GO

DECLARE @mahh CHAR(4)
SET @mahh = 'MG01'

DECLARE @giacu INT
SET @giacu = 300000

UPDATE HangHoa
SET dongiahh = dbo.fc_tangGia(@mahh,@giacu)

INSERT INTO LichSuGia (mahh, ngayhl, dongia)
SELECT @mahh,'2024-01-01',@giacu
FROM HangHoa

GO

--  f. Tạo thủ tục thêm mới một hàng hóa với tham số đầu
--  vào là: mã hàng, tên hàng, đơn vị tính, số lượng, đơn
--  giá. Yêu cầu:
-- - Kiểm tra khóa chính, nếu vi phạm thì báo lỗi và
--  chấm dứt thủ tục.
-- - Kiểm tra tên hàng phải là duy nhất (có nghĩa tên
--  hàng nếu khác null phải khác với tất cả các tên hàng
--  đã tồn tại trong bảng HangHoa), nếu không duy
--  nhất thì báo lỗi và chấm dứt thủ tục.
--  - Kiểm tra số lượng nếu khác null thì phải ≥0, ngược
--  lại thì báo lỗi và chấm dứt thủ tục.
--  - Kiểm tra đơn giá nếu khác null thì phải ≥0, ngược
--  lại thì báo lỗi và chấm dứt thủ tục.
--  - Nếu các điều kiện trên thỏa thì cho thêm hàng hóa.
CREATE FUNCTION fc_themmoihanghoa(@mahh CHAR(3),@tenhh NVARCHAR(40),@dvt NVARCHAR(20),@slcon SMALLINT,@dongiahh INT)
RETURNS INT AS
BEGIN

    DECLARE @result INT = 0

    IF EXISTS(
        SELECT 1
        FROM HangHoa
        WHERE @mahh = mahh
    )
    BEGIN
        SET @result = -1
        RETURN @result
    END

    IF EXISTS(
        SELECT 1
        FROM HangHoa
        WHERE @tenhh = tenhh
    )
    BEGIN

        SET @result = -2
        RETURN @result
    END

    IF @slcon <= 0 AND @slcon IS NOT NULL
    BEGIN
        SET @result = -3
        RETURN @result
    END

    IF @dongiahh <= 0 AND @dongiahh IS NOT NULL
    BEGIN
        SET @result = -4
        RETURN @result
    END
    
    -- DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO HangHoa(mahh,tenhh,dvt,slcon,dongiahh)VALUES(@mahh,@tenhh,@dvt,@slcon,@dongiahh)'
    -- DECLARE @params NVARCHAR(MAX) = N'@mahh CHAR(3), @tenhh NVARCHAR(40), @dvt NVARCHAR(20), @slcon SMALLINT, @dongiahh INT'

    -- EXEC QLDONHANG..sp_executesql @sql, @params

    SET @result = 1
    RETURN @result
    
END
GO
DECLARE @result INT
EXEC @result = dbo.fc_themmoihanghoa 'BA1', N'Bàn ăn SHAP', N'Cái', -1, 350000
SELECT @result
IF @result = 1
BEGIN
    INSERT INTO HangHoa(mahh, tenhh, dvt, slcon, dongiahh)
    VALUES ('BA1', N'Bàn ăn SHAP', N'Cái', 60, 350000)
    PRINT 'Thêm thành công'
END

-- sp_configure 'xp_cmdshell', 0;
-- RECONFIGURE;

--  g. Tạo thủ tục thêm mới một ChiTietGiaoHang với các
--  tham số đầu vào là: mã giao, mã hàng hóa, số lượng
--  giao. Yêu cầu:
--  - Kiểm tra hàng hóa này có được đặt không, có nghĩa
--  mãhàng hóa truyền vào có tồn tại trong ChiTietDatHang
--  của đơn đặt hàng tương ứng với phiếu giao hàng này
--  không? Nếu không thì báo lỗi và chấm dứt procedure.
--  - Kiểm tra số lượng giao có nhỏ hơn số lượng đặt ứng
--  với hàng hóa này không? Nếu không thì báo lỗi và
--  chấm dứt procedure.
--  - Kiểm tra số lượng giao có nhỏ hơn số lượng còn
--  của hàng hóa này không? Nếu không thì báo lỗi và
--  chấm dứt procedure.
--  - Nếu thỏa 3 điều kiện trên thì cho thêm mới vào chi
--  tiết giao hàng, với đơn giá giao được lấy từ đơn giá
--  hiện hành của hàng hóa này. Sau khi thêm mới phải
--  cập nhập lại cột số lượng còn của HangHoa: slcon=
--  slcon-slgiao. Cần phải lưu ý với 2 hành động thêm
--  mới chi tiết giao hàng và cập nhật lại số lượng còn,
--  nếu một trong hai hành động thất bại thì cả hai cùng
--  thất bại. Cần phải sử dụng giao dịch (transaction)
--  để giải quyết vấn đề này

GO
CREATE FUNCTION fc_themChiTietGiaoHang (@magiao CHAR(4),@mahh CHAR(3),@slgiao INT)
RETURNS INT AS
BEGIN
    DECLARE @result INT = 0

    IF NOT EXISTS(
        SELECT *
        FROM ChiTietGiaoHang
        WHERE @mahh IN(
            SELECT ChiTietDatHang.mahh
            FROM HangHoa
            JOIN ChiTietDatHang
            ON HangHoa.mahh = ChiTietDatHang.mahh
            JOIN DonDatHang
            ON ChiTietDatHang.madat = DonDatHang.madat
            JOIN PhieuGiaoHang 
            ON DonDatHang.madat = PhieuGiaoHang.madat
            WHERE ChiTietDatHang.mahh = @mahh AND PhieuGiaoHang.magiao = @magiao
        )
    )
    BEGIN
        SET @result = -1
        ROLLBACK TRANSACTION
        RETURN @result
    END

    IF @slgiao > (
        SELECT SLDat
        FROM ChiTietDatHang
        WHERE madat = (
            SELECT madat
            FROM DonDatHang
            JOIN PhieuGiaoHang
            ON DonDatHang.madat = PhieuGiaoHang.madat
            WHERE @magiao = magiao 
        ) AND mahh = @mahh
    )
    BEGIN
        SET @result = -2
        ROLLBACK TRANSACTION
        RETURN @result
    END


    IF @slgiao > (
        SELECT slcon
        FROM HangHoa
        WHERE mahh = @mahh
    )
    BEGIN
        SET @result = -3
        ROLLBACK TRANSACTION
        RETURN @result
    END

    SET @result = 1
    RETURN @result
END
GO
DECLARE @result INT
DECLARE @magiao CHAR(4),@mahh CHAR(3),@slgiao SMALLINT
SET @magiao = 'GH09'
SET @mahh = 'BU1'
SET @slgiao = 15
EXEC @result = dbo.fc_themChiTietGiaoHang @magiao,@mahh,@slgiao
SELECT @result 
IF @result = 1 
BEGIN
    INSERT INTO ChiTietGiaoHang (magiao, mahh, slgiao, dongiaohang)
    VALUES (@magiao, @mahh, @slgiao, (SELECT dongiahh FROM HangHoa WHERE mahh = @mahh))

    UPDATE HangHoa
    SET slcon = slcon - @slgiao
    WHERE mahh = @mahh
END
GO


--                                                                                      7. TRIGGER


--  a. Cài đặt ràng buộc sau bằng 2 cách: constraint và
--  trigger “Số lượng còn của hàng hóa phải lớn hơn 0”.

ALTER TABLE HangHoa
ADD CONSTRAINT CHK_SoLuongCon CHECK (slcon >= 0);

GO

CREATE TRIGGER trg_slhhlonhon0
ON HangHoa
FOR INSERT,UPDATE AS
BEGIN
    DECLARE @slcon INT

    SELECT @slcon = slcon 
    FROM inserted
    
    IF @slcon < 0
    BEGIN
        PRINT N'Số lượng còn phải lơn hơn hoặc bằng 0'
        ROLLBACK TRANSACTION
        RETURN
    END
END


--  b. Cài đặt ràng buộc sau bằng 2 cách: constraint và
--  trigger “Đơn vị tính của hàng hóa chỉ nhận một trong
--  các giá trị: Cái, Thùng, Chiếc, Chai, Lon”.

ALTER TABLE HangHoa
ADD CONSTRAINT CHK_DONVITINH CHECK (dvt IN(N'Cái',N'Thùng',N'Chiếc',N'Chai',N'Lon'));

GO

CREATE TRIGGER trg_donvitinh
ON HangHoa
FOR INSERT,UPDATE AS
BEGIN
    DECLARE @dvt NVARCHAR(30)

    SELECT @dvt = dvt 
    FROM inserted
    
    IF @dvt NOT IN(N'Cái',N'Thùng',N'Chiếc',N'Chai',N'Lon')
    BEGIN
        PRINT N'Đơn vị tính phải là:Cái,Thùng,Chiếc,Chai,Lon'
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO

--  c. Cài đặt ràng buộc: “Mỗi đơn đặt hàng chỉ có tối đa 1 phiếu giao hàng”.
CREATE TRIGGER trg_hoadon_toida1phieugiao
ON DonDatHang
AFTER INSERT,UPDATE AS
BEGIN
    
    IF (SELECT COUNT(*) FROM DonDatHang) < (SELECT COUNT(*) FROM PhieuGiaoHang) 
    BEGIN
        PRINT N'Mỗi đơn đặt hàng chỉ tối đa 1 phiếu giao hàng'
        ROLLBACK TRANSACTION
        RETURN
    END
END
GO
--  d. Cài đặt ràng buộc: “Ngày giao hàng phải bằng hoặc
--  sau ngày đặt hàng nhưng không được quá 30 ngày”.

CREATE TRIGGER trg_ngaygiaohang_saungaydat
ON PhieuGiaoHang
FOR INSERT,UPDATE AS
BEGIN
    DECLARE @ngaygiao INT,@ngaydat INT

    SELECT @ngaygiao = DAY(ngaygiao) FROM inserted
    SELECT @ngaydat = DAY(ngaydat) FROM DonDatHang

    IF @ngaydat > @ngaygiao AND (@ngaydat - @ngaygiao) > 30
    BEGIN
        PRINT N'Ngày giao hàng phải bằng hoặc sau ngày đặt hàng nhưng không được quá 30 ngày'
        ROLLBACK TRANSACTION
        RETURN
    END   

END

GO
CREATE TRIGGER trg_ngaygiao_ngaydat
ON PhieuGiaoHang
AFTER INSERT, UPDATE AS
    DECLARE @madat char(10),@ng datetime,@nd datetime--Trường hợp thêm mới

    IF NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @madat = madat,@ng = ngaygiao
        FROM inserted
        SELECT @nd = ngaydat
        FROM DonDatHang 
        WHERE madat = @madat
        IF @ng < @nd
        BEGIN
            PRINT N'Ngày giao phải sau ngày đặt'
            ROLLBACK TRANSACTION
            RETURN
        END
        IF DATEDIFF(DD, @nd, @ng) > 30
        BEGIN
            PRINT N'Ngày giao- ngày đặt <= 30 ngày'
            ROLLBACK TRANSACTION
            RETURN
        END
    END
    ELSE
    BEGIN
        IF UPDATE(ngaygiao)
        BEGIN
            SELECT @madat = madat,@ng = ngaygiao
            FROM inserted
            SELECT @nd = ngaydat
            FROM DonDatHang WHERE madat=@madat
            IF @ng < @nd
            BEGIN
                PRINT N'Ngày giao phải sau ngày đặt'
                ROLLBACK TRANSACTION
                RETURN
            END
            IF DATEDIFF(DD, @nd, @ng) > 30
            BEGIN
                PRINT N'Ngày giao - ngày đặt <= 30 ngày'
                ROLLBACK TRANSACTION
                RETURN
            END
        END
    END
GO

--  e. Cài đặt ràng buộc trigger sau khi chèn 1 dòng mới
--  vào bảng LichSuGia (gồm: mã hàng hóa, ngày hiệu
--  lực mới, đơn giá mới), nếu ngày có hiệu lực mới lớn
--  hơn tất cả các ngày hiệu lực trong lịch sử giá của
--  hàng hóa tương ứng thì cập nhật lại dongiahh bằng
--  đơn giá mới cho hàng hóa này, ngược lại thì rollback.
GO
CREATE TRIGGER trg_capnhat_dongia
ON LichSuGia
AFTER INSERT AS
BEGIN
    DECLARE @mahh CHAR(3)
    DECLARE @ngayhieulucmoi DATE
    DECLARE @dongiamoi INT
    
    SELECT @mahh = i.mahh, @ngayhieulucmoi = i.ngayhl, @dongiamoi = i.dongia
    FROM inserted AS i

    IF NOT EXISTS (
        SELECT * 
        FROM HangHoa 
        WHERE mahh = @mahh
    )
    BEGIN
        PRINT 'Mã hàng hóa không tồn tại'
        ROLLBACK TRANSACTION
        RETURN
    END
    
    DECLARE @ngayhieuluc_lonnhat DATE
    SELECT @ngayhieuluc_lonnhat = MAX(ngayhl)
    FROM LichSuGia
    WHERE mahh = @mahh

    IF @ngayhieulucmoi > @ngayhieuluc_lonnhat
    BEGIN
        UPDATE HangHoa
        SET dongiahh = @dongiamoi
        WHERE mahh = @mahh
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION
        RETURN
    END
END




--  f. Cài đặt ràng buộc: “Số lượng hàng hóa được giao
--  không được lớn hơn số lượng hàng hóa được đặt
--  tương ứng”.
GO
CREATE TRIGGER trg_soluonggiao_soluongdat
ON ChiTietGiaoHang
AFTER INSERT,UPDATE AS
BEGIN
    DECLARE @slgiao INT,@sldat INT

    SELECT @slgiao = slgiao 
    FROM inserted 

    SELECT @sldat = sldat 
    FROM ChiTietDatHang
    JOIN HangHoa
    ON ChiTietDatHang.mahh = HangHoa.mahh
    JOIN inserted
    ON inserted.mahh = HangHoa.mahh 

    IF NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        IF @slgiao > @sldat
        BEGIN
            PRINT N'Số lượng hàng hóa được giao không được lớn hơn số lượng hàng hóa được đặt tương ứng'
            ROLLBACK TRANSACTION
            RETURN
        END
    END
    ELSE 
    BEGIN
        IF UPDATE(slgiao)
        BEGIN
            IF @slgiao > @sldat
            BEGIN
                PRINT N'Số lượng hàng hóa được giao không được lớn hơn số lượng hàng hóa được đặt tương ứng'
                ROLLBACK TRANSACTION
                RETURN
            END
        END
    END
END
GO


--                                                                                  8. AN TOÀN + BẢO MẬT DỮ LIỆU

--  a. Hãy Exportbảng KhachHang rafiletblKhachHang.txt

--  Bước 1: SELECT * FROM KhachHang
--  Bước 2: Nhấp chuột phải vào kết quả và chọn Save Results As.... lưu tệp .txt


--  b. Xóa hết dữ liệu trong bảng KhachHang, sau đó Import
--  lại dữ liệu từ file tblKhachHang.txt

-- Bước 1: Nhấp chuột phải vào Database chọn Tasks -> FLat File
-- Bước 2: Chọn file đã xuất ra và thiết lập các typedata 

--  c. Hãy Export toàn bộ bảng của CSDL sang Access

--  d. Saolưu(Backup) toàn bộ CSDL thành file QLDDH.bak,
--  sau đó xóa và sửa một vài dòng bất kỳ trong CSDL
--  rồi thực hiện phục hồi (restore) lại CSDL từ file
--  QLDDH.bak, có nhận xét gì?
-- Phục hồi lại ban đầu các dữ liệu xóa 

--  e. Giả sử cơ sở dữ liệu về Quản lý nhập xuất tồn có các nhóm, người sử dụng như sau:
-- - Các account: Admin, Director có quyền quản trị.
-- - Các user: user1, user2, user3 có quyền xem tất cả
--  các bảng nhưng không có quyền thêm, xóa sửa bất kỳ bảng nào.
-- - Các user: user4, user5, user6 có quyền xem tất cả
--  các bảng và quyền thêm, xóa, sửa bảng DonDatHang,
--  ChiTietDatHang, PhieuGiaoHang, ChiTietGiaoHang.
--  Hãy tạo các nhóm, role, user để đảm bảo quyền trên.

CREATE ROLE Admin1
CREATE ROLE Director

GRANT CONTROL TO Admin1,Director

CREATE USER user1 FOR LOGIN XemTatCaBang 
CREATE USER user2 FOR LOGIN XemTatCaBang
CREATE USER user3 FOR LOGIN XemTatCaBang

CREATE ROLE XemTatCaBang
GRANT SELECT DonDatHang TO XemTatCaBang;
GRANT SELECT ChiTietDatHang TO XemTatCaBang;
GRANT SELECT PhieuGiaoHang TO XemTatCaBang;
GRANT SELECT ChiTietGiaoHang TO XemTatCaBang;
GRANT SELECT HangHoa TO XemTatCaBang;
GRANT SELECT KhachHang TO XemTatCaBang;
GRANT SELECT LichSuGia TO XemTatCaBang;
GRANT XemTatCaBang TO user1, user2, user3;

CREATE USER user5 FOR LOGIN XemTatCaBang 
CREATE USER user6 FOR LOGIN XemTatCaBang
CREATE USER user7 FOR LOGIN XemTatCaBang

CREATE ROLE QuanLyBang;
GRANT SELECT, INSERT, UPDATE, DELETE ON DonDatHang TO QuanLyBang
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietDatHang TO QuanLyBang
GRANT SELECT, INSERT, UPDATE, DELETE ON PhieuGiaoHang TO QuanLyBang
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietGiaoHang TO QuanLyBang
GRANT QuanLyBang TO user4, user5, user6;

