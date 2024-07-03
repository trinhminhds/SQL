USE qlsvSchool


-- 1. Cơ sở dữ liệu quản lý sinh viên có chứa 3 bảng dữ
--  liệu được mô tả như sau:
--  1
--  SinhVien(mssv, ho, ten, ngaysinh, phai, lop)
--  Tân từ: Mỗi sinh viên có một mã số (mssv) là số
--  nguyên duy nhất, có họ (ho) và tên (ten) sinh viên,
--  ngày sinh (ngaysinh), thuộc phái nữ hay nam (phai)
--  và thuộc một lớp (lop).
--  MonHoc(mamh, tenmh)
--  Tân từ: Mỗi môn học có một mã môn học (mamh) là
--  một số nguyên duy nhất, có tên môn học (tenmh).
--  DiemThi(mssv, mamh, lanthi, diem)
--  Tân từ: Mỗi sinh viên (mssv) có thể học nhiều môn
--  (mamh). Mỗi môn học có thể thi nhiều lần (lanthi),
--  mỗi lần thi được đánh số thứ tự từ 1 trở đi và ghi
--  nhận điểm thi (diem) của các lần thi đó.

--  1.1 Viết lệnh tạo bảng với các ràng buộc khóa chính,
--  khóa ngoại được nêu trong tân từ. Kiểu dữ liệu
--  của các trường tự chọn theo ngữ nghĩa.

CREATE TABLE SinhVien (
    mssv INT PRIMARY KEY,
    ho NVARCHAR(50),
    ten NVARCHAR(50),
    ngaysinh DATE,
    phai NVARCHAR(3),
    lop NVARCHAR(20)
);

CREATE TABLE MonHoc (
    mamh INT PRIMARY KEY,
    tenmh NVARCHAR(100)
);

CREATE TABLE DiemThi (
    mssv INT,
    mamh INT,
    lanthi INT,
    diem FLOAT,
    PRIMARY KEY (mssv, mamh, lanthi),
    FOREIGN KEY (mssv) REFERENCES SinhVien(mssv),
    FOREIGN KEY (mamh) REFERENCES MonHoc(mamh)
);

--  1.2 Khai báo bổ sung các ràng buộc sau:
--  • Lần thi (lanthi) trong bảng DiemThi có
--  giá trị mặc định là 1.
--  • Điểm thi (diem) trong bảng DiemThi được
--  chấm theo thang điểm 10

ALTER TABLE DiemThi
ALTER COLUMN lanthi INT DEFAULT 1;

ALTER TABLE DiemThi
ADD CONSTRAINT CK_Diem CHECK (diem >= 0 AND diem <= 10);


-- 1.3 Tạo các khung nhìn sau:

--  • Tạo view vwLanThiCuoi dùng liệt kê danh
--  sách lần thi cuối cùng của các sinh viên
--  gồm: Mã số sinh viên, mã số môn học, lần
--  thi cuối cùng của môn học (ví dụ sinh viên
--  A thi môn học C ba lần thì lần thi cuối
--  cùng là 3).

--  • Tạoview vwDiemThiCuoi dùngliệtkêdanh
--  sách sinh viên gồm: Mã số sinh viên, mã số
--  môn học, lần thi cuối cùng của môn học
--  (ví dụ sinh viên A thi môn học M ba lần
--  thì lần thi cuối cùng là 3) và điểm của lần
--  thi cuối cùng đó.
GO

CREATE VIEW vwLanThiCuoi AS
    SELECT DiemThi.mssv, DiemThi.mamh, MAX(DiemThi.lanthi) AS LanThiCuoiCung
    FROM DiemThi
    GROUP BY DiemThi.mssv, DiemThi.mamh;
    
GO

CREATE VIEW vwDiemThiCuoi AS
    SELECT DiemThi.mssv, DiemThi.mamh,DiemThi.diem,MAX(DiemThi.lanthi) AS LanThiCuoiCung
    FROM DiemThi
    GROUP BY DiemThi.mssv, DiemThi.mamh,DiemThi.diem;

GO

-- 1.4 Tạo trigger Insert cho bảng DiemThi dùng điền
--  tự động số thứ tự lần thi khi thêm điểm thi một
--  môn học của một sinh viên. Ví dụ sinh viên A
--  đã thi môn học M hai lần thì lần thi mới thêm
--  vào phải là 3.

