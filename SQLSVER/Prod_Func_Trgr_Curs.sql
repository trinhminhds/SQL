CREATE PROCEDURE sp_indanhsachsv
AS 
    SELECT masv,hodem,ten
    FROM sinhvien;

EXEC sp_indanhsachsv;

GO

ALTER PROCEDURE sp_indanhsachsv
AS 
    SELECT masv,hodem,ten
    FROM sinhvien;

GO

ALTER PROCEDURE sp_timSinhVien(@masv varchar(10))
AS 
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    PRINT N'Không có trong danh sách'
    ELSE 
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    

GO

sp_timSinhVien 2401;

GO 

CREATE PROCEDURE sp_kiemTrahoccung(@masv1 varchar(10),@masv2 varchar(10) )
AS 
    DECLARE @malop1 char(5) , @malop2 CHAR(5)

    SELECT @malop1 = malop FROM sinhvien WHERE masv = @masv1;
    SET @malop2 = (SELECT malop FROM sinhvien WHERE masv = @masv2)

    IF @malop1 = @malop2
    PRINT N'Hai sv nà học cùng lớp'
    ELSE 
    PRINT N'Hai sinh vien học khác lớp'

GO

sp_kiemTrahoccung @masv1 = 2401, @masv2 = 2402


GO

ALTER PROCEDURE sp_tinhDiemTrungBinh(@masv varchar(10))
AS 
    SELECT AVG(diem) AS diemtrungbinh
    FROM ketqua 
    WHERE ketqua.masv = @masv

GO

EXEC sp_tinhDiemTrungBinh 2401


GO

ALTER FUNCTION fc_soNguyen(@soNguyen1 INT ,@soNguyen2 INT)
RETURNS INT AS
BEGIN
    DECLARE @tong INT
    SET @tong = @soNguyen1 + @soNguyen2

    RETURN @tong
END

GO

PRINT dbo.fc_soNguyen(100,2);

GO

--                                                              BÀI TẬP CHƯƠNG 4

--                          DẠNG 1: FUNCTION(HÀM)


-- 1. Viết hàm xếp loại dựa vào điểm

ALTER FUNCTION fc_xepLoai(@diem NUMERIC(3,1))
RETURNS NVARCHAR(20) AS
BEGIN
    DECLARE @xepLoai NVARCHAR(20)
    SET @xepLoai = 
    CASE
        WHEN @diem >= 8 THEN N'giỏi'
        WHEN @diem >= 7 THEN N'kha'
        WHEN @diem >= 5 THEN N'trung binh' 
        ELSE  N'Yeu'
    END
    RETURN @xepLoai
END

GO

--  Ứng dụng: Hiển thị danh sách gồm mã sinh
--  viên, điểm trung bình, xếp loại của mỗi sinh
--  viên và xuất ra bảng mới tên là DiemTBC

SELECT KQ.masv,(SUM(KQ.diem*HP.stc)/SUM(HP.stc)) AS DiemTB ,DBO.fc_xepLoai(SUM(KQ.diem*HP.stc)/SUM(HP.stc)) AS XEPLOAI
INTO DIEMTBC
FROM ketqua AS KQ 
JOIN hocphan AS HP
ON KQ.mahp = HP.mahp
GROUP BY KQ.masv

GO

SELECT *
FROM DIEMTBC


GO
-- 2. Viết hàm đọc điểm nguyên ra chữ tương ứng.
CREATE FUNCTION fc_docDiemNguyen(@diem INT)
RETURNS NVARCHAR (10) AS
BEGIN
    DECLARE @diemChu NVARCHAR(10)
    SET @diemChu  = 
    CASE 
        WHEN @diem = 0 THEN N'Không'
        WHEN @diem = 1 THEN N'Một'
        WHEN @diem = 2 THEN N'Hai'
        WHEN @diem = 3 THEN N'Ba'
        WHEN @diem = 4 THEN N'Bốn'
        WHEN @diem = 5 THEN N'Năm'
        WHEN @diem = 6 THEN N'Sáu'
        WHEN @diem = 7 THEN N'Bảy'
        WHEN @diem = 8 THEN N'Tám'
        WHEN @diem = 9 THEN N'Chín'
        WHEN @diem = 10 THEN N'Mười'
    END
    RETURN @diemChu
END

--  3. Viết hàm đọc điểm 1 chữ số thập phân ra thành chữ tương ứng.
GO

CREATE FUNCTION fc_docdiemthapphan(@diem numeric(3,1))
 RETURNS nvarchar(20) AS
 BEGIN
    DECLARE @pn tinyint, @ptp tinyint
    DECLARE @kq nvarchar(20)
    SET @pn = FLOOR(@diem)
    SET @ptp = (@diem*10)%10
    SET @kq = dbo.fc_docdiemnguyen(@pn)+ N' phẩy '+ dbo.fc_docdiemnguyen(@ptp)
 RETURN @kq
 END

GO
--  Ứng dụng: Hiển thị danh sách gồm mã sinh
--  viên, họ tên, mã học phần, điểm số, điểm chữ.

SELECT sinhvien.masv,sinhvien.hodem +''+ sinhvien.ten, ketqua.mahp, diem AS 'Điểm số', dbo.fc_docdiemthapphan(diem) AS 'Điểm chữ'
FROM sinhvien 
JOIN ketqua
ON sinhvien.masv = ketqua.masv


GO
-- 4. Viết hàm tính điểm trung bình của sinh viên có mã chỉ định ở học kỳ bất kỳ.

CREATE FUNCTION fc_diemTB_sv(@masv char(4),@hocKy tinyint)
RETURNS NUMERIC(3,1) AS 
BEGIN
    DECLARE @dtb NUMERIC(3,1)
    IF NOT EXISTS (
        SELECT * 
        FROM ketqua 
        WHERE masv = @masv)
        RETURN 0
    ELSE 
    SET @dtb = (SELECT SUM(diem*stc)/SUM(stc) 
            FROM ketqua AS KQ
            JOIN hocphan AS HP
            ON KQ.mahp = HP.mahp
            WHERE masv = @masv AND hocky = @hocKy)
    RETURN @dtb
END
GO
SELECT ketqua.masv, dbo.fc_diemTB_sv(ketqua.masv,hocphan.hocky)
FROM ketqua
JOIN hocphan
ON ketqua.mahp = hocphan.hocky

GO
--  5. Viết hàm tính tổng số tín chỉ của các học phần điểm < 8 của sinh viên có mã chỉ định

CREATE FUNCTION fc_tongTC_hocPhan(@masv char(4))
RETURNS INT AS
BEGIN
    DECLARE @stc INT 
    IF NOT EXISTS(
        SELECT *
        FROM ketqua 
        WHERE masv = @masv
    )
    RETURN 0
    ELSE 
        SET @stc = (
            SELECT SUM(hocphan.stc)
            FROM ketqua 
            JOIN hocphan 
            ON ketqua.mahp = hocphan.mahp
            WHERE ketqua.diem < 8 AND ketqua.masv = @masv
        )
    RETURN @stc
END

GO

SELECT masv,dbo.fc_tongTC_hocPhan(masv)
FROM sinhvien

GO

--  6. Viết hàm đếm số sinh viên có điểm dưới 8 của học phần chỉ định.


CREATE FUNCTION fc_dem_sinhVien(@mahp NVARCHAR(10))
RETURNS INT AS
BEGIN

    DECLARE @demSV INT 

    IF NOT EXISTS (
        SELECT *
        FROM hocphan 
        WHERE mahp = @mahp
    )
    RETURN 0
    ELSE 
        SET @demSV = (
            SELECT COUNT(ketqua.masv)
            FROM ketqua 
            JOIN hocphan
            ON ketqua.mahp = hocphan.mahp
            WHERE ketqua.diem < 8 AND hocphan.mahp = @mahp
        )
    RETURN @demSV
END

GO

SELECT mahp,dbo.fc_dem_sinhVien(mahp)
FROM hocphan 


-- 7. Viết hàm đếm số học phần có điểm dưới 8 của sinh viên chỉ định.
GO

CREATE FUNCTION fc_dem_hocPhan(@masv char(5))
RETURNS INT AS
BEGIN
    DECLARE @demHP INT 
    IF NOT EXISTS(
        SELECT *
        FROM ketqua
        WHERE masv = @masv
    )
        RETURN 0
    ELSE 
        SET @demHP = (
            SELECT COUNT(hocphan.mahp)
            FROM ketqua 
            JOIN hocphan 
            ON ketqua.mahp = hocphan.mahp
            WHERE ketqua.diem < 8 AND ketqua.masv = @masv
        ) 

    RETURN @demHP
END 

GO

SELECT masv, dbo.fc_dem_hocPhan(masv)
FROM sinhvien 



--                                   BÀI TẬP TỰ GIẢI


--  1. Viết hàm fc_tachho dùng để tách họ từ chuỗi họ tên, Ví dụ: Nguyễn Mai Chi → Nguyễn.
GO

