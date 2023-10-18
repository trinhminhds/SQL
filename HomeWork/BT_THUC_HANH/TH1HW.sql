USE TH1QUANLYBANHANG;
-- BÀI THỰC HÀNH Ở NHÀ SỐ 1

-- 1
SELECT *
FROM th1quanlybanhang.khachhang_copy AS K
ORDER BY K.DOANHSO DESC
LIMIT 3;


-- 2
SELECT COUNT(S.MASP) AS SOLUONG
FROM th1quanlybanhang.sanpham_copy AS S
WHERE S.NUOCSX = 'TRUNG QUOC';


-- 3
SELECT S.NUOCSX, COUNT(DISTINCT S.MASP) AS TONGSOSANPHAM
FROM th1quanlybanhang.SANPHAM_COPY AS S
GROUP BY S.NUOCSX;


-- 4 
SELECT S.NUOCSX, MAX(S.GIA) AS CAO, MIN(S.GIA) AS THAP , AVG(S.GIA) AS TRUNGBINH
FROM th1quanlybanhang.SANPHAM_COPY AS S
GROUP BY S.NUOCSX;


-- 5
SELECT H.NGHD, SUM(H.TRIGIA) AS DOANHTHU
FROM th1quanlybanhang.HOADON AS H
GROUP BY H.NGHD;


-- 6
SELECT C.MASP, SUM(C.SL) 
FROM th1quanlybanhang.CTHD AS C, th1quanlybanhang.HOADON AS H 
WHERE C.SOHD = H.SOHD AND month(H.NGHD) = 10 AND year(H.NGHD) = 2022 
GROUP BY C.MASP;


-- 7
SELECT H.NGHD, sum(H.TRIGIA) AS DOANHTHU
FROM th1quanlybanhang.hoadon AS H  
GROUP BY H.NGHD
HAVING month(H.NGHD) BETWEEN 1 AND 12 AND year(H.NGHD) = 2022;

-- 8
SELECT H.SOHD
FROM th1quanlybanhang.HOADON AS H
WHERE H.SOHD in (
	SELECT C.SOHD
	FROM th1quanlybanhang.cthd AS C
    WHERE H.SOHD = C.SOHD
	GROUP BY C.SOHD
	HAVING COUNT(DISTINCT C.MASP)>=4
);


-- 9

SELECT CT.SOHD, count(CT.MASP) AS SANPHAM
FROM th1quanlybanhang.CTHD AS CT, th1quanlybanhang.SANPHAM AS SP
WHERE CT.MASP = SP.MASP AND SP.NUOCSX = 'Viet Nam'
GROUP BY CT.SOHD
HAVING count(CT.MASP) >= 3;


-- 10
SELECT H.MAKH, K.HOTEN
FROM th1quanlybanhang.khachhang_copy AS K, th1quanlybanhang.hoadon AS H
WHERE K.MAKH = H.MAKH
GROUP BY H.MAKH, K.HOTEN
ORDER BY COUNT(H.MAKH) DESC
LIMIT 1;


-- 11
SELECT month(H.NGHD) AS THANG, sum(H.TRIGIA) AS DOANHTHU
FROM th1quanlybanhang.hoadon AS H  
GROUP BY H.NGHD
HAVING month(H.NGHD) BETWEEN 1 AND 12 AND year(H.NGHD) = 2022
ORDER BY SUM(H.TRIGIA) DESC
LIMIT 1;


-- 12
SELECT C.MASP, SUM(C.SL) 
FROM th1quanlybanhang.CTHD AS C, th1quanlybanhang.HOADON AS H 
WHERE C.SOHD = H.SOHD AND year(H.NGHD) = 2022 
GROUP BY C.MASP
ORDER BY SUM(C.SL) ASC
LIMIT 1 ; 



-- 13
SELECT s.NUOCSX, s.MASP, s.TENSP
FROM th1quanlybanhang.SANPHAM_COPY AS s
WHERE s.GIA in
(
    SELECT max(sp.GIA)
    FROM th1quanlybanhang.SANPHAM_COPY AS sp
    WHERE s.NUOCSX = sp.NUOCSX
);



-- 14
SELECT sp.NUOCSX
FROM th1quanlybanhang.SANPHAM_copy as sp
GROUP BY sp.NUOCSX
HAVING count(distinct SP.MASP) >= 3 AND count(distinct SP.GIA) ;

-- 15
SELECT H.MAKH, K.HOTEN, COUNT(H.MAKH) AS SOLAN
FROM th1quanlybanhang.khachhang_copy AS K, th1quanlybanhang.hoadon AS H
WHERE K.MAKH = H.MAKH
GROUP BY H.MAKH, K.HOTEN
ORDER BY COUNT(H.MAKH) DESC
LIMIT 1;
