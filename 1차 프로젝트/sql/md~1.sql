SELECT * FROM book;

select * from book
where price>=10000 and price<=20000;

select * from book
where publisher='굿스포츠' or publisher='대한미디어';

select * from book
where publisher in ('굿스포츠', '대한미디어');

select * from book
where publisher not in ('굿스포츠', '대한미디어');

select bookname, publisher from book
where bookname like '축구의 역사';

select * from book
where bookname like '%축구%';

select * from book
where bookname like '%_구%';

select * from book
where bookname like '%축구%' and price>=20000;

--정렬(default 올림차순) --(desc 내림차순)
select * 
from book
order by bookname desc;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
select * 
from book
order by price, bookname;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력.
select * 
from book
order by price desc, publisher;

--
select * 
from orders;

-------------------------------
select sum(saleprice) as "총 매출" 
from orders;

--
select sum(saleprice)
from orders
where custid like '2';

--과제1_ 0508. orders 테이블에서 saleprice의 합계, 평균, 최소값, 최대값을 구하세요
select sum(saleprice) as "합계",avg(saleprice) as "평균",min(saleprice) as "최소값",max(saleprice) as "최대값" 
from orders;

--과제2_ 0508. orders 테이블에서 도서수량, 총 판매액을 구하세요.
select COUNT(*) as "도서수량",  sum(saleprice) as "총 판매액"
from orders;

--과제3_0508. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.
--having절은 group by절과 함께 사용되어 그룹화된 결과 집합을 필터링하는데 사용됨
--where 집합에 대한 조건을 지정하는 반면 having절은 집계함수 결과에 대한 조건을 지정
select custid as "고객id", count(custid) as "주문 도서 수량", sum(saleprice) as "총 주문액"
from orders
where saleprice>=8000
group by custid
having count(custid)>=2;

select *
from customer, orders;

select *
from customer, orders
where customer.custid=orders.custid
order by customer.custid;

--고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select name, saleprice
from customer, orders
where customer.custid=orders.custid;

--과제4_0508. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select name as "이름", sum(saleprice) as "총 판매액"
from orders, customer
where customer.custid=orders.custid
group by name
order by customer.name;



--과제5_0508. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select name, bookname
from book b, customer c, orders o
where b.bookid=o.bookid and c.custid=o.custid
order by name;

--과제6_0508. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select distinct name, bookname
from customer, book, orders
where price=20000 and customer.custid=orders.custid
order by name;

--join: inner join vs outer join
select c.custid,o.custid,name, saleprice
from customer c, orders o
where c.custid=o.custid;

select c.custid,o.custid,c.name, o.saleprice
from customer c, orders o
where c.custid=o.custid(+);

select c.custid, o.custid, c.name, o.saleprice
from customer c left outer join orders o on c.custid=o.custid;

--부속 질의
--가장 비싼 도서의 이름을 출력하세요
select bookname, price
from book
where price=(select max(price) from book);



-- 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
select name
from customer c, orders o 
where o.custid=c.custid;


select name 
from customer 
where custid in (select custid from Orders);

--과제7_0508. '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 검색하시오.
select distinct name 
from customer,book,orders
where book.publisher='대한미디어' and customer.custid=orders.custid
order by name;

select name
from customer
where custid in(select custid 
                from orders 
                where bookid in 
                        (select bookid 
                        from book 
                        where publisher='대한미디어'));


--과제8_0508. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 검색하시오.
select publisher, avg(price)
from book
group by publisher;

select b1.bookname
from book b1
where b1.price > (select avg(b2.price) from Book b2 where b2.publisher = b1.publisher);

--과제9_0508. 도서를 주문하지 않은 고객의 이름을 검색하시오.
select name 
from customer 
where custid  not in (select custid from orders);

select name
from customer
minus 
select name
from customer
where custid in (select custid from orders);

--과제10_0508. 주문이 있는 고객의 이름과 주소를 검색하시오.
select name, address
from customer, orders
where customer.custid=orders.custid
order by name;

select name, address
from customer c
where exists(select*
            from orders o
            where c.custid=o.custid);

