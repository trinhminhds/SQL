USE qlsvSchool


GO
ALTER TABLE sinhvien
ADD CONSTRAINT PK_SINHVIEN PRIMARY KEY (masv);

GO
ALTER TABLE hocphan
ADD CONSTRAINT PK_HOCPHAN PRIMARY KEY(mahp);

GO
ALTER TABLE khoa
ADD CONSTRAINT PK_KHOA PRIMARY KEY(makhoa);

GO
ALTER TABLE nganh
ADD CONSTRAINT PK_NGANH PRIMARY KEY(manganh);

GO
ALTER TABLE lop
ADD CONSTRAINT PK_LOP PRIMARY KEY(malop);

GO
ALTER TABLE sinhvien
ADD CONSTRAINT FK_LOP_SINHVIEN FOREIGN KEY (malop) REFERENCES lop(malop);

GO
ALTER TABLE ketqua
ADD CONSTRAINT FK_SINHVIEN_KETQUA1 FOREIGN KEY(masv)REFERENCES sinhvien(masv);

GO
ALTER TABLE ketqua
ADD CONSTRAINT FK_HOCPHAN_KETQUA FOREIGN KEY (mahp) REFERENCES hocphan(mahp);

GO
ALTER TABLE nganh
ADD CONSTRAINT FK_NGANH_KHOA FOREIGN KEY(makhoa) REFERENCES khoa(makhoa);

GO
ALTER TABLE lop
ADD CONSTRAINT FK_LOP_NGANH FOREIGN KEY(manganh)REFERENCES nganh(manganh);


--1
SELECT masv, hodem, ten, malop,
 CONVERT(VARCHAR(10),ngaysinh,103) ngaysinh,
 CASE gioitinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END
 AS gioitinh, YEAR(ngaysinh) AS namsinh
 FROM sinhvien
 WHERE hodem NOT LIKE N'[NLT]%';


-- 2
SELECT masv, hodem, ten, malop,
 CONVERT(VARCHAR(10),ngaysinh,103) ngaysinh,
 CASE gioitinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END
 AS gioitinh, YEAR(ngaysinh) AS namsinh
 FROM sinhvien
 WHERE malop IN ('PM23','PM24') AND gioitinh = 1;


--3 
SELECT masv, hodem, ten, malop,
 CONVERT(VARCHAR(10),ngaysinh,103) ngaysinh,
 CASE gioitinh WHEN 1 THEN N'Nam' ELSE N'Nữ' END
 AS gioitinh, YEAR(ngaysinh) AS namsinh
 FROM sinhvien
 WHERE (YEAR(GETDATE()) - YEAR(ngaysinh)) >= 19 AND (YEAR(GETDATE()) - YEAR(ngaysinh)) <= 20;



 -- 4

 SELECT masv, hodem,ten,L.malop
 FROM sinhvien AS SV
 JOIN lop AS L
 ON L.malop = SV.malop
 ORDER BY L.malop ASC,hodem ASC ,ten ASC;



-- 5
 SELECT SV.masv, hodem, ten, K.mahp, diem,hocky
 FROM sinhvien AS SV
 JOIN ketqua AS K
 ON K.masv = SV.masv
 JOIN hocphan AS H
 ON K.mahp = H.mahp
 WHERE diem BETWEEN 5 AND 7 AND  H.hocky = 1;



-- Dạng 4: ALL, ANY, EXISTS

--  1. Cho biết sinh viên có điểm cao nhất.

SELECT SinhVien.masv, hodem, ten, mahp, diem
 FROM KetQua JOIN SinhVien
 ON SinhVien.masv = KetQua.masv
 WHERE diem >= ALL(SELECT diem FROM KetQua)


--  2. Cho biết sinh viên có tuổi lớn nhất.

SELECT hodem, ten, YEAR(GETDATE())- YEAR(ngaysinh)
 FROM SinhVien
 WHERE YEAR(GETDATE())- YEAR(ngaysinh) >=
 ALL (SELECT YEAR(GETDATE())- YEAR(ngaysinh)
 FROM SinhVien)


--  3. Sinh viên có điểm học phần ’001’ cao nhất.

SELECT SinhVien.masv, hodem, ten
 FROM KetQua JOIN SinhVien
 ON KetQua.masv = SinhVien.masv
 WHERE mahp = '001' AND diem >=
 ALL(SELECT diem FROM KetQua WHERE mahp = '001')


--  4. Khoa nào có số lượng sinh viên nhiều nhất.

SELECT k.makhoa,k.tenkhoa
FROM khoa as k
JOIN nganh as n
ON k.makhoa = n.makhoa
JOIN lop as l
ON l.manganh = n.manganh
JOIN sinhvien as s
ON s.malop = l.malop
WHERE COUNT(*) >= ALL(SELECT COUNT(*) FROM sinhvien);



