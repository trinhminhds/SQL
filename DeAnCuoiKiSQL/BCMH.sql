DROP DATABASE IF EXISTS db_Starbucks_Coffee;
GO
CREATE DATABASE db_Starbucks_Coffee
GO
USE db_Starbucks_Coffee

GO


-- Thiết lập khóa chính khóa ngoại cho bảng Nhân viên

-- Khóa chính
ALTER TABLE NHANVIEN
ADD PRIMARY KEY (MANV);
GO

ALTER TABLE BAOCAO
ADD CONSTRAINT FK_NHANVIEN_BAOCAO
FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);
GO


ALTER TABLE PHIEUCHI
ADD CONSTRAINT FK_NHANVIEN_PHIEUCHI
FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV); 
GO 


ALTER TABLE PHIEUNHAP
ADD CONSTRAINT FK_NHANVIEN_PHIEUNHAP
FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);
GO

ALTER TABLE PHIEUPHUTHU
ADD CONSTRAINT FK_NHANVIEN_PHIEUPHUTHU
FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);
GO

ALTER TABLE HOADON
ADD CONSTRAINT FK_NHANVIEN_HOADON
FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV);
GO






-- Thiết lập Khóa chính và khóa phụ bảng Chức Vụ
ALTER TABLE CHUCVU 
ADD PRIMARY KEY (MACV);
GO 
-- Thiết lập khóa ngoại bảng nhân viên
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_CHUCVU_NHANVIEN
FOREIGN KEY (MACV) REFERENCES CHUCVU(MACV);
GO 




-- Thiết lập khóa chính khóa ngoại cho bảng chi nhánh
ALTER TABLE CHINHANH
ADD PRIMARY KEY (MACN)
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_CHINHANH_NHANVIEN
FOREIGN KEY (MACN) REFERENCES CHINHANH(MACN);
GO



-- Thiết lập khóa chí và khóa ngoại cho bảng báo cáo
ALTER TABLE BAOCAO
ADD PRIMARY KEY (MABC)
GO


-- Thiết lập khóa chính và khóa ngoại cho bảng phiếu chi
ALTER TABLE PHIEUCHI 
ADD PRIMARY KEY (MAPC)
GO


-- Thiết lập khóa chính và khóa ngoại cho bảng phiếu phụ thu
ALTER TABLE PHIEUPHUTHU
ADD PRIMARY KEY (MAPHIEUPT)
GO


-- Thiết lập khóa chính và khóa ngoại cho phiếu nhập
ALTER TABLE PHIEUNHAP
ADD PRIMARY KEY (MAPN)
GO

ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT FK_PHIEUNHAP_CHITIET_PN
FOREIGN KEY (MAPN) REFERENCES PHIEUNHAP(MAPN)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng nhà cung cấp
ALTER TABLE NHACUNGCAP
ADD PRIMARY KEY (MANCC)
GO

ALTER TABLE PHIEUNHAP
ADD CONSTRAINT FK_NHACUNGCAP_PHIEUNHAP
FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC)
GO


-- Thiết lập khóa chính và khóa ngoại cho bảng chi tiết phiếu nhập
ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT PK_CHITIET_PHIEUNHAP PRIMARY KEY (MANL,MAPN)
GO

ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT FK_CHITIET_PN_NGUYENLIEU
FOREIGN KEY (MANL) REFERENCES NGUYENLIEU(MANL)
GO



-- Thiết lập khóa chính và khóa ngoại cho Bảng nguyên liệu
ALTER TABLE NGUYENLIEU
ADD PRIMARY KEY (MANL)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng công thức
ALTER TABLE CONGTHUC
ADD CONSTRAINT PK_CONGTHUC PRIMARY KEY (MATU,MANL)
GO

ALTER TABLE CONGTHUC
ADD CONSTRAINT FK_NGUYENLIEU_CONGTHUC
FOREIGN KEY (MANL) REFERENCES NGUYENLIEU(MANL)
GO

ALTER TABLE CONGTHUC 
ADD CONSTRAINT FK_THUCUONG_CONGTHUC
FOREIGN KEY (MATU) REFERENCES THUCUONG(MATU)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng thức uống
ALTER TABLE THUCUONG
ADD PRIMARY KEY (MATU)
GO

ALTER TABLE THUCUONG
ADD CONSTRAINT FK_THUCUONG_LOAITHUCUONG
FOREIGN KEY (MALOAI) REFERENCES LOAITHUCUONG(MALOAI)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng loại thức uống
ALTER TABLE LOAITHUCUONG
ADD PRIMARY KEY (MALOAI)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng chi tiết hóa đơn
ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT PK_CHITIET_HOADON PRIMARY KEY (MATU,MAHD)
GO

ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT FK_THUCUONG_CT_HOADON
FOREIGN KEY (MATU) REFERENCES THUCUONG(MATU)
GO


-- Thiết lập khóa chính và khóa ngoại cho bảng hóa đơn
ALTER TABLE HOADON
ADD PRIMARY KEY (MAHD) 
GO

ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT FK_HOADON_CHITIET_HD
FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD)
GO