CREATE FUNCTION fc_tachho (@hodem varchar(40))
RETURNS VARCHAR (40) AS
BEGIN
    DECLARE @ho VARCHAR(40)
    IF (@hodem IS NULL)
    RETURN NULL
    ELSE
    BEGIN
        SET @ho = LEFT(@hodem,CHARINDEX(' ',@hodem + ' ',0)-1)
    END
    RETURN @ho
END

GO

SELECT hodem, dbo.fc_tachho(hodem)
FROM sinhvien 



-- 2. Viết hàm fc_tachhodem dùng để tách họ đệm từ chuỗi họ tên, Ví dụ: Nguyễn Mai Chi → Mai.
GO

CREATE FUNCTION fc_tachhodem (@hodem varchar(30),@ten varchar(10))
RETURNS VARCHAR (40) AS
BEGIN

    DECLARE @hoten NVARCHAR(40)
    DECLARE @timHoDem NVARCHAR(20)
    DECLARE @batDau INT
    DECLARE @ketThuc INT

    IF (@hodem IS NULL)
    RETURN NULL
    ELSE IF (@ten IS NULL)
    RETURN NULL
    ELSE
    BEGIN
        SET @hoten =  @hodem +' '+ @ten
        SET @batDau = CHARINDEX(' ',@hoten) + 1
        SET @ketThuc = CHARINDEX(' ',@hoten,@batDau)
        IF (@ketThuc = 0)
            SET @hodem = RIGHT(@hoten,LEN(@hoten) - @batDau + 1)
        ELSE
            SET @hodem = SUBSTRING(@hoten,@batDau,@ketThuc - @batDau)
    END
    RETURN @hodem
END

GO

SELECT ten,hodem, dbo.fc_tachhodem(hodem,ten)
FROM sinhvien 

--  3. Viết hàm fc_tachten dùng để táchtên từ chuỗi họ tên. Ví dụ: Nguyễn Mai Chi → Chi.

GO

CREATE FUNCTION fc_tachten (@hodem varchar(30),@ten VARCHAR(10) )
RETURNS VARCHAR (40) AS
BEGIN
    DECLARE @timTen VARCHAR(10)
    DECLARE @hoten VARCHAR(40)
    IF (@hodem IS NULL)
    RETURN NULL
    ELSE IF(@ten IS NULL)
    RETURN NULL
    ELSE
    BEGIN
        SET @hoten = @hodem + ' ' + @ten  
        SET @timten = RIGHT(@hoten,CHARINDEX(' ',REVERSE(@hoten)))
    END
    RETURN @timTen
END

GO

SELECT hodem+' '+ten, dbo.fc_tachten(hodem,ten)
FROM sinhvien 


GO


CREATE FUNCTION fc_doc3so( @number INT )
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @result NVARCHAR(50)
    DECLARE @muoi NVARCHAR(10)
    DECLARE @tram NVARCHAR(10)
    DECLARE @nghin NVARCHAR(10)

    SET @result = ''
    SET @muoi = N'mươi'
    SET @tram = N'trăm'
    SET @nghin = N'nghìn'

    DECLARE @hangDonVi INT
    DECLARE @hangChuc INT
    DECLARE @hangTram INT

    -- Lấy chữ số hàng đơn vị, hàng chục và hàng trăm
    SET @hangDonVi = @number % 10
    SET @hangChuc = (@number / 10) % 10
    SET @hangTram = @number / 100

    -- Đọc hàng trăm
    IF @hangTram > 0
    
        SET @result = @result + 
            CASE @hangTram
                WHEN 1 THEN N'một'
                WHEN 2 THEN N'hai'
                WHEN 3 THEN N'ba'
                WHEN 4 THEN N'bốn'
                WHEN 5 THEN N'năm'
                WHEN 6 THEN N'sáu'
                WHEN 7 THEN N'bảy'
                WHEN 8 THEN N'tám'
                WHEN 9 THEN N'chín'
             END + ' ' + @tram + ' '
    

    -- Đọc hàng chục và hàng đơn vị
    IF @hangChuc = 1
    
        SET @result = @result + N'mười' + ' ' 
            IF @hangDonVi > 0
            
                SET @result = @result +
                    CASE @hangDonVi
                        WHEN 1 THEN N'một'
                        WHEN 2 THEN N'hai'
                        WHEN 3 THEN N'ba'
                        WHEN 4 THEN N'bốn'
                        WHEN 5 THEN N'năm'
                        WHEN 6 THEN N'sáu'
                        WHEN 7 THEN N'bảy'
                        WHEN 8 THEN N'tám'
                        WHEN 9 THEN N'chín'
                    END
            
    ELSE 
    
        IF @hangChuc > 1
        
            SET @result = @result  + 
                CASE @hangChuc
                    WHEN 2 THEN N'hai'
                    WHEN 3 THEN N'ba'
                    WHEN 4 THEN N'bốn'
                    WHEN 5 THEN N'năm'
                    WHEN 6 THEN N'sáu'
                    WHEN 7 THEN N'bảy'
                    WHEN 8 THEN N'tám'
                    WHEN 9 THEN N'chín'
                END + ' ' + @muoi + ' '
        

        IF @hangDonVi > 0
        
            SET @result = @result +
                CASE @hangDonVi
                    WHEN 1 THEN N'một'
                    WHEN 2 THEN N'hai'
                    WHEN 3 THEN N'ba'
                    WHEN 4 THEN N'bốn'
                    WHEN 5 THEN N'năm'
                    WHEN 6 THEN N'sáu'
                    WHEN 7 THEN N'bảy'
                    WHEN 8 THEN N'tám'
                    WHEN 9 THEN N'chín'
                END
           
    -- Trường hợp số 0
    IF @number = 0
        SET @result = N'không'
    

    RETURN @result
END

GO

PRINT dbo.fc_doc3so(170)

GO

-- 5. Viết hàmfc_doc10so đọc số có 10 chữ số thành chữ tương ứng.

CREATE FUNCTION fc_doc10so(@number int)
RETURNS NVARCHAR(100)AS
BEGIN
    DECLARE @result NVARCHAR(100)
    DECLARE @billions INT
    DECLARE @millions INT
    DECLARE @thousands INT
    DECLARE @hundreds INT
    DECLARE @tens INT
    DECLARE @ones INT

    SET @result = ''

    -- Chia số thành từng phần tỷ, triệu, nghìn, hàng trăm, hàng chục và hàng đơn vị
    SET @billions = @number / 1000000000
    SET @millions = (@number % 1000000000) / 1000000
    SET @thousands = (@number % 1000000) / 1000
    SET @hundreds = (@number % 1000) / 100
    SET @tens = (@number % 100) / 10
    SET @ones = @number % 10

    --Đọc số tỷ
    IF @billions > 0
    
        SET @result = @result + dbo.fc_doc3so(@billions) + N' tỷ '
    

    -- Đọc số triệu
    IF @millions > 0
    
        SET @result = @result + dbo.fc_doc3so(@millions) + N' triệu '
    

    -- Đọc số nghìn
    IF @thousands > 0
    
        SET @result = @result + dbo.fc_doc3so(@thousands) + N' nghìn '
    

    -- Đọc số hàng trăm
    IF @hundreds > 0
    
        SET @result = @result + dbo.fc_doc3so(@hundreds) + N' trăm '
    

    -- Đọc số hàng chục và hàng đơn vị
    IF @tens = 1
    
        SET @result = @result + N'mười '
    
    ELSE IF @tens > 1
    
        SET @result = @result + dbo.fc_doc3so(@tens) + N' mươi '
    

    -- Đọc số hàng đơn vị
    IF @ones > 0
    
        IF @tens = 0 AND @hundreds = 0 

            SET @result = @result + N'lẻ '
        
        SET @result = @result + dbo.fc_doc3so(@ones)
    

    RETURN @result

END


GO

PRINT dbo.fc_doc10so(1234567890)


GO


--  6. Viết hàm fc_doanhthunam tính doanh thu của năm chỉ định

CREATE FUNCTION fc_doanhthunam(@nam INT)
RETURNS INT AS
BEGIN
    DECLARE @doanhthu INT
    IF NOT EXISTS (
        SELECT *
        FROM hoadon
        WHERE YEAR(ngaylap) = @nam
    )
    RETURN 0
    ELSE
    SET @doanhthu = (
            SELECT SUM(gia * soluong)
            FROM mathang 
            JOIN cthd
            ON mathang.mamh = cthd.mamh
            JOIN hoadon 
            ON cthd.mahd = hoadon.mahd 
            WHERE YEAR(ngaylap) = @nam
            --GROUP BY YEAR(ngaylap)
        )
    RETURN @doanhthu
END

GO

PRINT dbo.fc_doanhthunam(2024)

GO

-- 7. Viết hàm fc_doanhthuthang tính doanh thu của tháng chỉ định.


CREATE FUNCTION cf_doanhthuthang(@thang INT)
RETURNS INT AS
BEGIN 
    DECLARE @doanhthu INT

    SET @doanhthu = (
        SELECT SUM(gia*soluong)
        FROM mathang 
        JOIN cthd
        ON mathang.mamh = cthd.mamh
        JOIN hoadon 
        ON cthd.mahd = hoadon.mahd 
        WHERE MONTH(ngaylap) = @thang
        -- GROUP BY MONTH(ngaylap)
    )

    RETURN @doanhthu