--  5. Cho biết mãsinh viên, mã học phần có điểm lớn
--  hơn bất kỳ các điểm của sinh viên mã ’2401’.

SELECT S.masv,H.mahp
FROM sinhvien as s
JOIN ketqua as k
ON s.masv = k.masv 
JOIN hocphan as h
ON k.mahp = h.mahp
WHERE s.masv = '2401' AND diem >= ALL(Select diem FROM ketqua WHERE masv = '2401');



--  6. Cho biết sinh viên có điểm học phần nào đó lớn
--  hơn gấp rưỡi điểm trung bình của sinh viên đó.

SELECT S.masv
FROM sinhvien as s
JOIN ketqua as k
ON s.masv = k.masv 
WHERE diem >= ALL(Select AVG(diem)*1.5 FROM ketqua);



--  7. Cho biết lớp nào không có sinh viên học.

SELECT l.malop
FROM lop as l
WHERE NOT EXISTS (SELECT malop FROM sinhvien WHERE malop = l.malop);


--  8. Cho biết sinh viên nào chưa học học phần nào.

SELECT s.masv,s.malop
FROM sinhvien AS S
WHERE NOT EXISTS (SELECT masv FROM ketqua WHERE S.masv = masv);


--  9. Sinh viên nào học cả hai học phần’001’ và ’002’.

SELECT DISTINCT s.masv
FROM sinhvien AS S
WHERE EXISTS (SELECT masv FROM ketqua WHERE S.masv = masv AND mahp = '001' AND mahp = '002');


--  10. Sinh viên nào học một trong hai học phần trên.

SELECT DISTINCT s.masv
FROM sinhvien AS S
WHERE EXISTS (SELECT masv FROM ketqua WHERE S.masv = masv AND mahp IN ('001','002'));



-- Dạng 5: Cập nhật, xóa, bổ sung dữ liệu


-- 1. Bổ sung một dòng dữ liệu cho bảng Khoa bộ
--  giá trị sau: (’KT’, ’Kế toán’,’0961669078’).

INSERT INTO Khoa(makhoa,tenkhoa) VALUES ('KT',N'Kế toán')
 
 

--  2. Thêmmộtsinh viên bất kỳ vào bảng SinhVien.


--  3. Thêm điểm học phần bất kỳ vào bảng KetQua.


--  4. Xóa các sinh viên có DTB < 3 (buộc thôi học).

DELETE FROM SinhVien
WHERE masv IN (
    SELECT masv 
    FROM KetQua
    WHERE AVG(diem) < 3
);

--  5. Xóa các sinh viên không học học phần nào.

DELETE FROM SinhVien 
WHERE masv NOT IN (SELECT DISTINCT masv FROM KetQua)

--  6. Xóa khỏi bảng Lop những lớp không có sinh
--  viên nào.

DELETE FROM lop 
WHERE malop NOT IN (
    SELECT malop
    FROM sinhvien
)


--  7. Thêm cột XepLoai vào bảng SinhVien, cập
--  nhật dữ liệu cột XepLoai theo yêu cầu sau:
--  • Nếu DTB >=8 thì xếp loại Giỏi
--  • Nếu DTB >=7 thì xếp loại Khá
--  • Nếu DTB >=5 thì xếp loại Trung bình
--  • Ngược lại là Yếu

ALTER TABLE SinhVien
ADD XepLoai NVARCHAR(20);

UPDATE SinhVien
SET sinhvien.XepLoai = CASE
    WHEN k.diem >= 8 THEN N'Giỏi'
    WHEN k.diem >= 7 THEN N'Khá'
    WHEN k.diem >= 5 THEN N'Trung bình'
    ELSE N'Yếu'
END
FROM sinhvien as s
JOIN ketqua as k
ON s.masv = k.masv


--  8. Thêm cột XetLenLop vào bảng SinhVien, cập
--  nhật dữ liệu cột XetLenLop theo yêu cầu sau:
--  • Nếu DTB >=5 thì được lên lớp, ngược lại
--  • Nếu DTB >=3 tạm ngừng tiến độ học tập
--  • Ngược lại buộc thôi học

ALTER TABLE SinhVien ADD xetlenlop nvarchar(50)

UPDATE sinhvien
SET xetlenlop = CASE
    WHEN k.diem >= 5 THEN N'Lên lớp'
    WHEN k.diem >= 3 THEN N'Tạm ngừng'
    ELSE N'Thôi học'
END
FROM sinhvien as s
JOIN ketqua as k
ON k.masv = s.masv


