DROP DATABASE IF EXISTS db_Starbucks_Coffee;
GO
CREATE DATABASE db_Starbucks_Coffee
GO
USE db_Starbucks_Coffee

GO


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


ALTER TABLE CHUCVU 
ADD PRIMARY KEY (MACV);
GO 


ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_CHUCVU_NHANVIEN
FOREIGN KEY (MACV) REFERENCES CHUCVU(MACV);
GO 


ALTER TABLE CHINHANH
ADD PRIMARY KEY (MACN)
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_CHINHANH_NHANVIEN
FOREIGN KEY (MACN) REFERENCES CHINHANH(MACN);
GO

ALTER TABLE BAOCAO
ADD PRIMARY KEY (MABC)
GO

ALTER TABLE PHIEUCHI 
ADD PRIMARY KEY (MAPC)
GO

ALTER TABLE PHIEUPHUTHU
ADD PRIMARY KEY (MAPHIEUPT)
GO



ALTER TABLE PHIEUNHAP
ADD PRIMARY KEY (MAPN)
GO

ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT FK_PHIEUNHAP_CHITIET_PN
FOREIGN KEY (MAPN) REFERENCES PHIEUNHAP(MAPN)
GO



ALTER TABLE NHACUNGCAP
ADD PRIMARY KEY (MANCC)
GO
ALTER TABLE PHIEUNHAP
ADD CONSTRAINT FK_NHACUNGCAP_PHIEUNHAP
FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC)
GO



ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT PK_CHITIET_PHIEUNHAP PRIMARY KEY (MANL,MAPN)
GO
ALTER TABLE CHITIET_PHIEUNHAP
ADD CONSTRAINT FK_CHITIET_PN_NGUYENLIEU
FOREIGN KEY (MANL) REFERENCES NGUYENLIEU(MANL)
GO




ALTER TABLE NGUYENLIEU
ADD PRIMARY KEY (MANL)
GO


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

ALTER TABLE THUCUONG
ADD PRIMARY KEY (MATU)
GO
ALTER TABLE THUCUONG
ADD CONSTRAINT FK_THUCUONG_LOAITHUCUONG
FOREIGN KEY (MALOAI) REFERENCES LOAITHUCUONG(MALOAI)
GO

ALTER TABLE LOAITHUCUONG
ADD PRIMARY KEY (MALOAI)
GO




ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT PK_CHITIET_HOADON PRIMARY KEY (MATU,MAHD)
GO

ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT FK_THUCUONG_CT_HOADON
FOREIGN KEY (MATU) REFERENCES THUCUONG(MATU)
GO


ALTER TABLE HOADON
ADD PRIMARY KEY (MAHD) 
GO

ALTER TABLE CHITIET_HOADON
ADD CONSTRAINT FK_HOADON_CHITIET_HD
FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD)
GO

ALTER TABLE KHUVUC
ADD PRIMARY KEY (MAKV)
GO

ALTER TABLE HOADON
ADD CONSTRAINT FK_KHUVUC_HOADON
FOREIGN KEY (MAKV) REFERENCES KHUVUC(MAKV)