END

GO

SELECT DISTINCT MONTH(ngaylap), dbo.cf_doanhthuthang(MONTH(ngaylap))
FROM hoadon 

GO


--  8. Viết hàm fc_doanhthuKH tính doanh thu của khách hàng chỉ định

CREATE FUNCTION cf_doanhthuKH(@makhachhang char(5))
RETURNS INT AS
BEGIN
    DECLARE @doanhthu INT

    IF NOT EXISTS(
        SELECT *
        FROM hoadon
        WHERE @makhachhang = makh
    )
    RETURN 0
    ELSE
    SET @doanhthu = (
        SELECT SUM(gia*soluong)
        FROM cthd
        JOIN mathang 
        ON cthd.mamh = mathang.mamh
        JOIN hoadon
        ON cthd.mahd = hoadon.mahd
        WHERE hoadon.makh = @makhachhang
    )

    RETURN @doanhthu
END
 

GO

SELECT hoadon.makh,dbo.cf_doanhthuKH(hoadon.makh)
FROM hoadon

GO

-- 9. Viết hàm fc_soluongban tính tổng số lượng
-- bán được cho từng mặt hàng chỉ định và tháng
-- chỉ định, nếu tháng không nhập vào tức là tính
-- tất cả các tháng.

CREATE FUNCTION fc_soluongban(@mathang VARCHAR(5),@thang INT = NULL)
RETURNS INT AS
BEGIN 

    DECLARE @soluongban INT
    SET @soluongban = 0
     
    IF @thang IS NULL
    SET @soluongban = (
        SELECT SUM(soluong)
        FROM cthd 
        JOIN hoadon
        ON cthd.mahd = cthd.mahd
        JOIN mathang
        ON cthd.mamh = mathang.mamh
        WHERE cthd.mamh = @mathang 
    )
    ELSE 
    SET @soluongban = (
        SELECT SUM(soluong)
        FROM cthd 
        JOIN hoadon
        ON cthd.mahd = cthd.mahd
        JOIN mathang
        ON cthd.mamh = mathang.mamh
        WHERE cthd.mamh = @mathang AND MONTH(ngaylap) = @thang
    )

    RETURN @soluongban
END

GO


SELECT DISTINCT mamh,MONTH(ngaylap), dbo.fc_soluongban(mamh,MONTH(ngaylap))
FROM hoadon
JOIN cthd
ON hoadon.mahd = cthd.mahd


GO

-- 10. Viết hàm fc_solanmuahang đếm số lần mua
-- hàng của khách hàng chỉ định.

CREATE FUNCTION cf_solanmuahang(@makh VARCHAR(5))
RETURNS INT AS
BEGIN 
    DECLARE @solanmuahang INT 
    SET @solanmuahang = 0

    SET @solanmuahang = (
        SELECT COUNT(mahd)
        FROM hoadon
        WHERE makh = @makh
    )

    RETURN @solanmuahang
END

GO

SELECT DISTINCT makh,DBO.cf_solanmuahang(makh)
FROM hoadon


--                                   DẠNG 2: PROCEDUCE(THỦ TỤC) 


-- 1. Viết thủ tục tính điểm trung bình theo từng
-- học kỳ với mã lớp chỉ định.

GO

CREATE PROCEDURE sp_tinhDTB (@hocKy tinyint,@malop varchar(5))
AS
    IF NOT EXISTS (
        SELECT *
        FROM sinhvien
        WHERE malop = @malop
    )
    BEGIN
        PRINT N'Lớp không có sinh viên'
        RETURN -1
    END
        SELECT sinhvien.masv,sinhvien.hodem,SUM(diem*stc)/SUM(stc) AS DTB
        FROM sinhvien 
        JOIN ketqua 
        ON sinhvien.masv = ketqua.masv
        JOIN hocphan
        ON ketqua.mahp = hocphan.mahp
        WHERE hocphan.hocky = @hocKy AND sinhvien.malop = @malop
        GROUP BY sinhvien.masv,sinhvien.hodem

GO

sp_tinhDTB 1,'PM22'



-- 2. Tạo thủ tục bổ sung dữ liệu cho bảng SinhVien.

GO 

CREATE PROCEDURE sp_bosungsinhvien(@masv varchar(5),@hodem varchar(20),@ten varchar(20),@ngaysinh date,@gioitinh int,
@noisinh nvarchar(30),@malop varchar(6))
AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    BEGIN 
        PRINT N'Mã sinh này đã tồn tại'
        RETURN -1
    END
    IF NOT EXISTS(
        SELECT *
        FROM lop
        WHERE malop = @malop
    )
    BEGIN 
        PRINT N'Lớp không tồn tại'
        RETURN -1
    END
    INSERT INTO sinhvien VALUES
    (@masv,@hodem,@ten,@ngaysinh,@gioitinh,@noisinh,@malop)
END


EXEC sp_bosungsinhvien '9042',N'Nguyễn Văn',
N'Thanh','2003-10-12',1,N'HCM','PM22'

GO

-- 3. Tạo thủ tục bổ sung dữ liệu cho bảng KetQua

CREATE PROCEDURE sp_bosungketqua(@masv varchar(5),@mahp varchar(10),@diem FLOAT)
AS 
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    BEGIN 
        PRINT N'Mã sinh viên không tồn tại'
        RETURN -1
    END
    IF NOT EXISTS(
        SELECT *
        FROM hocphan
        WHERE mahp = @mahp
    )
    BEGIN 
        PRINT N'Mã học phần không tồn tại'
        RETURN -1
    END
    
    INSERT INTO ketqua VALUES 
    (@masv,@mahp,@diem)

END

EXEC sp_bosungketqua '9042','001',9.0


-- 4. Viết thủ tục xóa sinh viên có mã chỉ định.
GO

CREATE PROCEDURE sp_xoaSV(@masv varchar(5))
AS 
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    BEGIN 
        PRINT N'Mã sinh viên không tồn tại'
        RETURN -1
    END

    DELETE FROM ketqua WHERE masv = @masv
    DELETE FROM sinhvien WHERE masv = @masv

END

EXEC sp_xoaSV '9042'

GO
--  5. Viết thủ tục cập nhật lại dữ liệu cho khoa có mã chỉ định.

CREATE PROCEDURE sp_capnhatkhoa(@makh varchar(5),@tenkhoa NVARCHAR(50),@dienthoai char(11))
AS 
BEGIN 
    IF NOT EXISTS(
        SELECT *
        FROM khoa
        WHERE makhoa = @makh
    )
    BEGIN
        PRINT N'Mã khoa không tồn tại'
        RETURN -1
    END

    UPDATE khoa
    SET tenkhoa = @tenkhoa, dienthoai = @dienthoai
    WHERE makhoa = @makh

END

GO

EXEC sp_capnhatkhoa 'CNTT','Khoa Công Nghệ Thông Tin','0961764559'


-- 6. Viết thủ tục cập nhật lại điểm có mã chỉ định.

GO

CREATE PROCEDURE sp_capnhatdiem(@masv varchar(5),@diem FLOAT)
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    BEGIN
        PRINT N'Mã khoa không tồn tại'
        RETURN -1
    END

    UPDATE ketqua
    SET diem = @diem
    WHERE masv = @masv

END

GO

EXEC sp_capnhatdiem '2405',9.0

GO


--  7. Viết thủ tục phân lớp thành 2 lớp A,B với điều
--  kiện là: Nếu Mã sinh viên là số lẻ thì là lớp A,
--  nếu Mã sinh viên là chẵn thì là lớp B.



CREATE PROCEDURE sp_phanlop(@masv varchar(5),@malop varchar(5))
AS
BEGIN

    DECLARE @Lop varchar(6)

    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv 
    )
    BEGIN 
        PRINT N'Mã sinh viên không tồn tại'
        RETURN -1
    END 
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE malop = @malop 
    )
    BEGIN 
        PRINT N'Mã lớp không tồn tại'
        RETURN -1
    END 
    
    SET @Lop = 
        CASE 
            WHEN CAST(RIGHT(@malop,2) AS INT) % 2 = 1 THEN N'Lớp A' 
            ELSE N'Lớp B'
        END
    

    SELECT masv,malop,@Lop AS Lop
    FROM sinhvien 
    WHERE masv = @masv AND malop = @malop

END

GO
sp_phanlop '2412','PM22'

GO

--  8. Viết thủ tục phân lớp thành A,B,C,D,.. bất kỳ
--  với số lượng lớp chỉ định. Phân lớp được quy
--  định như sau:
--  • Nếu Mã sinh viên chia cho số lớp dư 0 là
--  lớp ‘A’
--  • Nếu Mã sinh viên chia cho số lớp dư 1 là
--  lớp ‘B