CREATE TRIGGER trg_Insert_DiemThi
ON DiemThi 
FOR INSERT AS
BEGIN
    DECLARE @mssv INT, @mamh INT, @maxLanThi INT;
  
    SELECT @mssv = mssv, @mamh = mamh 
    FROM inserted;
    
    SELECT @maxLanThi = ISNULL(MAX(lanthi), 0) 
    FROM DiemThi 
    WHERE mssv = @mssv AND mamh = @mamh;

    INSERT INTO DiemThi (mssv, mamh, lanthi, diem)
    VALUES (@mssv, @mamh, @maxLanThi + 1, (SELECT diem FROM inserted));

END


-- 1.5 Viết thủ tục hoặc hàm liệt kê kết quả thi các
--  môn của một sinh viên khi biết mã số của sinh
--  viên gồm các thông tin: mã số môn học, lần thi,
--  điểm thi. Trong đó, mã số sinh viên là giá trị
--  input.
GO

CREATE PROCEDURE sp_lietkeketqua(@mssv INT)
AS
BEGIN

    SELECT DiemThi.mssv, DiemThi.mamh,DiemThi.lanthi,DiemThi.diem
    FROM DiemThi
    WHERE DiemThi.mssv = @mssv

END

GO



-- 2. Cơ sở dữ liệu quản lý các trận đấu bóng đá tại một
--  sân vận động có chứa 3 bảng dữ liệu được mô tả như
--  sau:
--  Doi(msdoi, tendoi, phai)
--  Tân từ: Mỗi đội có 1 mã số (msdoi) là một số nguyên
--  phân biệt; có tên (tendoi) và thuộc phái nam hay
--  nữ (phai).
--  TranDau(mstd, ngaytd, giobd, giokt)
--  Tân từ: Mỗi trận đấu có 1 mã số (mstd) là một số
--  nguyên phân biệt với những trận đấu khác, diễn ra
--  vào 1 ngày (ngaytd), bắt đầu ở một giờ (giobd) và
--  dự kiến kết thúc tại một giờ (giokt).
--  DoiThiDau(msdt, msdoi)
--  Tân từ: Lưu trữ danh sách các đội (msdoi) tham gia
--  thi đấu trong các trận đấu (msdt). Biết rằng, mỗi
--  trận đấu là một cuộc gặp gỡ giữa 2 đội và cả 2 đội
--  phải thuộc cùng một phái.

--  2.1 Viết lệnh tạo bảng với các ràng buộc khóa chính,
--  khóa ngoại được nêu trong tân từ. Kiểu dữ liệu
--  của các trường tự chọn theo ngữ nghĩa.

CREATE TABLE Doi (
    msdoi INT PRIMARY KEY,
    tendoi NVARCHAR(100),
    phai NVARCHAR(3)
);

CREATE TABLE TranDau (
    mstd INT PRIMARY KEY,
    ngaytd DATE,
    giobd TIME,
    giokt TIME
);

CREATE TABLE DoiThiDau (
    msdt INT PRIMARY KEY,
    msdoi1 INT,
    msdoi2 INT,
    FOREIGN KEY (msdoi1) REFERENCES Doi(msdoi),
    FOREIGN KEY (msdoi2) REFERENCES Doi(msdoi),
    FOREIGN KEY (msdt) REFERENCES TranDau(mstd)
);


-- 2.2 Khai báo bổ sung các ràng buộc:
-- Ràng buộc giờ bắt đầu và giờ kết thúc trong bảng TranDau:

ALTER TABLE TranDau
ADD CONSTRAINT CHK_GioBD_GioKT CHECK (giobd < giokt);

-- Ràng buộc không bắt đầu ở cùng một giờ thi đấu cho các trận đấu trong cùng một ngày trong bảng TranDau:

ALTER TABLE TranDau
ADD CONSTRAINT CHK_GioBD_UniquePerDay UNIQUE (ngaytd, giobd);


