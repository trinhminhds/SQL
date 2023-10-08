create table if not EXISTS testSINHVIEN (
MSSV INT     PRIMARY Key,
TEN nVarchar (20)    Not Null,
Tuoi INT            Not Null,
DIACHI Varchar (30)
);

CREATE TABLE testMONTHI (
MAMT varchar (4) PRIMARY Key,
TenMT varchar  (50) NOt null
);
Create table testKETQUA (
MSSV Int NOT Null,
MaMT varchar (4) Not null,
DIEM Decimal (3,1)
);
INSERT into testsinhvien values
(121345,'Nguyễn Nhật Quang',80,'Mỹ Tho');
-- thêm cột giới tính vào bảng sinh viên.
Alter table testsinhvien add COLUMN gioitinh varchar(3);