-- Thiết lập khóa chính và khóa ngoại cho bảng khu vức
ALTER TABLE KHUVUC
ADD PRIMARY KEY (MAKV)
GO

ALTER TABLE HOADON
ADD CONSTRAINT FK_KHUVUC_HOADON
FOREIGN KEY (MAKV) REFERENCES KHUVUC(MAKV)


-- 4. Viết câu lệnh thêm bảng vào HOADON có mã hóa đơn là HD101, mã nhân viên 
-- 8001, mã khu vực K11, ngày lập 12/2/2024, tổng tiền là 83000. 

INSERT INTO hoadon VALUES('HD101','8001','K1','2024-02-12',83000)


-- 5. Viết câu lệnh thêm vào bảng CHITIET_HOADON các giá trị: mã hóa đơn là HD101, 
-- mã thức uống là SACK, số lượng là 1.

INSERT INTO chitiet_hoadon VALUES('SACK','HD101',1)


-- 6. Viết câu lệnh thêm vào bảng PHIEUCHI có mã phiếu chi là MAPC51, mã nhân viên là 
-- 8005, nội dung chi là ‘rút doanh thu ngày’, ngày lập: 11/2/2024 và tổng tiền: 
-- 15000000. 

INSERT INTO phieuchi VALUES('MAPC51','8005','rút doanh thu ngày','2024-02-11',15000000)


-- 7. Viết câu lệnh thêm vào bảng PHIEUNHAP có mã phiếu nhập là PN55, mã nhân 
-- viên là NV3, mã nhà cung cấp là C1, ngày lập 12/1/2024 và tổng tiền là 1200000. 

INSERT INTO phieunhap VALUES('MAPN55','8003','C1','2024-01-12',1200000)


-- 8. Viết câu lệnh thêm vào PHIEUPHUTHU có mã phiếu phụ thu MAPT63, mã nhân viên 
-- là 8002, tên phiếu phụ thu là ‘Khách làm vỡ ly’, ngày lập 11/20/2024, số tiền phụ 
-- thu là 30000.  

INSERT INTO phieuphuthu VALUES('MAPT63','8002','Khách làm vỡ ly','2024-11-20',30000)


-- 9. Viết câu lệnh sửa tất cả mã nhân viên trong bảng PHIEUPHUTHU thành 'NV2' trong 
-- duy nhất ngày 14/02/2024.

-- Từ câu này chưa chạy

UPDATE phieuphuthu
SET MANV = '8002', NGAYLAP = '2024-14-02'


-- 10. Viết câu lệnh sửa TENPPT của nhân viên có mã NV3 trong ngày 30/01/2024 thành 
-- 'Quay phim'.

UPDATE phieuphuthu
SET TENPPT = 'Quay Phim'
WHERE MANV = '8003' AND NGAYLAP = '2024-01-30'


-- 11. Tăng hệ số giá thêm 1 cho khu vực có nhiều người uống nhất.

SELECT khuvuc.MAKV, COUNT(hoadon.MAHD)
FROM khuvuc 
JOIN hoadon 
on khuvuc.MAKV = hoadon.MAKV
GROUP BY  khuvuc.MAKV

UPDATE khuvuc 
SET HESOGIA = HESOGIA + 1
WHERE MAKV = (
    SELECT TOP 1 MAKV
    FROM hoadon 
    GROUP BY MAKV
    ORDER BY COUNT(*) DESC 
)

-- 12. Giảm 20% giá các thức uống không bán được trong tháng 1/2024. 

SELECT T.MATU
FROM thucuong as T
JOIN chitiet_hoadon as C
ON T.MATU = c.MATU
JOIN hoadon as H
ON C.MAHD = H.MAHD
WHERE YEAR(H.NGAYLAP) = 2024 AND MONTH(H.NGAYLAP) = 1 

UPDATE thucuong
SET DONGIA = DONGIA * 0.2
WHERE MATU = (
    SELECT TOP 1 C.MATU
    FROM chitiet_hoadon AS C
    JOIN hoadon AS H
    ON C.MAHD = H.MAHD
    WHERE YEAR(H.NGAYLAP) = 2024 AND MONTH(H.NGAYLAP) = 1 AND C.SOLUONG = 0
    GROUP BY C.MATU 
    ORDER BY COUNT(*) ASC
)


-- 13. Tăng thêm 50% giá các thức uống bán chạy nhất.

UPDATE thucuong
SET DONGIA = DONGIA * 1.5
WHERE MATU = (
    SELECT TOP 1 C.MATU
    FROM chitiet_hoadon AS C
    GROUP BY C.MATU 
    ORDER BY COUNT(*) DESC
)


--14. Viết câu lệnh xóa báo cáo của một nhân viên với MANV=NV5 vào  ngày 31/01/2024.
DELETE FROM baocao 
WHERE MANV = '8005' AND NGAYLAP = '2024-1-31'