CREATE PROCEDURE sp_phanlop_ABCD(@solop int ,@masv varchar(5))
AS 
BEGIN 

    DECLARE @lop VARCHAR(5)

    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE masv = @masv
    )
    BEGIN
        PRINT N'Mã sinh viên không tồn tại'
        RETURN -1
    END

    SET @lop = CHAR(65 + CAST(@masv AS int) % @solop)
    
    SELECT masv,@lop AS Lop
    FROM sinhvien
    WHERE masv = @masv

END


GO

sp_phanlop_ABCD 6,'2411'

GO

-- 9. Viết thủ tục hiển thị danh sách gồm mã sinh
-- viên, họ tên, mã lớp, mã học phần, điểm của
-- những sinh viên có điểm nhỏ hơn số chỉ định,
-- nếu không có thì hiển thị thông báo không có
-- sinh viên nào.


CREATE PROCEDURE sp_danhsachsinhvien(@diem FLOAT)
AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM ketqua
        WHERE diem < @diem
    )
    BEGIN 
        SELECT sinhvien.masv,hodem + ' ' + ten,malop,mahp,diem
        FROM sinhvien 
        JOIN ketqua
        ON sinhvien.masv = ketqua.masv
        WHERE diem < @diem
    END
    ELSE 
    BEGIN
        PRINT N'Không có sinh viên nào có điểm nhỏ hơn'

    END 
    
END

GO

sp_danhsachsinhvien 6.0

GO

--  10. Viết thủ tục hiển thị họ tên sinh viên chưa học
--  học phần có mã chỉ định. Kiểm tra mã học
--  phần có trong danh mục không, Nếu không có
--  thì hiển thị thông báo không có học phần này.

CREATE PROCEDURE sp_hienthihotensv(@mahp varchar(5))
AS 
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM hocphan
        WHERE mahp = @mahp
    )
    BEGIN
        PRINT N'Không có học phần này'
        RETURN -1
    END
    
    SELECT hodem + ' ' +  ten AS HoTen
    FROM sinhvien
    WHERE NOT EXISTS(
        SELECT 1
        FROM ketqua
        WHERE ketqua.masv = sinhvien.masv AND ketqua.mahp = @mahp
    )
    
END

GO

sp_hienthihotensv '007' 

GO


--  11. Viết thủ tục hiển thị danh sách gồm: mã sinh
--  viên, họ tên, mã lớp, ngày sinh (dd/mm/yyyy),
--  giới tính (Nam, Nữ), tuổi của những sinh viên
-- có tuổi trong khoảng chỉ định. Nếu không có
--  thì hiển thị thông báo không có sinh viên nào


CREATE PROCEDURE sp_danhsachngaysinh(@ngaysinh date)
AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM sinhvien
        WHERE ngaysinh BETWEEN @ngaysinh AND @ngaysinh
    )
    BEGIN 
        SELECT sinhvien.masv,hodem + ' ' + ten AS HoTen,malop,ngaysinh,
        CASE gioitinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END, YEAR(GETDATE()) - YEAR(@ngaysinh) AS Tuoi    
        FROM sinhvien 
        WHERE ngaysinh BETWEEN @ngaysinh AND @ngaysinh
    END
    ELSE 
    BEGIN
        PRINT N'Không có sinh viên nào '

    END 

END

GO

sp_danhsachngaysinh '2003-09-26'

GO


--  12. Viết thủ tục cho biết mã khoa, tên khoa, tổng
--  số sinh viên của khoa chỉ định. Kiểm tra điều
--  kiện mã khoa có trong bảng danh mục không.


CREATE PROCEDURE sp_tongsinhvien(@makhoa VARCHAR(10))
AS
BEGIN
    
    IF NOT EXISTS(
        SELECT *
        FROM khoa
        WHERE makhoa = @makhoa
    )
    BEGIN

        PRINT N'Không có sinh viên nào'
        RETURN -1
    
    END
    ELSE
    BEGIN 
        
        SELECT COUNT(sv.masv) AS soluongsinhvien, khoa.makhoa  
        FROM khoa
        JOIN nganh AS N
        ON khoa.makhoa = n.makhoa
        JOIN lop AS L
        ON L.manganh = N.manganh
        JOIN sinhvien AS sv
        ON L.malop = sv.malop
        WHERE khoa.makhoa = @makhoa
        GROUP BY khoa.makhoa

    END
        
END


GO

sp_tongsinhvien 'HH'


--  13. Viết thủ tục cho biết mã lớp, tên lớp, tổng số
--  sinh viên mỗi lớp của khoa có mã chỉ định,
--  Kiểm tra điều kiện mã khoa có trong bảng danh
--  mục không, Nếu không có thì hiển thị thông
--  báo Không có lớp này.
GO

CREATE PROCEDURE sp_sinhvienmoilopkhoa(@makhoa varchar(5))
AS 
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM khoa
        WHERE makhoa = @makhoa
    )
    BEGIN
        PRINT N'Không có mã khoa này'
        RETURN -1
    END

    SELECT L.malop,L.tenlop,COUNT(sinhvien.masv) AS TongSinhVien
    FROM sinhvien
    JOIN lop AS L
    ON sinhvien.malop = L.malop
    JOIN nganh AS N
    ON L.manganh = N.manganh
    WHERE NOT EXISTS(
        SELECT 1
        FROM khoa
        WHERE khoa.makhoa = @makhoa AND N.makhoa = N.manganh
    )
    GROUP BY L.malop,L.tenlop
END

GO

sp_sinhvienmoilopkhoa 'CNTT'

GO


--  14. Viết thủ tục tính điểm trung bình từng học kỳ
--  theo từng sinh viên của lớp có mã chỉ định.


CREATE PROCEDURE sp_tinhDTBHK(@malop nvarchar(5))
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE malop = @malop
    )
    BEGIN 
        PRINT N'Không có lớp tồn tại'
        RETURN -1
    END

    SELECT SV.masv, SUM(K.diem*HP.stc)/SUM(HP.stc) AS DTB, HP.hocky,SV.malop
    FROM sinhvien AS SV 
    JOIN ketqua AS K 
    ON SV.masv = K.masv
    JOIN hocphan AS HP
    ON K.mahp = HP.mahp
    WHERE SV.malop = @malop
    GROUP BY SV.masv,HP.hocky,SV.malop

END

GO

sp_tinhDTBHK 'DL24'

GO


--  15. Viết thủ tục hiển thị danh sách gồm: mã sinh
--  viên, họ tên, mã lớp, mã khoa, ngày sinh (định
--  dạng dd/mm/yyyy), giới tính (Nam, Nữ) của
--  những sinh viên ở khoa có mã chỉ định, nếu
--  không có thì hiển thị thông báo Không có sinh
--  viên nào.

CREATE PROCEDURE sp_sinhvienmokhoa(@makhoa varchar(5))
AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM khoa
        WHERE makhoa = @makhoa
    )
    BEGIN
        SELECT sinhvien.masv,sinhvien.hodem + ' ' + sinhvien.ten AS HoTen, L.malop,
        K.makhoa, sinhvien.ngaysinh, CASE sinhvien.gioitinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END   
        FROM sinhvien 
        JOIN lop AS L
        ON sinhvien.malop = L.malop
        JOIN nganh AS N
        ON L.manganh = N.manganh
        JOIN khoa AS K
        ON N.makhoa = N.makhoa
        WHERE K.makhoa = @makhoa 
    END
    ELSE
    BEGIN
        PRINT N'Không có sinh viên nào'
        RETURN -1
    END

END

GO

sp_sinhvienmokhoa 'HH'

GO


--  16. Viết thủ tục cho biết mã sinh viên, họ tên của
--  những sinh viên học lớp có mã chỉ định.

CREATE PROCEDURE sp_hienthimasvhoten(@malop nvarchar(5))
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE malop = @malop
    )
    BEGIN 
        PRINT N'Không có lớp tồn tại'
        RETURN -1
    END

    SELECT SV.masv, SV.hodem + ' ' + SV.ten AS hoten, SV.malop
    FROM sinhvien AS SV 
    WHERE SV.malop = @malop

END

GO

sp_hienthimasvhoten 'DL24'

GO

--  17. Viết thủ tục cho biết họ tên sinh viên không có
--  điểm dưới 8 ở lớp có mã chỉ định.

CREATE PROCEDURE sp_hienthihotentheodiem(@malop nvarchar(5))
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM sinhvien
        WHERE malop = @malop
    )
    BEGIN 
        PRINT N'Không có lớp tồn tại'
        RETURN -1
    END

    SELECT SV.masv, SV.hodem + ' ' + SV.ten AS hoten, SV.malop,K.diem
    FROM sinhvien AS SV 
    JOIN ketqua AS K
    ON SV.masv = K.masv
    WHERE SV.malop = @malop AND diem > 8

END

GO

sp_hienthihotentheodiem 'DL24'

GO



--                          Bài Tập tự giải


--  1. Viết thủ tục hiển thị danh các khách hàng đã
--  mua hàng trong ngày chỉ định.


