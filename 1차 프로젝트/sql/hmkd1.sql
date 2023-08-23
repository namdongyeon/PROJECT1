--[DDL]
--Table ����
create table test1(
eno number(4),
ename varchar2(20),
esal number(7)
);
desc test1;
drop table test1;
--Table ����
create table test2 as select * from test1;
insert into test1 values (1, '����ȣ', 5);
select * from test1;

--Table ���� ����
--�������� ���� ������ �����ϸ� �ش� �ο츦 �߰����� ���ϱ� ������ �� ���̺��� ���� 
create table test3 as select * from test1 where 1=0;
select * from test3;
desc test3

--�÷� �߰��ϱ�
alter table test1 add(email varchar2(10));

--�÷� �����ϱ�
alter table test1 modify(email varchar2(40));

--�÷� �����ϱ�
alter table test1 drop column email;

--���̺��� ��� �ο� ���� ���븸 ����
select * from test1;
truncate table test1;

----[���̺� ���� ��Ģ]

--���̺���� ��ü�� �ǹ��� �� �ִ� ������ �̸��� ����Ѵ�. ������ �ܼ����� �ǰ��Ѵ�.--
--���̺���� �ٸ� ���̺��� �̸��� �ߺ����� �ʾƾ� �Ѵ�.--
--�� ���̺� �������� Į������ �ߺ��ǰ� ������ �� ����. --
--���̺� �̸��� �����ϰ� �� Į������ ��ȣ "( )" �� ���� �����Ѵ�.--
--�� Į������ �޸�" ", �� ���еǰ�, �׻� ���� �����ݷ� ";"���� ������.--
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �����ͺ��̽� �������� �ϰ��� �ְ� ����ϴ� ���� ����. (������ ǥ��ȭ ����)--
--Į�� �ڿ� ������ ������ �� �����Ǿ�� �Ѵ�.--
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.--
--�������� ������ ������ �����(Reserved word)�� �� �� ����.--
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.

--���̺� ����Ʈ�� ��ȸ 
select * from tabs;

create table member(
ID varchar2(20),
PWD varchar2(20),
NAME varchar2(20),
GENDER char(1),
AGE number(2),
BIRTHDAY date,
PHONE varchar2(20),
regdate date
);

insert into member values('hmkd1','1111','namdy','M',29,(date '1995-8-31'),'010-0000-1510',(date '2023-3-6'));
insert into member(id, pwd, name, gender, birthday, regdate) values('hmkd2','1234','kevin','M',(date '2000-1-2'),(date '2023-3-6'));
drop table member;
select * from member;

desc member;

alter table member add(hobby varchar2(20));
alter table member modify(hobby varchar2(30));
alter table member drop column hobby;

alter table member add constraint member_pk primary key(id);
alter table member drop constraint member_pk;

-- Q. MEMBER1 ���̺��� ����(��� ������ Ÿ�� ����)�ϰ� 2���� ������ �Է� �� Į�� �߰�, Ÿ�� ����,
-- Į�� ����, �������� �߰�, ������ �� ����ϼ���.
create table member1(
kind varchar2(20),
company varchar2(20),
years date,
price number(10),
repaired char(1)
);
insert into member1 values('sorento','kia',(date '2022-10-20'),30000000,'N');
insert into member1 values('sonata','hyundai',(date '2019-8-20'),18000000,'N');

alter table member1 add(phone number(20));
alter table member1 modify(phone varchar2(20));

UPDATE member1
SET phone = '010-1234-5678'
WHERE kind = 'sorento' AND phone IS NULL;
UPDATE member1
SET phone = '010-1458-5458'
WHERE kind = 'sonata' AND phone IS NULL;

alter table member1 drop column phone;
alter table member1 add constraint member1_pk primary key(phone);
alter table member drop constraint member_pk;

desc member1;
truncate table member1;
select * from member1;

-- ���� 1_0510. member2 ���̺��� �����Ͽ� ddl ��ü ��ɾ ����ϴ� �ڵ带 �ۼ��ϼ���.
create table member2(
name varchar2(10),
kind varchar2(20),
company varchar2(20),
years date,
price number(10),
repaired char(1)
);
insert into member2 values('��ö��','sorento','kia',(date '2022-10-20'),30000000,'N');
insert into member2 values('��¯��','sonata','hyundai',(date '2019-8-20'),18000000,'N');