-- 15. Viết câu lệnh xóa phiếu phụ thu của nhân viên có mã là NV3 đã lập vào ngày 21/09/2023. 
DELETE FROM phieuphuthu 
WHERE MANV = '8003' AND NGAYLAP = '2023-09-21'


-- 16. Xuất ra danh sách các thức uống có loại là Tea (mã: tea) 

SELECT *
FROM thucuong 
WHERE MALOAI = 'TRA'


-- 17. Xuất ra danh sách thức uống không chứa nguyên liệu sữa đặc

SELECT thucuong.MATU
FROM thucuong
JOIN congthuc 
ON thucuong.MATU = congthuc.MATU
JOIN nguyenlieu
ON congthuc.MANL = nguyenlieu.MANL
WHERE nguyenlieu.TENNL NOT LIKE 'Sữa%'


-- 18. Xuất ra danh sách những loại thức uống có giá thấp hơn 50 ngàn. 

SELECT *
FROM thucuong
WHERE DONGIA < 50000


-- 19. Hãy lọc ra những nguyên liệu được cung cấp bởi nhà cung cấp NCC1.

SELECT nguyenlieu.MANL
FROM nguyenlieu 
JOIN chitiet_phieunhap AS P
ON nguyenlieu.MANL = P.MANL
JOIN phieunhap AS N
ON N.MAPN = P.MAPN
JOIN nhacungcap AS C
ON C.MANCC = N.MANCC
WHERE C.MANCC = 'C1'


-- 20. Viết câu lệnh thống kê toàn bộ những nhà cung cấp đang cấp hàng cho hệ thống. 

SELECT nhacungcap.*
FROM nhacungcap
JOIN phieunhap 
ON nhacungcap.MANCC = phieunhap.MANCC


-- 21. Hãy liệt kê danh sách nhân viên theo chi nhánh 1, 2, 3. 

SELECT *
FROM nhanvien 
WHERE MACN IN ('N1','N2','N3')


-- 22. Viết câu lệnh để liệt kê thức uống bán nhiều nhất. 

SELECT TOP 1 T.MATU
FROM thucuong as T
JOIN chitiet_hoadon as C
ON T.MATU = c.MATU
JOIN hoadon as H
ON C.MAHD = H.MAHD
GROUP BY T.MATU
ORDER BY COUNT(*) DESC



-- 23. Viết câu lệnh tìm khu vực khách hàng chọn nhiều nhất.

SELECT khuvuc.MAKV,COUNT(hoadon.MAHD) AS SOLUONGMUA
FROM khuvuc 
JOIN hoadon
ON khuvuc.MAKV = hoadon.MAKV
GROUP BY khuvuc.MAKV
ORDER BY COUNT(hoadon.MAHD) DESC


-- 24. Viết câu lệnh thống kê tổng chi theo từng quý.

SELECT YEAR(NGAYLAP) AS NAM,
DATEPART(QUARTER,NGAYLAP) AS Quy,
SUM(TONGTIEN) AS TONGTIEN
FROM phieuchi
GROUP BY YEAR(NGAYLAP),DATEPART(QUARTER,NGAYLAP)
ORDER BY NAM,Quy



-- 25. Viết câu lệnh để thống kê tổng phụ thu.

SELECT SUM(SOTIEN) AS TONGTIEN
FROM phieuphuthu


-- 26. Viết câu lệnh để tính doanh thu toàn hệ thống năm 2023.

SELECT SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN) AS TONGTIEN
FROM phieuphuthu
LEFT JOIN nhanvien
ON phieuphuthu.MANV = nhanvien.MANV
LEFT JOIN hoadon
ON nhanvien.MANV = hoadon.MANV
WHERE YEAR(hoadon.NGAYLAP) = 2023 OR YEAR(phieuphuthu.NGAYLAP) = 2023


-- 27. Viết câu lệnh để tính doanh thu toàn hệ thống của quý 1 năm 2024. 

SELECT SUM(hoadon.TONGTIEN + phieuphuthu.SOTIEN)  AS TongDoanhThu
FROM hoadon
LEFT JOIN nhanvien ON hoadon.MANV = nhanvien.MANV
LEFT JOIN phieuphuthu ON nhanvien.MANV = phieuphuthu.MANV
WHERE YEAR(hoadon.NGAYLAP) = 2024 OR YEAR(phieuphuthu.NGAYLAP) = 2024 
AND MONTH(hoadon.NGAYLAP) IN (1,2,3) OR MONTH(phieuphuthu.NGAYLAP) IN (1,2,3)



-- 28. Tính lợi nhuận toàn hệ thống năm 2023

SELECT 
    SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN) AS TongDoanhThu,
    SUM(phieuchi.TONGTIEN) AS TongChiPhi,
    (SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN)) - SUM(phieuchi.TONGTIEN) AS LoiNhuan
FROM 
    hoadon
LEFT JOIN 
    nhanvien ON hoadon.MANV = nhanvien.MANV
