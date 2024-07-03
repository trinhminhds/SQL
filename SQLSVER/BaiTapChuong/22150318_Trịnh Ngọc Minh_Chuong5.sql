
-- 1. Tạo mới người dùng user1, user2, manager,
--  viewer, developer, admin_user và nhóm người
--  dùng sales_team, order_management trong cơ
--  sở dữ liệu QLBH.

CREATE LOGIN user1 WITH PASSWORD = '123456'
CREATE LOGIN user2 WITH PASSWORD = '123456'
CREATE LOGIN manager WITH PASSWORD = '123456'
CREATE LOGIN viewer WITH PASSWORD = '123456'
CREATE LOGIN developer WITH PASSWORD = '123456'
CREATE LOGIN admin_user WITH PASSWORD = '123456'

USE QLBANHANG
CREATE USER minh FOR LOGIN admin_user

CREATE ROLE sales_team
CREATE ROLE order_management

EXEC sp_addrolemember 'sales_team', 'order_management'


SELECT sales_team
FROM sys.database_principals
WHERE type ='R';


--  2. Thực hiện cấp quyền SELECT tất cả các cột
--  trong bảng khachhang cho người dùng user1.


GRANT SELECT 
ON QLBANHANG.khachhang
TO user1


--  3. Thực hiện cấp quyền SELECT, INSERT tất cả
--  các cột trong bảng cthd cho user2.

GRANT SELECT, INSERT ON  cthd TO user2

--  4. CấpquyềnSELECTcáccộtmakh, tenkh, diachi,
--  sdt trong bảng khachhang cho viewer.

GRANT SELECT makh,tenkh,diachi,sdt ON khachhang TO viewer


-- 5. Cấp quyền EXECUTE thủ tục tinhdoanhthu cho
--  người dùng manager.

GRANT EXEC sp_tinhtongdoanhthu ON khachhang TO manager

--  6. Cấpquyềntạobảngchongườidùng developer

GRANT CREATE TABLE ON khachhang TO developer

-- 7. Cấp quyền truy cập vào toàn bộ cơ sở dữ liệu
--  QLBH cho người dùng admin_user.

GRANT CONTROL TO admin_user

-- 8. Cấp quyền SELECT và UPDATE tất cả các cột
--  trong bảng mathang cho người dùng manager.

GRANT SELECT, UPDATE ON mathang TO manager

--  9. Cấp quyền INSERT và UPDATE bảng hoadon cho
--  nhóm người dùng sales_team.

GRANT INSERT, UPDATE ON hoadon TO seles_team

--  10. Cấp quyền REFERENCES cột mahd trong bảng
--  hoadon cho nhóm order_management.

GRANT REFERENCES mahd ON hoadon TO order_management

--  11. Thuhồi quyền SELECT tất cả các cột trong bảng
--  khachhang từ người dùng user1.

REVOKE SELECT ON khachhang FROM user1

-- 12. Thu hồi quyền UPDATE bảng hoadon từ nhóm
--  người dùng sales_team.

REVOKE UPDATE ON hoadon TO sales_team