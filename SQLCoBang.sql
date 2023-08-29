-- SELECT 
-- FROM
SELECT [CompanyName],[Phone]
FROM [dbo].[Shippers];

SELECT CompanyName,Country,Phone
FROM dbo.Suppliers;

-- Lay toan bo cac cot trong bang
--SELECT *
--FROM
SELECT *
FROM dbo.Products;

------------------DISTINCT---------------------

-- viết câu lệnh DISTINCT lay ra ten cac quoc gia khac nhau (khong trung lap)
--SELECT DISTINCT
--FROM
SELECT DISTINCT Country
FROM dbo.Customers;

------------------------- TOP AND PERCENT ----------------- 

--Gioi Han so luong dong (hoac30%) duoc tra ve khi gioi lenh Top 
-- SELECT TOP so luong dong can lay ra PERCENT ten cot
-- FROM
SELECT TOP 3 PERCENT *
FROM dbo.Customers;


--EX 2
-- Lay cac don hang voi quy dinh 
-- mã khách hàng không trùng lặp, chỉ lấy 5 giá dòng dữ liệu đầu tiên
SELECT DISTINCT TOP 5 [CustomerID]
FROM dbo.Orders;


--EX 3
--LAY RA CAC SẢN PHẨM CÓ MÃ THỂ LOẠI KHÔNG BỊ TRÙNG LẶP
-- VÀ CHỈ LẤY RA 3 DÒNG ĐẦU
SELECT DISTINCT TOP 3 CategoryID  
FROM dbo.Products;

-------------ALIAS-----------------

-- ALIAS TÊN TRONG KHI CODE AS
-- ĐẶT TÊN THAY THẾ CHO CÁC CỘT 
-- GIÚP CHO VIỆC ĐỌC VÀ HIỂU CÂU LỆNH SQL DỄ DÀNG HƠN
--SELECT TÊN CỘT AS TÊN THAY THẾ
--FROM

SELECT CompanyName AS "Tên Công Ty",
City AS "Thành Phố",
PostalCode "Mã" --Hạn chế sử dụng bởi chỉ có SQL servel mới hiểu khi không sử dụng AS
FROM dbo.Customers;

--EX 4
-- LẤY RA 3 DÒNG ĐẦU TIÊN
-- ĐỔI CỘT LAST NAME THÀNH "HỌ"
-- ĐỔI CỘT FIRST NAME THÀNH "TÊN"

SELECT TOP 3 LastName AS "HỌ",
FirstName AS "TÊN"
FROM DBO.Employees;


--EX 5
-- ĐỔI PRODUCTNAME => TÊN SẢN PHẨM
-- SUPPEIER ID => MÃ NHÀ CUNG CẤP 
-- CATEGORY ID => MÃ THẺ LOẠI
--VÀ ĐẶT TÊN THAY THẾ CHO BẢNG PRODUCT => P, SỬ DỤNG TÊN THAY THẾ KHI TRUY VẤN CÁC CỘT BÊN TRÊN 
-- VÀ LẤY RA 5 DÒNG ĐẦU TIÊN 

SELECT TOP 5 ProductName AS "TÊN SẢN PHẨM",
SupplierID AS "MÃ NHÀ CUNG CẤP",
CategoryID AS "MÃ THỂ LOẠI"
FROM DBO.Products AS "P";


---------------------MIN AND MAX--------------------
SELECT MAX(OrderDate) AS "THỜI HẠN ĐẶT"
FROM dbo.Orders;


---TÌM RA SẢN PHẨM (LẤY MÃ VÀ TÊN SẢN PHẨM) CÓ SỐ LƯỢNG HÀNG TỒN KHO LỚN NHẤT
SELECT MAX(UnitsInStock) AS "HANG TON"
FROM dbo.Products;

-- TÌM RA NHÂN VIÊN CÓ TUỔI LỚN NHẤT
SELECT MIN(BirthDate) AS "MAXBIRTHDATE"
FROM DBO.Employees;



------------SUM - COUNT - AVG --------------

SELECT COUNT(*) AS "NUMBER"
FROM dbo.Customers;


-- TỔNG SỐ TIỀN VẬN CHUYỂN CỦA CÁC ĐƠN HÀNG
SELECT SUM(Freight) AS "SUMMONEY"
FROM dbo.Orders;


-- TÍNH TRUNG BÌNH SỐ LƯỢNG ĐẶT HÀNG CỦA  CẢ SẢN PHẨM
SELECT AVG(Quantity) AS "AVGQuatity"
FROM [dbo].[Order Details];


--EX 6
-- ĐẾM SỐ LƯỢNG, TÍNH TỔNG SỐ LƯỢNG TỒN KHO VÀ TRUNG BÌNH GIÁ CÁC SẢN PHẨM  
SELECT COUNT(*) AS "ĐẾM",
SUM(UnitsInStock - UnitsOnOrder) AS "HÀNG TỒN",
AVG(UnitPrice) AS "SẢN PHẨM"
FROM dbo.Products;


---EX 7
-- ĐẾM SỐ LƯỢNG ĐƠN HÀNG 
SELECT COUNT(*) AS "SỐ LƯỢNG ĐƠN HÀNG"
FROM dbo.Orders;

-- EX 8

SELECT AVG(UnitPrice) AS "TRUNG BÌNH",
SUM(Quantity) AS "TỔNG"
FROM dbo.[Order Details];


---------------- ORDER BY --------------
-- SẮP XẾP KẾT QUẢ TRẢ VỀ TRUY VẤN
-- ASC (ascending) SẮP XẾP TĂNG DẰN
-- DESC (descending) SẮP XẾP GIẢM DẦN

SELECT *
FROM dbo.Suppliers
ORDER BY CompanyName ASC;


-- LIỆT KÊ CÁC CẢ SẢN PHẨM THEO THỨ TỰ GIÁ GIẢM DẦN
SELECT *
FROM dbo.Products
ORDER BY UnitPrice DESC;


-- Liệt kê tất cả các họ và tên đệm nhân viên theo thứ tự tăng dần
-- Không dùng ASC AND DESC
SELECT *
FROM DBO.Employees
ORDER BY LastName,FirstName ;


---EX 9
--Lấy ra 1 sản phẩm có số lượng bán cao nhất từ bảng OD
-- kHÔNG DÙNG MAX
SELECT TOP 1 *
FROM DBO.[Order Details]
ORDER BY Quantity DESC;


-- EX 10
-- LIỆT KÊ DANH SÁCH CÁC ĐƠN ĐẶT HÀNG TRONG BẲNG ORDERS THEO THỨ TỰ GIẢM DẦN CỦA NGÀY ĐẶT HÀNG
SELECT OrderID
FROM DBO.Orders
ORDER BY OrderDate DESC;


-- EX 11
-- HÃY LIỆT KÊ TÊN, ĐƠN HÀNG, SỐ LƯỢNG TỒN KHO CỦA TẤT CẢ CÁC SẢN PHẨM TRONG BẢNG PRO THEO THỨ TỰ GIẢM DẦN CỦA UNI

SELECT ProductName,UnitPrice,UnitsInStock
FROM DBO.Products
ORDER BY UnitsInStock DESC;