LEFT JOIN 
    phieuphuthu ON nhanvien.MANV = phieuphuthu.MANV
LEFT JOIN 
    phieuchi ON nhanvien.MANV = phieuchi.MANV
WHERE 
    YEAR(hoadon.NGAYLAP) = 2023 OR YEAR(phieuphuthu.NGAYLAP) = 2023 OR YEAR(phieuchi.NGAYLAP) = 2023;


-- 29. Tính lợi nhuận theo từng chi nhánh.

SELECT 
    SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN) AS TongDoanhThu,
    SUM(phieuchi.TONGTIEN) AS TongChiPhi,
    (SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN)) - SUM(phieuchi.TONGTIEN) AS LoiNhuan,khuvuc.MAKV
FROM 
    khuvuc
LEFT JOIN 
    hoadon ON khuvuc.MAKV = hoadon.MAKV
LEFT JOIN 
    nhanvien ON hoadon.MANV = nhanvien.MANV
LEFT JOIN 
    phieuphuthu ON nhanvien.MANV = phieuphuthu.MANV
LEFT JOIN 
    phieuchi ON nhanvien.MANV = phieuchi.MANV
GROUP BY khuvuc.MAKV 



-- 30. Thống kê số lượng tồn của tất cả các nguyên liệu còn dưới mức quy định.

SELECT 
    NL.MANL, 
    NL.TENNL, 
    SUM(CPN.SOLUONG) - SUM(CX.SOLUONG) AS SOLUONGTON
FROM 
    CHITIET_PHIEUNHAP AS CPN
JOIN 
    NGUYENLIEU AS NL
    ON NL.MANL = CPN.MANL
JOIN
    congthuc AS CT
    ON CT.MANL = NL.MANL
JOIN 
    thucuong AS TU
    ON CT.MATU = TU.MATU
JOIN 
    CHITIET_HOADON AS CX 
    ON TU.MATU = CX.MATU
GROUP BY 
    NL.MANL, NL.TENNL
HAVING 
    SUM(CPN.SOLUONG) - SUM(CX.SOLUONG) < 90;




-- 31. Liệt kê loại nguyên liệu được sử dụng nhiều nhất. 

SELECT NL.MANL, SUM(CTHD.SOLUONG) AS SOLUONG
FROM chitiet_hoadon AS CTHD
JOIN thucuong AS TU
ON CTHD.MATU = TU.MATU
JOIN congthuc AS CT
ON CT.MATU = TU.MATU
JOIN nguyenlieu AS NL
ON CT.MANL = NL.MANL
GROUP BY NL.MANL
ORDER BY SOLUONG DESC


-- 32. Hãy viết thủ tục thêm một nhân viên mới vào bảng NHANVIEN với tham số truyền 
-- vào là mã nhân viên, tên nhân viên, mã chức chức vụ, mã chi nhánh, giới tính, ngày 
-- vào, ngày nghĩ (có thể null). Kiểm tra ngày vào phải lớn hơn ngày thành lập hệ thống 
-- (01/01/2020) và ràng buộc tồn tại các mã chức vụ, mã chi nhánh. 
GO

CREATE PROCEDURE sp_themNhanVien(@manv char(5),@tennv nvarchar(50),@macv char(5),@macn char(5),@gioitinh bit ,@ngayvao date,@ngaynghi date = null)
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM chucvu
        WHERE chucvu.MACV = @macv
    )
    BEGIN
        PRINT N'Mã Chức vụ không tồn tại'
        RETURN
    END

    IF NOT EXISTS(
        SELECT *
        FROM chinhanh
        WHERE chinhanh.MACN = @macn
    )
    BEGIN
        PRINT N'Mã chi nhánh không tồn tại'
        RETURN
    END

    IF @ngayvao < '2020-01-01'
    BEGIN
        PRINT N'Ngày vào phải lớn hơn ngày lập hệ thống (01/01/2020)'
        RETURN
    END

    INSERT INTO nhanvien VALUES(@manv,@tennv,@macv,@macn,@gioitinh,@ngayvao,@ngaynghi)
    PRINT N'Thêm nhân viên thành công'

END

GO 


-- 33. Viết thủ tục thêm một thức uống vào bảng THUCUONG với tham số truyền vào là 
-- mã thức uống, mã loại thức uống, tên thức uống, đơn giá. Kiểm tra tham số vào 
-- (kiểm tra tồn tại mã loại thức uống). 


CREATE PROCEDURE sp_themThucUong(@matu char(5),@maloai char(5),@tentu nvarchar(50),@dongia DECIMAL)
AS
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM loaithucuong
        WHERE MALOAI = @maloai
    )
    BEGIN
        PRINT N'Mã loại không tồn tại'
        RETURN
    END

    INSERT INTO thucuong VALUES(@matu,@maloai,@tentu,@dongia)
    PRINT N'Thêm thành công'

END
GO

-- 34. Viết thủ tục thêm mới một loại thức uống mới vào bảng LOAITHUCUONG với 
-- tham số truyền vào là mã loại, tên loại thức uống.  