--  2.3 Tạo các khung nhìn sau:
--  • Tạo view vwDoiChuaThiDau dùng liệt kê
--  danh sách các đội chưa có mã số đội trong
--  bảng DoiThiDau gồm: Mã số đội, tên đội,
--  phái.
--  • Tạo view vwSoTranDau dùng thống kê số
--  trận đấu diễn ra trong từng ngày thi đấu
--  với các thông tin: Ngày thi đấu và số trận
--  đấu trong ngày.
GO

CREATE VIEW vw_DoiChuaThiDau 
AS
    SELECT *
    FROM  Doi
    WHERE Doi.msdoi NOT IN (
        SELECT DoiThiDau.msdoi1
        FROM DoiThiDau
    )
    AND
    Doi.msdoi NOT IN (
        SELECT DoiThiDau.msdoi2
        FROM DoiThiDau
    )


GO


CREATE VIEW vw_SoTranDau
AS
    SELECT ngaytd,COUNT(*) AS sotrandau
    FROM TranDau
    GROUP BY ngaytd

GO

-- 2.4 Tạo insert trigger cho bảng DoiThiDau dùng
--  kiểm tra ràng buộc mỗi trận đấu chỉ là một
--  cuộc gặp gỡ giữa 2 đội và cả 2 đội phải thuộc
--  cùng một phái.


CREATE TRIGGER trg_doithidau
ON DoiThiDau
FOR INSERT AS
BEGIN
    DECLARE @msdoi1 INT , @phai1 NVARCHAR(5),@msdoi2 INT,@phai2 NVARCHAR(5)

    SELECT @msdoi1 = msdoi1 FROM inserted
    SELECT @msdoi2 = msdoi2 FROM inserted

    SELECT @phai1 = phai FROM Doi WHERE Doi.msdoi = @msdoi1
    SELECT @phai2 = phai FROM Doi WHERE Doi.msdoi = @msdoi2

    IF @phai1 <> @phai2
    BEGIN
        PRINT(N'Hai đội phải cùng 1 phái')
        ROLLBACK TRANSACTION
        RETURN 
    END

    IF EXISTS(SELECT 1 FROM DoiThiDau WHERE msdt = (
        SELECT msdt 
        FROM inserted
        ) AND (
        msdoi1 = @msdoi1 OR msdoi2 = @msdoi1 OR msdoi1 = @msdoi2 OR msdoi2 = @msdoi2 
        )
    )
    BEGIN
        PRINT N'Mỗi trận đấu chỉ là một cuộc gặp gỡ giữa 2 đội'
        ROLLBACK TRANSACTION
        RETURN
    END

END


--  2.5 Tạo thủ tục hoặc hàm hiển thị thông tin 2 đội
--  tham gia trong một trận đấu khi biết mã số
--  trận đấu. Nếu mã trận đấu không có trong bảng
--  DoiThiDau thì hiện thị thông báo lỗi. Mã số
--  trận đấu là giá trị input.
GO

CREATE PROCEDURE sp_hienthithongtin(@msdt INT)
AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM TranDau AS T
        WHERE T.mstd = @msdt 
    )
    BEGIN
        SELECT DoiThiDau.msdoi1,DoiThiDau.msdoi2
        FROM TranDau 
        JOIN DoiThiDau
        ON TranDau.mstd = DoiThiDau.msdt
        WHERE TranDau.mstd = @msdt
    END
    ELSE
    BEGIN
        PRINT N'Mã số trận đấu không tồn tại'
        RETURN -1
    END
END



-- 3. Cơ sở dữ liệu quản lý hóa đơn bán hàng có chứa 3
--  bảng dữ liệu được mô tả như sau:

--  MatHang(msmh, tenmh, dongia, soton)
--  Tân từ: Mỗi mặt hàng có một mã số (msmh) là một
--  số nguyên phân biệt, có tên mặt hàng (tenmh), đơn
--  giá (dongia) bán mới nhất của mặt hàng đó và số
--  lượng hàng tồn kho (soton)

--  HoaDon(mshd, ngaylap)
--  Tân từ: Mỗi hóa đơn có một mã số phân biệt (mshd),
--  ngày lập hóa đơn (ngaylap).

--  CTHD(mshd, msmh, soluong, dongiahd))
--  Tân từ: Mỗi hóa đơn (mshd) ghi một hoặc nhiều mặt
--  hàng (msmh) cùng với số lượng (soluong) và đơn giá
--  bán tại thời điểm ghi hóa đơn (dongiahd)