------------------- TOÁN TỬ ---------------------
--- + - * / %
 
-- TÍNH TOÁN SỐ LƯỢNG HÀNG TỒN KHO 
SELECT ProductID, ProductName , (UnitsInStock - UnitsOnOrder) AS "STOCKREMAINING"
FROM DBO.Products;


SELECT OrderID,UnitPrice,Quantity, (UnitPrice * Quantity) AS "OrderDetailvalue"
FROM DBO.[Order Details];


--- Tính tỷ lệ giá vận chuyển đơn đặt hàng (Freight) trung bình của các đơn hàng trong bảng Orders
--- so với giá trị vận chuyển của đơn hàng lớn nhất (MaxFreight)

SELECT (AVG(Freight)/ MAX(Freight)) AS "FreightRatio"
FROM DBO.Orders;


-- Hãy liệt kê danh sách các sản phẩm va giá của từng sản phẩm sẽ được giảm đi 10 %
SELECT *,(UnitPrice - (UnitPrice * 0.1)) AS "DISCOUT"
FROM DBO.Products;



-------------------- WHERE --------------------
-- lọc dữ liệu trong truy vấn


-- Liệt kê tất cả các nhân viên đến thành phố London
SELECT *
FROM DBO.Employees
WHERE City = 'London'

-- Liệt kê tất cả các nhân viên đến thành phố London
-- Sắp xếp từ a -> z cột LastName
SELECT *
FROM DBO.Employees
WHERE City = 'London'
ORDER BY LastName ;


-- Liệt kê tất cả các đơn hàng giao muộn
SELECT COUNT(*) AS "ĐƠN MUỘN"
FROM DBO.Orders
WHERE ShippedDate > RequiredDate;


-- Lấy ra tất cả các đơn hàng chi tiết được giảm giá nhiều hơn 10 %
SELECT COUNT(*) AS "DC"
FROM DBO.[Order Details]
WHERE Discount > 0.1;


---- EX 12 
-- LIỆT KÊ TẤT CẢ CÁC ĐƠN HÀNG ĐƯỢC GỬI ĐẾN QUỐC GIA FRANCE
SELECT *
FROM DBO.Orders
WHERE ShipCountry = 'FRANCE';


--- EX 13
-- LIỆT KÊ CÁC SẢN PHẨM CÓ SỐ LƯỢNG HÀNG TRONG KHO LỚN HƠN 20
SELECT *
FROM DBO.Products
WHERE UnitsInStock > 20
ORDER BY UnitsInStock;



------------------- AND OR NOT --------------------


-- HÃY LIỆT KÊ TẤT CẢ SẢN PHẨM CÓ SỐ LƯỢNG TRONG KHO THUỘC KHOẢNG < 50 HOẶC > 100
SELECT *
FROM DBO.Products
WHERE UnitsInStock < 50 OR UnitsInStock > 100
ORDER BY UnitsInStock;



--LIỆT KÊ TẤT CẢ CÁC ĐƠN HÀNG ĐƯỢC GIAO ĐẾN BRAZILL ĐÃ BỊ MUỘN 
SELECT * 
FROM DBO.Orders
WHERE ShipCountry = 'BRAZIL' AND ShippedDate > RequiredDate ;



-- LẤY RA TẤT CẢ CÁC SẢN PHẨM CÓ GIÁ SẢN PHẨM DƯỚI 100 VÀ MÃ THỂ LOẠI KHÁC 1
SELECT *
FROM DBO.Products
WHERE NOT(UnitPrice >= 100 OR CategoryID = 1);



------ EX 14
--- Liệt kê tất cả các đơn hàng có giá vận chuyển trong khoảng (50,100) đô la
SELECT *
FROM DBO.Orders
WHERE Freight > 50 AND Freight < 100;


----- EX 15
--- LIỆT KÊ CÁC SẢN PHẨM CÓ SÔ LƯỢNG HÀNG TRONG KHO  > 20 
--- VÀ SỐ LƯỢNG HÀNG TRONG ĐƠN HÀNG < 20
SELECT *
FROM DBO.Products
WHERE UnitsInStock > 20 AND UnitsOnOrder < 20;



------------------- Toán tử BETWEEN ---------------
-- CHỌN DỮ LIỆU TRONG 1 KHOẢNG NHẤT ĐỊNH
--- TOÁN TỬ BETWEEN CHỌN CÁC GIÁ TRỊ TRONG 1 PHẠM VI NHẤT ĐỊNH
--- CÁC GIÁ TRỊ CÓ THỂ LÀ SỐ, KÝ TỰ, NGÀY THÁNG



--- Lấy danh sách các sản phẩm có giá bán trong khoảng 10 đến 20 
SELECT *
FROM DBO.Products
WHERE UnitPrice BETWEEN 10 AND 20;



-- Lấy danh sách các sản phẩm có đơn đặt hàng từ ngày 1996-07-01 đến 1996-07-31
SELECT *
FROM DBO.Orders
WHERE OrderDate  BETWEEN '1996-07-01' AND '1996-07-31';



-- TÍNH TỔNG SÔ TIỀN VẬN CHUYỂN CỦA CÁC ĐƠN HÀNG ĐƯỢC ĐẶT TỪ '1996-07-01' AND '1996-07-31';
SELECT SUM(Freight) AS 'TỔNG'
FROM DBO.Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';




-- LẤY DANH SÁCH CÁC SẢN PHẨM CÓ ĐƠN ĐẶT HÀNG TỪ NGÀY '1997-01-01' AND '1997-12-31' 
--- VÀ ĐI BẰNG ĐƯỜNG TÀU THỦY 
SELECT *
FROM DBO.Orders
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31' AND ShipVia = 3; 






------------------ LIKE ------------------------------
-- LỌC DỮ LIỆU TRONG CHUỖI




-- LỌC RA CÁC KHÁCH HÀNG ĐẾN TỪ CÁC QUỐC GIA BẮT ĐẦU BẰNG CHỮ 'A'
SELECT *
FROM DBO.Customers
WHERE Country LIKE 'A%';-- LẤY 1 CHỮ CÁI ĐẦU LÀ A (Argentina,Austria)



--- LẤY DANH SÁCH CÁC ĐƠN HÀNG ĐƯỢC GỬI ĐẾN CÁC THÀNH PHỐ CÓ CHỮA CHỮ 'a';
SELECT DISTINCT ShipCity
FROM DBO.Orders
WHERE ShipCity LIKE '%a%';



--- LỌC RA CÁC ĐƠN HÀNG VỚI ĐIỀU KIỆN
-- "U_" CHỈ CHỨA 1 KÝ TỰ TRỐNG Ở SAU
-- "U%" CHỨ NHIỀU KÝ TỰ TRỐNG Ở SAU
SELECT *
FROM DBO.Orders
WHERE ShipCountry LIKE 'U_';



------ EX 16
-- HÃY LẤY RA TẤT CẢ CÁC NHÀ CUNG CẤP HÀNG CÓ CHỮ 'b' TRONG TÊN CÔNG TY
SELECT *
FROM DBO.Suppliers
WHERE CompanyName LIKE '%b%';