CREATE PROCEDURE sp_themLoaiThuUong(@maloai char(5),@tenloai nvarchar(50))
AS
BEGIN
    INSERT INTO loaithucuong VALUES (@maloai,@tenloai)
    PRINT N'Thêm thành công'
END
GO


-- 35.  Viết thủ tục thêm mới một nguyên vào bảng NGUYENLIEU với tham số đầu vào 
-- là mã nguyên liệu, tên nguyên liệu, số lượng, đơn vị.   


CREATE PROCEDURE sp_themNguyenLieu(@manl char(10),@tennl nvarchar(100),@soluong FLOAT,@donvi nvarchar(25))
AS
BEGIN
    INSERT INTO nguyenlieu VALUES(@manl,@tennl,@soluong,@donvi)
    PRINT N'Thêm thành công'
END
GO

-- 36. Viết thủ tục để cập nhật thông tin của một thức uống trong bảng THUCUONG với 
-- tham số đầu vào là mã thức uống, mã loại thức uống, tên thức uống, đơn giá. Kiểm 
-- tra ràng buộc tồn tại thức uống và mã loại thức uống. 

CREATE PROCEDURE sp_capNhatThucUong(@matu CHAR(5),@maltu char(5),@tentu nvarchar(50),@dongia DECIMAL)
AS
BEGIN
    IF NOT EXISTS(
        SELECT *
        FROM loaithucuong
        WHERE MALOAI = @maltu
    )
    BEGIN
        PRINT N'Mã loại thức uống không tồn tại'
        RETURN
    END

    UPDATE thucuong
    SET MATU = @matu,MALOAI = @maltu, TENTU = @tentu,DONGIA = @dongia
    
    PRINT N'Sửa thành công'
END
GO

-- 37. Viết thủ tục liệt kê các thức uống thuộc một loại thức uống bất kì, với tham số truyền 
-- vào là tên loại. Kiểm tra ràng buộc tồn tại tên loại.  


CREATE PROCEDURE sp_lietkeThucUong(@tenloai NVARCHAR(20))
AS 
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM loaithucuong 
        WHERE TENLOAI = @tenloai
    )
    BEGIN
        PRINT N'Tên loại không tồn tại'
    END

    SELECT TU.*
    FROM thucuong AS TU
    JOIN loaithucuong AS L
    ON TU.MALOAI = L.MALOAI
    WHERE L.TENLOAI = @tenloai 

END
GO


-- 38. Viết thủ tục liệt kê thông tin tất cả các nguyên liệu (tên nguyên liệu, số lượng tồn 
-- kho, đơn vị) của một thức uống bất kì, với tham số truyền vào là tên thức uống. Kiểm 
-- tra ràng buộc tồn tại tên thức uống.

CREATE PROCEDURE sp_lietKeNguyenLieu(@tentu nvarchar(25))
AS
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM thucuong
        WHERE TENTU = @tentu
    )
    BEGIN
        PRINT N'Tên thức uống không tồn tại'
    END

    SELECT NL.TENNL,NL.SOLUONG ,NL.DONVI
    FROM nguyenlieu AS NL
    JOIN congthuc AS CT
    ON NL.MANL = CT.MANL
    JOIN thucuong AS TU
    ON CT.MATU = TU.MATU
    JOIN chitiet_hoadon AS CTHD
    ON CTHD.MATU = TU.MATU
    WHERE TU.TENTU = @tentu

END
GO


-- 39. Viết thủ tục dùng để tìm những thức uống không bán được của chi nhánh bất kì trong 
-- khoảng thời gian nào đó. Với tham số đầu vào là tên chi nhánh, thời gian bắt đầu và 
-- thời gian kết thúc. 


CREATE PROCEDURE sp_timThucUong(@tenchinhanh nvarchar(25),@tgbatdau date, @tgketthuc date)
AS
BEGIN

    SELECT TU.*
    FROM thucuong AS TU
    LEFT JOIN chitiet_hoadon AS CTHD
    ON TU.MATU = CTHD.MATU
    LEFT JOIN hoadon AS HD
    ON CTHD.MAHD = HD.MAHD
    LEFT JOIN nhanvien AS NV
    ON HD.MANV = NV.MANV
    LEFT JOIN chinhanh AS CN
    ON NV.MACN = CN.MACN
    WHERE CN.TENCN = @tenchinhanh AND HD.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc AND CTHD.MAHD IS NULL

END
GO

-- 40. Viết thủ tục liệt kê tên các nguyên liệu của một nhà cung cấp bất kì, với tham số đầu 
-- vào là tên nhà cung cấp, kiểm tra ràng buộc tồn tại tên nhà cung cấp. 

