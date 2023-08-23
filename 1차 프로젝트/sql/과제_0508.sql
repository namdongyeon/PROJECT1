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

--����4_0508. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select name as "�̸�", sum(saleprice) as "�� �Ǹž�"
from orders, customer
where customer.custid=orders.custid
group by name
order by customer.name;


--����5_0508. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select distinct name, bookname
from customer, book, orders
where book.bookid=orders.bookid and customer.custid=orders.custid
order by name;


--����6_0508. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
select distinct name, bookname
from customer, book, orders
where price=20000 and customer.custid=orders.custid
order by name;

--����7_0508. '���ѹ̵��'���� ������ ������ ������ ���� �̸��� �˻��Ͻÿ�.
select distinct name 
from customer,book,orders
where book.publisher='���ѹ̵��' and customer.custid=orders.custid
order by name;


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

--����10_0508. �ֹ��� �ִ� ���� �̸��� �ּҸ� �˻��Ͻÿ�.
select name, address
from customer, orders
where customer.custid=orders.custid
order by name;