------------------------ WILDCARD --------------------
-- KÝ TỰ ĐẠI DIỆN

--  %		bl% finds bl, black, blue, and blob
--  _		h_t finds hot, hat, and hit
--  []		h[oa]t finds hot and hat, but not hit
--  ^		h[^oa]t finds hit, BUT not hot and hat
--  -		c[a-e]t từ chữ cái a đến chữ cái e


-- Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố 
-- Bắt đầu bằng chữ L, chữ thứ 2 là u hoặc o
SELECT *
FROM DBO.Orders
WHERE ShipCity LIKE 'L[uo]%';




-- Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố 
-- Bắt đầu bằng chữ L, chữ thứ 2 KHÔNG là u hoặc o 
SELECT OrderID,ShipCity
FROM DBO.Orders
WHERE ShipCity LIKE 'L[^u,o]%';



-- Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố 
-- Bắt đầu bằng chữ L, chữ thứ 2 là các ký tự từ a đến u 
SELECT OrderID,ShipCity
FROM DBO.Orders
WHERE ShipCity LIKE 'L[a-u]%';




---EX 17
-- HÃY LẤY RA TẤT CẢ CÁC NHÀ CUNG CẤP HÀNG CÓ TÊN CÔNG TY BẮNG ĐẦU BẰNG CHỮ 'A' VÀ KHÔNG CHỨ KÝ TỰ b
SELECT *
FROM DBO.Suppliers
WHERE CompanyName LIKE 'A[^b]%';







---------------- IN / NOT IN -------------------------
-- TÌM KIẾM GIÁ TRỊ TRONG DANH SÁCH 



-- HÃY LỌC RA TẤT CẢ CÁC ĐƠN HÀNG VỚI ĐIỀU KIỆN 
-- A ĐƠN HÀNG ĐƯỢC GIAO ĐẾN GERMANY, BRAZIL, UK

SELECT *
FROM DBO.Orders
WHERE ShipCountry IN ('GERMANY', 'BRAZIL' ,'UK');

-- B ĐƠN HÀNG KHÔNG ĐƯỢC GIAO ĐẾN GERMANY, BRAZIL, UK

SELECT *
FROM DBO.Orders
WHERE ShipCountry NOT IN ('GERMANY', 'BRAZIL' ,'UK');



--- LẤY RA TẤT CẢ SẢN PHẨM CÓ MÃ THỂ LOẠI KHÁC VỚI 2, 3,4 
SELECT ProductID,ProductName, CategoryID
FROM DBO.Products
WHERE CategoryID NOT IN (2,3,4);



--- HÃY LIỆT KÊ CÁC NHÂN VIÊN KHÔNG PHẢI LÀ NHÂN VIÊN NỮ TỪ BẢNG NHÂN VIÊN
SELECT *
FROM DBO.Employees
WHERE TitleOfCourtesy NOT IN ('Ms.','Mrs.');

--- HÃY LIỆT KÊ CÁC NHÂN VIÊN NỮ TỪ BẢNG NHÂN VIÊN
SELECT *
FROM DBO.Employees
WHERE TitleOfCourtesy IN ('Ms.','Mrs.');



--- EX 16
-- HÃY LẤY RA TẤT CẢ CÁC KHÁCH HÀNG ĐẾN TỪ CÁC THÀNH PHỐ BERLIN, LONDON, WARSZAWA
SELECT *
FROM DBO.Customers
WHERE City IN ('Berlin','LONDON','Warszawa');





------------------ IS NULL , IS NOT NULL ---------------------
-- KIỂM TRA GIÁ TRỊ NULL


--- LẤY RA TẤT CẢ CÁC ĐƠN HÀNG CHƯA ĐƯỢC GIAO
SELECT *
FROM DBO.Orders
WHERE ShippedDate IS NULL;





--- LẤY DANH SÁCH KHÁCH HÀNG CÓ KHU VỰC KHÔNG BỊ NULL
SELECT *
FROM DBO.Customers
WHERE Region IS NOT NULL;




-- LẤY DANH SÁCH KHÁCH HÀNG KHÔNG CÓ TÊN CÔNG TY 
SELECT *
FROM DBO.Customers
WHERE CompanyName IS NULL;



-- Hãy lấy ra tất cả các đơn hàng chưa được giao hàng và có khu vực giao hàng không bị NULL
SELECT *
FROM DBO.Orders
WHERE ShippedDate IS NULL AND ShipRegion IS NOT NULL;






----------------------------- GROUP BY ---------------------------
-- ĐỂ NHÓM CÁC DÒNG DỮ LIỆU CÓ CÙNG GIÁ TRỊ 
--- THƯỜNG ĐƯỢC DÙNG VỚI CÁC HÀM SUM, MAX, MIN, AGV, COUNT,




-- HÃY CHO BIẾT MỖI KHÁCH HÀNG ĐÃ ĐẶT BAO NHIÊU ĐƠN HÀNG ?
SELECT CustomerID, COUNT (OrderID) AS 'SO LUONG'
FROM DBO.Orders
GROUP BY CustomerID;




-- TÍNH GIÁ TRỊ ĐƠN GIÁ TRUNG BÌNH THEO MỖI NHÀ CUNG CẤP SẢN PHẨM
SELECT SupplierID, AVG (UnitPrice) AS 'NEW'
FROM DBO.Products
GROUP BY SupplierID;



-- HÃY CHO BIẾT MỖI THỂ LOẠI CÓ TỔNG SO BAO NHIÊU SẢN PHẨM TRONG KHO 
SELECT CategoryID, SUM(UnitsInStock) AS 'SUM' 
FROM DBO.Products
GROUP BY CategoryID;



-- HÃY CHO BIẾT GIÁ VẬN CHUYỂN THẤP NHẤT VÀ LỚN NHẤT CỦA CÁC ĐƠN HÀNG 
-- THEO TỪNG THÀNH PHỐ VÀ GUỐC GIA KHÁC NHAU
SELECT  ShipCountry ,ShipCity, MAX(FREIGHT)AS 'MAX', MIN(Freight) AS 'MIN'
FROM DBO.Orders
GROUP BY  ShipCountry,ShipCity 
ORDER BY  ShipCountry ASC,ShipCity ASC;


-- EX 18
-- THỐNG KÊ SỐ LƯỢNG NHÂN VIÊN THEO TỪNG QUỐC GIA KHÁC NHAU
SELECT Country , COUNT(EmployeeID) AS 'SO LUONG'
FROM DBO.Employees
GROUP BY Country;




------------------ DAY, MONTH , YEAR ----------------------
-- HÀM LẤY NGÀY, THÁNG, NĂM




-- TÍNH SO LƯỢNG ĐƠN HÀNG TRONG NĂM 1997 CỦA TỪNG KHÁCH HÀNG 
SELECT CustomerID, COUNT(OrderID), YEAR (OrderDate)
FROM DBO.Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY CustomerID, YEAR(OrderDate);




-- HÃY LỌC RA CÁC ĐƠN HÀNG ĐƯỢC ĐẶT VÀO 1997 - 05
SELECT *
FROM DBO.Orders
WHERE MONTH(OrderDate) = 5 AND YEAR(OrderDate) = 1997;