CREATE PROCEDURE sp_lietKeNhaCungCap(@tennhacc nvarchar(50))
AS
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM nhacungcap
        WHERE TENNCC = @tennhacc
    )
    BEGIN
        PRINT N'Tên nhà cung cấp không tồn tại'
        RETURN
    END

    SELECT NL.*
    FROM nguyenlieu AS NL
    JOIN chitiet_phieunhap AS CTPN
    ON NL.MANL = CTPN.MANL
    JOIN phieunhap AS PN
    ON CTPN.MAPN = PN.MAPN
    JOIN nhacungcap AS NCC
    ON NCC.MANCC = PN.MANCC
    WHERE NCC.TENNCC = @tennhacc

END
GO

-- 41. Viết thủ tục tăng giá của một thức uống bất kì với tham số truyền vào là tên thức 
-- uống và hệ số giá. Điều kiện tên thức uống tồn tại và hệ số tăng giá phải nhỏ hơn 1 
-- đồng thời không nhỏ hơn -0.5. 

CREATE PROCEDURE sp_tangGiaThucUong(@tentu nvarchar(50),@hesogia FLOAT)
AS
BEGIN

    IF NOT EXISTS(
        SELECT *
        FROM thucuong
        WHERE TENTU = @tentu
    )
    BEGIN
        PRINT N'Tên thức uống không tồn tại'
        RETURN
    END

    IF @hesogia > 1 AND @hesogia < -0.5
    BEGIN
        PRINT N'Hệ số giá phải nhỏ hơn 1 đồng thời không nhỏ hơn -0.5'
        RETURN
    END 

    UPDATE thucuong
    SET DONGIA = DONGIA * @hesogia
    WHERE TENTU = @tentu

END
GO


-- 42. Viết thủ tục tính tổng tiền phụ thu của một chi nhánh bất kì trong thời gian bất kì. 
-- Với tham số truyền vào là tên chi nhánh, thời gian bắt đầu và thời gian kết thúc. Điều 
-- kiện ràng buộc thời gian bắt đầu phải trước thời gian kết thúc. 

CREATE PROCEDURE sp_tongTienPhuThu(@tenchinhanh NVARCHAR(100),@tgbatdau DATE,@tgketthuc DATE)
AS
BEGIN

    IF @tgbatdau > @tgketthuc
    BEGIN 
        PRINT N'Thời gian bắt đầu phải trước thời gian kết thúc'
        RETURN
    END

    SELECT CN.TENCN , SUM(PT.SOTIEN) AS TONGTIEN
    FROM phieuphuthu AS PT
    JOIN nhanvien AS NV
    ON PT.MANV = NV.MANV
    JOIN chinhanh AS CN
    ON NV.MACN = CN.MACN
    WHERE CN.TENCN = @tenchinhanh AND PT.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc 

END
GO


-- 43. Viết thủ tục tính lợi nhuận của hệ thống trong khoảng thời gian bất kì. Với tham số 
-- đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng lợi nhuận của 
-- hệ thống (lợi nhuận = tổng doanh thu - tổng chi).  

CREATE PROCEDURE sp_loiNhuanHeThong(@tgbatdau date,@tgketthuc date)
AS
BEGIN

    SELECT SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN) AS TongDoanhThu,
    SUM(phieuchi.TONGTIEN) AS TongChiPhi,
    (SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN)) - SUM(phieuchi.TONGTIEN) AS LoiNhuan
    FROM hoadon
    LEFT JOIN nhanvien 
    ON hoadon.MANV = nhanvien.MANV
    LEFT JOIN phieuphuthu 
    ON nhanvien.MANV = phieuphuthu.MANV
    LEFT JOIN phieuchi 
    ON nhanvien.MANV = phieuchi.MANV
    WHERE hoadon.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc OR
    phieuphuthu.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc OR
    phieuchi.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc;

END
GO

-- 44. Viết thủ tục tìm thức uống bán chạy nhất của chi nhánh bất kì trong khoảng thời gian 
-- bất kì, với tham số truyền vào là tên chi nhánh, thời gian bắt đầu và thời gian kết 
-- thúc. Điều kiện thời gian bắt đầu trước thời gian kết thúc.   

CREATE PROCEDURE sp_timThucUongChiNhanh(@tenchinhanh NVARCHAR(50),@tgbatdau date,@tgketthuc date)
AS
BEGIN
    
    IF @tgbatdau < @tgketthuc
    BEGIN

        SELECT TOP 1 CN.TENCN ,TU.MATU ,TU.TENTU ,COUNT(*) AS SOLUONGBAN
        FROM thucuong AS TU
        JOIN chitiet_hoadon AS CTHD
        ON TU.MATU = CTHD.MATU
        JOIN hoadon AS HD
        ON CTHD.MAHD = HD.MAHD
        JOIN nhanvien AS NV
        ON HD.MANV = NV.MANV
        JOIN chinhanh AS CN
        ON NV.MACN = CN.MACN
        WHERE CN.TENCN = @tenchinhanh AND HD.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc
        GROUP BY CN.TENCN ,TU.MATU ,TU.TENTU
        ORDER BY COUNT(*) DESC

    END
    ELSE
    BEGIN
        PRINT N'Thời gian bắt đầu phải trước ngày kết thức'
        RETURN
    END