alter table member2 add(phone number(20));
alter table member2 modify(phone varchar2(20));
alter table member2 add constraint member2_pk primary key(name);
alter table member2 drop column phone;

UPDATE member2
SET phone = '010-1234-5678'
WHERE name = '��ö��';

truncate table member2;
desc member2;
select * from member2;

-- [DML]

-- IN: or ��� ���
select * from employees;
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in (101,102,103);

select employee_id, manager_id from employees;
-- between and: and ��� ��� 101~ 105����
select employee_id, manager_id from employees where manager_id between 101 and 105;

-- null �������� Ȯ��, �ƴѰ͸� ���
select employee_id, commission_pct 
from employees 
where commission_pct is null;

select employee_id, commission_pct 
from employees 
where commission_pct is not null;

--order by
select employee_id, last_name, salary 
from employees
order by salary, last_name; 

select employee_id, last_name, salary 
from employees
order by salary, last_name desc;

-- dual table
--select �� ������ �ݵ�� from ���� ����ؾ� �Ѵ�.
--������ ��� select �� ��ü������ ������ �����ϱ� ������ from �� �ڿ� �� ���̺��� �ʿ����.
--�̷� ��� ����� �� �ִ� Dummy ���̺��� DUAL ���̺��̴�.

--mod: ������
select employee_id, last_name from employees where mod(employee_id, 2)=1;
select mod(10,3) from dual;

-- round() : �ݿø� �Լ�
select round(355.95555,2) from dual;
select round(355.95555,-2) from dual;


--trunc() ���� �Լ�, ������ �ڸ��� ���ϸ� ���� ����� ��ȯ
select trunc(45.5555) from dual;
select trunc(45.5555,-1) from dual;
select trunc(45.5555,1) from dual;

--��¥ ���� �Լ�
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;

select last_name, hire_date, sysdate-hire_date �ٹ��ϼ� from employees;
select last_name, hire_date, add_months(hire_date,6) from employees;
select last_name, hire_date, last_day(hire_date) from employees;
select last_day(sysdate)-sysdate from dual;
select hire_date, next_day(hire_date,'��') from employees;
select last_name, months_between(sysdate, hire_date) from employees;

-- �� ��ȯ
-- to_date: ���ڸ� ��¥�� ��ȯ
select to_date('20210101') from dual;

-- to_char: ��¥�� ���ڷ� ��ȯ
select to_char(sysdate, 'yy/mm/dd') from dual;
select to_char(sysdate, 'yy/mm/dd hh24:mi:ss') from dual;

--����
--YYYY 		�� �ڸ� ����
--YY		�� �ڸ� ����
--YEAR		���� ���� ǥ��
--MM		���� ���ڷ�
--MON		���� ���ĺ�����
--DD		���� ���ڷ�
--DAY		���� ǥ��
--DY		���� ��� ǥ��
--D		���� ���� ǥ��
--
--AM �Ǵ� PM	���� ����
--HH �Ǵ� HH12	12�ð�
--HH24		24�ð�
--MI		��
--SS		��

-- ���� �Լ�
select upper('Hello World') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where upper(last_name)='SEO';
select last_name, salary from employees where lower(last_name)='seo';

-- ù���ڸ� �빮��
select job_id, initcap(job_id) from employees;

--length()
select job_id, length(job_id) from employees;

--instr() ���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� �� �� °
select instr('Hello World' , 'o' , 2, 2) from dual;

--substr(���ڿ�, ������ġ, ����)
select substr('Hello World', 3, 3) from dual;
select substr('Hello World', -3, 3) from dual;

--lpad(), rpad() ����, ������ ���� �� ���ڸ� ä���.
select lpad('Hello World', 20,'#') from dual;
select rpad('Hello World', 20,'#') from dual;

--ltrim(), rtrim() ��, ���� Ư�� ���� ����
select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;

--trim() �յ��� Ư�� ���� ����
select last_name, trim('A' from last_name) new_name from employees;

