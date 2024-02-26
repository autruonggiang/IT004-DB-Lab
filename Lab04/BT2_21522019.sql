create database QLyHangHoa
go

use QLyHangHoa
go

create table Nhacungcap (
	maNCC varchar(5) not null,
	tenNCC varchar(20),
	trangthai numeric(2, 0),
	thanhpho varchar(20),
	constraint PK_NCC primary key(maNCC)
)

create table Phutung (
	maPT varchar(5) not null,
	tenPT varchar(5),
	mausac varchar(10),
	khoiluong float,
	thanhpho varchar(30),
	constraint PK_PT primary key(maPT)
)

create table Vanchuyen (
	maNCC varchar(5) not null,
	maPT varchar(5) not null,
	soluong numeric(5, 0),
	constraint PK_VC primary key(maNCC, maPT),
	constraint FK01_VC foreign key(maNCC) references Nhacungcap(maNCC),
	constraint FK02_VC foreign key(maPT) references Phutung(maPT)
)

--Nha cung cap
insert into Nhacungcap values ('H01', 'Honda', 10, 'TPHCM')
insert into Nhacungcap values ('H02', 'Honda', 35, 'Ha Noi')
insert into Nhacungcap values ('Y01', 'Yamaha', 20, 'TPHCM')
insert into Nhacungcap values ('Y02', 'Yamada', 15, 'Can Tho')
insert into Nhacungcap values ('S01', 'Suzuki', 30, 'Ha Noi')

--Phu tung
insert into Phutung values ('V01', 'VN', 'Blue', 45, 'TPHCM')
insert into Phutung values ('V02', 'VN', 'Yellow', 60, 'TPHCM')
insert into Phutung values ('M01', 'My', 'Red', 45, 'Ha Noi')
insert into Phutung values ('M02', 'My', 'Black', 55, 'Ha Noi')
insert into Phutung values ('T02', 'TQ', 'Red', 70, 'Can Tho')

--Van chuyen
insert into Vanchuyen values ('H01', 'V02', 200)
insert into Vanchuyen values ('Y02', 'M01', 150)
insert into Vanchuyen values ('H01', 'T02', 400)
insert into Vanchuyen values ('S01', 'V01', 600)
insert into Vanchuyen values ('Y01', 'V01', 350)

--17. Lặp lại câu 11 nhưng dùng truy vấn con. Sử dụng toán tử EXISTS.
select *
from Nhacungcap ncc
where ncc.thanhpho = 'Ha Noi' and exists
	(select *
	from Vanchuyen
	where exists
		(select *
		from Phutung pt
		where  pt.thanhpho = 'Ha Noi'))

--18. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT IN.
select *
from Nhacungcap ncc
where maNCC not in
	(select maNCC
	from Vanchuyen
	where maPT in
		(select maPT
		from Phutung pt))
--19. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT EXISTS.
select *
from Nhacungcap ncc
where not exists
	(select *
	from Vanchuyen
	where ncc.maNCC = vc.maNCC and exists
		(select *
		from Phutung pt
		where vc.maPT = pt.maPT))

--20. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng outer JOIN (Phép kết ngoài)