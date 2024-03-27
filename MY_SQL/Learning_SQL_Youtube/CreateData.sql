DROP DATABASE IF EXISTS Quanlysinhvien;
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
	-- character set "minh17"
    -- collate "minh17_trinh"
USE QuanLySinhVien;

DROP TABLE IF EXISTS chuongTrinhDaoTao;
CREATE TABLE chuongTrinhDaoTao(
	maChuongTrinhDaoTao NVARCHAR(50) NOT NULL ,
    tenChuongTrinhDaoTao NVARCHAR(200),
    soTinChi FLOAT,
    namBatDauDaoTao YEAR,
	 PRIMARY KEY (maChuongTrinhDaoTao)
);
INSERT INTO chuongTrinhDaoTao VALUES ('CNTT', 'Công nghệ Thông tin', 120, 2022);
INSERT INTO chuongTrinhDaoTao VALUES ('KHMT', 'Khoa học Máy tính', 150, 2020);
INSERT INTO chuongTrinhDaoTao VALUES ('KT', 'Kế toán', 130, 2022);
INSERT INTO chuongTrinhDaoTao VALUES ('QTKD', 'Quản trị kinh doanh', 120, 2021);
INSERT INTO chuongTrinhDaoTao VALUES ('TC', 'Tài chính', 130, 2020);
INSERT INTO chuongTrinhDaoTao VALUES ('KTPM', 'Công Nghệ Thông Tin', 144 ,2022 );


DROP TABLE IF EXISTS sinhVien;
CREATE TABLE sinhVien(
	maSinhVien NVARCHAR(50) NOT NULL UNIQUE,
    hoDem NVARCHAR(50),
    ten NVARCHAR(50),
    ngaySinh DATE,
    namNhapHoc YEAR,
    maChuongTrinh NVARCHAR(50) not null,
    gioiTinh TINYINT,
    PRIMARY KEY (maSinhVien),
    CONSTRAINT FK_sinhVien_chuongTrinhDaoTao FOREIGN KEY (maChuongTrinh) REFERENCES chuongTrinhDaoTao(maChuongTrinhDaoTao)
);
INSERT INTO `sinhVien` VALUES ('01', 'Lê Nhật', 'Thảo', '2000-01-05', 2022, 'CNTT', 1);
INSERT INTO `sinhVien` VALUES ('02', 'Trần Văn', 'An', '2000-07-05', 2022, 'KHMT', 1);
INSERT INTO `sinhVien` VALUES ('03', 'Lê Thị', 'Thủy', '1999-01-05', 2020, 'QTKD', 0);
INSERT INTO `sinhVien` VALUES ('04', 'Hoàng Mỹ', 'Nương', '1999-01-06', 2020, 'QTKD', 0);
INSERT INTO `sinhVien` VALUES ('05', 'Nguyên Hoàng', 'Yến', '1999-12-16', 2022, 'CNTT', 0);



DROP TABLE IF EXISTS monHoc;
CREATE TABLE monHoc(
	maMonHoc varchar(50)  NOT NULL,
  tenMonHoc varchar(255)  NULL DEFAULT NULL,
  soTinChi float NULL DEFAULT 0,
  namBatDauApDung int NULL DEFAULT 0,
  theLoai varchar(50) ,
  moTaTomTat varchar(1024) ,
  maTaDayDu text ,
  taiLieu varchar(1024) ,
  mucTieuDauRa varchar(1024) ,
  hinhThucDanhGia varchar(1024) ,
  MaChuongTrinhDaoTao NVARCHAR(50) not null,
     PRIMARY KEY (maMonHoc),
	 CONSTRAINT FK_monHoc_chuongTrinhDaoTao FOREIGN KEY (MaChuongTrinhDaoTao) REFERENCES chuongTrinhDaoTao(maChuongTrinhDaoTao)
);
INSERT INTO `monHoc` VALUES ('CSKH', 'Chăm sóc khách hàng', 5, 2021, 'Tự chọn', '0', NULL, '', '', 'Thi Trắc nghiệm', 'QTKD');
INSERT INTO `monHoc` VALUES ('TRR', 'Toán Rời Rạc', 3, 2020, 'Bắt buộc', 'Môn học này cung cấp kiến thức về Toán Rời Rạc', NULL, 'Giáo trình Toán Rời rạc', 'Sinh viên năm được kiến thức TRR', 'Thi viết', 'CNTT');

