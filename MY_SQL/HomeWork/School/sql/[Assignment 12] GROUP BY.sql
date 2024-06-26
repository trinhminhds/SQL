# Sinh viên tiến hành chạy file DB.sql để lấy dữ liệu trước khi thực hiện các yêu cầu tiếp theo

USE DB;

SELECT MABM
FROM GIAOVIEN;

SELECT MABM, COUNT(*)
FROM GIAOVIEN
GROUP BY MABM;


# Xuất ra danh sách tên bộ môn và số lượng giáo viên của bộ môn đó
SELECT TENBM, COUNT(*) AS 'SLGV' -- Cột hiển thị phải là thuộc tính của GROUP BY hoặc các hàm tính tổng hợp
FROM GIAOVIEN, BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY TENBM;


# Bài tập 
-- 1. Cho biết lương trung bình của giáo viên từng bộ môn.
-- 2. Cho biết số lượng giáo viên tham gia cho mỗi đề tài.
-- 3. Xuất ra tên giáo viên và số lượng đề tài giáo viên đó đã làm.
-- 4. Xuất ra tên giáo viên và số lượng người thân của giáo viên đó.
-- 5. Xuất ra tên khoa có số lượng giáo viên trong khoa là nhiều nhất.