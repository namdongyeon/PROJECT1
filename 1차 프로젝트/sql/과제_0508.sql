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

--과제4_0508. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select name as "이름", sum(saleprice) as "총 판매액"
from orders, customer
where customer.custid=orders.custid
group by name
order by customer.name;


--과제5_0508. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select distinct name, bookname
from customer, book, orders
where book.bookid=orders.bookid and customer.custid=orders.custid
order by name;


--과제6_0508. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select distinct name, bookname
from customer, book, orders
where price=20000 and customer.custid=orders.custid
order by name;

--과제7_0508. '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 검색하시오.
select distinct name 
from customer,book,orders
where book.publisher='대한미디어' and customer.custid=orders.custid
order by name;


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

--과제10_0508. 주문이 있는 고객의 이름과 주소를 검색하시오.
select name, address
from customer, orders
where customer.custid=orders.custid
order by name;