DROP TABLE IF EXISTS nhanVien;
CREATE TABLE nhanVien(
	maNhanVien NVARCHAR(50) NOT NULL UNIQUE,
	hoDem NVARCHAR(50),
    ten NVARCHAR(50),
    theLoai NVARCHAR(100),
    ngaySinh DATE,
    gioiTinh TINYINT,
    PRIMARY KEY(maNhanVien)
);
INSERT INTO `nhanVien` VALUES (1, 'Nguyễn Văn', 'Thành', 'Giảng viên', '1990-01-15', 1);
INSERT INTO `nhanVien` VALUES (2, 'Nguyễn Thị', 'Vân', 'Giảng viên', '1995-07-10', 0);
INSERT INTO `nhanVien` VALUES (3, 'Trân Thanh', 'Thiện', 'Giảng viên', '1970-08-17', 1);
INSERT INTO `nhanVien` VALUES (4, 'Lâm Minh', 'Anh', 'Chuyên viên', '1988-03-05', 0);
INSERT INTO `nhanVien` VALUES (5, 'Thái Vân', 'Tiên', 'Chuyên viên', '1955-01-19', 1);


DROP TABLE IF EXISTS lopHocPhan;
CREATE TABLE lopHocPhan(
  maLopHoc VARCHAR(50) NOT NULL ,
  MaMonHoc varchar(50)  NOT NULL,
  namHoc int NOT NULL,
  hocKy varchar(50)  NOT NULL,
  maNhanVienGiangDay NVARCHAR(50) NOT NULL UNIQUE,
  ngonNguGiangDay varchar(50)  NOT NULL,
  moTa text  NOT NULL,
  gioiHanSoLuongSinhVien int NOT NULL,
    PRIMARY KEY (maLopHoc),
	CONSTRAINT FK_lopHocPhan_monHoc	FOREIGN KEY (MaMonHoc) REFERENCES monHoc(maMonHoc),
	CONSTRAINT FK_lopHocPhan_nhanVien FOREIGN KEY (maNhanVienGiangDay) REFERENCES nhanVien(maNhanVien)
);
INSERT INTO lopHocPhan VALUES (4, 'TRR', 2022, 'Học kỳ 1', 4, 'Tiếng Việt', '', 50);
INSERT INTO lopHocPhan VALUES (5, 'CSKH', 2022, 'Học kỳ 1', 1, 'Tiếng Anh', '', 100);


DROP TABLE IF EXISTS nguoiDung;
CREATE TABLE nguoiDung (
	tenNguoiDung NVARCHAR(50) NOT NULL UNIQUE,
    matKhau NVARCHAR(50),
    theLoai NVARCHAR(50),
    MaNhanVien NVARCHAR(50),
    MaSinhVien NVARCHAR(50),
    PRIMARY KEY(tenNguoiDung),
    CONSTRAINT FK_nguoiDung_sinhVien FOREIGN KEY (MaSinhVien) REFERENCES sinhVien(maSinhVien),
    CONSTRAINT FK_nguoiDung_nhanVien FOREIGN KEY (MaNhanVien) REFERENCES nhanVien(maNhanVien)
);

INSERT INTO `nguoiDung` VALUES ('abc', '456', 'Sinh viên', NULL, '01');
INSERT INTO `nguoiDung` VALUES ('lam1', '123', 'Giảng viên', 4, NULL);

DROP TABLE IF EXISTS thamGiaHoc;
CREATE TABLE thamGiaHoc(
	MaLopHoc VARCHAR(50) not null,
    MaSinhVien NVARCHAR(50) not null UNIQUE,
	diemSo FLOAT,
    diemchu NVARCHAR(50),
    PRIMARY KEY (MaLopHoc,MaSinhVien),
    CONSTRAINT FK_thamGiaHoc_lopHocPhan FOREIGN KEY(MaLopHoc) REFERENCES lopHocPhan(maLopHoc),
    CONSTRAINT FK_thamGiaHoc_sinhVien FOREIGN KEY(MaSinhVien) REFERENCES sinhVien(maSinhVien)
);
INSERT INTO `thamGiaHoc` VALUES (4, '01', NULL, NULL);
INSERT INTO `thamGiaHoc` VALUES (4, '02', NULL, NULL);
INSERT INTO `thamGiaHoc` VALUES (5, '03', NULL, NULL);
INSERT INTO `thamGiaHoc` VALUES (5, '04', NULL, NULL);
INSERT INTO `thamGiaHoc` VALUES (5, '05', NULL, NULL);