-- 3.1 Viết lệnh tạo bảng với các ràng buộc khóa chính,
--  khóa ngoại được nêu trong tân từ. Kiểu dữ liệu
--  của các trường tự chọn theo ngữ nghĩa

CREATE TABLE MatHang (
    msmh INT PRIMARY KEY,
    tenmh NVARCHAR(100) UNIQUE,
    dongia DECIMAL(18, 2),
    soton INT DEFAULT 0
);

CREATE TABLE HoaDon (
    mshd INT PRIMARY KEY,
    ngaylap DATE
);

CREATE TABLE CTHD (
    mshd INT,
    msmh INT,
    soluong INT,
    dongiahd DECIMAL(18, 2),
    PRIMARY KEY (mshd, msmh),
    FOREIGN KEY (mshd) REFERENCES HoaDon(mshd),
    FOREIGN KEY (msmh) REFERENCES MatHang(msmh)
);

--  3.2 Khai báo bổ sung các ràng buộc sau:
--  • Số tồn (soton) trong bảng MatHang có giá
--  trị mặc định bằng 0.
--  • Tên mặt hàng trong bảng MatHang có giá
--  trị phân biệt giữa các mặt hàng.


ALTER TABLE MatHang
ALTER COLUMN soton INT DEFAULT 0;

ALTER TABLE MatHang
ADD CONSTRAINT UC_TenMatHang UNIQUE (tenmh);


-- 3.3 Tạo các khung nhìn sau:

--  • Tạo view vwTienHD dùng hiển thị tiền bán
--  trên từng hóa đơn gồm các thông tin: mã
--  số hóa đơn, ngày lập, tiền hóa đơn bằng
--  tổng tiền bán từng mặt hàng ghi trên mỗi
--  hóa đơn.

--  • Tạo view vwHangKhongBanDuoc dùng liệt
--  kê danh sách các mặt hàng không bán được
--  trong tháng hiện hành.
GO

CREATE VIEW vw_TienHD 
AS 
    SELECT H.mshd,H.ngaylap,SUM(C.soluong * M.dongia) AS Tongtien
    FROM HoaDon AS H
    JOIN CTHD AS C
    ON H.mshd = C.mshd
    JOIN MatHang AS M
    ON C.msmh = M.msmh
    GROUP BY H.mshd,H.ngaylap
    

GO

CREATE VIEW vwHangKhongBanDuoc
AS
    SELECT M.msmh,M.tenmh
    FROM MatHang AS M
    JOIN CTHD AS C
    ON M.msmh = C.msmh
    JOIN HoaDon AS H
    ON H.mshd = C.mshd
    WHERE MONTH(H.ngaylap) = MONTH(GETDATE()) AND M.msmh NOT IN (
        SELECT *
        FROM MatHang 
    )

GO


--  3.4 Xây dựng Insert trigger cho bảng CTHD thực
--  hiện yêu cầu: khi thêm một chi tiết hóa đơn
--  phải cập nhật lại số lượng tồn của mặt hàng
--  tương ứng.


CREATE TRIGGER trg_themctdh
ON CTHD
FOR INSERT AS
BEGIN
    UPDATE MatHang
    SET soluong = soluong - inserted.soluong 
    FROM MatHang
    JOIN inserted
    ON MatHang.msmh = inserted.msmh
END



--  3.5 Viết thủ tục hoặc hàm nhận 2 giá trị input kiểu
--  số nguyên là tháng và năm. Hãy liệt kê doanh
--  thu của từng mặt hàng gồm các thông tin: mã
--  số mặt hàng, doanh thu mặt hàng trong
--  • Một năm nếu tháng là NULL và năm khác
--  NULL
--  • Một tháng nếu tháng và năm khác NULL
GO