END
GO


-- 45. Viết thủ tục tính tổng số tiền doanh thu của hệ thống trong một ngày bất kì với tham 
-- số đầu vào là ngày và tham số đầu ra là tổng doanh thu của ngày đó.  

CREATE PROCEDURE sp_doanhThuNgay(@ngay INT)
AS
BEGIN

    SELECT SUM(hoadon.TONGTIEN) + SUM(phieuphuthu.SOTIEN) AS TONGTIEN
    FROM phieuphuthu
    LEFT JOIN nhanvien
    ON phieuphuthu.MANV = nhanvien.MANV
    LEFT JOIN hoadon
    ON nhanvien.MANV = hoadon.MANV
    WHERE DAY(hoadon.NGAYLAP) = @ngay OR DAY(phieuphuthu.NGAYLAP) = @ngay

END
GO


-- 46. Viết thủ tục tìm thức uống bán chạy nhất của hệ thống trong khoảng thời gian bất kì, 
-- với tham số truyền vào là thời gian bắt đầu và thời gian kết thúc. Điều kiện thời gian 
-- bắt đầu trước thời gian kết thúc. 

CREATE PROCEDURE sp_thucUongBanChay(@tgbatdau date, @tgketthuc date)
AS
BEGIN
    IF @tgbatdau < @tgketthuc
    BEGIN

        SELECT TOP 1 TU.MATU ,TU.TENTU ,COUNT(*) AS SOLUONGBAN
        FROM thucuong AS TU
        JOIN chitiet_hoadon AS CTHD
        ON TU.MATU = CTHD.MATU
        JOIN hoadon AS HD
        ON CTHD.MAHD = HD.MAHD
        --WHERE HD.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc
        GROUP BY TU.MATU,TU.TENTU
        ORDER BY COUNT(*) DESC

    END
    ELSE
    BEGIN
        PRINT N'Thời gian bắt đầu phải trước ngày kết thức'
        RETURN
    END

END
GO


-- 47. Viết thủ tục liệt kê các loại nguyên liệu (tên, số lượng tồn, đơn vị) của một phiếu 
-- nhập bất kì, với tham số đầu vào là mã phiếu nhập.

CREATE PROCEDURE sp_lietKeNguyenLieu_phieuNhap(@mapn char(10))
AS
BEGIN 

    SELECT NL.TENNL,NL.SOLUONG,NL.DONVI
    FROM nguyenlieu AS NL
    JOIN chitiet_phieunhap AS CTPN
    ON NL.MANL = CTPN.MANL
    JOIN phieunhap AS PN
    ON CTPN.MAPN = PN.MAPN
    WHERE PN.MAPN = @mapn

END
GO


-- 48. Viết thủ tục tính tổng doanh thu của hệ thống trong khoảng thời gian bất kì. Với 
-- tham số đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng 
-- doanh thu của hệ thống (doanh thu= tổng tiền hóa đơn + tổng tiền phụ thu).  

CREATE PROCEDURE sp_tinhTongDoanhThu_HeThong(@tgbatdau date,@tgketthuc date)
AS
BEGIN

    SELECT SUM(HD.TONGTIEN + PT.SOTIEN) AS TONGTIEN
    FROM hoadon AS HD
    JOIN phieuphuthu AS PT
    ON HD.MANV = PT.MANV
    WHERE HD.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc OR
    PT.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc

END
GO



-- 49. Viết thủ tục tính tổng chi tiêu của hệ thống trong khoảng thời gian bất kì. Với tham 
-- số đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng tiền chi 
-- của hệ thống (tổng chi= tổng tiền phiếu nhập + tổng tiền phiếu chi).
CREATE PROCEDURE sp_tongChiTieu(@tgbatdau date, @tgketthuc date)
AS
BEGIN

    SELECT SUM(PC.TONGTIEN + PN.TONGTIEN) AS TONGTIEN 
    FROM phieuchi AS PC
    JOIN phieunhap AS PN
    ON PC.MANV = PN.MANV
    WHERE PC.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc OR
    PN.NGAYLAP BETWEEN @tgbatdau AND @tgketthuc 

END
GO

-- 50. Viết một thủ tục với tùy chọn ‘with encryption’, mã hóa không cho người dùng xem 
-- được nội dung của thủ tục. 
-- ĐÃ CHẠY
CREATE PROCEDURE sp_maHoa_nguoiDung
WITH ENCRYPTION
AS
BEGIN
    PRINT N'Mã hóa không cho người dùng xem được nội dung của thủ tục';
END
GO


-- 51. Viết Trigger bắt lỗi cho lệnh Insert vào bảng CHITIET_HOADON. Khi thêm chi 
-- tiết hóa đơn thì kiểm tra trùng mã, kiểm tra nhập số lượng âm, thông báo không đủ 
-- nguyên liệu nếu hết và phải giảm số lượng tồn của nguyên liệu nếu thỏa các điều 
-- kiện còn lại. 
-- ĐÃ CHẠY