create database QLGH
go 
use QLGH
alter table donDatHang add constraint fk_maNhanVien foreign key (ma_nhan_vien) references nhanVien(maNhanVien)
alter table donDatHang add constraint fk_maKH foreign key (ma_khach_hang) references khachhangg(ma_khach_hang)
alter table ctdh add constraint fk_soHD foreign key (so_hoa_don) references donDatHang(so_hoa_don)
alter table ctdh add constraint fk_mahang foreign key (ma_hang) references mathangaa(ma_hang)
alter table mathangaa add constraint fk_maCTy foreign key (ma_cong_ty) references NhaCungCap(ma_cong_ty)
alter table mathangaa add constraint fk_maLHang foreign key (ma_loai_hang) references loaihang(ma_loai_hang)



---- Sử dụng câu lệnh SELECT để viết các yêu cầu truy vấn dữ liệu sau đây:
--1. Cho biết danh sách các đối tác cung cấp hàng.
select * from matHangaa


--2.  Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty.
select ma_hang, ten_hang, so_luong
from matHangaa

--3. Họ tên và địa chỉ và năm bắt đầu làm việc của các nhân viên trong công ty.
select 
ho + tên as HoTen, diachi, YEAR(ngayLamViec) as namlamviec
from nhanVien

--4.  Địa chỉ và điện thoại của nhà cung cấp có tên giao dịch VINAMILK là gì? do dữ liệu e ko giông nên là e xin đổi tên khác nha

select dia_chi, dien_thoai, ten_giao_dich
from NhaCungcap
where ten_giao_dich = 'NYSE'

--5.  Cho biết mã và tên của các mặt hàng có giá lớn hơn 100000 và số lượng hiện có ít hơn 50. Do e khác dữ liệu nên e để 10000 nha 

select * from matHangaa
select ma_hang, ten_hang, so_luong, gia_hang
from matHangaa
where gia_hang = 10000 and so_luong < 50

--6. Mỗi mặt hàng trong công ty do ai cung cấp.
select ma_hang,ten_cong_ty
from matHangaa
join NhaCungcap on  NhaCungcap.ma_cong_ty = matHangaa.ma_cong_ty

--7.  Công ty Việt Tiến đã cung cấp mặt hàng nào?

select ten_cong_ty, ten_hang
from NhaCungcap
join matHangaa on matHangaa.ma_cong_ty = NhaCungcap.ma_cong_ty
where ten_cong_ty = 'Lazz'

--8. Loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ của các công ty đó là gì?. em sửa lại là Stone nha 
select ten_cong_ty, ten_hang, dia_chi
from NhaCungcap
join matHangaa on matHangaa.ma_cong_ty = NhaCungcap.ma_cong_ty
where ten_hang = 'Stone'

--9. Những khách hàng nào (tên giao dịch) đã đặt mua mặt hàng Sữa hộp XYZ của công ty?. e đổi lại cho khớp với dữ liệu tạo ra
select * from donDatHang
select distinct ten_giao_dich,ten_hang, ten_cong_ty
from NhaCungcap
join matHangaa on matHangaa.ma_cong_ty = NhaCungcap.ma_cong_ty
where ten_giao_dich = 'NASDAQ' and ten_hang = 'Plastic';

--10. Đơn đặt hàng số 1 do ai đặt, do nhân viên nào lập, thời gian, địa điểm giao hàng là ở đâu?
select so_hoa_don as donhangso1,ten_giao_dich as khachhang, ma_nhan_vien, ngay_dat_hang as thoigian, noi_giao_hang as diadiem
from donDatHang
join khachhangg on khachhangg.ma_khach_hang = donDatHang.ma_khach_hang
where so_hoa_don =37690973


--11. Số tiền lương phải trả cho mỗi nhân viên là bao nhiêu (lương = lương cơ bản + phụ cấp).
select ho  +' '+ tên as hoten, luong + Allowances as sotienluong
from nhanVien