-- HÃY LẤY CÁC ĐƠN HÀNG ĐƯỢC ĐẶT VÀO NGÀY 04-09-1996
SELECT *
FROM DBO.Orders
WHERE DAY(OrderDate) = 4 AND MONTH(OrderDate) = 9 AND YEAR(OrderDate) =1996;





-- LẤY DANH SÁCH KHÁCH HÀNG ĐẶT HÀNG TRONG NĂM 1998 VÀ SỐ ĐƠN HÀNG MỖI THÁNG 
-- SẮP XẾP THÁNG TĂNG DẦN	
SELECT CustomerID, MONTH(OrderDate), COUNT(*)
FROM DBO.Orders
WHERE YEAR(OrderDate) = 1998 
GROUP BY CustomerID, MONTH(OrderDate)
ORDER BY MONTH(OrderDate)



--- HÃY LỌC CÁC ĐƠN ĐẶT HÀNG ĐÃ ĐƯỢC GIAO VÀO THÁNG 5, VÀ SẮP XẾP TĂNG DẦN THEO NĂM 
SELECT OrderID,CustomerID,MONTH(ShippedDate) AS 'THANG', YEAR(ShippedDate) AS 'NAM'
FROM DBO.Orders
WHERE MONTH (ShippedDate) = 5
GROUP BY OrderID,CustomerID,MONTH(ShippedDate), YEAR (ShippedDate)
ORDER BY OrderID ASC ,CustomerID ASC,MONTH(ShippedDate)ASC,YEAR (ShippedDate) ASC;







----------------------------- HAVING -------------------------
-- LỌC DỮ LIỆU SAU GROUP BY



-- HÃY CHO BIẾT NHỮNG KHÁCH HÀNG NÀO ĐÃ ĐẶT NHIỀU HƠN 20 ĐƠN HÀNG 
-- SẮP XẾP THEO THỨ TỰ TỔNG SỐ ĐƠN HÀNG GIẢM DẦN
SELECT CustomerID ,COUNT( OrderID) AS 'SO LUONG'
FROM DBO.Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 20 
ORDER BY COUNT(OrderID) DESC ;






-- HÃY LỌC RA NHỮNG NHÀ CUNG CẤP SẢN PHẨM CÓ TỔNG SỐ LƯỢNG HÀNG TRONG KHO LỚN HƠN 30
-- VÀ CÓ TRUNG BÌNH ĐƠN GIÁ CÓ GIÁ TRỊ DƯỚI 50
SELECT SupplierID,SUM(UnitsInStock) AS 'TON KHO',AVG(UnitPrice) AS 'GIA'
FROM DBO.Products
GROUP BY SupplierID
HAVING SUM(UnitsInStock) > 30 AND AVG(UnitPrice) < 50
ORDER BY SUM(UnitsInStock),AVG(UnitPrice);






-- HÃY CHO BIẾT TỔNG SỐ TIỀN VẬN CHUYỂN CỦA TỪNG THÁNG 
-- TRONG NỮA NĂM SAU CỦA NĂM 1996, SẮP XẾP THEO THÁNG TĂNG DẦN

SELECT SUM(Freight)AS 'TONG TIEN', MONTH(ShippedDate) AS 'THANG', YEAR(ShippedDate) AS 'NAM' 
FROM DBO.Orders
WHERE MONTH(ShippedDate) > 6 AND YEAR(ShippedDate) = 1996
GROUP BY  MONTH(ShippedDate), YEAR(ShippedDate)
ORDER BY MONTH(ShippedDate) ASC;




-- HÃY CHO BIẾT TỔNG SỐ TIỀN VẬN CHUYỂN CỦA TỪNG THÁNG 
-- TRONG NỮA NĂM SAU CỦA NĂM 1996, SẮP XẾP THEO THÁNG TĂNG DẦN
-- TỔNG TIỀN VẨN CHUYỂN > 1000$
SELECT SUM(Freight)AS 'TONG TIEN', MONTH(ShippedDate) AS 'THANG', YEAR(ShippedDate) AS 'NAM' 
FROM DBO.Orders
WHERE MONTH(ShippedDate) > 6 AND YEAR(ShippedDate) = 1996
GROUP BY  MONTH(ShippedDate), YEAR(ShippedDate)
HAVING SUM(Freight) > 1000
ORDER BY MONTH(ShippedDate) ASC;





--- LỌC RA NHỮNG THÀNH PHỐ CÓ SỐ LƯỢNG ĐƠN HÀNG  > 16 
--- VÀ SẮP XẾP THEO TỔNG SỐ LƯỢNG GIẢM DẦN
SELECT COUNT(OrderID) AS 'DON HANG' , ShipCity,ShipCountry
FROM DBO.Orders
GROUP BY ShipCity,ShipCountry
HAVING COUNT(OrderID) > 16
ORDER BY COUNT(OrderID) DESC;





------------------------------- ÔN TẬP --------------------------





-- HÃY CHO BIẾT	NHỮNG KHÁCH HÀNG NÀO ĐÃ ĐẶT NHIỀU HƠN 20 ĐƠN 
-- VÀ SẮP XẾP THEO THỨ TỰ TÔNG SỐ ĐƠN GIẢM DẦN
SELECT CustomerID , COUNT(OrderID) AS 'SO DON' 
FROM DBO.Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 20
ORDER BY COUNT(OrderID) DESC;





-- HÃY LỌC RA CÁC NHÂN VIÊN CÓ TỔNG SỐ ĐƠN HÀNG LỚN HƠN HOẶC BẰNG 100
-- VÀ SẮP XẾP THEO TỔNG SỐ ĐƠN HÀNG GIẢM DẦN
SELECT EmployeeID , COUNT(OrderID) AS 'ĐƠN HÀNG'
FROM DBO.Orders
GROUP BY EmployeeID
HAVING COUNT(OrderID) >= 100
ORDER BY COUNT(OrderID) DESC;





-- HÃY CHO BIẾT NHỮNG THỂ LOẠI NÀO CÓ SẢN PHẨM KHÁC NHAU LỚN HƠN 11
SELECT CategoryID ,COUNT(ProductID) AS 'SAN PHAM'
FROM DBO.Products
GROUP BY CategoryID 
HAVING COUNT(ProductID) > 11;





-- HÃY CHO BIẾT NHỮNG THỂ LOẠI NÀO CÓ TỔNG SẢN PHẨM TRONG KHO LỚN HƠN 350
SELECT CategoryID, SUM(UnitsInStock) AS 'KHO' 
FROM DBO.Products
GROUP BY CategoryID
HAVING SUM(UnitsInStock) > 350;






-- HÃY CHO BIẾT NHỮNG QUỐC GIA NÀO CÓ HƠN 7 ĐƠN HÀNG
SELECT COUNT(OrderID) AS 'ĐƠN HÀNG',ShipCountry
FROM DBO.Orders
GROUP BY ShipCountry
HAVING COUNT(OrderID) > 7;