CREATE TRIGGER trg_themBangCHITIET_HOADON
ON chitiet_hoadon
FOR INSERT AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM inserted 
        WHERE inserted.MAHD IN (
            SELECT MAHD
            FROM chitiet_hoadon
        )
    )
    BEGIN
        PRINT N'Mã hóa đã bị trùng'
        ROLLBACK TRANSACTION
        RETURN
    END

    IF EXISTS(
        SELECT *
        FROM inserted 
        WHERE SOLUONG < 0
    )
    BEGIN
        PRINT N'Số lượng không thể âm'
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE NL
    SET NL.SOLUONG = NL.SOLUONG - I.SOLUONG
    FROM nguyenlieu AS NL
    JOIN inserted AS I
    ON NL.MANL = I.MATU
    WHERE NL.SOLUONG >= I.SOLUONG

    IF EXISTS(
        SELECT *
        FROM nguyenlieu AS NL
        JOIN inserted AS I
        ON NL.MANL = I.MATU 
        WHERE NL.SOLUONG < I.SOLUONG
    )
    BEGIN 
        PRINT N'Không đủ nguyên liệu'
        ROLLBACK TRANSACTION
        RETURN
    END

END
GO

-- 52. Viết Trigger bắt lỗi cho lệnh Update vào bảng CHITIET_HOADON. Khi sửa số 
-- lượng thức uống trong chi tiết hóa đơn thì phải sửa số lượng tồn của nguyên liệu. 

CREATE TRIGGER trg_capNhatCHITIET_HOADON
ON chitiet_hoadon
FOR UPDATE AS
BEGIN

    IF UPDATE(SOLUONG)
    BEGIN
        UPDATE NL
        SET NL.SOLUONG = NL.SOLUONG - (I.SOLUONG - D.SOLUONG) 
        FROM nguyenlieu AS NL 
        JOIN congthuc AS CT
        ON CT.MANL = NL.MANL
        JOIN thucuong AS TU
        ON TU.MATU = CT.MATU
        JOIN inserted AS I 
        ON TU.MATU = I.MATU
        JOIN deleted AS D 
        ON TU.MATU = D.MATU
        JOIN chitiet_hoadon AS CTHD 
        ON I.MAHD = CTHD.MAHD AND I.MATU = CTHD.MATU
    END

END
GO

-- 53. Viết Trigger bắt lỗi cho lệnh Delete vào bảng CHITIET_HOADON. Khi xóa chi tiết 
-- hóa đơn thì phải tăng số lượng tồn của nguyên liệu kiểm tra nếu xóa hết mã hóa đơn 
-- đó thì xóa lun bên bảng hóa đơn.

CREATE TRIGGER trg_xoa_CHITIET_HOADON
ON chitiet_hoadon
FOR DELETE AS
BEGIN

    DECLARE @xoabangHoaDon TABLE (MAHD CHAR(5))

    INSERT INTO @xoabangHoaDon (MAHD)
    SELECT DISTINCT MAHD
    FROM deleted

    UPDATE NL
    SET NL.SOLUONG = NL.SOLUONG + D.SOLUONG
    FROM nguyenlieu AS NL 
    JOIN congthuc AS CT
    ON CT.MANL = NL.MANL
    JOIN thucuong AS TU
    ON TU.MATU = CT.MATU
    JOIN deleted AS D 
    ON TU.MATU = D.MATU
    
    DELETE FROM hoadon
    WHERE MAHD IN(SELECT MAHD FROM @xoabangHoaDon)
    AND NOT EXISTS(SELECT * FROM chitiet_hoadon WHERE MAHD = hoadon.MAHD)

END
GO

-- 54. Viết Trigger bắt lỗi cho lệnh Insert vào bảng CHITIET_PHIEUNHAP. Khi thêm chi 
-- tiết nhập thì kiểm tra trùng mã, bắt không được nhập số âm phải tăng số lượng tồn 
-- của nguyên liệu (nhập hàng). 


CREATE TRIGGER trg_them_CHITIET_PHIEUNHAP
ON CHITIET_PHIEUNHAP 
FOR INSERT AS
BEGIN

    IF EXISTS(
        SELECT *
        FROM inserted,chitiet_phieunhap
        WHERE inserted.MAPN = chitiet_phieunhap.MAPN 
    )
    BEGIN 
        PRINT N'Mã phiếu nhập đã bị trùng'
        ROLLBACK TRANSACTION
        RETURN
    END


    IF EXISTS(
        SELECT *
        FROM inserted
        WHERE inserted.SOLUONG <= 0
    )
    BEGIN 
        PRINT N'Số lượng không được nhập số âm'
        ROLLBACK TRANSACTION 
        RETURN
    END


    UPDATE NL
    SET NL.SOLUONG = NL.SOLUONG + I.SOLUONG
    FROM nguyenlieu AS NL
    JOIN inserted AS I 
    ON NL.MANL = I.MANL

END

