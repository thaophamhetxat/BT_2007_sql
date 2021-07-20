use bt_tkcsdl_2007;



/*  In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 19/6/2006 và ngày 20/6/2006.*/
select *
from hoadon
where hoadon.ngay between '2006-06-19' and '2006-06-20';

/*In ra các số hóa đơn, trị giá hóa đơn trong tháng 6/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần). */
select hoadon.id_HD,hoadon.TongGia,hoadon.ngay
from hoadon
where ngay like '2006-06%'
order by ngay and TongGia desc;

/* In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 19/07/2007.*/
select id_KH,HoTen
from khachhang
JOIN hoadon on khachhang.id_KH = hoadon.id_HDKH
where ngay = '2007-07-19%';

/* In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van” mua trong tháng 10/2006.*/
select id_SP,TenSP
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '%2006-10%' and HoTen='Nguyen Van';

/*Tìm các số 	hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”.*/
select hoadon.id_HD,hoadonchitiet.id_CT,sanpham.TenSP
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
where TenSP = 'May giat' or TenSP = 'Tu lanh';

/* Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20*/
select hoadon.*,hoadonchitiet.SoLuong
from hoadonchitiet
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
where SoLuong between 10 and 20;

/*Tìm các số hóa đơn mua cùng lúc 2 sản phẩm “Máy giặt” và “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20*/


/*In ra danh sách các sản phẩm (MASP,TENSP) không bán được*/
SELECT id_SP,TenSP
FROM sanpham S
WHERE NOT EXISTS(SELECT * 
                 FROM sanpham S2 
                 INNER JOIN hoadonchitiet C ON S2.id_SP = C.id_SPCT
                 AND S2.id_SP = S.id_SP);
/*In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.*/
SELECT id_SP,TenSP
FROM sanpham
WHERE  id_SP Not in (SELECT id_SPCT
					FROM hoadonchitiet C
                    INNER JOIN hoadon H ON C.id_CT = H.id_HD
					WHERE year(ngay) =2006);
     


/*In ra danh sách các sản phẩm (MASP,TENSP) có giá >300 sản xuất bán được trong năm 2006.*/
select sanpham.id_SP,TenSP 
from sanpham 
join hoadon
join hoadonchitiet on hoadon.id_HD = hoadonchitiet.id_CT and sanpham.id_SP = hoadonchitiet.id_SPCT
where hoadon.ngay like "2006%" and sanpham.Gia >300
group by TenSP;              
                 
/*Tìm số hóa đơn đã mua tất cả các sản phẩm có giá >200.*/      

/*21: Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.*/
select id_SP,TenSP,SoLuong
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '2006%';

/*22  Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?*/
SELECT MAX(TongGia) AS MAX, MIN(TongGia) AS MIN
FROM hoadon ;

/*23  Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?*/
select avg(TongGia) as 'trung binh tat ca hoa don'
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '2006%';

/*24   Tính doanh thu bán hàng trong năm 2006.*/
select sum(TongGia) as 'doanh thu bán hàng'
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '2006%';

/*25 Tìm số hóa đơn có trị giá cao nhất trong năm 2006*/
select id_SP,TenSP,max(TongGia) as 'hóa đơn có trị giá cao nhất'
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '2006%' ;

/*26 Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006*/
-- c1
select id_KH,HoTen,TenSP,max(TongGia) as 'hóa đơn có trị giá cao nhất'
from sanpham
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
where  ngay like '2006%';

-- c2
select HoTen
from khachhang
inner join hoadon on khachhang.id_KH=hoadon.id_HDKH
where hoadon.tonggia=(select max(tonggia) from hoadon) and hoadon.ngay LIKE '2006%';



/*27  In ra danh sách 3 khách hàng (MAKH, HOTEN) mua nhiều hàng nhất (tính theo số lượng). */
SELECT id_KH,HoTen,SoLuong
from sanpham 
join hoadonchitiet on  sanpham.id_SP=hoadonchitiet.id_SPCT
join hoadon on hoadon.id_HD=hoadonchitiet.id_HDCT
join khachhang on khachhang.id_KH=hoadon.id_HDKH
order by SoLuong desc
limit 3;

/*28 In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.*/
SELECT id_SP, TenSP,Gia
FROM sanpham
ORDER BY Gia DESC
limit 3;   