-- HÃY CHO BIẾT NHỮNG NGÀY NÀO CÓ NHIỀU HƠN 5 ĐƠN HÀNG ĐƯỢC GIAO
-- VÀ SẮP XẾP TĂNG DẦN THEO NGÀY GIAO HÀNG
SELECT ShippedDate , COUNT(*)AS'DON HANG'
FROM DBO.Orders
GROUP BY ShippedDate
HAVING COUNT(*)> 5
ORDER BY ShippedDate ASC;




--- HÃY CHO BIẾT NHỮNG QUỐC GIA BẮT ĐẦU BẰNG CHỮ A HOẶC G
--- VÀ CÓ SỐ LƯƠNG ĐƠN HÀNG LỚN HƠN 29
SELECT ShipCountry , COUNT(OrderID) AS 'ĐƠN HÀNG'
FROM DBO.Orders
WHERE ShipCountry LIKE 'A%' OR  ShipCountry LIKE 'G%'
GROUP BY ShipCountry
HAVING COUNT(OrderID) > 29;





-- HÃY CHO BIẾT NHỮNG THÀNH PHỐ NÀO CÓ SỐ LƯỢNG ĐƠN HÀNG ĐƯỢC GIAO LÀ KHÁC 1 VÀ 2 
-- NGÀY ĐẶT HÀNG TỪ NGÀY 1997-04-01 ĐẾN	1997-08-31
SELECT ShipCity, COUNT(ShippedDate) AS 'SO LUONG'  
FROM DBO.Orders
WHERE OrderDate BETWEEN '1997-04-01' AND '1997-08-31'
GROUP BY ShipCity
HAVING COUNT(ShippedDate) > 2
ORDER BY COUNT(ShippedDate) ASC;








------------------------------- Truy vấn dữ liệu từ nhiều table -------------------------------



--- TỪ BẲNG PRODUCTS VÀ CATEGORIES
-- MÃ THỂ LOẠI
-- TÊN THỂ LOẠI 
-- MÃ SẢN PHẨM 
-- TÊN SẢN PHẨM
SELECT C.CategoryID,C.CategoryName,P.ProductID,P.ProductName
FROM DBO.Products AS P , DBO.Categories AS C
WHERE C.CategoryID = P.CategoryID;






--- MÃ NHÂN VIÊN
-- TÊN NHÂN VIÊN 
-- SỐ LƯỢNG ĐƠN HÀNG MÀ NHÂN VIÊN ĐÃ BÁN ĐƯỢC
SELECT E.EmployeeID , E.FirstName , COUNT(O.OrderID) AS 'ĐƠN HÀNG'
FROM DBO.Employees AS E, DBO.Orders AS O
WHERE E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName ;





--- TỪ BẢNG CUSTOMERS AND ORDERS 
-- MÃ SỐ KHÁCH HÀNG
-- TÊN CÔNG TY 
-- TÊN LIÊN HỆ 
-- SỐ LƯỢNG ĐƠN HÀNG ĐÃ MUA
-- VỚI ĐIỀU KIỆN QUỐC GIA CỦA KHÁCH HÀNG LÀ UK

SELECT C.CustomerID,C.CompanyName,C.ContactName,C.Country,COUNT(O.OrderID) AS 'ĐƠN HÀNG'
FROM DBO.Customers AS C, DBO.Orders AS O
WHERE C.CustomerID = O.CustomerID AND C.Country = 'UK'
GROUP BY  C.CustomerID,C.CompanyName,C.ContactName,C.Country;









--- TỪ BẢNG SHIPPERS AND ORDERS 
-- MÃ NHÀ VẬN CHUYỂN 
-- TÊN CÔNG TY VẬN CHUYỂN
-- TỔNG TIỀN ĐƯỢC VẬN CHUYỂN
-- VÀ SẮP XẾP THEO THỨ TỰ GIẢM DẦN
SELECT S.ShipperID, S.CompanyName,SUM(O.Freight) AS 'SUM'
FROM DBO.Shippers AS S , DBO.Orders AS O
WHERE S.ShipperID = O.ShipVia
GROUP BY S.ShipperID, S.CompanyName
ORDER BY SUM(O.Freight) DESC;







-- TỪ BẢNG PRODUCST AND SUPPLIESRS
-- MÃ NHÀ CUNG CẤP 
-- TÊN CÔNG TY
-- TỔNG SỐ CÁC SẢN PHẨM KHÁC NHAU ĐÃ CUNG CẤP
-- VÀ CHỈ IN RA MÀN HÌNH DUY NHẤT 1 NHÀ CUNG CẤP CÓ SỐ LƯỢNG SẢN PHẨM KHÁC NHAU NHIỀU NHẤT
SELECT TOP 1 S.SupplierID , S.CompanyName , COUNT(P.ProductID) AS 'SAN PHAM'
FROM DBO.Products AS P , DBO.Suppliers AS S
WHERE S.SupplierID = P.SupplierID 
GROUP BY S.SupplierID , S.CompanyName
ORDER BY COUNT(P.ProductID) DESC;







-- TỪ BẢNG ORDERS VÀ ORDERS DETAILS 
-- MÃ ĐƠN HÀNG
-- TỔNG SỐ TIỀN SẢN PHẨM CỦA ĐƠN HÀNG ĐÓ
SELECT O.OrderID , SUM(D.UnitPrice*D.Quantity) AS 'TỔNG'
FROM DBO.Orders AS O ,DBO.[Order Details] AS D
WHERE O.OrderID = D.OrderID
GROUP BY O.OrderID ;


-- TỪ 3 BẢNG ORDERS DATAILLS AND ORDERS AND EMPLOYEES
-- MÃ ĐƠN HÀNG 
-- TÊN NHÂN VIÊN 
-- TỔNG SỐ TIỀN SẢN PHẨM CỦA ĐƠN HÀNG
SELECT O.OrderID, E.LastName ,E.FirstName, SUM(D.UnitPrice*D.Quantity) AS 'SUM'
FROM DBO.[Order Details] AS D , DBO.Orders AS O , DBO.Employees AS E
WHERE D.OrderID = O.OrderID  AND O.EmployeeID = E.EmployeeID 
GROUP BY  O.OrderID, E.LastName ,E.FirstName;





--- TỪ 3 BẢNG ORDERS AND CUSTOMES AND SHIPPERS
-- MÃ ĐƠN HÀNG 
-- TÊN KHÁCH HÀNG 
-- TÊN CÔNG TY VẬN CHUYỂN
-- VÀ CHỈ IN RA CÁC ĐƠN HÀNG ĐƯỢC GIAO ĐẾN UK VÀO NĂM 1997
SELECT O.OrderID , C.CustomerID ,S.CompanyName
FROM DBO.Orders AS O , DBO.Customers AS C, DBO.Shippers AS S 
WHERE O.CustomerID = C.CustomerID AND O.ShipVia = S.ShipperID AND C.Country = 'UK' AND YEAR(O.ShippedDate) = '1997';










------------------------- EXERCISE truy vấn dữ liệu từ nhiều Table khác nhau -----------------------------



--- TỪ BẢNG PRODUCST AND CATEGORIES 
-- HÃY TÌM CÁC SẢN PHẨM THUỘC DANH MỤC SEAFOOD 
-- MÃ THỂ LOẠI 
-- TÊN SẢN PHẨM 
-- MÃ SẢN PHẨM 
-- TÊN SẢN PHẨM

