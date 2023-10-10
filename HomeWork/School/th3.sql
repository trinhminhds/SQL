DROP DATABASE IF EXISTS TH3QLNV;
CREATE DATABASE TH3QLNV;

USE TH3QLNV;


CREATE TABLE PHONG(
    MAPH CHAR(3) NOT NULL PRIMARY KEY,
    TENPH VARCHAR(40),
    DIACHI VARCHAR(50),
    TEL CHAR(10)
);


CREATE TABLE DMNN(
    MANN CHAR(2) NOT NULL PRIMARY KEY,
    TENNN VARCHAR(20)

);


CREATE TABLE NHANVIEN(
    MANV CHAR(5) NOT NULL PRIMARY KEY,
    HOTEN VARCHAR(40),
    GT VARCHAR(3),
    NGSINH DATE,
    LUONG INT,
    MAPH CHAR(3),
    SDT CHAR(10),
    NGAYBC DATE,
    FOREIGN KEY (MAPH) REFERENCES PHONG(MAPH)
);


CREATE TABLE TDNN(
    MANV CHAR(5),
    MANN CHAR(2),
    TDO CHAR(1),
    PRIMARY KEY (MANV,MANN),
    CONSTRAINT PK_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    CONSTRAINT PK_NN FOREIGN KEY (MANN) REFERENCES DMNN(MANN)
);


INSERT INTO PHONG 
VALUES
('HCA', 'Hành chính tổ hợp', '371 Nguyễn Kiệm', '0362588541'),
('KDA', 'Kinh doanh', '371 Nguyễn Kiệm', '0362517395'),
('KTA', 'Kỹ thuật', '371 Nguyễn Kiệm', '0362567401'),
('QTA', 'Quản trị', '371 Nguyễn Kiệm', '0362565788');

INSERT INTO DMNN 
VALUES
('01', 'Anh'),
('02', 'Nga'),
('03', 'Pháp'),
('04', 'Nhật'),
('05', 'Trung Quốc'),
('06', 'Hàn Quốc');

INSERT INTO NHANVIEN 
VALUES
('HC001', 'Nguyễn Thị Hà', 'Nữ', '1966-8-27', 7500000, 'HCA', NULL, '1995-2-8'),
('HC002', 'Trần Văn Nam', 'Nam', '1995-6-12', 8000000, 'HCA', NULL, '2017-6-8'), 
('HC003', 'Nguyễn Thanh Huyền', 'Nữ', '1993-7-3', 6500000, 'HCA', NULL, '2019-9-24'),
('KD001', 'Lê Tuyết Anh', 'Nữ', '1992-3-2', 7500000, 'KDA', NULL, '2021-10-2'),
('KD002', 'Nguyễn Anh Tú', 'Nam', '1962-7-4', 7600000, 'KDA', NULL, '2000-7-14'),
('KD003', 'Phạm An Thái', 'Nam', '1977-5-9', 6600000, 'KDA', NULL, '2019-10-13'),
('KD004', 'Lê Văn Hải', 'Nam', '1976-1-2', 7900000, 'KDA', NULL, '2017-6-8'), 
('KD005', 'Nguyễn Phương Minh', 'Nam', '1980-1-2', 7000000, 'KDA', NULL, '2021-10-2'),
('KT001', 'Trần Đình Khâm', 'Nam', '1971-2-12', 7700000, 'KTA', NULL, '2022-1-1'),
('KT002', 'NguyễN Mạnh Hùng', 'Nam', '1991-8-16', 7300000, 'KTA', NULL, '2022-1-1'),
('KT003', 'Phạm Thanh Sơ', 'Nam', '1994-8-20', 7100000, 'KTA', NULL, '2022-1-1'),
('KT004', 'Vũ Thị Hoài', 'Nữ', '1995-12-5', 7500000, 'KTA', NULL, '2021-10-2'),
('KT005', 'Nguyễn Thu La', 'Nữ', '1994-10-5', 8000000, 'KTA', NULL, '2021-10-2'),
('KT006', 'Trần Hoài Nam', 'Nam', '1978-7-2', 7800000, 'KTA', NULL, '2017-6-8'),
('TT007', 'Hoàng Nam Sơ', 'Nam', '1969-12-3', 8200000, NULL, NULL, '2015-7-2'),
('KT008', 'Lê Thu Trang', 'Nữ', '1970-7-6', 7500000, 'KTA', NULL, '2018-8-2'),
('KT009', 'Khúc Nam Hải', 'Nam', '1980-7-22', 7000000, 'KTA', NULL, '2015-1-1'),
('TT010', 'Phùng Trung Dũng', 'Nam', '1978-8-28', 7200000, NULL, NULL, '2022-9-24');

INSERT INTO TDNN 
VALUES 
('HC001', '01', 'A'),
('HC001', '02', 'B'),
('HC002', '01', 'C'),
('HC002', '03', 'C'),
('HC003', '01', 'D'),
('KD001', '01', 'C'),
('KD001', '02', 'B'),
('KD002', '01', 'D'),
('KD002', '02', 'A'),
('KD003', '01', 'B'),
('KD003', '02', 'C'),
('KD004', '01', 'C'),
('KD004', '04', 'A'),
('KD004', '05', 'A'),
('KD005', '01', 'B'),
('KD005', '02', 'D'),
('KD005', '03', 'B'),
('KD005', '04', 'B'), 
('KT001', '01', 'D'),
('KT001', '04', 'E'),
('KT002', '01', 'C'), 
('KT002', '02', 'B'),
('KT003', '01', 'D'),
('KT003', '03', 'C'), 
('KT004', '01', 'D'), 
('KT005', '01', 'C');