--nvl() : null�� 0 �Ǵ� �ٸ� ������ ��ȯ
select salary, nvl(commission_pct, 0) 
from employees;
select last_name, nvl(to_char(manager_id),'ceo') from employees;
select last_name, department_id from employees;
--decode(): if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
select last_name, department_id,
decode(department_id,
90, '�濵������',
60, '���α׷���',
100, '�λ��') �μ���
from employees;

--case(): decode() �Լ��� �����ϳ� decode() �Լ��� ������ ������ ��츸 ����������
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ����

select last_name, department_id,
case when department_id=90 then '�濵������'
     when department_id=60 then '���α׷���'
     when department_id=100 then '�λ��'
     when department_id=30 then '������'
     when department_id=50 then '������' end as �μ���
from employees;

--first_value() over() : �׷��� ù��° ���� ���Ѵ�.
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc) �ְ���
from employees;

--3�� ���� ������ �� ù��° ��
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc rows 3 preceding) �ְ���
from employees;

--����+2000���� �� ù��° ��
select first_name �̸�, salary ����,
first_value(salary) over(order by salary desc range 2000 preceding) �ְ���
from employees;
select department_id, salary from employees
order by department_id;

--sum() over(): ���Ŀ� ���� �׷��� ���� �հ踦 ���Ѵ�.
select department_id, last_name, sum(salary) over(order by department_id)
from employees;

--insert
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUM    N_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);
select * from member;
insert into member (id, pwd, name) values('200903','113','�迬��');
insert into member values('200103','113','�迬��','F',25,(date'1999-1-2'),sysdate);

--* UPDATE
--UPDATE ������ �����Ǿ�� �� Į���� �����ϴ� ���̺���� �Է��ϰ�, SET  ������ �����Ǿ�� �� Į����� �ش� Į�� ���� ������ ������ �̷������.
--UPDATE ���̺�� SET �����Ǿ�� �� Į���� = �����Ǳ⸦ ���ϴ� ���ο� ��;
--[����] UPDATE PLAYER SET POSITION = 'MF��;
select * from member;

UPDATE member
SET name = '�߽ż�'
WHERE id = 'hmkd2';

--* DELETE
--DELETE FROM ������ ������ ���ϴ� �ڷᰡ ����Ǿ� �ִ� ���̺���� �Է��ϰ� �����Ѵ�. �̶� FROM ������ ������ ������ Ű�����̴�. 
--DELETE [FROM] ������ ���ϴ� ������ �ִ� ���̺��;
--[����] DELETE FROM PLAYER;

delete member where pwd is null;

insert into member (id) values('200103');
alter table member add constraint member_pk primary key(id);
alter table member drop constraint member_pk;
desc member;

--UNION
--UNION( ������ ) INTERSECT( ������ ) MINUS( ������ ) UNION ALL( ��ġ�� �ͱ��� ���� )
--�� ���� �������� ����ؾ� �Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.

select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where salary<5000
union
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date<'05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where salary<5000
intersect
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date<'05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where salary<5000
minus
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date<'05/01/01'
order by �Ի���;

select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where salary<5000
union all
select first_name �̸�, hire_date �Ի���, salary �޿� from employees
where hire_date<'05/01/01'
order by �Ի���;

create table test5(
id varchar2(10),
name varchar2(10),
eng number
);
insert into test5 values('111','james',90);
insert into test5 values('112','susan',60);
insert into test5 values('113','tom',85);
insert into test5 values('114','jean',70);
insert into test5 values('115','dick',75);
delete test5 where eng =20;
select * from test5;

create table test6(
id varchar2(10),
math number,
age number
);

insert into test6 values('111',90,20);
insert into test6 values('112',60,20);
insert into test6 values('113',85,20);
insert into test6 values('114',70,20);
insert into test6 values('115',75,20);
select * from test6;

--inner join
select * 
from test5
inner join test6 on test5.id = test6.id;

select t5.id, t5.name, t5.eng, t6.math, t6.age 
from test5 t5
join test6 t6 on t5.id = t6.id;