SELECT P.CategoryID,C .CategoryName,P.ProductID,P.ProductName
FROM DBO.Products AS P , DBO.Categories AS C
WHERE C.CategoryName = 'SEAFOOD' AND P.CategoryID = C.CategoryID;









-- TỪ BẢNG PRODUCTS AND SUPPLIES 
-- HÃY TÌM RA CÁC SẢN PHẨM THUỘC ĐƯỢC CUNG CẤP TỪ NƯỚC ĐỨC
-- MÃ NHÀ CUNG CẤP
-- QUỐC GIA
-- MÃ SẢN PHẨM
-- TÊN SẢN PHẨM
SELECT P.SupplierID,S.Country,P.ProductID,P.ProductName
FROM DBO.Products AS P , DBO.Suppliers AS S
WHERE P.SupplierID = S.SupplierID AND S.Country = 'germany';






-- TỪ 3 BẢNG ORDERS AND CUSTOMERS AND SHIPPERS
-- MÃ đơn hàng
-- TÊN khách hàng
-- TÊN CÔNG TY VẬN CHUYỂN 
-- VÀ IN RA CÁC ĐƠN HÀNG CỦA CÁC KHÁCH HÀNG ĐẾN TỪ THÀNH PHỐ LONDON
SELECT O.OrderID,c.CustomerID,s.CompanyName
FROM dbo.Orders AS O, DBO.Customers AS C, DBO.Shippers AS S
WHERE O.CustomerID = C.CustomerID AND O.ShipVia = S.ShipperID AND O.ShipCity = 'LONDON'; 








-- TỪ 3 BẢNG ORDERS AND CUSTOMERS AND SHIPPERS
-- MÃ ĐƠN HÀNG 
-- TÊN KHÁCH HÀNG 
-- TÊN CÔNG TY VẬN CHUYỂN 
-- NGÀY YÊU CẦU CHUYỂN HÀNG
-- NGÀY GIAO HÀNG
-- VÀ IN RA CÁC ĐƠN HÀNG BỊ GIAO MUỘN
SELECT O.OrderID , C.CustomerID, S.CompanyName, O.RequiredDate , O.ShippedDate
FROM DBO.Orders AS O, DBO.Customers AS C , DBO.Shippers AS S
WHERE O.CustomerID = C.CustomerID AND O.ShipVia = S.ShipperID AND O.RequiredDate < O.ShippedDate;




-- TỪ 2 BẢNG
-- LẤY RA NHỮNG ĐƠN HÀNG KHÔNG ĐẾN TỪ MỸ
-- VÀ ĐƠN HÀNG > 100
SELECT COUNT(O.OrderID),C.Country 
FROM DBO.Orders AS O, DBO.Customers AS C 
WHERE O.CustomerID = C.CustomerID 
GROUP BY C.Country
HAVING COUNT(O.OrderID) > 100 AND C.Country != 'USA';











------------------------- UNION AND UNION ALL ----------------------------------------
-- UNION
-- ĐƯỢC SỬ DỤNG ĐỂ KẾT HỢP TẬP KẾT QUẢ CỦA 2 HOẶC NHIỀU CÂU LỆNH 
-- MỖI CÂU LỆNH BÊN TRONG PHẢI CÓ CÙNG SỐ LƯỢNG CỘT 
-- CÁC CỘT CŨNG PHẢI CÓ KIỂU DỮ LIỆU TƯƠNG TỰ 
-- CÁC CỘT TRONG MỖI CÂU LỆNH CŨNG PHẢI THEO CÙNG THỨ TỰ

-- UNION ALL
-- ĐƯỢC SỬ DỤNG ĐỂ KẾT HỢP TẬP KẾT QUẢ CỦA 2 HOẶC NHIỀU CÂU LỆNH 
-- MỖI CÂU LỆNH BÊN TRONG PHẢI CÓ CÙNG SỐ LƯỢNG CỘT 
-- CÁC CỘT CŨNG PHẢI CÓ KIỂU DỮ LIỆU TƯƠNG TỰ 
-- CÁC CỘT TRONG MỖI CÂU LỆNH CŨNG PHẢI THEO CÙNG THỨ TỰ
-- CHO PHÉP CÁC GIÁ TRỊ BỊ LẶP LẠI



SELECT City,Country
FROM DBO.Customers
WHERE Country LIKE 'U%'
UNION
SELECT City,Country
FROM DBO.Suppliers
WHERE City = 'LONDON'
UNION
SELECT ShipCity,ShipCountry
FROM DBO.Orders
WHERE ShipCountry = 'USA';









------------------------------- JOIN - LEFT JOIN - RIGHT JOIN - FULL JOIN -------------------------------

-- JOIN HOẶC INNER JOIN
-- TRẢ VỀ TẤT CẢ CÁC HÀNG KHI CÓ ÍT NHẤT MỘT GIÁ TRỊ Ở CẢ HAI BẢNG




-- SỬ DỤNG INNER JOIN
-- TỪ BẲNG PRODUCTS AND CATEGORIES, HÃY IN RA CÁC THÔNG TIN:
-- MÃ THỂ LOẠI 
-- TÊN THỂ LOẠI 
-- MÃ SẢN PHẨM 
-- TÊN SẢN PHẨM

SELECT C.CategoryID ,C.CategoryName ,P.ProductID,P.ProductName
FROM DBO.Products AS P 
INNER JOIN DBO.Categories AS C
ON P.CategoryID = C.CategoryID;






-- SỬ DỤNG INNER JOIN
-- TỪ BẲNG PRODUCTS AND CATEGORIES, HÃY IN RA CÁC THÔNG TIN:
-- MÃ THỂ LOẠI 
-- TÊN THỂ LOẠI
-- SO LƯỢNG SẢN PHẨM
SELECT C.CategoryID ,C.CategoryName , COUNT(P.ProductID) AS 'SOLUONG'
FROM DBO.Products AS P 
INNER JOIN DBO.Categories AS C
ON P.CategoryID = C.CategoryID 
GROUP BY C.CategoryID ,C.CategoryName;






-- SỬ DỤNG INNER JOIN
-- MÃ ĐƠN HÀNG
-- TÊN CÔNG TY KHÁCH HÀNG
SELECT O.OrderID , S.CompanyName
FROM DBO.Orders AS O 
INNER JOIN DBO.Shippers AS S
ON O.ShipVia = S.ShipperID;




------------------------------- LEFT JOIN -----------------------------------
-- TRẢ LẠI TẤT CẢ CÁC DÒNG TỪ BẢNG BÊN TRÁI VÀ CÁC DÒNG	ĐÚNG VỚI ĐIỀU KIỆN TỪ BẢNG BÊN PHẢI



-- SỬ DỤNG LEFT JOIN
-- TỪ BẲNG PRODUCTS AND CATEGORIES, HÃY IN RA CÁC THÔNG TIN:
-- MÃ THỂ LOẠI 
-- TÊN THỂ LOẠI 
-- MÃ SẢN PHẨM 
-- TÊN SẢN PHẨM
SELECT C.CategoryID ,C.CategoryName ,P.ProductID,P.ProductName
FROM  DBO.Categories AS C
LEFT JOIN DBO.Products AS P
ON P.CategoryID = C.CategoryID;