CREATE PROCEDURE sp_LietKeDoanhThu(@thang INT = NULL,@nam INT = NULL)
AS
BEGIN
    IF @thang IS NULL AND @nam IS NOT NULL
    BEGIN
        SELECT CTHD.msmh AS MaMatHang,SUM(CTHD.soluong * CTHD.dongiahd) AS DoanhThu
        FROM CTHD
        JOIN HoaDon ON CTHD.mshd = HoaDon.mshd
        WHERE YEAR(HoaDon.ngaylap) = @nam
        GROUP BY CTHD.msmh;
    END
    ELSE IF @thang IS NOT NULL AND @nam IS NOT NULL
    BEGIN
        
        SELECT  CTHD.msmh AS MaMatHang, SUM(CTHD.soluong * CTHD.dongiahd) AS DoanhThu
        FROM CTHD
        INNER JOIN HoaDon ON CTHD.mshd = HoaDon.mshd
        WHERE MONTH(HoaDon.ngaylap) = @thang AND YEAR(HoaDon.ngaylap) = @nam
        GROUP BY CTHD.msmh;
    END
    ELSE
    BEGIN
        PRINT 'Vui lòng cung cấp tháng hoặc năm hoặc cả hai.';
    END;
END;


-- 4. Cơ sở dữ liệu quản lý việc mượn trả sách có chứa 3
--  bảng dữ liệu được mô tả như sau:

--  Sach(masach, tensach, soluong, sodamuon)
--  Tân từ: Mỗi tựa sách có một mã số (masach) là một
--  số nguyên phân biệt, có tên sách (tensach), số lượng
--  (soluong), và số sách hiện đã cho mượn (sodamuon).

--  DocGia(madg, tendg)

--  Tân từ: Mỗi độc giả có một mã số độc giả (madg) là
--  một số nguyên phân biệt, có tên độc giả (tendg).

--  PhieuMuon(madg, ngaymuon, masach, ngaytra))

--  Tân từ: Mỗi ngày mỗi độc giả chỉ được mượn một
--  quyển sách. Khi độc giả mượn sách cần ghi nhận
--  mã độc giả (madg), ngày mượn (ngaymuon), mã sách
--  (masach), ngày trả sách (ngaytra). Ngày trả sách là
--  NULL khi chưa trả sách.

--  4.1 Viết lệnh tạo bảng với các ràng buộc khóa chính,
--  khóa ngoại được nêu trong tân từ. Kiểu dữ liệu
--  của các trường tự chọn theo ngữ nghĩa.


CREATE TABLE Sach (
    masach INT PRIMARY KEY,
    tensach NVARCHAR(100),
    soluong INT,
    sodamuon INT,
    CHECK (soluong >= sodamuon)
);

CREATE TABLE DocGia (
    madg INT PRIMARY KEY,
    tendg NVARCHAR(100)
);

CREATE TABLE PhieuMuon (
    madg INT,
    ngaymuon DATE DEFAULT GETDATE(), 
    masach INT,
    ngaytra DATE NULL,
    PRIMARY KEY (madg, masach), 
    FOREIGN KEY (madg) REFERENCES DocGia(madg),
    FOREIGN KEY (masach) REFERENCES Sach(masach)
);


--  4.2 Khai báo bổ sung các ràng buộc sau:
--  • Số lượng sách (soluong) trong bảng Sach
--  không nhỏhơnsốsáchđãmượn(sodamuon).
--  • Ngày mượn sách (ngaymuon) trong bảng
--  PhieuMuon có giá trị mặc định là ngày hiện
--  hành.

ALTER TABLE Sach
ADD CONSTRAINT CHK_SoLuongSoDaMuon CHECK (soluong >= sodamuon);


--  4.3 Tạo các khung nhìn sau:
--  • Tạo view vwHetSach dùng liệt kê các sách
--  có số lượng sách (soluong) bằng với số
--  lượng sách đã cho mượn (sodamuon) gồm
--  các thông tin: Mã sách, tên sách.

--  • Tạoview vwChuaTraSach dùnghiểnthịdanh
--  sách các độc giả chưa trả sách (có ngày trả
--  là rỗng) gồm các thông tin: mã độc giả, tên
--  độc giả, ngày mượn, tên sách đã mượn.
GO

CREATE VIEW vw_HetSach 
AS
    SELECT Sach.masach,Sach.tensach
    FROM Sach
    WHERE Sach.soluong = Sach.sodamuon

GO

CREATE VIEW vw_ChuaTraSach
AS
    SELECT PhieuMuon.madg,PhieuMuon.ngaymuon,Sach.tensach
    FROM PhieuMuon
    JOIN Sach
    ON PhieuMuon.masach = Sach.masach
    WHERE PhieuMuon.ngaytra IS NULL

