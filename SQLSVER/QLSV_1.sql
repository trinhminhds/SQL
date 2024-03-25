CREATE DATABASE qlsvSchool
USE qlsvSchool

CREATE TABLE sinhvien(
    masv VARCHAR(5),
    hodem NVARCHAR(20),
    ten NVARCHAR(20),
    ngaysinh date,
    gioitinh INT,
    noisinh NVARCHAR(100),
    malop NVARCHAR(10)
)

BULK INSERT sinhvien 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\sinhvien.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)


CREATE TABLE lop(
    malop NVARCHAR(10),
    tenlop NVARCHAR(100),
    khoa NVARCHAR(20),
    nam INT,
    hedt NVARCHAR(20),
    manganh NVARCHAR(20),
    siso VARCHAR(10)
)

BULK INSERT lop 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\lop.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)



CREATE TABLE nganh(
    manganh NVARCHAR(10),
    tennganh NVARCHAR(20),
    makhoa NVARCHAR(10)
)

BULK INSERT nganh 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\nganh.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

CREATE TABLE khoa(
    makhoa NVARCHAR(10),
    tenkhoa NVARCHAR(20),
    dienthoai CHAR(11)
)

BULK INSERT khoa 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\khoa.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

CREATE TABLE ketqua(
    masv VARCHAR(10),
    mahp VARCHAR(10),
    diem FLOAT
)

BULK INSERT ketqua 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\ketqua.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

CREATE TABLE hocphan(
    mahp VARCHAR(10),
    tenhp VARCHAR(10),
    stc TINYINT,
    hocky TINYINT
)

BULK INSERT hocphan 
FROM 'G:\My Drive\DBMS\dbms\CSV\DATA Quan Ly Sinh Vien\hocphan.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '\n'
)