CREATE PROCEDURE sp_hienthiKHmua(@ngaylap date)
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM hoadon 
        WHERE ngaylap = @ngaylap
    )
    BEGIN 
        SELECT kh.makh,h.ngaylap
        FROM khachhang as kh
        JOIN hoadon as h 
        ON kh.makh = h.makh
        WHERE h.ngaylap = @ngaylap
    END
    ELSE 
    BEGIN
        PRINT N'Ngày không tồn tại'
        RETURN -1
    END
END

GO

sp_hienthiKHmua '2024-01-20'

GO



--  2. Viết thủ tục hiển thị danh sách 5 khách hàng
--  có tổng trị giá các đơn hàng lớn nhất


CREATE PROCEDURE sp_tongtrigialonnhat
AS 
BEGIN 
    SELECT TOP 5 k.makh, SUM(gia*soluong) AS tonggiatri
    FROM khachhang as k
    JOIN hoadon as h
    ON k.makh = h.makh
    JOIN cthd as c
    ON h.mahd = c.mahd
    JOIN mathang as m
    ON c.mamh = m.mamh
    GROUP BY k.makh
    ORDER BY tonggiatri DESC
END

GO

sp_tongtrigialonnhat

GO


--  3. Viết thủ tục hiển thị danh sách 10 mặt hàng có
--  số lượng bán lớn nhất.


CREATE PROCEDURE sp_soluongbanlonnhat
AS
BEGIN 

    SELECT TOP 10 m.mamh
    FROM mathang AS m
    JOIN cthd AS c
    ON m.mamh = c.mamh
    ORDER BY c.soluong DESC 

END

GO

sp_soluongbanlonnhat

GO


--  4. Viết thủ tục cập nhật loại khách hàng là VIP
--  nếu tổng thành tiền trong năm lớn hơn hoặc
--  bằng 10 triệu.


CREATE PROCEDURE sp_loaikhachhang
AS
BEGIN 
    
    UPDATE khachhang 
    SET loaikh = 'VIP'
    FROM khachhang 
    JOIN (

        SELECT k.makh
        FROM khachhang as k
        JOIN hoadon as h
        ON k.makh = h.makh
        JOIN cthd as c
        ON h.mahd = c.mahd
        JOIN mathang as m
        ON c.mamh = m.mamh
        WHERE YEAR(ngaylap) = '2024'
        GROUP BY k.makh
        HAVING SUM(gia*soluong) > 10000000
   
    ) AS T
    ON khachhang.makh = T.makh

END


GO

sp_loaikhachhang 

GO


--  5. Viết thủ tục thêm vào một hóa đơn vào bảng
--  HoaDon với tham số truyền vào là mahd, makh
--  và ngaylap. Kiểm tra ngày lập hóa đơn phải
--  lớn hơn ngày hiện tại và ràng buộc makh.


CREATE PROCEDURE sp_themhoadon(@mahd varchar(5),@makh varchar(5),@ngaylap date)
AS 
BEGIN

    IF  @ngaylap <= GETDATE()
    BEGIN
        PRINT N'Ngày lập hóa đơn phải lớn hơn hoặc bằng hiện tại'
        RETURN      
    END

    IF EXISTS(
        SELECT *
        FROM hoadon
        WHERE mahd = @mahd
    )
    BEGIN
        PRINT N'Mã hóa đơn đã tồn tại'
        RETURN 
    END
    
    IF NOT EXISTS(
        SELECT *
        FROM khachhang
        WHERE makh = @makh
    )
    BEGIN 
        PRINT N'Mã khách hàng không tồn tại'
        RETURN
    END
    
    INSERT INTO hoadon VALUES(@mahd,@makh,@ngaylap)
    PRINT N'Thêm thành công'

END

GO

sp_themhoadon 'HD88','KH01','2024-03-20'

GO


--  6. Viết thủ tục cập nhật giá của một mặt hàng.

CREATE PROCEDURE sp_capnhatgia(@mamh varchar(5),@tenmh nvarchar(50),@dvt nvarchar(20),@gia int)
AS 
BEGIN 
    IF EXISTS(
        SELECT *
        FROM cthd
        WHERE mamh = @mamh
    )
    BEGIN
        UPDATE mathang
        SET tenmh = @tenmh,dvt =@dvt , gia = @gia
        WHERE mamh = @mamh
    END
    ELSE
    BEGIN   
        PRINT N'Mã mặt hàng không tồn tại'
        RETURN
    END
    

    PRINT N'Sửa thành công'
END


GO

sp_capnhatgia 'MH02',N'Sữa đặc ông thọ',N'hộp','25000'

GO

-- 7. Viết thủ tục liệt kê các hóa đơn có mua mặt
--  hàng có tham số truyền vào là mã mặt hàng.


CREATE PROCEDURE sp_lietkehoadon(@mamh varchar(5))
AS
BEGIN 
    IF EXISTS (
        SELECT *
        FROM mathang
        WHERE mamh = @mamh
    )
    BEGIN 
        SELECT DISTINCT hoadon.mahd
        FROM mathang 
        JOIN cthd
        ON mathang.mamh = cthd.mamh
        JOIN hoadon
        ON hoadon.mahd = cthd.mahd
    END
    ELSE 
    BEGIN
        PRINT N'Mã mặt hàng không tồn tại'
        RETURN
    END

END

GO

sp_lietkehoadon 'MH01'

GO


--  8. Viết thủ tục tìm mặt hàng bán chạy nhất.

CREATE PROCEDURE sp_timmathang
AS
BEGIN
    
    SELECT mathang.mamh,COUNT(cthd.mahd) AS soluonghoadon
    FROM mathang
    JOIN cthd
    ON mathang.mamh = cthd.mamh
    GROUP BY mathang.mamh
    ORDER BY soluonghoadon DESC 

END

GO

sp_timmathang 

GO


--  9. Viết thủ tục tính tổng doanh thu của các hóa
--  đơn trong một ngày bất kỳ.

CREATE PROCEDURE sp_tinhtongdoanhthu (@ngaylap date = NULL)
AS 
BEGIN
    IF EXISTS(
        SELECT *
        FROM hoadon 
        WHERE ngaylap = @ngaylap
    )
    BEGIN 
        
        SELECT H.mahd,SUM(M.gia * C.soluong) AS tongdoanhthu
        FROM hoadon AS H
        JOIN cthd AS C
        ON C.mahd = H.mahd
        JOIN mathang AS M
        ON C.mamh = M.mamh
        WHERE H.ngaylap = @ngaylap
        GROUP BY H.mahd
    
    END
    ELSE 
    BEGIN
        PRINT N'Ngày lập hóa đơn không tồn tại'
        RETURN
    END

END

GO

sp_tinhtongdoanhthu '2024-01-22'

GO

--  10. Viết thủ tục tính tổng số lượng mặt hàng của
--  mỗi hóa đơn.


CREATE PROCEDURE sp_tongsoluongmathang
AS
BEGIN
    SELECT H.mahd,SUM(C.soluong)
    FROM hoadon AS H
    JOIN cthd AS C
    ON C.mahd = H.mahd
    JOIN mathang AS M
    ON C.mamh = M.mamh
    GROUP BY H.mahd
END

GO

sp_tongsoluongmathang

GO

--  11. Viết thủ tục tính trị giá cho mỗi hoá đơn.

CREATE PROCEDURE sp_trigiamoiHD
AS
BEGIN
        SELECT H.mahd,SUM(M.gia * C.soluong) AS tongdoanhthu
        FROM hoadon AS H
        JOIN cthd AS C
        ON C.mahd = H.mahd
        JOIN mathang AS M
        ON C.mamh = M.mamh
        GROUP BY H.mahd
END

GO

sp_trigiamoiHD

GO


--  12. Viết thủ tục với tùy chọn WITH ENCRYPTION,
--  mã hóa không cho người dùng xem được nội
--  dung của thủ tục.

CREATE PROCEDURE sp_mahoa
WITH ENCRYPTION
AS
BEGIN
    SELECT H.mahd,SUM(M.gia * C.soluong) AS tongdoanhthu
        FROM hoadon AS H
        JOIN cthd AS C
        ON C.mahd = H.mahd
        JOIN mathang AS M
        ON C.mamh = M.mamh
        GROUP BY H.mahd

    PRINT N'Đây là một thủ tục đã được mã hóa'
END

GO

sp_mahoa

GO





--                                              DẠNG 3 : TRIGGER




--  1. Tạo trigger để kiểm tra tính hợp lệ của dữ liệu
--  được nhập vào một bảng SinhVien là dữ liệu
--  masv là không rỗng


CREATE TRIGGER trg_themSV
ON sinhvien
FOR INSERT AS
IF ((SELECT masv FROM inserted) = '')
BEGIN 
    PRINT N'Mã sinh viên phải được nhập'
    ROLLBACK TRANSACTION
END


--  2. Thực hiện việc kiểm tra rằng buộc khoá ngoại
--  trong bảng SinhVien là mã lớp phải tồn tại
--  trong bảng Lop.

GO