GO


--  4.4 Tạo update trigger trên bảng PhieuMuon thực
--  hiện yêu cầu sau: Khi sửa ngày trả của một
--  phiếu mượn từ giá trị NULL sang một giá trị
--  khác NULL thì phải giảm số lượng sách đã mượn
--  của tựa sách tương ứng trên bảng Sach, ngược
--  lại nếu sửa ngày trả từ một giá trị khác NULL
--  sang giá trị NULL thì phải tăng số lượng sách đã
--  mượn của tựa sách tương ứng trên bảng Sach.

CREATE TRIGGER trg_PhieuMuon
ON PhieuMuon
FOR INSERT AS
BEGIN

    IF UPDATE(ngaymuon)

        DECLARE @ngaytracu DATE,@ngaytramoi DATE, @masach INT

        SELECT @ngaytracu = deleted.ngaytra FROM deleted
        SELECT @ngaytramoi = inserted.ngaytra FROM inserted
        SELECT @masach = inserted.masach FROM inserted

        IF (@ngaytracu IS NULL AND  @ngaytramoi IS NOT NULL)
        BEGIN
            UPDATE Sach 
            SET soluong = soluong - 1
            WHERE masach = @masach 
        END
        IF ELSE (@ngaytracu IS NOT NULL AND @ngaytramoi IS NULL)
        BEGIN
            UPDATE Sach
            SET soluong = soluong + 1
            WHERE masach = @masach
        END
    END
END



--  4.5 Tạo thủ tục hoặc hàm trả về số sách còn có thể
--  cho mượn (soluong– sodamuon) của một mã
--  sách nào đó. Trong đó, mã sách là giá trị input.
--  Hiển thị thông báo lỗi nếu mã sách không tồn
--  tại trong bảng Sach
GO


CREATE PROCEDURE sp_sosachconcothemuon(@masach INT)
AS
BEGIN
    IF EXISTS(
        SELECT *
        FROM Sach 
        WHERE Sach.masach = @masach
    )
    BEGIN
        SELECT masach, SUM(soluong - sodamuon) AS SOLUONGSACH
        FROM Sach 
    END
    ELSE
    BEGIN
        PRINT N'Mã sách này không tồn tại'
        RETURN -1
    END
END


-- 5. Cơ sở dữ liệu quản lý lương hành chánh có chứa 3
--  bảng dữ liệu được mô tả như sau:

--  NgachLuong(msngach, mota)

--  Tântừ: Hệthốnglương hànhchánhgồmnhiềungạch,
--  mỗi ngạch lương có một mã số (msngach) là một số
--  nguyên phân biệt, mục mô tả (mota) dùng chỉ định
--  nhân viên thực hiện công việc nào, bằng cấp nào thì
--  thuộc ngạch lương này.

--  DMNgachBac(msngach, bac, hsluong)

--  Tân từ: Mỗi ngạch lương (msngach) có nhiều bậc
--  lương (bac). Mỗi bậc lương là một số nguyên có giá
--  trị từ 1 trở đi phân biệt trong cùng một ngạch lương.
--  Mỗi bậc trong một ngạch lương có một hệ số lương
--  (hsluong).

--  NhanVien(msnv,ho,ten,msngach,bac,ngaynlcc))
--  Tân từ: Mỗi nhân viên có một mã số (msnv) là một
--  số nguyên phân biệt, có họ (ho), tên (ten), thuộc
--  ngạch lương (msngach), bậc lương (bac) và ngày
--  nâng lương cuối cùng (ngaynlcc).

--  5.1 Viết lệnh tạo bảng với các ràng buộc khóa chính,
--  khóa ngoại được nêu trong tân từ. Kiểu dữ liệu
--  của các trường tự chọn theo ngữ nghĩa.

--  5.2 Khai báo bổ sung các ràng buộc sau:
--  • Hệsốlương(hsluong) phải phân biệt trong
--  cùng mộtngạchlương (msngach) trong bảng
--  DMNgachBac.

--  • Bậc lương (bac) trong bảng NhanVien có
--  giá trị mặc định bằng 1.

