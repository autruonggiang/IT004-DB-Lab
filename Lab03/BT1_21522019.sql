Create database PartShipmentDB
go
use PartShipmentDB
go
Create table Nhacungcap 
(
maNCC		varchar(5),
tenNCC	varchar(20), 
trangthai 	numeric(2),
thanhpho	varchar(30),
Constraint PKNcc primary key (maNCC)
)


create table Phutung 
(
 maPT		varchar(5),
 tenPT	varchar(10),
 mausac	varchar(10),
 khoiluong	float,
 thanhpho	 varchar(30),
 Constraint PKPt Primary Key (maPT) 
)


Create table Vanchuyen 
(
maNCC		varchar(5) ,
maPT		varchar(5),
soluong	numeric(5), 
Constraint PKVc primary key (maNCC,maPT),
Constraint FKShip1 foreign key (maNCC) references Nhacungcap (maNCC),
Constraint FKShip2 foreign key (maPT) references Phutung (maPT)
)


insert into Nhacungcap values ('S1','Smith','20','London')
insert into Nhacungcap values ('S2','Jones','10','Paris')
insert into Nhacungcap values ('S3','Blake','30','Paris')
insert into Nhacungcap values ('S4','Clark','20','London')
insert into Nhacungcap values ('S5','Adams','30','Athens')


Insert  into Phutung values  ( 'P1' , 'Nut' , 'Red' , 12.0 , 'London')
Insert  into Phutung values  ( 'P2' , 'Bolt' , 'Green', 17.0 , 'Paris')
Insert  into Phutung values  ( 'P3' , 'Screw' , 'Blue', 17.0 , 'Oslo')
Insert  into Phutung values  ( 'P4' , 'Screw' , 'Red' , 14.0 , 'London')
Insert  into Phutung values  ( 'P5' , 'Cam' , 'Blue' , 12.0 , 'Paris')
Insert  into Phutung values  ( 'P6' , 'Cog' , 'Red' , 19.0 , 'London')



Insert into Vanchuyen values ('S1','P1',300)
Insert into Vanchuyen values ('S1','P2',200)
Insert into Vanchuyen values ('S1','P3',400)
Insert into Vanchuyen values ('S1','P4',200)
Insert into Vanchuyen values ('S1','P5',100)
Insert into Vanchuyen values ('S1','P6',100)
Insert into Vanchuyen values ('S2','P1',300)
Insert into Vanchuyen values ('S2','P2',400)
Insert into Vanchuyen values ('S3','P2',200)
Insert into Vanchuyen values ('S4','P2',200)
Insert into Vanchuyen values ('S4','P4',300)
Insert into Vanchuyen values ('S4','P5',400)

select * from Vanchuyen 

--1. Hiển thị thông tin (maNCC, tenNCC, thanhpho) của tất cả nhà cung cấp.
select maNCC, tenNCC, thanhpho
from Nhacungcap

--2. Hiển thị thông tin của tất cả các phụ tùng.
select *
from Phutung

--3. Hiển thị thông tin các nhà cung cấp ở thành phố London.
select *
from Nhacungcap
where thanhpho = 'London'

--4. Hiển thị mã phụ tùng, tên và màu sắc của tất cả các phụ tùng ở thành phố Paris.
select maPT, tenPT, mausac
from Phutung
where thanhpho = 'Paris'

--5. Hiển thị mã phụ tùng, tên, khối lượng của những phụ tùng có khối lượng lớn hơn 15.
select maPT, tenPT, khoiluong
from Phutung
where khoiluong > 15

--6. Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, không phải màu đỏ (red).
select maPT, tenPT, mausac
from Phutung
where khoiluong > 15 and mausac <> 'Red'

--7. Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, màu sắc khác màu đỏ (red) và xanh (green).
select maPT, tenPT, mausac
from Phutung
where khoiluong > 15 and mausac not in ('Red', 'Green')

--8. Hiển thị những phụ tùng (maPT, tenPT, khối lượng) có khối lượng lớn hơn 15 và nhỏ hơn 20, sắp xếp theo tên phụ tùng.
select maPT, tenPT, khoiluong
from Phutung
where (khoiluong between 15 and 20) 
order by tenPT ASC

--9. Hiển thị những phụ tùng được vận chuyển bởi nhà cung cấp có mã số S1. Không hiển thị kết quả trùng. (sử dụng phép kết).
select distinct pt.*
from Nhacungcap ncc join Vanchuyen vc on ncc.maNCC = vc.maNCC
join Phutung pt on vc.maPT = pt.maPT
where ncc.maNCC = 'S1'

--10. Hiển thị những nhà cung cấp vận chuyển phụ tùng có mã là P1 (sử dụng phép kết).
select ncc.*
from Vanchuyen vc join Nhacungcap ncc on ncc.maNCC = vc.maNCC
join Phutung pt on vc.maPT = pt.maPT
where pt.maPT = 'P1'

--11. Hiển thị thông tin nhà cung cấp ở thành phố London và có vận chuyển phụ tùng của thành phố London. Không hiển thị kết quả trùng. (Sử dụng phép kết)
select distinct ncc.*
from Vanchuyen vc join Nhacungcap ncc on ncc.maNCC = vc.maNCC
join Phutung pt on vc.maPT = pt.maPT
where ncc.thanhpho = 'London' and pt.thanhpho = 'London'