CREATE TRIGGER trg_kiemtra_malop_themSV
ON sinhvien
FOR INSERT AS
    IF NOT EXISTS(
        SELECT *
        FROM lop,inserted
        WHERE lop.malop = inserted.malop
    )
    BEGIN
        PRINT N'Mã lớp không có trong danh mục'
        ROLLBACK TRANSACTION
    END

GO


--  3. Tạo trigger khi thêm một sinh viên trong bảng
--  SinhVien ở một lớp nào đó thì cột siso của
--  lớp đó trong bảng Lop tự động tăng lên 1. Đảm
--  bảo tính toàn vẹn dữ liệu khi thêm một sinh
--  viên mới trong bảng SinhVien thì sinh viên đó
--  phải có mã lớp trong bảng Lop


ALTER TABLE lop 
ADD siso INT


UPDATE lop
SET siso = 0

GO

CREATE TRIGGER trg_kiemtra_siso_themSV
ON sinhvien
FOR INSERT AS
    IF NOT EXISTS(
        SELECT *
        FROM lop,inserted
        WHERE lop.malop = inserted.malop 
    )
    BEGIN
        ROLLBACK TRANSACTION
    END
    ELSE
        UPDATE lop 
        SET lop.siso = lop.siso + 1
        FROM inserted
        WHERE lop.malop = inserted.malop


INSERT INTO sinhvien(masv,malop) VALUES(1414114,'DL24')


-- 4. Tạo trigger không cho phép xóa các sinh viên
--  ở lớp PM24
GO

CREATE TRIGGER trg_xoaSV
ON sinhvien
FOR DELETE AS
    IF NOT EXISTS(
        SELECT *
        FROM deleted
        WHERE malop = 'PM24'
    )
    BEGIN 
        PRINT N'Không thể xóa sv lớp PM24'
        ROLLBACK TRANSACTION
    END


GO


--  5. Tạo trigger không cho phép xóa nhiều hơn hai
--  lớp trong bảng Lop

CREATE TRIGGER trg_xoaLop
ON lop
FOR DELETE AS
    IF ((SELECT * 
        FROM deleted ) > 2)
    BEGIN 
        PRINT N'Không thể xóa hơn 2 lớp'
        ROLLBACK TRANSACTION
    END

GO


--  6. Tạo trigger sao cho khi xóa một sinh viên mới
--  từ bảng SinhVien thì sỉ số của lớp tương ứng
--  trong bảng Lop tự động giảm xuống 1.

CREATE TRIGGER trg_xoaSV_siso_lop
ON sinhvien
FOR DELETE AS
    IF NOT EXISTS(
        SELECT *
        FROM lop,deleted
        WHERE lop.malop = deleted.malop
    )
    ROLLBACK TRANSACTION
    ELSE 
        UPDATE lop
        SET siso = siso - 1
        FROM deleted 
        WHERE lop.malop = deleted.malop


GO
-- 7. Tạo trigger kiểm tra điều kiện cho cột điểm là <= 10.

CREATE TRIGGER trg_kiemtra_diem
ON ketqua 
FOR INSERT, UPDATE AS
    IF EXISTS (
        SELECT * 
        FROM inserted 
        WHERE diem <= 10
    )
    BEGIN 
        PRINT N'Điểm phải dưới 10'
        ROLLBACK TRANSACTION  
    END

GO
-- 8. Tạo trigger bẫy lỗi cho khoá ngoại của bảng
--  SinhVien khi chỉnh sửa.

CREATE TRIGGER trg_bayloi_SVchinhsua
ON sinhvien
FOR UPDATE AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM inserted 
        JOIN deleted ON inserted.masv = deleted.masv
        LEFT JOIN lop ON inserted.malop = lop.malop
        WHERE lop.malop IS NULL
    )
    BEGIN
        PRINT N'Không thể chỉnh sửa vì bản ghi trong sinhvien có tham chiếu đến bảng khác'
        ROLLBACK TRANSACTION
    END
END


--  9. Tạo trigger sao cho khi cập nhật mã lớp một
--  sinh viên trong bảng SinhVien thì sỉ số của lớp
--  tương ứng trong bảng Lop tự động thay đổi.
GO

CREATE TRIGGER trg_capnhatsisoSV_lop
ON sinhvien
FOR UPDATE AS
BEGIN
    
    UPDATE lop 
    SET siso = (
        SELECT COUNT(*) 
        FROM inserted
        WHERE lop.malop = inserted.malop 
    )
    FROM lop
    JOIN inserted 
    ON lop.malop = inserted.malop

END


-- 10. Tạo trigger sao cho khi sửa mã lớp những sinh
--  viên trong bảng SinhVien thì sỉ số của lớp
--  tương ứng trong bảng Lop tự động thay đổi.

GO


CREATE TRIGGER trg_suamaLOP_siso
ON sinhvien
FOR UPDATE AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM lop, inserted
        WHERE lop.malop = inserted.malop
    )
    ROLLBACK TRANSACTION
    ELSE 
        UPDATE lop
        SET siso = (
            SELECT *
            FROM sinhvien
            WHERE sinhvien.malop = lop.malop
        ) 
        FROM lop
        JOIN inserted ON lop.malop = inserted.malop

END

--                            BÀI TẬP TỰ GIẢI


GO
--  1. Tạo trigger kiểm tra rằng buộc khoá ngoại ở
--  bảng HoaDon và CTHD.

CREATE TRIGGER trg_rangbuoc_hd_cthd
ON hoadon
FOR INSERT,UPDATE AS
BEGIN
    IF NOT EXISTS(
    SELECT *
    FROM cthd,inserted
    WHERE cthd.mahd = inserted.mahd
    )
    BEGIN
        PRINT N'Mã hóa đơn không có trong danh mục'
        ROLLBACK TRANSACTION
    END
END


GO
--  2. Tạo trigger không cho phép cascade delete trong
--  các rằng buộc khoá ngoại. Ví dụ không cho
--  phép xóa các chi tiết hóa đơn nào có số hóa
--  đơn còn trong bảng HoaDon.

CREATE TRIGGER trg_khongchophepxoa
ON hoadon
INSTEAD OF DELETE AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM cthd
        WHERE mahd IN (SELECT mahd FROM deleted)
    )
    BEGIN
        RAISERROR('Không được phép xóa hóa đơn có CTHD',16,1)
        ROLLBACK TRANSACTION
    END
    ELSE 
    BEGIN
        DELETE FROM hoadon WHERE mahd IN(SELECT mahd FROM deleted)
    END

END


--  3. Tạo trigger không cho phép người dùng nhập
--  vào hai mặt hàng có cùng tên.
GO

CREATE TRIGGER trg_check_mathang
ON mathang
FOR INSERT,UPDATE AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM mathang,inserted
        WHERE mathang.mamh = inserted.mamh
    )
    BEGIN
        PRINT N'Mặt hàng này đã tồn tại'
        ROLLBACK TRANSACTION
    END

END


GO
--  4. Tạotrigger không cho phép người dùng xóa một
--  lúc nhiều hơn một mặt hàng.

CREATE TRIGGER sp_check_xoamathang
ON mathang
FOR DELETE AS
BEGIN
    IF (( SELECT COUNT(*) FROM deleted) > 1)
    BEGIN 
        PRINT N'Không thể xóa nhiều hơn 1 mặt hàng'
        ROLLBACK TRANSACTION
    END
END



GO
-- 5. Tạo trigger chỉ cho phép bán mặt hàng sữa với
--  số lượng là bội số của 10.


CREATE TRIGGER trg_check_soluong_bansua
ON mathang
FOR INSERT AS
BEGIN
    DECLARE @soluongban INT
    
    SELECT @soluongban = COUNT(*) 
    FROM cthd,inserted 
    WHERE inserted.mamh LIKE '%Sữa%' AND  cthd.soluong % 10 != 0 
    AND cthd.mamh = inserted.mamh 

    IF @soluongban > 0
    BEGIN 
        PRINT N'Số lượng bán mặt hàng sữa phải là bội số của 10'
        ROLLBACK TRANSACTION
    END
    ELSE 
    BEGIN
        INSERT INTO cthd (mahd,mamh,soluong)
        SELECT mamh,tenmh,dvt,gia
        FROM inserted
    END

END


-- 6. Tạo trigger bắt lỗi khi thêm bản ghi vào bảng
--  CTHD. Kiểm tra mã mặt hàng có tồn tại không,
--  không cho phép nhập số lượng âm.
GO

CREATE TRIGGER trg_checkmathang_soluong
ON cthd
FOR INSERT AS
BEGIN 
    IF NOT EXISTS(
        SELECT *
        FROM mathang,inserted    
        WHERE mathang.mamh = inserted.mamh AND inserted.soluong > 0
    )
    BEGIN
        PRINT N'Số lượng bán phải lớn hơn 0 và mặt hàng phải có trong bảng mặt hàng'
        ROLLBACK TRANSACTION
    END
END



--  7. Tạo trigger cho lệnh xóa của bảng MatHang.
--  Khi xóa một mặt hàng thì tự động xóa trong
--  các bảng có liên quan.
GO

