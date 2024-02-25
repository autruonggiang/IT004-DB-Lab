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