select abs(-78), abs(+78) from dual;
select round(4.875, 2) from dual;

-- Q. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
select round(avg(saleprice),-2)
from orders o, customer c
where o.custid=c.custid
group by name;

select custid, round(avg(saleprice),-2) 평균금액 
from orders 
group by custid;

-- Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록, 가격을 구하세요.
select bookid, replace(bookname, '야구', '농구') bookname, price
from book;

-- Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
select bookname,length(bookname),lengthb(bookname)
from book
where publisher='굿스포츠';

select* from book;

-- 마당서점의 고객중에서 같은 성을 가진 사람이 몇명이나 되는지 성별 인원수를 구하시오.
-- substr 이란 특정 위치에서 시작하여 지정한 길이만큼의 문자열을 반환
select substr(name,1,1)"성",count(*)"인원"
from customer
group by substr(name,1,1);

insert into Customer VALUES(6, '남동연', '서울 금천구','010-0000-1510');
delete from customer where custid=6;

insert into customer values(6,'박찬호','대한민국 공주','');
delete from customer where custid=6;

select * from customer;
select * from orders;

select to_date('2020-07-01')오늘날짜,to_date('2020-07-01','yyyy-mm-dd')+5 after, to_date('2020-07-01','yyyy-mm-dd')-5 before
from dual;



-- 마당서점은 주문일로부터 10일 후 매출을 확정한다.  각 주문의 확정일자를 구하시오
select orderid "주문번호" , orderdate"주문일", orderdate+10
from orders;

select * from orders;

-- 현재 날짜
select sysdate 
from dual;

-- TO_CHAR 함수를 사용하여 SYSDATE 값을 문자열 형식으로 변환
select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 
from dual;

-- 과제1_0509.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 
-- 모두 구하세요. 단, 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.

select orderid 주문번호, to_char(orderdate,'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
from orders
where orderdate='2020-07-07';

-- 과제2_0509.Q.DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.

select sysdate 
from dual;

select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 
from dual;

-- NVL 함수는 두개의 인수만 비교하고 coalesce함수는 여러 인수를 비교하고 첫번째 null이 아닌 인수의
-- 데이터 타입으로 결과를 반환
-- 과제3_0509. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 
-- 표시하세요.(NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
-- 함수  :  NVL("값", "지정값") 

select * from customer;

select name 이름, nvl(phone,'연락처없음') 전화번호
from customer;

select name 이름, coalesce(phone,' 연락처없음') 전화번호
from customer;

-- 과제4_0509. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이세요.
select rownum 순번, custid 고객번호, name 이름, phone 전화번호 
from customer
where  rownum<=2;

-- 과제5_0509. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이세요.

select orderid 주문번호, saleprice 금액
from orders
where saleprice<=(select avg(saleprice)from orders);

-- 과제6_0509. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 
-- 금액을 보이시오.
select * from customer;
select o1.orderid 주문번호, o1.custid 고객번호, o1.saleprice 금액
from orders o1
where o1.saleprice > (select avg(o2.saleprice)from orders o2 where o1.custid=o2.custid);

-- 과제7_0509.‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하세요.
select sum(saleprice)  
from customer c, orders o
where address  like '%대한민국%' and o.custid=c.custid;

-- 과제8_0509. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice>(select max(saleprice)from orders where custid=3);

-- 과제9_0509. EXISTS 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice)
from orders o
where EXISTS (
  select *
  from customer c
  where o.custid = c.custid and c.address like '%대한민국%');

-- 과제10_0509. 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select c.name 고객이름, sum(o.saleprice) "고객별 판매액"
from customer c, orders o
where c.custid= o.custid
group by c.name;

select * from customer;
-- update set
update customer
set phone='010-1234-5678'
where custid=1;
select * from orders;

-- 과제11_0509. 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)

select name 고객이름, sum(saleprice) "고객별 판매액"
from customer c, orders o
where c.custid<=2 and c.custid=o.custid
group by c.name;


select cs.name, sum(od.saleprice)
from(select custid, name
from customer
where custid <= 2) cs,
orders od
where cs.custid=od.custid
group by cs.name;