CREATE TRIGGER trg_xoaMatHang
ON mathang
FOR DELETE AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM cthd
        WHERE cthd.mamh IN (SELECT mamh FROM deleted)
    )
    BEGIN
        DELETE FROM cthd WHERE mamh IN (SELECT mamh FROM deleted)
    END

    DELETE FROM mathang WHERE mamh IN(SELECT mamh FROM deleted)

END 




--  8. Tạo trigger trong bảng MatHang kiểm tra đơn
--  vị tính chỉ có thể là lốc, lon, gói và hộp.
GO

CREATE TRIGGER trg_check_dvt
ON mathang
FOR INSERT,UPDATE AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM inserted
        WHERE dvt NOT IN ('lốc','lon','gói','hộp')
    )
    BEGIN 
        PRINT N'Đơn vị tính phải là lốc, lon, gói, hộp '
        ROLLBACK TRANSACTION
    END

END


--  9. Tạo trigger bắt lỗi số điện thoại trong bảng
--  KhachHang. Số điện thoại phải gồm 10 số và
--  bắt đầu bằng ’01’ hoặc ’03’.
GO


CREATE TRIGGER trg_check_sdt
ON khachhang
FOR INSERT, UPDATE AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM inserted
        WHERE LEN(sdt) <> 10 AND (LEFT(sdt,2) NOT IN ('03','01'))
    )
    BEGIN
        PRINT N'Số điện thoại phải gồm 10 số vàbắt đầu bằng 01 hoặc 03'
        ROLLBACK TRANSACTION
    END
END



--  10. Tạo trigger cập nhật loại khách hàng là VIP
--  nếu tổng thành tiền trong năm lớn hơn hoặc
--  bằng 10 triệu.
GO

CREATE TRIGGER trg_update_loaikhachhang
ON khachhang
FOR INSERT, UPDATE AS
BEGIN
    DECLARE @nam INT,@makh VARCHAR(5)

    SET @nam = YEAR(GETDATE())

    UPDATE khachhang
    SET loaikh = 'Vip'
    FROM khachhang
    JOIN (
        SELECT hoadon.makh, SUM(mathang.gia * cthd.soluong) AS tongthanhtien
        FROM hoadon
        JOIN cthd 
        ON hoadon.mahd = cthd.mahd
        JOIN mathang
        ON cthd.mamh = mathang.mamh
        GROUP BY hoadon.makh
    ) AS Tongthanhtien 
    ON khachhang.makh = Tongthanhtien.makh
    WHERE Tongthanhtien.tongthanhtien >= 10000000

END



--                                     DẠNG 4: CON TRỎ (CURSOR)



-- 1. Tạo thủ tục đánh Số báo danh theo từng lớp chỉ định.


ALTER TABLE sinhvien ADD SBD varchar(4)
GO


CREATE PROCEDURE sp_danhSBD(@malop char(4))
AS
BEGIN
    DECLARE curSBD CURSOR FOR
    SELECT masv
    FROM sinhvien 
    WHERE malop = @malop
    ORDER BY malop 


    OPEN curSBD
    DECLARE @masv char(4),@i int = 1
    FETCH NEXT FROM curSBD INTO @masv
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE sinhvien 
        SET SBD = RIGHT('0000' + LTRIM(STR(@i)),4)
        WHERE masv = @masv
        FETCH NEXT FROM curSBD INTO @masv
        SET @i = @i + 1
    END

    CLOSE curSBD
    DEALLOCATE curSBD

END

GO


-- 2. Tạo thủ tục đánh số báo danh tự động, khi sang
--  lớp mới thì SBD đánh lại từ đầu.

CREATE PROCEDURE sp_danhSBD_Lop
AS
    DECLARE curSBD CURSOR FOR
    SELECT masv,malop
    FROM  sinhvien
    ORDER BY malop


    OPEN curSBD
    DECLARE @masv char(4),@i int 
    DECLARE @malop char(4),@lop CHAR(4)
    FETCH NEXT FROM curSBD INTO @masv,@malop
    WHILE @@FETCH_STATUS = 0
    BEGIN 
        SET @lop = @malop
        SET @i =  1
        WHILE @malop = @lop AND @@FETCH_STATUS = 0
        BEGIN 
            UPDATE sinhvien 
            SET SBD =  RIGHT('0000' + LTRIM(STR(@i)),4)
            WHERE masv = @masv 
            FETCH NEXT FROM curSBD
            INTO @masv,@malop
            SET @i = @i + 1
        END
    
    END

    CLOSE curSBD
    DEALLOCATE curSBD


--  3. Tạo thủ tục cập nhật mã thẻ sinh viên với công
--  thức như sau: MaThe = Năm nhập học (2 chữ
--  số) + Mã Ngành (6 chữ số) + Số thứ tự.

GO

CREATE PROCEDURE sp_theSV(@manganh varchar(4), @namnhaphoc char(4))
AS
    DECLARE curMaSV CURSOR FOR
    
    SELECT masv,manganh,lop.malop
    FROM sinhvien 
    JOIN lop
    ON sinhvien.malop = lop.malop 
    WHERE manganh = @manganh AND nam = @namnhaphoc
    
    OPEN curMaSV
    DECLARE @masv char(4), @i int = 1
    FETCH NEXT FROM curMaSV INTO @masv, @manganh , @namnhaphoc
    WHILE @@FETCH_STATUS = 0
    
    BEGIN 
        UPDATE sinhvien 
        SET masv = RIGHT(@namnhaphoc,2) + @manganh + RIGHT('0000' + LTRIM(STR(@i)),4)
        WHERE masv = @masv
        FETCH NEXT FROM curMaSV INTO @masv,@manganh,@namnhaphoc
        SET @i = @i + 1
    END

    CLOSE curMaSV
    DEALLOCATE curMaSV




-- 4. Tạo thủ tục phân lớp thành 2 lớp A,B với tỉ lệ
--  nam, nữ như nhau, mã lớp là tham số truyền
--  vào chỉ định.

GO

CREATE PROCEDURE sp_phanlopAB(@malop char(4))
AS
    DECLARE curPL CURSOR FOR
    SELECT masv
    FROM  sinhvien
    WHERE malop = @malop


    OPEN curPL
    DECLARE @i int = 1
    FETCH NEXT FROM curPL WHILE @@FETCH_STATUS = 0
    BEGIN 
        IF @i % 2 = 0
            UPDATE sinhvien 
            SET phanlop  = @malop + 'A'
            WHERE CURRENT OF curPL
        ELSE
            UPDATE sinhvien 
            SET phanlop = @malop + 'B'
            WHERE  CURRENT OF curPL

        SET @i = @i + 1
        FETCH NEXT FROM curPL
    
    END

    CLOSE curPL
    DEALLOCATE curPL    



-- 5. Tạo thủ tục phân lớp với số lượng lớp chỉ định
--  và tỉ lệ nam, nữ như nhau.
GO

CREATE PROCEDURE sp_phanlopAB2(@malop char(4), @solop int)
AS 
    DECLARE curPL CURSOR FOR
    SELECT masv
    FROM sinhvien 
    WHERE  malop = @malop

    OPEN curPL 
    DECLARE @i int = 1, @j int
    DECLARE @chuoi char (5) = 'ABCDEF'
    FETCH NEXT FROM curPL 
    WHILE @@FETCH_STATUS = 0
    BEGIN 
        SET @j = @i % @solop
        BEGIN
            UPDATE sinhvien 
            SET phanlop = @malop + SUBSTRING(@chuoi,@j+1,1)
            WHERE CURRENT OF curPL
            SET @i = @i + 1
            FETCH NEXT FROM curPL
        END
    END

    CLOSE curPL 
    DEALLOCATE curPL

    
GO

--                 DẠNG 5: TỔNG HỢP BÀI TẬP


--  1. Dựa trên cơ sở dữ liệu ở bài tập chương 4, thực hiện
--  các yêu cầu sau:


--  1.1 Tạo thủ tục lưu trữ để thông qua thủ tục này
--  có thể bổ sung thêm một bản ghi mới cho bảng
--  MatHang (thủ tục phải thực hiện kiểm tra tính
--  hợp lệ của dữ liệu cần bổ sung: không trùng
--  khóa chính và đảm bảo toàn vẹn tham chiếu)

CREATE PROCEDURE sp_luutru(@mamh varchar(5),@tenmh varchar(50),@dvt varchar(20),@gia INT)
AS  
BEGIN
    IF EXISTS(
        SELECT *
        FROM mathang
        WHERE mamh = @mamh
    )
    BEGIN
        PRINT N'Mã mặt hàng đã tồn tại'
        RETURN 
    END
    ELSE
    BEGIN
        INSERT INTO mathang VALUES (@mamh,@tenmh,@dvt,@gia)
    END  

    PRINT N'Thêm thành công'

END



--  1.2 Tạo thủ tục lưu trữ có chức năng thống kê tổng
--  số lượng hàng bán được của một mặt hàng có
--  mã bất kỳ (mã mặt hàng cần thống kê là tham
--  số của thủ tục).
GO