------------------------------- RIGHT JOIN ---------------------------------
-- TRẢ LẠI TẤT CẢ CÁC HÀNG TỪ BẢNG BÊN PHẢI	VÀ CÁC DÒNG THỎA MÃN ĐIỀU KIỆN TỪ BẢNG BÊN TRÁI 

-- SỬ DỤNG RIGHT JOIN
-- MÃ ĐƠN HÀNG
-- TÊN CÔNG TY KHÁCH HÀNG
SELECT O.OrderID , C.CompanyName
FROM DBO.Orders AS O 
RIGHT JOIN DBO.Customers AS C
ON O.CustomerID = C.CustomerID;






-------------------------- FULL JOIN ----------------------------------
-- TRẢ VỀ TẤT CẢ CÁC DÒNG ĐÚNG VỚI 1 TRONG CÁC BẢNG



-- SỬ DỤNG FULL JOIN
-- TỪ BẲNG PRODUCTS AND CATEGORIES, HÃY IN RA CÁC THÔNG TIN:
-- MÃ THỂ LOẠI 
-- TÊN THỂ LOẠI 
-- MÃ SẢN PHẨM 
-- TÊN SẢN PHẨM
SELECT C.CategoryID ,C.CategoryName ,P.ProductID,P.ProductName
FROM  DBO.Categories AS C
FULL JOIN DBO.Products AS P
ON P.CategoryID = C.CategoryID;







--------------------- EXERCISE --------------------------





-- CÂU 1 : HÃY LIỆT KÊ TÊN NHÂN VIÊN VÀ TÊN KHÁCH HÀNG CỦA CÁC ĐƠN HÀNG TRONG BẢNG 'ORDERS'
-- INNER JOIN
SELECT O.OrderID, E.LastName ,E.FirstName, C.ContactName 
FROM DBO.Orders AS O 
INNER JOIN DBO.Employees AS E
ON O.ShipVia = E.EmployeeID
INNER JOIN DBO.Customers AS C
ON O.CustomerID = C.CustomerID;




-- CÂU 2 : HÃY LIỆT KÊ TÊN NHÀ CUNG CẤP VÀ TÊN SẢN PHẨM CỦA CÁC SẢN PHẨM TRONG BẢNG PRODUCST 
-- VÀ BAO GỒM CẢ CÁC SẢN PHẨM KHÔNG CÓ NHÀ CUNG CẤP 
SELECT  P .ProductName,S.ContactName
FROM   DBO.Suppliers AS S
LEFT JOIN    DBO.Products AS P
ON S.SupplierID = P.SupplierID;





-- CÂU 3: HÃY LIỆT KÊ TÊN KHÁCH HÀNG VÀ TÊN ĐƠN HÀNG CỦA CÁC ĐƠN HÀNG TRONG BẢNG 'ORDERS',
-- BAO GỒM CẢ CÁC KHÁCH HÀNG KHÔNG CÓ ĐƠN HÀNG
SELECT C.ContactName , O.ShipName 
FROM DBO.Orders AS O
RIGHT JOIN DBO.Customers AS C
ON O.CustomerID = C.CustomerID;





-- CÂU 4: HÃY LIỆT KÊ TÊN DANH MỤC VÀ TÊN NHÀ CUNG CẤP CỦA CÁC SẢN PHẨM TRONG BẢNG "PRODUCTS"
-- BAO GỒM CẢ CÁC DANH MỤC VÀ NHÀ CUNG CẤP KHÔNG CÓ SẢN PHẨM 
SELECT C.CategoryName , S.ContactName, P.ProductName
FROM  DBO.Products AS P 
FULL JOIN DBO.Categories AS C
ON P.CategoryID = C.CategoryID
FULL JOIN DBO.Suppliers AS S
ON P.SupplierID = S.SupplierID;









------------------------------ Bài tập về các câu lệnh JOIN -----------------------------



-- CÂU 1: LIỆT KÊ SẢN PHẨM VÀ TÊN NHÀ CUNG CẤP CỦA CÁC SẢN PHẨM ĐÃ ĐƯỢC ĐẶT HÀNG TRONG BẢNG 'ORDERS DETAILS'
-- SỬ DỤNG 'INNER JOIN' ĐỂ KẾT HỢP BẢNG 'ORDERS DETAIL' VỚI CÁC BẢNG LIÊN QUAN ĐỂ LẤY THÔNG TIN SẢN PHẨM VÀ NHÀ CUNG CẤP
SELECT DISTINCT O.ProductID, P.ProductName, S.ContactName
FROM  DBO.Products AS P
INNER JOIN DBO.Suppliers AS S  
ON P.SupplierID = S.SupplierID
INNER JOIN DBO.[Order Details] AS O
ON P.ProductID = O.ProductID;




-- CÂU 2: LIỆT KÊ TÊN KHÁCH HÀNG VÀ TÊN NHÂN VIÊN PHỤ TRÁCH CỦA CÁC ĐƠN HÀNG TRONG BẢNG 'ORDERS'
-- BAO GỒM CẢ ĐƠN HÀNG KHÔNG CÓ NHÂN VIÊN PHỤ TRÁCH
-- SỬ DỤNG LEFT JOIN ĐỂ KẾT HỢP BẢNG 'ORDERS' VỚI BẢNG 'EMPLOYYEES' ĐỂ LẤY THÔNG TIN VỀ KHÁCH HÀNG VÀ NHÂN VIÊN PHỤ TRÁCH 
SELECT DISTINCT O.OrderID,C.ContactName, E.LastName, E.FirstName
FROM DBO.Orders AS O
LEFT JOIN DBO.Employees AS E  
ON O.EmployeeID = E.EmployeeID
LEFT JOIN DBO.Customers AS C
ON O.CustomerID = C.CustomerID;





-- CÂU 3: LIỆT KÊ TÊN KHÁCH HÀNG VÀ TÊN NHÂN VIÊN PHỤ TRÁCH CỦA CÁC ĐƠN HÀNG TRONG BẢNG 'ORDERS'
-- BAO GỒM CẢ CÁC KHÁCH HÀNG KHÔNG CÓ ĐƠN HÀNG
-- SỬ DỤNG RIGHT JOIN ĐỂ KẾT HỢP 'ORDER' AND 'CUSTOMERS' ĐỂ LẤY THÔNG TIN VỀ KHÁCH HÀNG VÀ NHÂN VIÊN PHỤ TRÁCH 
SELECT O.OrderID, C.ContactName , E.LastName,E.FirstName
FROM DBO.Orders AS O
RIGHT JOIN DBO.Employees AS E
ON E.EmployeeID = O.EmployeeID
RIGHT JOIN DBO.Customers AS C
ON C.CustomerID = O.CustomerID; 







-- CÂU 4: Liệt kê tên danh mục và tên nhà cung cấp của các sản phẩm trong bảng 'products'
-- Bao gồm cả danh mục và nhà cung cấp không có sản phẩm
-- sử dụng full join hoặc kết hợp left join và right join để lấy thông tin về danh mục và nhà cung cấp
SELECT P.ProductName, C.CategoryName, S.ContactName
FROM DBO.Products AS P
FULL JOIN DBO.Categories AS C
ON C.CategoryID = P.CategoryID
FULL JOIN DBO.Suppliers AS S
ON P.SupplierID = S.SupplierID;





