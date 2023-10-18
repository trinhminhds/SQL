

-- 1
SELECT P.DIACHI,P.TEL
FROM th3qlnv.phong AS P
WHERE P.MAPH  = 'KDA';

-- 2
SELECT N.MANV,N.HOTEN,N.NGAYBC
FROM th3qlnv.nhanvien AS N
WHERE N.LUONG > 7000000; 


-- 3
SELECT *
FROM th3qlnv.nhanvien AS N
ORDER BY N.NGSINH DESC;


-- 4
SELECT N.MANV,N.HOTEN,N.NGSINH
FROM th3qlnv.nhanvien AS N
WHERE N.MAPH = 'KTA';

-- 5
SELECT *
FROM th3qlnv.nhanvien AS N
WHERE N.NGAYBC < '2017-1-1' AND N.MAPH IN ('KTA','KDA');


-- 6
SELECT N.MANV,N.HOTEN,N.NGSINH,D.TENNN,T.TDO
FROM th3qlnv.nhanvien AS N
INNER JOIN TH3QLNV.TDNN AS T
ON N.MANV = T.MANV
INNER JOIN th3qlnv.dmnn AS D
ON T.MANN = D.MANN
WHERE T.MANN IN ('01','03') AND T.TDO = 'C';



-- 7
SELECT *
FROM th3qlnv.DMNN AS D
WHERE D.MANN NOT IN (
	SELECT T.MANN
    FROM th3qlnv.TDNN AS T
);


-- 8
SELECT *
FROM th3qlnv.nhanvien AS N
WHERE N.MANV NOT IN (
	SELECT N.MANV
    FROM th3qlnv.tdnn AS T
    WHERE N.MANV = T.MANV
);


-- 9
SELECT COUNT(*) AS SOLUONG
FROM th3qlnv.nhanvien AS N
WHERE N.GT = 'NU';



-- 10
SELECT N.MANV,N.HOTEN, COUNT(T.MANN) AS SLNN
FROM th3qlnv.nhanvien AS N
INNER JOIN th3qlnv.tdnn AS T
ON N.MANV = T.MANV
GROUP BY N.MANV, N.HOTEN
HAVING COUNT(T.MANN) >= 3;



-- 11
SELECT N.MAPH,P.TENPH,SUM(N.LUONG) AS TONGLUONG
FROM th3qlnv.nhanvien AS N
INNER JOIN th3qlnv.phong AS P
ON N.MAPH = P.MAPH 
GROUP BY N.MAPH,P.TENPH;


-- 12
SELECT N.MAPH, MAX(N.LUONG), MIN(N.LUONG), AVG(N.LUONG),COUNT(N.MANV)
FROM th3qlnv.nhanvien AS N
INNER JOIN TH3QLNV.PHONG AS P
ON N.MAPH = P.MAPH
GROUP BY N.MAPH;


-- 13
UPDATE th3qlnv.NHANVIEN AS N
SET N.LUONG = N.LUONG * 1.15
WHERE N.MAPH = 'KTA'; 

-- 14
CREATE TABLE NGHI_HUU(
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

INSERT INTO NGHI_HUU
SELECT * 
FROM th3qlnv.nhanvien AS N
WHERE (year(curdate()) - year(N.NGSINH) >= 60 AND N.GT = 'NAM') 
OR (year(curdate()) - year(N.NGSINH) >= 55 AND N.GT = 'NU'); 

DELETE FROM th3qlnv.nhanvien AS N
WHERE (year(curdate()) - year(N.NGSINH) >= 60 AND N.GT = 'NAM') 
OR (year(curdate()) - year(N.NGSINH) >= 55 AND N.GT = 'NU'); 


-- 15
CREATE TABLE TDNN_NH(
    MANV CHAR(5),
    MANN CHAR(2),
    TDO CHAR(1),
    PRIMARY KEY (MANV,MANN),
    CONSTRAINT FK_NGH FOREIGN KEY (MANV) REFERENCES nghi_huu(MANV)
);    
INSERT INTO TDNN_NH
VALUES 
('HC001', '01', 'A'),
('HC001', '02', 'B'),
('KD002', '01', 'D'),
('KD002', '02', 'A');


ALTER TABLE th3qlnv.TDNN
ADD CONSTRAINT FK_NGH FOREIGN KEY (MANV) REFERENCES nghi_huu(MANV) ON DELETE NO ACTION;