CREATE TABLE NgachLuong (
    msngach INT PRIMARY KEY,
    mota NVARCHAR(255)
);

CREATE TABLE DMNgachBac (
    msngach INT,
    bac INT,
    hsluong FLOAT,
    PRIMARY KEY (msngach, bac),
    FOREIGN KEY (msngach) REFERENCES NgachLuong(msngach)
);

CREATE TABLE NhanVien (
    msnv INT PRIMARY KEY,
    ho NVARCHAR(50),
    ten NVARCHAR(50),
    msngach INT,
    bac INT DEFAULT 1, -- Bậc lương có giá trị mặc định là 1
    ngaynlcc DATE,
    FOREIGN KEY (msngach) REFERENCES NgachLuong(msngach),
    FOREIGN KEY (msngach, bac) REFERENCES DMNgachBac(msngach, bac)
);


ALTER TABLE DMNgachBac
ADD CONSTRAINT UQ_hsluong UNIQUE (msngach, hsluong);


-- 5.3 Tạo các khung nhìn sau:
--  • Tạo view vwhsluong dùng liệt kê hệ số
--  lương của mỗi nhân viên gồm các thông
--  tin: mã số nhân viên, mã số ngạch, bậc, hệ
--  số lương.
GO

CREATE VIEW vwhsluong
AS
    SELECT N.msnv,D.msngach,D.bac,D.hsluong
    FROM NhanVien AS N
    JOIN DMNgachBac AS D
    ON N.msngach = D.msngach


--  • Tạo view vwNangLuong dùng liệt kê nhân
--  viên có số tháng tính từ ngày nâng lương
--  cuối cùng (ngaynlcc) đến ngày hiện hành
--  có giá trị không nhỏ hơn 24 tháng.

GO

CREATE VIEW vw_NangLuong
AS
    SELECT msnv,ho,ten
    FROM NhanVien
    WHERE (MONTH(ngaynlcc) - MONTH(GETDATE())) >= 24


GO



--  5.4 Tạo update trigger cho bảng NhanVien để kiểm
--  tra ràng buộc: Khi nâng bậc lương (bac) của
--  một nhân viên thì bậc lương mới không lớn hơn
--  bậc lương cao nhất trong ngạch lương của nhân
--  viên (ví dụ, ngạch lương mã số 15113 có số thứ
--  tự bậc lương từ 1 đến 10 thì bậc lương mới của
--  nhân viên có mã ngạch 15113 không được lớn
--  hơn 10).

CREATE TRIGGER trg_Check_BacLuong
ON NhanVien
FOR INSERT,UPDATE
AS
BEGIN
    DECLARE @msngach INT, @max_bac INT;
    
    
    SELECT @msngach = msngach FROM inserted;

    
    SELECT @max_bac = MAX(bac) FROM DMNgachBac WHERE msngach = @msngach;

    
    IF (SELECT bac FROM inserted) <= @max_bac
    BEGIN
        UPDATE NhanVien
        SET ho = inserted.ho,
            ten = inserted.ten,
            msngach = inserted.msngach,
            bac = inserted.bac,
            ngaynlcc = inserted.ngaynlcc
        FROM inserted
        WHERE NhanVien.msnv = inserted.msnv;
    END
    ELSE
    BEGIN
        PRINT N'Bac luong moi khong duoc lon hon bac luong cao nhat trong ngach luong'
        ROLLBACK TRANSACTION
        RETURN
    END
END



--  5.5 Tạo thủ tục hoặc hàm trả về danh sách nhân
--  viên đã được nâng lương trong một năm (nghĩa
--  là có ngày nâng lương cuối cùng thuộc năm tìm
--  kiếm). Trong đó, năm là một giá trị Input kiểu
--  số nguyên. Nếu năm là NULL thì trả về danh
--  sách nhân viên đã được nâng lương trong năm
--  hiện hành.
GO

CREATE PROCEDURE sp_NhanVienNangLuong(@nam INT = NULL)
AS
BEGIN
    IF @nam IS NULL
    BEGIN
        SET @nam = YEAR(GETDATE());
    END

    SELECT msnv, ho, ten, msngach, bac, ngaynlcc
    FROM NhanVien
    WHERE YEAR(ngaynlcc) = @nam;
END