-- CÂU 5: LIỆT KÊ TÊN KHÁCH HÀNG VÀ TÊN SẢN PHẨM ĐÃ ĐƯỢC ĐẶT HÀNG TRONG BẢNG 'ORDERS' VÀ 'ORDERS DETAILS'
-- SỬ DỤNG INNER JOIN ĐỂ KẾT HỢP BẢNG 'ORDERS' VÀ 'ORDERS DETAILS' ĐỂ LẤY THÔNG TIN KHÁCH HÀNG 
-- VÀ SẢN PHẨM ĐÃ ĐƯỢC ĐẶT HÀNG
SELECT DISTINCT O.OrderID, C.ContactName,P.ProductName
FROM DBO.Orders AS O
INNER JOIN DBO.Customers AS C
ON O.CustomerID = C .CustomerID
INNER JOIN DBO.[Order Details] AS D
ON O.OrderID = D.OrderID
INNER JOIN DBO.Products AS P
ON D.ProductID = P.ProductID;






-- CÂU 6: 
-- LIỆT KÊ TÊN NHAN VIÊN VÀ TÊN KHÁCH HÀNG CỦA CÁC ĐƠN HÀNG TRONG BẢNG 'ORDERS' 
-- BAO GỒM CẢ CÁC ĐƠN HÀNG KHÔNG CÓ NHÂN VIÊN HOẶC KHÁCH HÀNG TƯƠNG ỨNG
-- SỬ DỤNG FULL JOIN HOẶC KẾT HỢP LEFT JOIN VÀ RIGHT JOIN ĐỂ KẾT HỢP 
-- BẢNG 'ORDERS' VỚI BẢNG 'EMPOYEES' VÀ 'CUSTOMERS' ĐỂ LẤY THÔNG TIN VỀ NHÂN VIÊN VÀ KHÁCH HÀNG
SELECT O.OrderID, E.LastName, E.FirstName,C.ContactName 
FROM DBO.Orders AS O
FULL JOIN DBO.Employees AS E
ON O.EmployeeID = E.EmployeeID
FULL JOIN DBO. Customers AS C
ON O.CustomerID = C.CustomerID;







----------------------- SUB QUERY - NESTED QUERY -------------------------
-- TRUY VẤN CON - TRUY VẤN LỒNG NHAU



-- SUB QUERY
-- LỌC NHỮNG SẢN PHẨM CÓ GIÁ > GIÁ TRUNG BÌNH
SELECT ProductName , UnitPrice
FROM DBO.Products
WHERE UnitPrice > (
	SELECT AVG(UnitPrice)
	FROM DBO.Products);




-- LỌC RA NHỮNG KHÁCH HÀNG CO SÔ ĐƠN HÀNG > 10
SELECT COUNT(O.OrderID) AS 'SOLUONG' , C.ContactName
FROM DBO.Orders AS O
RIGHT JOIN DBO.Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName
HAVING  COUNT(O.OrderID) > 10;
-- SUB QUERY
SELECT *
FROM DBO.Customers
WHERE CustomerID IN (
		SELECT CustomerID
		FROM DBO.Orders
		GROUP BY CustomerID
		HAVING COUNT(OrderID) > 10
);






-- TÍNH TỔNG TIỀN CHO TỪNG ĐƠN HÀNG 
SELECT O.*, (
SELECT SUM(D.Quantity*D.UnitPrice)
FROM DBO.[Order Details] AS D
WHERE O.OrderID = D.OrderID
) AS 'TONG'
FROM DBO.Orders AS O;






--- LỌC RA TÊN SẢN PHẨM VÀ TÔNG SỐ ĐON HÀNG CỦA SẢN PHẨM
SELECT P.ProductName ,(
	SELECT COUNT(*) 
	FROM DBO.[Order Details] AS O
	WHERE O.ProductID = P.ProductID
)
FROM DBO.Products AS P;







--BẠN HÃY IN RA MÃ ĐƠN HÀNG VÀ SO LUONGỰ SẢN PHẨM CỦA ĐƠN HÀNG ĐÓ
SELECT O.OrderID , (
	SELECT COUNT(D.ProductID)
	FROM DBO.[Order Details] AS D
	WHERE O.OrderID = D.OrderID
) AS 'SANPHAM'
FROM DBO.Orders AS O;

			




--------------------------- Bài tập Sub Query - truy vấn con, truy vấn lồng nhau ------------


-- BÀI 1: LIỆT KÊ CÁC ĐƠN HÀNG CO NGÀY ĐẶT HÀNG GẦN NHẤT
SELECT *
FROM DBO.Orders AS R
WHERE R.OrderDate = (
	SELECT MAX (O .OrderDate)
	FROM DBO.Orders AS O
);





-- LIỆT KÊ TẤT CẢ CÁC SẢN PHẨM 
-- MÃ KHÔNG CÓ ĐƠN ĐẶT HÀNG NÀO ĐĂT MUA CHÚNG
SELECT P.*
FROM DBO.Products AS P
WHERE P.ProductID NOT IN(
	SELECT DISTINCT O.ProductID
	FROM DBO.[Order Details] AS O
);





-- LẤY THÔNG TIN VỀ CÁC ĐƠN HÀNG, VÀ TÊN CÁC SẢN PHẨM 
-- THUỘC CÁC ĐƠN HÀNG CHƯA ĐƯỢC GIAO CHO KHÁCH
SELECT O.*,P.ProductName
FROM DBO.Orders AS O
INNER JOIN DBO.[Order Details] AS OD
ON OD.OrderID = O.OrderID
INNER JOIN DBO.Products AS P
ON P.ProductID = OD.ProductID
WHERE O.OrderID IN (
		SELECT O.OrderID
		FROM DBO.Orders AS O
		WHERE O.ShippedDate IS NULL
		);







-- LẤY THÔNG TIN VỀ CÁC SẢN PHẨM CÓ SỐ LƯỢNG SẢN PHẨM TỒN KHO
-- ÍT HƠN SỐ LƯỢNG TỒN KHO TRUNG BÌNH CỦA TẤT CẢ CÁC SẢN PHẨM
SELECT P.*
FROM DBO.Products AS P
WHERE P.UnitsInStock > (
	SELECT AVG(P.UnitsInStock)
	FROM DBO.Products AS P
);








-- LẤY THÔNG TIN VỀ CÁC KHÁCH HÀNG CÓ TỔNG GIÁ TRỊ ĐƠN HÀNG LỚN NHẤT

SELECT TOP 1 C.*,  (
SELECT SUM(D.Quantity*D.UnitPrice)
FROM DBO.[Order Details] AS D
WHERE O.OrderID = D.OrderID
) AS 'TONG'
FROM DBO.Orders AS O
INNER JOIN DBO.Customers AS C
ON C.CustomerID = O.CustomerID
ORDER BY TONG DESC;





SELECT CategoryID
FROM dbo.Categories;