--left outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age 
from test5 t5 left outer join test6 t6 on t5.id = t6.id;

--right outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age 
from test5 t5 join test6 t6 on t5.id(+) = t6.id;

--full outer join
select t5.id, t5.name, t5.eng, t6.math, t6.age 
from test5 t5 full outer join test6 t6 on t5.id = t6.id;

select* from test5;
select* from test6;
--����2_0510. test5, test6�� ������, ������, ���̸� where�� �̿��ؼ� ���ϼ���.

select id 
from test5
where eng>80
union
select id
from test6
where math>70;

select id 
from test5
where eng>80
union all
select id
from test6
where math>70;

select id 
from test5
where eng>80
intersect
select id
from test6
where math>70;

select id 
from test5
where eng>70
minus
select id
from test6
where math>90;

select t5.id,t5.name, t5.eng, t6.math, t6.age 
from test5 t5, test6 t6
where t5.id=t6.id;


--����3_0510. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
--join~on, where �� �����ϴ� �� ���� ��� ��� ���.
select *
from jobs;

select employees.employee_id, empoyees.last_name, employees.job_id, jobs.job_title
from employees
join jobs on employees.job_id=jobs.job_id and employee_id = 120;

select em.employee_id, em.first_name, em.last_name, em.job_id, j.job_title
from employees em, jobs j
where employee_id=120 and em.job_id=j.job_id;


--����4_0510. employees, jobs, departments ������ ���̺��� �����ؼ� employee_id, job_title, 
--department_name�� ����ϼ���.

select em.employee_id, j.job_title, d.department_name
from employees em, jobs j, departments d
where em.job_id=j.job_id and em.manager_id=d.manager_id
order by em.employee_id;


--����5_0510. hr�� ���ԵǴ� 6���� ���̺���� �м��ؼ� �λ���Ʈ�� ���� �� �ִ�
--������� 5�� �̻� ����ϼ���. 
--(�� : �μ��� ��� SALARY ����)

SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;

-- �ٹ��ϼ��� ���� ��å�� �ִ뿬��
select round(sysdate-e.hire_date,1) �ٹ��ϼ�,j.job_title, j.max_salary
from employees e, jobs j
where e.job_id=j.job_id
order by j.max_salary desc;

-- �μ��� �ִ�޿��� �ּұ޿� ������ ���
SELECT d.DEPARTMENT_NAME, ROUND(AVG(j.max_salary-j.min_salary))
from departments d, employees e, jobs j
where d.department_id=e.department_id and j.job_id=e.job_id
group by department_name
order by ROUND(AVG(j.max_salary-j.min_salary)) desc;

-- �μ��� ��� �ٹ��Ⱓ(��)
select department_name, round(avg(sysdate-hire_date)/365,1)
from departments d, employees e
where d.department_id =e.department_id
group by d.department_name
order by avg(sysdate-hire_date) desc;


--rank() within group(order by �÷��� ����)
select commission_pct from employees
order by commission_pct desc;

--rank 1���� 73��°
select rank(0.31) within group( order by commission_pct desc) from employees;
select rank() over(order by salary) from employees;
select rank(3000) within group( order by salary) from employees;

--count() 
--null�� ����, �ߺ��� count
select count(commission_pct) from employees;
select count(distinct commission_pct) from employees;

--��ü���� ��
select count(*) from employees;

--group by
-- ���� select �ڿ��� �׷����� ���� �� �ִ� �÷� �� �� �� �ִ�.

select department_id, round(avg(salary)) from employees group by department_id;
select job_id, avg(salary) from employee group by job_id;

select job_id, avg(salary), max(salary), min(salary)
from employees
group by job_id;

--Q. ��տ����� 5000�̻��� �μ��鿡 ���ؼ� job_id ���� �����հ� ������� �ְ��� �������� ���
select job_id, sum(salary), avg(salary), max(salary), min(salary)
from employees
group by job_id
having avg(salary)>=5000;

--Q. ��տ����� 10000�̻��� �μ��鿡 ���ؼ� job_id ���� ������� �μ��ο� ���(������� ���� �������� ����)
select job_id, avg(salary), count(employee_id)
from employees
group by job_id
having avg(salary)>=10000
order by avg(salary) desc;