/*29 In ra danh sách các sản phẩm (MASP, TENSP) có tên bắt đầu bằng chữ M, có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).*/
SELECT id_SP, TenSP,Gia
FROM sanpham
where TenSP like 'M%'
ORDER BY Gia DESC
limit 3; 

/*30 Tính tổng số sản phẩm giá <500000.*/
SELECT count(id_SP) as 'tổng số sản phẩm'
FROM sanpham
where Gia<500000   ;  

/* 32  Tính tổng số sản phẩm giá <300.*/                                      
                                         
	
/*33 Tính tổng số sản phẩm theo từng giá.*/
SELECT Gia, COUNT(DISTINCT id_SP) AS 'tổng số sản phẩm'
FROM sanpham
GROUP BY Gia;

/*34 Tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm bắt đầu bằng chữ M.*/
SELECT TenSP, MAX(Gia) AS 'cao nhất', MIN(Gia) AS 'thấp nhất', AVG(Gia) AS 'trung bình'
FROM sanpham
where TenSP like 'T%'
GROUP BY Gia;                              
                 
/*35 Tính doanh thu bán hàng mỗi ngày.*/    
SELECT ngay, SUM(TongGia) AS 'doanh thu bán hàng mỗi ngày'
FROM hoadon
GROUP BY ngay;             
                
/*36   tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006. */
SELECT id_SP, COUNT(DISTINCT id_SP) AS 'tổng số lượng'
FROM sanpham
WHERE id_SP IN(SELECT id_SPCT
              FROM hoadonchitiet C INNER JOIN hoadon H
              ON C.id_HDCT = H.id_HD
              WHERE ngay like '2006-10%'
              GROUP BY id_SPCT);
              
 /*37 Tính doanh thu bán hàng của từng tháng trong năm 2006.*/   
SELECT MONTH(ngay) AS 'tháng', SUM(TongGia) AS 'doanh thu'
FROM hoadon
WHERE ngay like '2006%'
GROUP BY MONTH(ngay);


/*38 Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau. */
SELECT *
FROM hoadon
WHERE id_HD IN(SELECT id_HDCT
               FROM hoadonchitiet
               WHERE SoLuong >= 4);
                                  
										
/* 39 Tìm hóa đơn có mua 3 sản phẩm có giá <300000 (3 sản phẩm khác nhau). */

SELECT *
FROM hoadon
WHERE id_HD IN(SELECT id_HD
               FROM hoadonchitiet  
               INNER JOIN sanpham ON hoadonchitiet.id_SPCT = sanpham.id_SP
               WHERE TongGia < 300000 AND SoLuong >= 3);
                                         
/* 40 Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.*/

SELECT id_KH, HoTen
FROM khachhang
WHERE id_KH = (SELECT id_HDKH
              FROM hoadon
              GROUP BY id_HDKH
              ORDER BY COUNT(DISTINCT id_HD) DESC
              limit 1);

/*41  Tháng mấy trong năm 2006, doanh số bán hàng cao nhất? */
SELECT MONTH(ngay) AS 'tháng', SUM(TongGia) AS 'doanh thu'
FROM hoadon
WHERE ngay like '2006%'
GROUP BY MONTH(ngay)
order by SUM(TongGia) desc
limit 1;

/*42 Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.*/
SELECT id_SP, TenSP
FROM sanpham
WHERE id_SP = (SELECT id_SPCT
               FROM hoadonchitiet
               GROUP BY id_SPCT
			   ORDER BY SUM(SoLuong)
               limit 1);

/*45 Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.*/
-- 10 khách hàng có doanh số cao nhất
SELECT  id_KH
FROM khachhang
join hoadon on khachhang.id_KH = hoadon.id_HDKH
ORDER BY TongGia DESC
limit 10;
-- tìm khách hàng có số lần mua hàng nhiều nhất
SELECT id_KH, COUNT(id_HD) as 'số lần mua'
FROM khachhang
join hoadon on khachhang.id_KH = hoadon.id_HDKH
GROUP BY id_KH;

/* gộp*/

SELECT id_KH
FROM (SELECT  id_KH
      FROM khachhang
      join hoadon on khachhang.id_KH = hoadon.id_HDKH
	  ORDER BY TongGia DESC
	  limit 10) AS A
where  id_KH  in(SELECT id_HDKH, COUNT(id_HD) as 'số lần mua'
                FROM hoadon
                join khachhang on khachhang.id_KH = hoadon.id_HDKH
                GROUP BY id_HDKH)
ORDER BY TongGia DESC
limit 1;     
                                