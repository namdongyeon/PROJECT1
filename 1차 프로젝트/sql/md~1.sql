SELECT * FROM book;

select * from book
where price>=10000 and price<=20000;

select * from book
where publisher='�½�����' or publisher='���ѹ̵��';

select * from book
where publisher in ('�½�����', '���ѹ̵��');

select * from book
where publisher not in ('�½�����', '���ѹ̵��');

select bookname, publisher from book
where bookname like '�౸�� ����';

select * from book
where bookname like '%�౸%';

select * from book
where bookname like '%_��%';

select * from book
where bookname like '%�౸%' and price>=20000;

--����(default �ø�����) --(desc ��������)
select * 
from book
order by bookname desc;

-- ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�
select * 
from book
order by price, bookname;

-- ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ���.
select * 
from book
order by price desc, publisher;

--
select * 
from orders;

-------------------------------
select sum(saleprice) as "�� ����" 
from orders;

--
select sum(saleprice)
from orders
where custid like '2';

--����1_ 0508. orders ���̺��� saleprice�� �հ�, ���, �ּҰ�, �ִ밪�� ���ϼ���
select sum(saleprice) as "�հ�",avg(saleprice) as "���",min(saleprice) as "�ּҰ�",max(saleprice) as "�ִ밪" 
from orders;

--����2_ 0508. orders ���̺��� ��������, �� �Ǹž��� ���ϼ���.
select COUNT(*) as "��������",  sum(saleprice) as "�� �Ǹž�"
from orders;

--����3_0508. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
--having���� group by���� �Բ� ���Ǿ� �׷�ȭ�� ��� ������ ���͸��ϴµ� ����
--where ���տ� ���� ������ �����ϴ� �ݸ� having���� �����Լ� ����� ���� ������ ����
select custid as "��id", count(custid) as "�ֹ� ���� ����", sum(saleprice) as "�� �ֹ���"
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

--���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
select name, saleprice
from customer, orders
where customer.custid=orders.custid;

--����4_0508. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select name as "�̸�", sum(saleprice) as "�� �Ǹž�"
from orders, customer
where customer.custid=orders.custid
group by name
order by customer.name;



--����5_0508. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select name, bookname
from book b, customer c, orders o
where b.bookid=o.bookid and c.custid=o.custid
order by name;

--����6_0508. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
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

--�μ� ����
--���� ��� ������ �̸��� ����ϼ���
select bookname, price
from book
where price=(select max(price) from book);



-- ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
select name
from customer c, orders o 
where o.custid=c.custid;


select name 
from customer 
where custid in (select custid from Orders);

--����7_0508. '���ѹ̵��'���� ������ ������ ������ ���� �̸��� �˻��Ͻÿ�.
select distinct name 
from customer,book,orders
where book.publisher='���ѹ̵��' and customer.custid=orders.custid
order by name;

select name
from customer
where custid in(select custid 
                from orders 
                where bookid in 
                        (select bookid 
                        from book 
                        where publisher='���ѹ̵��'));


--����8_0508. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ �˻��Ͻÿ�.
select publisher, avg(price)
from book
group by publisher;

select b1.bookname
from book b1
where b1.price > (select avg(b2.price) from Book b2 where b2.publisher = b1.publisher);

--����9_0508. ������ �ֹ����� ���� ���� �̸��� �˻��Ͻÿ�.
select name 
from customer 
where custid  not in (select custid from orders);

select name
from customer
minus 
select name
from customer
where custid in (select custid from orders);

--����10_0508. �ֹ��� �ִ� ���� �̸��� �ּҸ� �˻��Ͻÿ�.
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

-- Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
select round(avg(saleprice),-2)
from orders o, customer c
where o.custid=c.custid
group by name;

select custid, round(avg(saleprice),-2) ��ձݾ� 
from orders 
group by custid;

-- Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���ϼ���.
select bookid, replace(bookname, '�߱�', '��') bookname, price
from book;

-- Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
select bookname,length(bookname),lengthb(bookname)
from book
where publisher='�½�����';

select* from book;

-- ���缭���� ���߿��� ���� ���� ���� ����� ����̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
-- substr �̶� Ư�� ��ġ���� �����Ͽ� ������ ���̸�ŭ�� ���ڿ��� ��ȯ
select substr(name,1,1)"��",count(*)"�ο�"
from customer
group by substr(name,1,1);

insert into Customer VALUES(6, '������', '���� ��õ��','010-0000-1510');
delete from customer where custid=6;

insert into customer values(6,'����ȣ','���ѹα� ����','');
delete from customer where custid=6;

select * from customer;
select * from orders;

select to_date('2020-07-01')���ó�¥,to_date('2020-07-01','yyyy-mm-dd')+5 after, to_date('2020-07-01','yyyy-mm-dd')-5 before
from dual;



-- ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�.  �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
select orderid "�ֹ���ȣ" , orderdate"�ֹ���", orderdate+10
from orders;

select * from orders;

-- ���� ��¥
select sysdate 
from dual;

-- TO_CHAR �Լ��� ����Ͽ� SYSDATE ���� ���ڿ� �������� ��ȯ
select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 
from dual;

-- ����1_0509.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� 
-- ��� ���ϼ���. ��, �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.

select orderid �ֹ���ȣ, to_char(orderdate,'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
from orders
where orderdate='2020-07-07';

-- ����2_0509.Q.DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.

select sysdate 
from dual;

select sysdate, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') sysdate1 
from dual;

-- NVL �Լ��� �ΰ��� �μ��� ���ϰ� coalesce�Լ��� ���� �μ��� ���ϰ� ù��° null�� �ƴ� �μ���
-- ������ Ÿ������ ����� ��ȯ
-- ����3_0509. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� 
-- ǥ���ϼ���.(NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
-- �Լ�  :  NVL("��", "������") 

select * from customer;

select name �̸�, nvl(phone,'����ó����') ��ȭ��ȣ
from customer;

select name �̸�, coalesce(phone,' ����ó����') ��ȭ��ȣ
from customer;

-- ����4_0509. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̼���.
select rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ 
from customer
where  rownum<=2;

-- ����5_0509. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̼���.

select orderid �ֹ���ȣ, saleprice �ݾ�
from orders
where saleprice<=(select avg(saleprice)from orders);

-- ����6_0509. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, 
-- �ݾ��� ���̽ÿ�.
select * from customer;
select o1.orderid �ֹ���ȣ, o1.custid ����ȣ, o1.saleprice �ݾ�
from orders o1
where o1.saleprice > (select avg(o2.saleprice)from orders o2 where o1.custid=o2.custid);

-- ����7_0509.�����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���ϼ���.
select sum(saleprice)  
from customer c, orders o
where address  like '%���ѹα�%' and o.custid=c.custid;

-- ����8_0509. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice>(select max(saleprice)from orders where custid=3);

-- ����9_0509. EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice)
from orders o
where EXISTS (
  select *
  from customer c
  where o.custid = c.custid and c.address like '%���ѹα�%');

-- ����10_0509. ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
select c.name ���̸�, sum(o.saleprice) "���� �Ǹž�"
from customer c, orders o
where c.custid= o.custid
group by c.name;

select * from customer;
-- update set
update customer
set phone='010-1234-5678'
where custid=1;
select * from orders;

-- ����11_0509. ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)

select name ���̸�, sum(saleprice) "���� �Ǹž�"
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