-- ���� ����
--Seo ��� ����� �μ����� ��� ������ �� �� �˻��ؾ� �Ѵ�.
select department_id from employees where last_name='Seo';
select department_name from departments where department_id=50;

select department_id, department_name
from departments
where department_id=(select department_id from employees where last_name='Seo');

-- ��պ��� ���� �޿��� �޴� ���� �˻�
select last_name, salary
from employees
where salary>(select avg(salary) from employees);

--'Seo' �� �Ѹ��̱� ������ ������ ���� ����
select last_name, hire_date, department_id from employees
where department_id=(select department_id from employees where last_name='Seo');

--'King'�� �θ��̱� ������ ������ ���� ����
select last_name, hire_date, department_id from employees
where department_id in (select department_id from employees where last_name='King');

-- ������
select last_name, salary from employees
where salary>all(select salary from employees where department_id =100);

-- ������
select last_name, salary from employees
where salary>(select max(salary) from employees where department_id =100);

--Ư���μ����� ���� �Ի�
select last_name, salary, department_id, hire_date
from employees
where hire_date<all(select hire_date from employees where department_id=100);

select last_name, salary from employees
where salary > any (select salary from employees where department_id=100);



--����1_0511. ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'


select employee_id, last_name,
case when salary > 20000 then '��ǥ�̻�'
     when salary > 15000 then '�̻�' 
     when salary > 10000 then '����' 
     when salary > 5000 then '����' 
     when salary > 3000 then '�븮' 
     else '���' end as ����
from employees;

--����2_0511. �μ��� ���� ������ ����ϼ���.


select * from employee_salary;
--����3_0511. employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����ϼ���.
create table employee_salary as select employee_id, salary from employees;

--����4_0511. employees_salary ���̺� first_name, last_name �÷��� �߰��ϼ���.
alter table employee_salary add(first_name varchar2(20));
alter table employee_salary add(last_name varchar2(20));

--����5_0511. last_name�� name���� �����ϼ���.
alter table employee_salary rename column last_name to name;

--����6_0511. employees_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� �� 
--����ϼ���.
alter table employee_salary add constraint ES_PK primary key(employee_id);
desc employee_salary;

--����7_0511. employees_salary ���̺��� employee_id���� CONSTRAINT_NAME�� ������ ���� ���θ� Ȯ���ϼ���.
alter table employee_salary drop constraint ES_PK;
desc employee_salary;

--m4_db test 
select * from employees;
select * from jobs;
--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
select last_name, salary, salary * 1.1
from employees;

--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
select * from employees
where hire_date;

--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
select * 
from employees e, jobs j
where j.job_id= 'SA_MAN' or j.job_id= 'IT_PROG' or j.job_id= 'ST_MAN';

--Q4. manager_id �� 101���� 103�� ����� ���
select * from employees
where manager_id>=101 and manager_id<=103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
select last_name, hire_date,next_day(add_months(hire_date,6),'��')  from employees;

select * from employees;
select * from jobs;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� 
--�����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)


--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� 
--W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
select employee_id, last_name 
from employees
where mod(employee_id, 2)=1;
--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. 
--�� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
select employee_id, last_name, round(salary/12,2) M_SALARY 
from employees;

--Q10. employees ���̺��� ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'    

select employee_id, last_name,
case when salary > 20000 then '��ǥ�̻�'
     when salary > 15000 then '�̻�' 
     when salary > 10000 then '����' 
     when salary > 5000 then '����' 
     when salary > 3000 then '�븮' 
     else '���' end as ����
from employees;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.

select * 
from employees
where commission_pct is null;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
select * 
from employees
where department_id is null;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���
--(join~on, where �� �����ϴ� �� ���� ��� ���)

select employees.employee_id, employees.last_name, employees.job_id, jobs.job_title
from employees
join jobs on employees.job_id=jobs.job_id and employee_id = 120;

select em.employee_id, em.first_name, em.last_name, em.job_id, j.job_title
from employees em, jobs j
where employee_id=120 and em.job_id=j.job_id;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
alter table employees add(name varchar2(20))