CREATE PROCEDURE sp_thongke_tongsoluong(@mamh varchar(5))
AS
BEGIN
    
    IF NOT EXISTS(
        SELECT *
        FROM mathang
        WHERE mamh = @mamh
    )
    BEGIN
        PRINT N'Mã mặt hàng không tồn tại'
        RETURN 
    END
    ELSE 
    BEGIN

        SELECT mathang.mamh,SUM(cthd.soluong)
        FROM mathang
        JOIN cthd
        ON mathang.mamh = cthd.mamh
        WHERE mathang.mamh = @mamh
        GROUP BY mathang.mamh 

    END

END


GO
-- 1.3 Viết hàm trả về một bảng trong đó cho biết
--  tổng số lượng hàng bán được của mỗi mặt hàng.
--  Sử dụng hàm này để thống kê xem tổng số
--  lượng hàng (hiện có và đã bán) của mỗi mặt
--  hàng là bao nhiêu.


CREATE FUNCTION fc_soluongban_banhang(@mathang VARCHAR(5))
RETURNS INT AS
BEGIN 

    DECLARE @soluongban INT
    SET @soluongban = 0
    
    SET @soluongban = (
        SELECT SUM(soluong)
        FROM cthd 
        JOIN hoadon
        ON cthd.mahd = cthd.mahd
        JOIN mathang
        ON cthd.mamh = mathang.mamh
        WHERE cthd.mamh = @mathang 
    )

    RETURN ISNULL (@soluongban,0)
END

GO

-- 1.4 Viết trigger cho bảng ChiTietDatHang theo yêu
--  cầu sau:

--  • Khi một bản ghi mới được bổ sung vào
--  bảng này thì giảm số lượng hàng hiện có
--  nếu số lượng hàng hiện có lớn hơn hoặc
--  bằng số lượng hàng được bán ra. Ngược lại
--  thì huỷ bỏ thao tác bổ sung.

--  • Khi cập nhật lại số lượng hàng được bán,
--  kiểm tra số lượng hàng được cập nhật lại
--  có phù hợp hay không (số lượng hàng bán
--  ra không được vượt quá số lượng hàng hiện
--  có và không được nhỏ hơn 1). Nếu dữ liệu
--  hợp lệ thì giảm (hoặc tăng) số lượng hàng
--  hiện có trong công ty, ngược lại thì huỷ bỏ
--  thao tác cập nhật.


CREATE TRIGGER trg_bosungbang
ON cthd
FOR INSERT,UPDATE AS
BEGIN

    DECLARE @mamh VARCHAR(5)
    DECLARE @soluong_moi INT
    DECLARE @soluong_hientai INT
    DECLARE @soluong_banra INT

    SELECT @mamh = mamh, @soluong_moi = soluong
    FROM inserted 


    SELECT soluong = @soluong_hientai
    FROM cthd 
    WHERE mamh = @mamh

    SET @soluong_banra  = (
        SELECT SUM(soluong) 
        FROM cthd
        JOIN hoadon 
        ON cthd.mahd = hoadon.mahd
        JOIN mathang
        ON mathang.mamh = hoadon.mahd
        GROUP BY mathang.mamh
    )

    IF EXISTS(
        SELECT *
        FROM inserted
    )
    BEGIN
        IF @soluong_hientai >= @soluong_banra + @soluong_moi
       
        BEGIN
            UPDATE cthd 
            SET soluong = soluong - @soluong_moi
            WHERE mamh = @mamh
        END
    
        ELSE 
        BEGIN
            ROLLBACK TRANSACTION
        END
    END
    ELSE 
    BEGIN
        IF @soluong_hientai >= @soluong_moi AND @soluong_moi >= 1
        BEGIN
            UPDATE cthd
            SET soluong = soluong - (@soluong_moi - @soluong_banra)
            WHERE mamh = @mamh
        END
        ELSE 
        BEGIN
            ROLLBACK TRANSACTION
        END       
    END  


END


--  1.5 Viết trigger cho bảng ChiTietDatHang để sao
--  cho chỉ chấp nhận giá hàng bán ra phải nhỏ hơn
--  hoặc bằng giá gốc (giá trong bảng MatHang).
GO

CREATE TRIGGER trg_check_hangbanra
ON mathang
FOR INSERT, UPDATE AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM inserted
    )
    BEGIN
    
        IF EXISTS(
            SELECT * 
            FROM inserted,mathang
            WHERE mathang.gia < inserted.gia
        )
        BEGIN
            PRINT N'Gía bán phải nhỏ hơn hoặc bằng bằng giá gốc'
            ROLLBACK TRANSACTION
        END

    END


END





CREATE TABLE MatHang(
    mahang char(3) PRIMARY KEY,
    soluong INT
)


CREATE TABLE HoaDon(
    mahang char(3) FOREIGN KEY REFERENCES MatHang(mahang),
    soluongban int,
    stt INT IDENTITY PRIMARY KEY ,
    ngaylap DATE,
    ngaygiao DATE
)

INSERT INTO MatHang VALUES('MH1',100),('MH2',150);

GO


CREATE TRIGGER trg_check_ngaygiao_ngaylap
ON HoaDon
FOR INSERT AS
BEGIN
    DECLARE @nl DATE,@ng DATE
    SELECT @nl = ngaylap, @ng = ngaygiao FROM inserted
    
    IF @ng < @nl
    BEGIN
        PRINT N'Ngày giao phải lớn hơn ngay lập'
        ROLLBACK TRANSACTION
    END   
    ELSE 
        UPDATE MatHang
        SET soluong = soluong - inserted.soluongban
        FROM inserted
        WHERE MatHang.mahang = inserted.mahang

END

GO


INSERT INTO HoaDon(ngaygiao,ngaylap) VALUES ('2003-09-08','2003-09-01')


GO



CREATE TRIGGER trg_tudong_soluong
ON HoaDon
FOR INSERT AS
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM MatHang,inserted
        WHERE MatHang.mahang = inserted.mahang
    )
    BEGIN
        PRINT N'Mã Mặt hàng này không tồn tại'
        ROLLBACK TRANSACTION
    END
    ELSE
        UPDATE MatHang
        SET MatHang.soluong = MatHang.soluong + 1
        FROM inserted
        WHERE MatHang.mahang = inserted.mahang

END




--  2. Để quản lý các bản tin trong một Website, người ta
--  sử dụng hai bảng sau:


CREATE TABLE loaibantin(
    
    maloai INT PRIMARY KEY,
    tenphanloai NVARCHAR(100) NOT NULL,
    bantinmoinhat INT DEFAULT(0)

)



CREATE TABLE bantin(
    
    maso INT PRIMARY KEY,
    ngayduatin DATETIME NULL,
    tieude NVARCHAR(200) NULL,
    noidung NTEXT NULL,
    maloai INT NULL FOREIGN KEY REFERENCES loaibantin(maloai) 

)


--  Khi một bản tin mới được bổ sung, cập nhật
--  lại cột bantinmoinhat của dòng tương ứng với
--  loại bản tin vừa bổ sung.

CREATE TRIGGER trg_capnhat_bantinmoinhat
ON bantin
FOR INSERT,UPDATE AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM inserted,loaibantin
        WHERE inserted.maloai = loaibantin.maloai
    )
    BEGIN
        PRINT N'Mã loại không tồn tại'
    END
    ELSE

        UPDATE loaibantin
        SET bantinmoinhat =  bantinmoinhat + 1
        FROM inserted 
        WHERE inserted.maloai = loaibantin.maloai

END


--  Khi một bản tin bị xóa, cập nhật lại giá trị của
--  cột bantinmoinhat trong bảng LOAIBANTIN của
--  dòng ứng với loại bản tin vừa xóa là mã số của
--  bản tin trước đó (dựa vào ngày đưa tin). Nếu
--  không còn bản tin nào cùng loại thì giá trị của
--  cột này bằng 0.


CREATE TRIGGER trg_check_bantin
ON bantin
FOR DELETE AS
BEGIN
    DECLARE @maloai INT

    SELECT @maloai = maloai FROM deleted

    UPDATE loaibantin
    SET bantinmoinhat = (
        SELECT *
        FROM bantin
        WHERE maloai = @maloai
        ORDER BY ngayduatin DESC
    )
    WHERE maloai = @maloai


    IF NOT EXISTS(
        SELECT *
        FROM bantin 
        WHERE maloai = @maloai
    )
    BEGIN
        UPDATE loaibantin
        SET bantinmoinhat = 0
        WHERE maloai = @maloai
    END

END

--  Khi cập nhật lại mã số của một bản tin và
--  nếu đó là bản tin mới nhất thì cập nhật lại cột
--  bantinmoinhat mã số mới.


CREATE TRIGGER trg_check_updatebantin
ON bantin
FOR INSERT,UPDATE AS
BEGIN
    
    IF UPDATE(bantin)
    BEGIN
        UPDATE loaibantin
        SET bantinmoinhat = inserted.maso
        FROM loaibantin 
        JOIN inserted 
        ON loaibantin.maloai = inserted.maloai
        WHERE loaibantin.bantinmoinhat = deleted.maso
    END 
END