--12. Trong đơn đặt hàng số 3 đặt mua những mặt hàng nào và số tiền mà khách hàng phải trả cho mỗi mặt hàng là bao nhiêu (số tiền phải trả
-- được tính theo công thức: soluong*giaban*(1 - mucgiamgia/100). em đổi lại dữ liệu cho khop



select * from ctdh
select 
ctdh.so_hoa_don, mathangaa.ten_hang, ctdh.so_luong*ctdh.gia_ban*(1 - muc_giam_gia/100) as sotientra
from ctdh
join matHangaa on matHangaa.ma_hang = ctdh.ma_hang
where so_hoa_don = '2193697167'
	
--  13. Khách hàng nào lại chính là đối tác cung cấp hàng của công ty (tức là có cùng tên giao dịch).
select *from nhanVien
-- 14.  Những nhân viên nào có cùng ngày sinh?
SELECT 
n1.maNhanVien AS nhanvien1, 
n1.ho + ' ' + n1.tên AS hoten1, 
n1.Ngaythangnam AS ngaysinh, 
n2.maNhanVien AS nhanvien2, 
n2.ho + ' ' + n2.tên AS hoten2
FROM nhanVien n1, nhanVien n2
WHERE n1.Ngaythangnam = n2.Ngaythangnam AND n1.maNhanVien < n2.maNhanVien;


--16. Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và các nhà cung cấp hàng.
select NhaCungcap.ten_cong_ty, khachhangg.ten_giao_dich, dia_chi, dien_thoai
from NhaCungcap,khachhangg

--17. Những mặt hàng nào chưa từng được đặt mua?/ Do e tạo mã nào cũng có đơn hàng 
select ma_hang, ten_hang
from mathangaa
where ma_hang not in (select distinct ma_hang from ctdh)

--18. Những nhân viên nào của công ty chưa từng lập bất kỳ một hóa đơn đặt hàng nào? do e tạo nhân viên nào cũng có hóa đơn hết 
select maNhanVien, ho  +' '+ tên as hoten,so_hoa_don
from nhanVien
join donDatHang on donDatHang.ma_nhan_vien= nhanVien.maNhanVien
where so_hoa_don  not in (select distinct so_hoa_don from ctdh)

--19. Những nhân viên nào của công ty có lương cơ bản cao nhất?
select top(5) maNhanVien, ho  +' '+ tên as hoten, luong as luongcoban
from nhanVien
order by luong desc

--20.  Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu? 
SELECT
    so_hoa_don,
    SUM(so_luong * gia_ban * (1 - muc_giam_gia / 100)) AS tong_tien
FROM
    ctdh
GROUP BY
    so_hoa_don;

--21. Trong năm 2022, những mặt hàng nào chỉ được đặt mua đúng một lần.
SELECT ma_hang, ten_hang
FROM matHangaa
WHERE ma_hang IN (
    SELECT ma_hang
    FROM ctdh
    WHERE YEAR() = 2022
    GROUP BY ma_hang
    HAVING COUNT(DISTINCT so_hoa_don) = 1
);

--22. Hãy cho biết mỗi một khách hàng đã phải bỏ ra bao nhiêu tiền để đặt mua hàng của công ty?
select ma_khach_hang, so_luong*gia_ban as tienBoRa
from ctdh
join donDatHang on donDatHang.so_hoa_don = ctdh.so_hoa_don

--23. Mỗimộtnhânviêncủacôngtyđãlậpbaonhiêu đơn đặt hàng (nếu nhân viên chưa hề lập một hóa đơn nào thì cho kết quả là 0)
select
 ho +' '+tên as hoTen,
ISNULL (count (so_hoa_don), 0) as dondathang
from nhanVien
JOIN donDatHang on donDatHang.ma_nhan_vien = nhanVien.maNhanVien
group by ho +' '+tên

--24. Số tiền nhiều nhất mà mỗi khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu?
SELECT khachhangg.ten_giao_dich, MAX(so_luong * gia_ban) AS tienBoRa 
FROM ctdh
JOIN donDatHang ON ctdh.so_hoa_don = donDatHang.so_hoa_don 
JOIN khachhangg ON donDatHang.ma_khach_hang = khachhangg.ma_khach_hang 
GROUP BY khachhangg.ten_giao_dich;

--25. Cho biết tổng số tiền hàng mà cửa hàng thu được trong mỗi tháng của năm 2022 (thời được gian tính theo ngày đặt hàng).
SELECT
    MONTH(ngay_dat_hang) AS Moithang,
    SUM(so_luong * gia_ban * (1 - muc_giam_gia / 100)) AS tong_tien
FROM
    ctdh
	join donDatHang on donDatHang.so_hoa_don = ctdh.so_hoa_don
WHERE
    YEAR(ngay_dat_hang) = 2022
GROUP BY
    MONTH(ngay_dat_hang)
ORDER BY
    Moithang;

--26. Hãy cho biết dơn đặt hàng nào có số lượng hàng được đặt mua ít nhất?
SELECT TOP 1
    so_hoa_don,
    SUM(so_luong) AS tong_so_luong
FROM
    ctdh
GROUP BY
    so_hoa_don
ORDER BY
    tong_so_luong ASC;
--27. Hãy cho biết tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2022.
SELECT
    matHangaa.ma_hang,
    matHangaa.ten_hang,
    SUM(ctdh.so_luong * (ctdh.gia_ban - matHangaa.gia_hang)) AS tong_loi
FROM
    ctdh
JOIN
    matHangaa ON ctdh.ma_hang = matHangaa.ma_hang
join donDatHang on donDatHang.so_hoa_don = ctdh.so_hoa_don
WHERE
    YEAR(donDatHang.ngay_dat_hang) = 2022
GROUP BY
    matHangaa.ma_hang, matHangaa.ten_hang;

--28. Cho biết tổng số lượng hàng của mỗi mặt hàng mà công ty đã có (tổng số lượng hàng hiện có và đã bán).
SELECT
    matHangaa.ma_hang,
    matHangaa.ten_hang,
    COALESCE(SUM(ctdh.so_luong), 0) AS tong_so_luong
FROM
    matHangaa
LEFT JOIN
    ctdh ON matHangaa.ma_hang = ctdh.ma_hang
GROUP BY
    matHangaa.ma_hang, matHangaa.ten_hang;

--29. Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng bán được của những nhân viên này là bao nhiêu?
SELECT top(3)
   maNhanVien,
  ho + ' ' + tên AS hoTen,
    COALESCE(SUM(ctdh.so_luong), 0) AS sobanduoc
FROM
    nhanVien
LEFT JOIN
    donDatHang ON nhanVien.maNhanVien = donDatHang.ma_nhan_vien
LEFT JOIN
    ctdh ON donDatHang.so_hoa_don = ctdh.so_hoa_don
GROUP BY
    nhanVien.maNhanVien, nhanVien.ho, nhanVien.tên
ORDER BY
    sobanduoc DESC

--30. Mỗi một đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền mà mỗi đơn đặt hàng phải trả là bao nhiêu?
SELECT
    donDatHang.so_hoa_don,
    ctdh.ma_hang,
    matHangaa.ten_hang,
    ctdh.so_luong,
    ctdh.gia_ban,
    ctdh.muc_giam_gia,
    ctdh.so_luong * ctdh.gia_ban * (1 - ctdh.muc_giam_gia / 100) AS tong_tien
FROM
    donDatHang
JOIN
    ctdh ON donDatHang.so_hoa_don = ctdh.so_hoa_don
JOIN
    matHangaa ON ctdh.ma_hang = matHangaa.ma_hang;

--31. Hãy cho biết mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng hàng của mỗi loại và tổng số lượng của tất cả các mặt hàng hiện
--có trong công ty là bao nhiêu?


SELECT
    loaihang.tenHang,
    COUNT(matHangaa.ma_hang) AS so_mat_hang,
    SUM(matHangaa.so_luong) AS tong_so_luong
FROM
    loaihang
LEFT JOIN
    matHangaa ON loaihang.ma_loai_hang = matHangaa.ma_loai_hang
GROUP BY
    loaihang.tenHang;

--33.  Cập nhật lại giá trị trường NGAYCHUYENHANG
--của những bản ghi có NGAYCHUYENHANG chưa
 --xác định (NULL) trong bảng DONDATHANG bằng
 --với giá trị của trường NGAYDATHANG.
UPDATE DONDATHANG
SET ngay_chuyen_hang = ngay_dat_hang
WHERE ngay_chuyen_hang IS NULL;

--34. Tăng số lượng hàng của những mặt hàng do công ty VINAMILK cung cấp lên gấp đôi.

UPDATE mathangaa
SET so_luong = so_luong * 2
WHERE ma_cong_ty IN (SELECT ma_cong_ty 
					FROM NhaCungcap 
					WHERE ten_giao_dich = 'VINAMILK');

--35. Cập nhật giá trị của trường NOIGIAOHANG bằng
 --địa chỉ của khách hàng đối với những đơn đặt
-- hàng chưa xác định được nơi giao hàng (giá trị
 --trường NOIGIAOHANG bằng NULL).
  update donDatHang
  set noi_giao_hang = khachhangg.dia_chi
  from donDatHang
  join khachhangg on khachhangg.ma_khach_hang = donDatHang.ma_khach_hang
  where donDatHang. noi_giao_hang IS NULL

--36. Cập nhật lại bảng KHACHHANG sao cho nếu tên
 --công ty và tên giao dịch của khách hàng trùng
 --với tên công ty và tên giao dịch của một nhà
 --cung cấp nào đó thì địa chỉ, điện thoại, fax và
 --e-mail phải giống nhau.
UPDATE khachhangg
SET dia_chi = NhaCungCap.dia_chi,
    dien_thoai = NhaCungCap.dien_thoai,
    fax = NhaCungCap.fax,
    email = NhaCungCap.email
FROM khachhangg
JOIN NhaCungCap ON khachhangg.ten_cong_ty = NhaCungCap.ten_cong_ty AND khachhangg.ten_giao_dich = NhaCungCap.ten_giao_dich;


--37. Tăng lương lên gấp rưỡi cho nhân viên bán được số lượng hàng nhiều hơn 100 trong năm 2022.

UPDATE nhanVien
SET luong = luong * 1.5
WHERE maNhanVien IN (
    SELECT nhanVien.maNhanVien
    FROM nhanVien
    JOIN donDatHang ON nhanVien.maNhanVien = donDatHang.ma_nhan_vien
    JOIN ctdh ON donDatHang.so_hoa_don = ctdh.so_hoa_don
    WHERE YEAR(donDatHang.ngay_dat_hang) = 2022
    GROUP BY nhanVien.maNhanVien
    HAVING SUM(ctdh.so_luong) > 100
);

--38. Tăng phụ cấp lên bằng 50% lương cho những nhân viên bán được hàng nhiều nhất.
-- Tăng phụ cấp lên 50% lương cho những nhân viên bán được hàng nhiều nhất
UPDATE nhanVien
SET Allowances = Allowances + (luong * 0.5)
WHERE maNhanVien IN (
    SELECT TOP 5 WITH TIES nhanVien.maNhanVien
    FROM nhanVien
    JOIN donDatHang ON nhanVien.maNhanVien = donDatHang.ma_nhan_vien
    JOIN ctdh ON donDatHang.so_hoa_don = ctdh.so_hoa_don
    GROUP BY nhanVien.maNhanVien
    ORDER BY SUM(ctdh.so_luong) DESC
);

 --39.Giảm 25% lương của nhân viên trong năm 2022 không lập được bất kỳ đơn đặt hàng nào.
 update nhanVien
 set luong = luong -(luong*0.25)
 where maNhanVien in
 (
 select nhanVien.maNhanVien
 from nhanVien
 JOIN donDatHang ON nhanVien.maNhanVien = donDatHang.ma_nhan_vien
 JOIN ctdh ON donDatHang.so_hoa_don = ctdh.so_hoa_don
 WHERE YEAR(donDatHang.ngay_dat_hang) = 2022
 GROUP BY nhanVien.maNhanVien
having  SUM(ctdh.so_hoa_don) < 0
 );

 --40.  Giả sử trong bảng DONDATHANG có thêm trường
 --SOTIEN cho biết số tiền mà khách hàng phải trả
 --trong mỗi đơn đặt hàng. Hãy tính giá trị cho
 --trường này.

-- Cập nhật giá trị cho trường SOTIEN trong bảng donDatHang dựa trên thông tin từ bảng ctdh
ALTER TABLE donDatHang
ADD SOTIEN bigint

UPDATE donDatHang
SET SOTIEN = ctdh.so_luong * ctdh.gia_ban * (1 - ctdh.muc_giam_gia / 100)
FROM donDatHang
JOIN ctdh ON ctdh.so_hoa_don = donDatHang.so_hoa_don;

--41.  Xóa khỏi bảng NHANVIEN những nhân viên đã
 --làm việc trong công ty quá 40 năm.
 DELETE FROM NHANVIEN
WHERE DATEDIFF(YEAR, ngayLamViec, GETDATE()) >= 40;

--42.  Xóa những đơn đặt hàng trước năm 2020.

DELETE FROM donDatHang
WHERE YEAR(ngay_dat_hang) < 2020;

--43. Xóa khỏi bảng LOAIHANG những loại hàng hiện không có mặt hàng.
DELETE FROM LOAIHANG
WHERE ma_loai_hang NOT IN (SELECT DISTINCT ma_loai_hang FROM mathangaa);

--44. Xóa khỏi bảng KHACHHANG những khách hàng
 --hiện không có bất kỳ đơn đặt hàng nào cho
 --công ty.
 delete from khachhangg
 where ma_khach_hang not in (select distinct ma_khach_hang from donDatHang);

 --45.  Xóa khỏi bảng MATHANG những mặt hàng có số
 --lượng bằng 0 và không được đặt mua trong bất
 --kỳ đơn đặt hàng nào.
 DELETE FROM mathangaa
WHERE so_luong = 0 AND ma_hang NOT IN (SELECT DISTINCT ma_hang FROM ctdh);



USE QLBANHANG;

-- 1

SELECT makh,tenkh,sdt
FROM khachhang
WHERE loaikh = 'TV';


--2 
SELECT makh, tenkh, sdt,diachi
FROM khachhang
WHERE loaikh = 'VIP' AND diachi IN ('Long An','HCM');


-- 3
SELECT COUNT(mahd) AS slhdxuat 
FROM hoadon
WHERE MONTH(ngaylap) = 1;


--4
SELECT *
FROM mathang
WHERE gia BETWEEN 20000 AND 50000;

--5
SELECT c.mahd
FROM cthd as c
JOIN hoadon AS H
ON c.mahd = H.mahd
WHERE c.soluong >= 50
GROUP BY c.mahd;


--6
SELECT C.mahd,M.mamh,M.tenmh,M.gia,C.soluong,SUM(gia*soluong) as tongtien
FROM cthd as c
JOIN mathang as M
ON c.mamh = m.mamh
WHERE c.mahd = 'HD01'
GROUP BY C.mahd,M.mamh,M.tenmh,M.gia,C.soluong;


--7
SELECT C.mahd,M.mamh,M.tenmh,M.gia,C.soluong,SUM(gia*soluong) as tongtien
FROM cthd as c
JOIN mathang as M
ON c.mamh = m.mamh
GROUP BY C.mahd,M.mamh,M.tenmh,M.gia,C.soluong
HAVING SUM(gia*soluong) BETWEEN 300000 AND 500000;


--8
SELECT *
FROM khachhang as k
JOIN hoadon as H
ON k.makh = h.makh
WHERE MONTH(ngaylap) != 1;

--9
SELECT H.mahd,H.ngaylap,K.makh,SUM(m.gia*c.soluong) as tongtien
FROM khachhang as k
JOIN hoadon as H 
ON k.makh = h.makh
JOIN cthd AS c
ON c.mahd = h.mahd
JOIN mathang AS M
ON m.mamh = c.mamh
WHERE MONTH(ngaylap) = 2
GROUP BY h.mahd,H.ngaylap,K.makh;


-- 10
SELECT DISTINCT m.mamh,m.tenmh
FROM mathang as M
JOIN cthd as c
ON m.mamh = c.mamh


-- Dạng 2: Câu lệnh truy vấn có phân nhóm
-- Bài tập tự giải

-- 1.Cho biết mã khách hàng, tên khách hàng, tổng thành tiền của từng khách hàng.

SELECT k.makh,k.tenkh,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
GROUP BY k.makh,k.tenkh;

-- 2. Cho biết mã khách hàng, tên khách hàng, tổng thành tiền của khách hàng VIP.
SELECT k.makh,k.tenkh,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
WHERE K.loaikh = 'VIP'
GROUP BY k.makh,k.tenkh;


--  3. Cho biết mã khách hàng, tên khách hàng, tổng thành tiền của từng khách hàng có tổng thành tiền mua được >=1 triệu.
SELECT k.makh,k.tenkh,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
GROUP BY k.makh,k.tenkh
HAVING SUM(M.gia*C.soluong) >= 1000000;


--  4. Cho biết mã mặt hàng, tên mặt hàng, Tổng số lượng của từng mặt hàng.

SELECT m.mamh,m.tenmh,SUM(soluong) as Tongslhang
FROM mathang as m
JOIN cthd as c
ON m.mamh = c.mamh
GROUP BY m.mamh,m.tenmh;

-- 5. Cho biết mã hóa đơn, tổng thành tiền của những hóa đơn có tổng thành tiền lớn hơn 1 triệu.

SELECT C.mahd, SUM(M.gia*C.soluong) tongTien
FROM cthd AS C
JOIN mathang as m
ON m.mamh = c.mamh
GROUP BY c.mahd
HAVING SUM(M.gia*C.soluong) >= 1000000;

-- 6. Cho biết hóa đơn bán ít nhất hai mặt hàng MH01 và MH02.

SELECT H.mahd,COUNT(DISTINCT c.mamh)
FROM hoadon as h
JOIN cthd as c
ON h.mahd = c.mahd
WHERE C.mamh IN ('MH01','MH02')
GROUP BY H.mahd
HAVING COUNT(DISTINCT c.mamh) >= 2; 


-- 7 Đếm số hóa đơn của mỗi khách hàng.

SELECT K.makh,COUNT(h.mahd) tonghdcuamoikh
FROM khachhang AS K
JOIN hoadon AS H
ON K.makh = H.makh
GROUP BY K.makh;

--  8. Cho biết thông tin khách hàng VIP có tổng thành tiến trong năm 2023 nhỏ hơn 10 triệu.

SELECT k.makh,k.tenkh,h.ngaylap,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
WHERE K.loaikh = 'VIP' AND YEAR(H.ngaylap) = 2023
GROUP BY k.makh,k.tenkh,h.ngaylap
HAVING SUM(M.gia*C.soluong) <= 10000000;


--  9. Cho biết hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hoá đơn, ngày bán, tên khách hàng, số điện thoại khách hàng, tổng trị giá của hóa đơn.

SELECT TOP 1 h.mahd,h.ngaylap,k.makh,k.sdt,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
GROUP BY h.mahd,h.ngaylap,k.makh,k.sdt
ORDER BY tongtien DESC;


-- 10. Cho biết hóa đơn có tổng trị giá lớn nhất trong tháng 10/2023 gồm các thông tin: Số hóa đơn,
-- ngày, tên khách hàng, số điện thoại khách hàng, tổng trị giá của hóa đơn.

SELECT TOP 1 h.mahd,h.ngaylap,k.makh,k.sdt,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
WHERE MONTH(h.ngaylap) = 10 AND YEAR(h.ngaylap) = 2023
GROUP BY h.mahd,h.ngaylap,k.makh,k.sdt
ORDER BY tongtien DESC;


-- 11 Cho biết hóa đơn có tổng trị giá nhỏ nhất gồm các thông tin: Số hoá đơn, ngày, tên khách
-- hàng, số điện thoại khách hàng, tổng trị giá của hóa đơn.

SELECT TOP 1 h.mahd,h.ngaylap,k.makh,k.sdt,SUM(M.gia*C.soluong) tongtien
FROM khachhang as k
JOIN hoadon as h
ON k.makh = h.makh
JOIN cthd as c 
ON h.mahd = c.mahd
JOIN mathang as m
ON m.mamh = c.mamh
GROUP BY h.mahd,h.ngaylap,k.makh,k.sdt
ORDER BY tongtien ASC;


-- 12. Cho biết thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất

SELECT TOP 1 K.makh,COUNT(H.mahd) AS SOHD
FROM khachhang as k
JOIN hoadon as h
ON K.makh = H.makh
GROUP BY K.makh
ORDER BY SOHD DESC;


-- 13  Cho biết thông tin của khách hàng có số lượng hàng mua nhiều nhất.

SELECT TOP 1 K.makh,c.soluong
FROM khachhang as k
JOIN hoadon as h
ON K.makh = H.makh
JOIN cthd as c
ON c.mahd = c.mahd
GROUP BY K.makh,c.soluong
ORDER BY c.soluong DESC;


-- 14. Cho biết thông tin về các mặt hàng mà được bán trong nhiều hoá đơn nhất

SELECT TOP 1 m.mamh,m.tenmh,COUNT(DISTINCT C.mahd) AS sohd
FROM mathang as M
JOIN cthd as c
ON m.mamh = c.mamh
GROUP BY m.mamh,m.tenmh
ORDER BY sohd DESC;


--15  Cho biết thông tin về các mặt hàng mà được bán nhiều nhất.

SELECT TOP 1 m.mamh,m.tenmh,SUM(c.soluong) AS soluong
FROM mathang as M
JOIN cthd as c
ON m.mamh = c.mamh
GROUP BY m.mamh,m.tenmh
ORDER BY soluong DESC;



-- Dạng 3: Câu truy vấn lồng nhau

-- 1  Cho biết mã, tên mặt hàng chưa được bán

SELECT DISTINCT  m.mamh,m.tenmh
FROM mathang as M
WHERE m.mamh NOT IN (SELECT C.mamh FROM cthd AS C WHERE c.mamh = m.mamh);

-- 2 Khách hàng chưa mua hàng vào tháng 1.

SELECT k.makh,k.tenkh 
FROM khachhang AS K
WHERE k.makh NOT IN (SELECT h.makh FROM hoadon as h WHERE MONTH(ngaylap) = 1); 


-- 3 Mặt hàng chưa được bán vào tháng 1.

SELECT M.mamh,M.tenmh
FROM mathang as m
Where m.mamh NOT IN(
    SELECT c.mamh 
    FROM cthd as c
    JOIN hoadon as h
    ON c.mahd = h.mahd
    WHERE MONTH(H.ngaylap) = 1
);

-- 4 Cho biết tên khách hàng có mua mặt hàng sữa.

SELECT K.makh,K.tenkh
FROM khachhang as k
WHERE k.makh IN (
    SELECT s.makh
    FROM hoadon as s
    JOIN cthd as c
    ON c.mahd = s.mahd
    JOIN mathang AS m
    ON c.mamh = m.mamh 
    WHERE M.tenmh LIKE N'Sữa%'
);


--5 Tìm những đơn hàng do khách hàng VIP mua.

SELECT h.mahd
FROM hoadon as h
WHERE h.makh IN (
    SELECT makh
    FROM khachhang AS K
    WHERE K.loaikh = 'VIP'
);