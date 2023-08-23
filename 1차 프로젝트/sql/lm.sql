select * from channel;
select * from compet;
select * from demo;
select * from membership;
select * from prodcl;
select * from purprod;

--demographic data
select count(*) from demo
order by ����ȣ;

--���޻纰 ����� �̿���Ȳ
select * from compet;

-- �����
select * from membership;

-- ��ǰ�з�
select * from prodcl;

-- ���ŵ�����
select count(*) from purprod;
select * from purprod;

-- �����հ�
select sum(���űݾ�)
from purprod;

--purprod ����
create table purprod1 as 
select * from purprod;

-- ������ �����հ�
alter table purprod1 add year varchar2(20);

update purprod1 set year=substr(��������,1,4);

commit;

select year, sum(���űݾ�) ���ž�
from purprod1
group by year;

--���� �����հ�
select ����ȣ, sum(���űݾ�) ���ž�
from purprod1
group by ����ȣ
order by ���ž� desc;

--���� ���޻纰 ���� �հ�
select ����ȣ, ���޻�, sum(���űݾ�) ���ž�
from purprod1
group by ����ȣ, ���޻�
order by ����ȣ;

--���� ���޻纰 ��ǰ��з� ���� �հ�
select ����ȣ, ���޻�, ��з��ڵ�, sum(���űݾ�) ���ž�
from purprod1
group by ����ȣ, ���޻�, ��з��ڵ�
order by ����ȣ;

CREATE TABLE AMT14
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� < 20150101
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

select * from amt14;
select * from amt15;
CREATE TABLE AMT15
AS SELECT ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ� 
FROM PURPROD
WHERE �������� > 20141231
GROUP BY ����ȣ, ���޻�
ORDER BY ����ȣ;

--FULL OUTER JOIN ���̺� ����
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.����ȣ, A4.���޻�, A4.���űݾ� ����14, A5.���űݾ� ����15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.����ȣ=A5.����ȣ AND A4.���޻�=A5.���޻�);
select * from AMT_YEAR_FOJ;

--FULL OUTER JOIN ����� ���� ���
SELECT ����ȣ,���޻�, NVL(����14,0) ����14, NVL(����15,0) ����15,
(NVL(����15,0)-NVL(����14,0)) ����
FROM AMT_YEAR_FOJ A;

--�ݱ⺰ ���űݾ�
ALTER TABLE PURPROD1 ADD MONTH VARCHAR2(20);
UPDATE PURPROD1 SET MONTH=SUBSTR(��������,1,6);
COMMIT;

select month from purprod1;

DESC PURPROD1;
ALTER TABLE PURPROD1 ADD HYEAR VARCHAR2(20);
ALTER TABLE PURPROD1 ADD QYEAR VARCHAR2(20);

UPDATE PURPROD1 
SET HYEAR=
CASE WHEN MONTH <=201406 THEN '20141H'
WHEN MONTH <=201412 THEN '20
142H'
WHEN MONTH <=201506 THEN '20151H'
ELSE '20152H' 
END;

UPDATE PURPROD1 
SET QYEAR=
CASE WHEN MONTH <=201403 THEN '20141Q'
WHEN MONTH <=201406 THEN '20142Q'
WHEN MONTH <=201409 THEN '20143Q'
WHEN MONTH <=201412 THEN '20144Q'
WHEN MONTH <=201503 THEN '20151Q'
WHEN MONTH <=201506 THEN '20152Q'
WHEN MONTH <=201509 THEN '20153Q'
ELSE '20154Q' 
END;  




COMMIT;
SELECT * FROM PURPROD1;

--����8_0511. lm ������ ���̺� 6���� l���� ���� ��Ȳ�� �ľ��� �� �ִ� ��� ���̺��� 5�� �̻� �����ϰ� �����ϼ���.
select * from membership;

select ���ɴ�,count(����ʸ�)
from demo d, membership m
where d.����ȣ=m.����ȣ
group by ���ɴ�
order by ���ɴ�;

select count(*) from purprod1;

select count(��з��ڵ�), count(�ߺз��ڵ�),count(�Һз��ڵ�),count(�ߺз���),count(�Һз���) from purprod1
where �Һз� is not null;

select ���ɴ�, count(���ɴ�)
from demo
group by ���ɴ�
order by ���ɴ�;



select ����, count(����ȣ)
from demo
group by ����; 


SELECT ����, COALESCE(COUNT(d.����ȣ), 0) AS ����, COALESCE(COUNT(m.����ȣ), 0) AS ����ʼ�
FROM demo d
LEFT JOIN membership m ON d.����ȣ = m.����ȣ
WHERE ���� IN ('M', 'F') 
GROUP BY ����
ORDER BY ����;


select ���޻�, count(���޻�)
from purprod1
group by ���޻�
order by ���޻�; 


select * from prodcl
where ���޻� ='D';

select count(*) 
from compet c, prodcl p
where p.���޻�= c.���޻�;



SELECT COUNT(*)
FROM (
    SELECT demo.����ȣ
    FROM demo
    MINUS
    SELECT membership.����ȣ
    FROM membership
) result;


select ���ɴ�, count(eo)
from demo
group by ���ɴ�
order by ���ɴ�;





--���̺� ���� : DEMO + PURPROD
SELECT d.����ȣ, SUM(p.HYEAR='201406'), sum(p.HYEAR='201412') 
FROM DEMO d, PURPROD1 p
WHERE d.����ȣ = p.����ȣ
GROUP BY d.����ȣ;

SELECT d.����ȣ,
       SUM(CASE WHEN p.HYEAR = '201406' THEN 1 ELSE 0 END) AS "201406 �� ���� Ƚ��",
       SUM(CASE WHEN p.HYEAR = '201412' THEN 1 ELSE 0 END) AS "201412 �� ���� Ƚ��"
FROM DEMO d
JOIN PURPROD1 p ON d.����ȣ = p.����ȣ
GROUP BY d.����ȣ;





--���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ����
SELECT * FROM PURPROD1;

CREATE TABLE CUSPUR
AS SELECT ����ȣ, 
SUM(CASE WHEN HYEAR='20141H' THEN ���űݾ� ELSE 0 END) AS H1,
SUM(CASE WHEN HYEAR='20142H' THEN ���űݾ� ELSE 0 END) AS H2,
SUM(CASE WHEN HYEAR='20151H' THEN ���űݾ� ELSE 0 END) AS H3,
SUM(CASE WHEN HYEAR='20152H' THEN ���űݾ� ELSE 0 END) AS H4
FROM PURPROD1
GROUP BY ����ȣ
ORDER BY ����ȣ;

drop table cuspur2;

CREATE TABLE CUSPUR2
AS SELECT ����ȣ, 
SUM(CASE WHEN QYEAR='20141Q' THEN ���űݾ� ELSE 0 END) AS Q1,
SUM(CASE WHEN QYEAR='20142Q' THEN ���űݾ� ELSE 0 END) AS Q2,
SUM(CASE WHEN QYEAR='20143Q' THEN ���űݾ� ELSE 0 END) AS Q3,
SUM(CASE WHEN QYEAR='20144Q' THEN ���űݾ� ELSE 0 END) AS Q4,
SUM(CASE WHEN QYEAR='20151Q' THEN ���űݾ� ELSE 0 END) AS Q5,
SUM(CASE WHEN QYEAR='20152Q' THEN ���űݾ� ELSE 0 END) AS Q6,
SUM(CASE WHEN QYEAR='20153Q' THEN ���űݾ� ELSE 0 END) AS Q7,
SUM(CASE WHEN QYEAR='20154Q' THEN ���űݾ� ELSE 0 END) AS Q8
FROM PURPROD1
GROUP BY ����ȣ
ORDER BY ����ȣ;

SELECT * FROM CUSPUR2;

--DEMO�� CUSPUR ����ȣ ���� ���� : CUSDP
DESC DEMO;
DROP TABLE CUSDP;

CREATE TABLE CUSDP
AS SELECT CP.*, D.����, D.���ɴ�, D.��������
FROM CUSPUR CP, DEMO D 
WHERE D.����ȣ = CP.����ȣ;

CREATE TABLE CUSDP2
AS SELECT CP.*, D.����, D.���ɴ�, D.��������
FROM CUSPUR2 CP, DEMO D 
WHERE D.����ȣ = CP.����ȣ;

SELECT * FROM CUSDP;

CREATE TABLE CUSDEPU
AS SELECT * 
FROM CUSDP
ORDER BY ����ȣ;

CREATE TABLE CUSDEPU2
AS SELECT * 
FROM CUSDP2
ORDER BY ����ȣ;

SELECT * FROM compet;

SELECT * FROM CUSDEPU2;


-- ����1_0512. LM ��� ������ �ľ��� �� �ִ� ��ü, ��, ��ǰ�� ���̺��� 3�� �̻� �ۼ��ϼ���.
CREATE TABLE GENDER_M
as SELECT ����, COALESCE(COUNT(d.����ȣ), 0) AS ����, COALESCE(COUNT(m.����ȣ), 0) AS ����ʼ�
FROM demo d
LEFT JOIN membership m ON d.����ȣ = m.����ȣ
WHERE ���� IN ('M', 'F') 
GROUP BY ����
ORDER BY ����;

drop table GENDER_M;
select * from GENDER_M;
select * from pro_Age;

drop Table PRO_AGE;



--��ǰ�� � ���ɴ밡 ���� ��
CREATE TABLE PRO_AGE
as;
SELECT p.�ߺз���, d.���ɴ�, COUNT(*) AS ���ŰǼ�
FROM prodcl p, compet c, demo d
WHERE p.���޻� = c.���޻� 
  AND c.����ȣ = d.����ȣ
GROUP BY p.�ߺз���, d.���ɴ�
ORDER BY  �ߺз���;

select YEAR from purprod1;

sel

-- 2014�� ���ŰǼ� ���ɴ뺰
SELECT p.�ߺз��ڵ�, d.���ɴ�, COUNT(*) AS ���ŰǼ�, sum(p.���űݾ�)
FROM purprod1 p, compet c, demo d
WHERE p.����ȣ = d.����ȣ 
  AND p.YEAR=2014
GROUP BY p.�ߺз��ڵ�, d.���ɴ�
ORDER BY  �ߺз��ڵ�;

drop table AF_PR;

select * from purprod1;

-- ���޻� �� ����ȣ �ݾ�

create table AF_PR as 
SELECT p.����ȣ, p.���޻�, p.YEAR, SUM(p.���űݾ�) as �ѱ��űݾ�
FROM purprod1 p, demo d
WHERE p.����ȣ = d.����ȣ
GROUP BY p.����ȣ, p.���޻�, p.YEAR
ORDER BY p.����ȣ;


-- 2015�� ���ŰǼ� ���ɴ뺰
SELECT p.�ߺз��ڵ�, d.���ɴ�, COUNT(*) AS ���ŰǼ�
FROM purprod1 p, compet c, demo d
WHERE p.���޻� = c.���޻� 
  AND c.����ȣ = d.����ȣ
  AND p.YEAR=2015
GROUP BY p.�ߺз��ڵ�, d.���ɴ�
ORDER BY  �ߺз��ڵ�;

CREATE TABLE PRO_AGE
AS;

SELECT p.�ߺз���, d.���ɴ�, SUM(pd.���űݾ�) AS �ѱ��ž�
FROM purprod1 pd, prodcl p, compet c, demo d
WHERE p.���޻� = c.���޻� 
  AND c.����ȣ = d.����ȣ
  AND p.���޻� = pd.���޻�
GROUP BY p.�ߺз���, d.���ɴ�
ORDER BY �ߺз���;

SELECT p.�ߺз���, d.���ɴ�, SUM(pd.���űݾ�) AS �ѱ��ž�
FROM prodcl p
JOIN compet c ON p.���޻� = c.���޻�
JOIN demo d ON c.����ȣ = d.����ȣ
JOIN (
    SELECT DISTINCT ���޻�, ����ȣ, ���űݾ�
    FROM purprod1
) pd ON p.���޻� = pd.���޻� AND c.����ȣ = pd.����ȣ
GROUP BY p.�ߺз���, d.���ɴ�
ORDER BY �ߺз���;



SELECT p.�ߺз���, d.���ɴ�, COUNT(*) AS ���ŰǼ�
FROM prodcl p, compet c, demo d
WHERE p.���޻� = c.���޻� 
  AND c.����ȣ = d.����ȣ
GROUP BY p.�ߺз���, d.���ɴ�
ORDER BY  �ߺз���;


-- ���� �Ѿ� ���ϱ�
SELECT SUBSTR(��������, 1, 6) AS ����, SUM(���űݾ�) AS ����_�Ѿ�
FROM purprod1
WHERE SUBSTR(��������, 1, 6) = '201405'
GROUP BY SUBSTR(��������, 1, 6);


create table AMTMon_14 as
SELECT SUBSTR(��������, 1, 6) AS ����, SUM(���űݾ�) AS ����_�Ѿ�
FROM purprod1
WHERE SUBSTR(��������, 1, 6) BETWEEN '201401' AND '201412'
GROUP BY SUBSTR(��������, 1, 6)
ORDER BY ����;


SELECT SUBSTR(��������, 1, 6) AS ����, SUM(���űݾ�) AS ����_�Ѿ�
FROM purprod1
WHERE SUBSTR(��������, 1, 6) BETWEEN '201501' AND '201512'
GROUP BY SUBSTR(��������, 1, 6)
order by ����;

SELECT SUBSTR(��������, 1, 6) AS ����, SUM(���űݾ�) AS ����_�Ѿ�
FROM purprod1
WHERE SUBSTR(��������, 1, 6) IN ('201501','201502','201503','201504','201505', '201506', '201507','201508','201509',
'201510','201511','201512') and ���޻�='D'
GROUP BY SUBSTR(��������, 1, 6)
order by ����;

SELECT SUBSTR(��������, 1, 6) AS ����, SUM(���űݾ�) AS ����_�Ѿ�
FROM purprod1
WHERE SUBSTR(��������, 1, 6) IN ('201401','201402','201403','201404','201405', '201406', '201407','201408','201409',
'201410','201411','201412','201501','201502','201503','201504','201505', '201506', '201507','201508','201509',
'201510','201511','201512') and ���޻�='A'
GROUP BY SUBSTR(��������, 1, 6)
order by ����;



select ����ȣ, sum(���űݾ�) as �Ѿ�


from purprod1
where year=2014
group by ����ȣ
order by �Ѿ� desc;

drop table CUSGRADE15;

create table cusgrade15 as
SELECT p.����ȣ,d.����, d.���ɴ�, d.��������, SUM(p.���űݾ�) AS �Ѿ�,
  CASE
    WHEN SUM(p.���űݾ�) >= 200000000 THEN 'VVIP'
    WHEN SUM(p.���űݾ�) >= 80000000 THEN 'VIP'
    WHEN SUM(p.���űݾ�) >= 30000000 THEN 'A'
    WHEN SUM(p.���űݾ�) >= 10000000 THEN 'B'
    WHEN SUM(p.���űݾ�) >= 3000000 THEN 'C'
    ELSE 'N'
  END AS ���
FROM purprod1 p, demo d
WHERE p.����ȣ = d.����ȣ AND p.year = 2015
GROUP BY p.����ȣ,d.����,  d.���ɴ�, d.��������
ORDER BY �Ѿ� DESC;

select * from cusgrade15;

create table year_purprod as
SELECT ���޻�, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�, ����ȣ, �����ڵ�, sum(���űݾ�) ���űݾ�, ���Žð�,
    SUM(CASE WHEN �������� LIKE '2014%' THEN ���űݾ� ELSE 0 END) "2014���űݾ�",
    SUM(CASE WHEN �������� LIKE '2015%' THEN ���űݾ� ELSE 0 END) "2015���űݾ�",
    SUM(CASE WHEN �������� LIKE '2015%' THEN ���űݾ� END) - SUM(CASE WHEN �������� LIKE '2014%' THEN ���űݾ� END) ������
FROM purprod1
group by ���޻�, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�, ����ȣ, �����ڵ�, ���Žð�;

create table year_pur_demo as
select d.*, ���޻�, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�, �����ڵ�, ���űݾ�, "2014���űݾ�", "2015���űݾ�", ���Žð�
from year_purprod y, demo d
where y.����ȣ=d.����ȣ;

select * from year_pur_demo;



SELECT p.�ߺз��ڵ�, pd.�ߺз���, COUNT(DISTINCT p.����ȣ) AS VVIP_���ż�
FROM purprod1 p, cusgrade14 c, prodcl pd
WHERE p.����ȣ = c.����ȣ AND p.�ߺз��ڵ� = pd.�ߺз��ڵ� AND c.��� = 'VVIP' AND p.���޻�='D'
GROUP BY p.�ߺз��ڵ�, pd.�ߺз���
HAVING COUNT(DISTINCT p.����ȣ) > 1
order by VVIP_���ż� desc;

select pd.�ߺз��ڵ�, pd.�ߺз���
from prodcl pd
where pd.�ߺз��ڵ�='0601' and pd.���޻�='A';

select p.�ߺз��ڵ�
from purprod1 p
where p.�ߺз��ڵ�='0601' and p.���޻�='A';


SELECT p.�ߺз��ڵ�, pd.�ߺз���, COUNT(DISTINCT p.����ȣ) AS VVIP_���ż�
FROM purprod1 p, cusgrade15 c, prodcl pd
WHERE p.����ȣ = c.����ȣ AND p.�ߺз��ڵ� = pd.�ߺз��ڵ� AND c.��� = 'VVIP' AND p.���޻�='D'
GROUP BY p.�ߺз��ڵ�, pd.�ߺз���
HAVING COUNT(DISTINCT p.����ȣ) > =1
order by VVIP_���ż� desc;

SELECT pd.�ߺз��ڵ�, pd.�ߺз���, COUNT(DISTINCT p.����ȣ) AS VVIP_���ż�, p.���޻�
FROM purprod1 p, cusgrade14 c, prodcl pd
WHERE p.����ȣ = c.����ȣ AND p.���޻� = pd.���޻� AND c.��� = 'VVIP' AND p.���޻�='B'
GROUP BY pd.�ߺз��ڵ�, pd.�ߺз���, p.���޻�
HAVING COUNT(DISTINCT p.����ȣ) > =1
order by VVIP_���ż� desc;

-- ���� �� �� ���űݾ� ����
select d.����, sum(p.���űݾ�) ���űݾ�, ROUND(SUM(p.���űݾ�) / (SELECT SUM(���űݾ�) FROM purprod1 WHERE year = '2014') * 100, 2) AS ����
from demo d, purprod1 p
where d.����ȣ=p.����ȣ and year='2014'
group by ����
order by ���űݾ� desc;

SELECT * FROM ddpp;

-- ���ɴ� �� �� ���űݾ� ����
select d. ���ɴ�, sum(p.���űݾ�) ���űݾ�, ROUND(SUM(p.���űݾ�) / (SELECT SUM(���űݾ�) FROM purprod1 WHERE year = '2014') * 100, 2) AS ����
from demo d, purprod1 p
where d.����ȣ=p.����ȣ and year='2014'
group by ���ɴ�
order by ���űݾ� desc;

SELECT c.����ȣ, COALESCE(SUM(d.���űݾ�), 0) AS ���űݾ�
FROM (SELECT DISTINCT ����ȣ FROM ddpp) c
LEFT JOIN ddpp d ON c.����ȣ = d.����ȣ AND d.���з��ڵ� = '1' AND d.qyear = '2014Q'
GROUP BY c.����ȣ
ORDER BY c.����ȣ;



-- �� ��� �׷�ȭ
create table cusgrade15 as
SELECT p.����ȣ,d.����, d.���ɴ�, d.��������, SUM(p.���űݾ�) AS �Ѿ�,
  CASE
    WHEN SUM(p.���űݾ�) >= 200000000 THEN 'VVIP'
    WHEN SUM(p.���űݾ�) >= 80000000 THEN 'VIP'
    WHEN SUM(p.���űݾ�) >= 30000000 THEN 'A'
    WHEN SUM(p.���űݾ�) >= 10000000 THEN 'B'
    WHEN SUM(p.���űݾ�) >= 3000000 THEN 'C'
    ELSE 'N'
  END AS ���
FROM purprod1 p, demo d
WHERE p.����ȣ = d.����ȣ AND p.year = 2015
GROUP BY p.����ȣ,d.����,  d.���ɴ�, d.��������
ORDER BY �Ѿ� DESC;


-- ��޺� �ο� �Ѿ� ����
SELECT ���, COUNT(*) AS �ο���, SUM(�Ѿ�) AS �Ѿ�, ROUND(SUM(�Ѿ�) / (SELECT SUM(�Ѿ�) FROM cusgrade14) * 100, 2) AS ����
FROM cusgrade14
GROUP BY ���
ORDER BY CASE ���
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END;

-- ��޺� ���� �Ѿ� ����
select * from cusgrade15;
SELECT ���,
       COUNT(*) AS �ο���,
       ����,
       ROUND(COUNT(*) / (SELECT COUNT(*) FROM cusgrade15 WHERE ��� = g.���) * 100, 2) AS �ۼ�Ʈ,
       SUM(�Ѿ�) AS �Ѿ�
FROM cusgrade15 g
GROUP BY ���, ����
ORDER BY CASE ���
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END;

-- ��޺� ���ɴ� 
SELECT ���, ���ɴ�, COUNT(*) AS �ο���, ROUND(COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY ���) * 100, 2) AS �ۼ�Ʈ,SUM(�Ѿ�) AS �Ѿ�
FROM cusgrade15
GROUP BY ���, ���ɴ�
ORDER BY CASE ���
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END, ���ɴ�;


select * from cusgrade14;


select ���Žð�, count(*) ���ŰǼ�, sum(���űݾ�) ���űݾ�
from purprod1 
where ���޻�='A' AND year='2015'
group by ���Žð�
order by ���űݾ� desc;

-- �����ڵ庰 ���ޤ̻�
 SELECT �����ڵ�, COUNT(*) AS ����, ���޻�
FROM YEAR_PUR_DEMO
WHERE ���޻�='A'
GROUP BY �����ڵ�, ���޻�
ORDER BY �����ڵ�;

-- 14 15 ��ü ��� �� ������, ��޺�ȭ
CREATE TABLE CUSGRADE AS
SELECT
  COALESCE(c14.����ȣ, c15.����ȣ) AS ����ȣ,
  COALESCE(c14.����, c15.����) AS ����,
  COALESCE(c14.���ɴ�, c15.���ɴ�) AS ���ɴ�,
  COALESCE(c14.��������, c15.��������) AS ��������,
  COALESCE(c14.�Ѿ�, 0) AS �Ѿ�_14,
  c15.�Ѿ� AS �Ѿ�_15,   
  c15.�Ѿ� - COALESCE(c14.�Ѿ�, 0) AS �Ѿ�_������,
  c14.��� AS ���_14,
  c15.��� AS ���_15,
  CASE
    WHEN c14.��� IS NULL THEN '�ű԰�'
    WHEN c15.��� > c14.��� THEN '��� ���'
    WHEN c15.��� < c14.��� THEN '��� �϶�'
    ELSE '��� ��ȭ ����'
  END AS ���_��ȭ
FROM
  cusgrade15 c15
LEFT JOIN
  cusgrade14 c14
ON c14.����ȣ = c15.����ȣ;


ALTER TABLE CUSGRADE ADD ��ü_�Ѿ� NUMBER;
UPDATE CUSGRADE SET ��ü_�Ѿ� = �Ѿ�_14 + �Ѿ�_15;

select * from CUSGRADE
order by ��ü_�Ѿ� desc;



SELECT
  ���_14,
  ���_15,
  COUNT(*) AS ��޺�ȭ_����
FROM
  CUSGRADE
WHERE
  ���_14 IS NOT NULL
  AND ���_15 IS NOT NULL
GROUP BY
  ���_14,
  ���_15
ORDER BY CASE ���_14
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
  END,
  CASE ���_15
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
  END;
------------------------------ channel ���޻� ��
SELECT *
FROM channel
WHERE ���޻� IN (
    SELECT ���޻�
    FROM channel
    GROUP BY ���޻�
    HAVING COUNT(*) >= 2
)
order by ����ȣ;


select ���޻�, count(*)
from channel
group by ���޻�
order by ���޻�;



select
case when ���޻� like 'A%' then 'A'
when ���޻� like 'B%' then 'B'
when ���޻� like 'C%' then 'C'
else 'D' end ����, sum(�̿�Ƚ��) �̿�Ƚ��
from channel
group by case when ���޻� like 'A%' then 'A'
when ���޻� like 'B%' then 'B'
when ���޻� like 'C%' then 'C'
else 'D' end
order by ����;


select c.����ȣ, c.�̿�Ƚ��
from channel c, purprod1 p
where c.����ȣ= p.����ȣ;

-- ���� ������ ��ȣ �ٸ� ���޻翡 �� �ִ���
SELECT ��������ȣ
FROM purprod1
GROUP BY ��������ȣ
HAVING COUNT(DISTINCT ���޻�) > 1;


SELECT p.����ȣ, COUNT(p.��������ȣ) �̿�Ƚ��
from purprod1 p
GROUP BY p.����ȣ
ORDER BY �̿�Ƚ�� desc;

SELECT c.����ȣ, SUM(c.�̿�Ƚ��) �̿�Ƚ��
FROM channel c
GROUP BY c.����ȣ
order by c.����ȣ;


-- �� ��ȣ �� ��ü �̿�Ƚ�� ä�� �̿�Ƚ��
create table abcd as
SELECT p.����ȣ,c.�̿�Ƚ�� AS ä��_�̿�Ƚ��, p.�̿�Ƚ�� AS purprod1_�̿�Ƚ��
FROM (
  SELECT ����ȣ, COUNT(��������ȣ) AS �̿�Ƚ��
  FROM purprod1
  GROUP BY ����ȣ
) p
LEFT JOIN (
  SELECT ����ȣ, SUM(�̿�Ƚ��) AS �̿�Ƚ��
  FROM channel
  GROUP BY ����ȣ
) c ON c.����ȣ = p.����ȣ
ORDER BY p.����ȣ;

select * from abcd
where ä��_�̿�Ƚ�� is not null;
------------------------------------------------
--��ȭ�� ������ ���� ���� - �������ͷ� ������ ���� ����

SELECT �����ڵ�, SUM(���űݾ�) 
FROM year_pur_demo
where ���޻�='A'
GROUP BY �����ڵ�
ORDER BY SUM(���űݾ�) DESC;


SELECT �����ڵ�, ��������, SUM(���űݾ�) 
FROM year_pur_demo  
WHERE ���޻� = 'A'
GROUP BY �����ڵ�, ��������
ORDER BY SUM(���űݾ�) DESC;



-----------
CREATE TABLE QUA_AMT AS
SELECT "����ȣ",    
    COALESCE(SUM(CASE WHEN "��������" >= 20140101 and "��������" < 20140401 THEN "���űݾ�" END), 0) as "14�⵵1�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20140401 and "��������" < 20140701 THEN "���űݾ�" END), 0) as "14�⵵2�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20140701 and "��������" < 20141001 THEN "���űݾ�" END), 0) AS "14�⵵3�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20141001 and "��������" < 20150101 THEN "���űݾ�" END), 0) AS "14�⵵4�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20150101 and "��������" < 20150401 THEN "���űݾ�" END), 0) AS "15�⵵1�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20150401 and "��������" < 20150701 THEN "���űݾ�" END), 0) AS "15�⵵2�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20150701 and "��������" < 20151001 THEN "���űݾ�" END), 0) AS "15�⵵3�б�",
    COALESCE(SUM(CASE WHEN "��������" >= 20151001 and "��������" < 20160101 THEN "���űݾ�" END), 0) AS "15�⵵4�б�",
    
    COALESCE(SUM(CASE WHEN "��������" >= 20140101 and "��������" < 20140401 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20140401 and "��������" < 20140701 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20140701 and "��������" < 20141001 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20141001 and "��������" < 20150101 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20150101 and "��������" < 20150401 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20150401 and "��������" < 20150701 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20150701 and "��������" < 20151001 THEN "���űݾ�" END), 0) +
    COALESCE(SUM(CASE WHEN "��������" >= 20151001 and "��������" < 20160101 THEN "���űݾ�" END), 0) AS "14,15���ѱ��űݾ�"
FROM PURPROD1
GROUP BY "����ȣ"
order by"14,15���ѱ��űݾ�" desc;
-------------------------------- �б� �ݱ� ��ȭ ��� ��
    
drop table incdecall;
---------    

CREATE TABLE incdecall AS
select "����ȣ",
"14�⵵1�б�",
"14�⵵2�б�",
"14�⵵3�б�",
"14�⵵4�б�",
"15�⵵1�б�",
"15�⵵2�б�",
"15�⵵3�б�",
"15�⵵4�б�",
"14,15���ѱ��űݾ�",
("14�⵵2�б�"-"14�⵵1�б�") as "14�⵵1,2�б⺯ȭ",
("14�⵵3�б�"-"14�⵵2�б�") as "14�⵵2,3�б⺯ȭ",
("14�⵵4�б�"-"14�⵵3�б�") as "14�⵵3,4�б⺯ȭ",
("15�⵵2�б�"-"15�⵵1�б�") as "15�⵵1,2�б⺯ȭ",
("15�⵵3�б�"-"15�⵵2�б�") as "15�⵵2,3�б⺯ȭ",
("15�⵵4�б�"-"15�⵵3�б�") as "15�⵵3,4�б⺯ȭ",
("14�⵵2�б�"+"14�⵵1�б�") as "14���ݱ�",
("14�⵵4�б�"+"14�⵵3�б�") as  "14���Ϲݱ�",
("15�⵵2�б�"+"15�⵵1�б�") as "15���ݱ�",
("15�⵵4�б�"+"15�⵵3�б�") as  "15���Ϲݱ�",
(("15�⵵4�б�"+"15�⵵3�б�")-("15�⵵2�б�"+"15�⵵1�б�"))as "15����Ϲݱ�����",
(("14�⵵4�б�"+"14�⵵3�б�")-("14�⵵2�б�"+"14�⵵1�б�"))as "14����Ϲݱ�����",
("14�⵵2�б�"+"14�⵵1�б�"+"14�⵵4�б�"+"14�⵵3�б�") as "14�⵵�ѱ��űݾ�",
("15�⵵2�б�"+"15�⵵1�б�"+"15�⵵4�б�"+"15�⵵3�б�") as "15�⵵�ѱ��űݾ�",
("14�⵵2�б�"+"14�⵵1�б�"+"14�⵵4�б�"+"14�⵵3�б�"+"15�⵵2�б�"+"15�⵵1�б�"+"15�⵵4�б�"+"15�⵵3�б�") as "1415�⵵�ѱ��űݾ�",
    CASE WHEN "14�⵵1�б�" = 0 AND "14�⵵2�б�" = 0 AND "14�⵵3�б�" = 0 AND "14�⵵4�б�" = 0
         THEN '�ű԰�'
         WHEN "15�⵵1�б�" = 0 AND "15�⵵2�б�" = 0 AND "15�⵵3�б�" = 0 AND "15�⵵4�б�" = 0
         THEN '��Ż��'
         ELSE '������'
    END AS "������"
FROM
    QUA_AMT;


----������ ������ �Ѿ�
CREATE TABLE incdecyear AS
SELECT �׷�, sum("14�⵵�ѱ��űݾ�") AS "14�⵵�ѱ��űݾ�", sum("15�⵵�ѱ��űݾ�") AS "15�⵵�ѱ��űݾ�", sum(����������) AS ����������
FROM ab
GROUP BY �׷�;

select * from abcd
where ä��_�̿�Ƚ�� is not null;

create table aaaa as 
select ����ȣ,"14���ݱ�","14���Ϲݱ�","15���ݱ�","15���Ϲݱ�" 
from incdecall;

ALTER TABLE AAAA
CHANGE '14�⵵1�б�' Q1 MONEY;

SELECT SUM(���űݾ�) FROM PURPROD1; 

ALTER TABLE AAAA
DROP column "15�⵵3,4�б⺯ȭ";


ALTER TABLE QUA_AMT
ADD "��׷�"  VARCHAR(30);


   CASE 
        WHEN "15�⵵4�б�" - "14�⵵1�б�" > 0 THEN '������'
        WHEN "15�⵵4�б�" - "14�⵵1�б�" < 0 THEN '���Ұ�'
        ELSE '��Ÿ'



ALTER TABLE aaaa
ADD "W"  VARCHAR(20);

UPDATE QUA_AMT
SET "��׷�"  =  
    CASE 
        WHEN "8�б�-1�б�" > 0 THEN '������'
        WHEN "8�б�-1�б�" < 0 THEN '���Ұ�'
        ELSE '��Ÿ'
    END;

select SUM("14,15���ѱ��űݾ�") fROM INCDECALL;

UPDATE aaaa
SET "��������" = "14�⵵1,2�б⺯ȭ"+"14�⵵2,3�б⺯ȭ"+"14�⵵3,4�б⺯ȭ"+"15�⵵1,14�⵵4�б⺯ȭ"+"15�⵵1,2�б⺯ȭ"+"15�⵵2,3�б⺯ȭ"+"15�⵵3,4�б⺯ȭ"; 

SELECT * FROM AAAA;
select * 
from DEMO D, PURPROD1 P
WHERE D.����ȣ=P.����ȣ;

ALTER TABLE HGROUP
MODIFY (��׷� VARCHAR2(30));

UPDATE AFQY
SET �Ѿ� = �Ѿ�2;


SELECT *
FROM QUA_AMT;


SELECT *
FROM AAAA
WHERE "15�⵵4�б�" - "14�⵵1�б�" < 0 AND �������� > 0 AND ���� = '���Ұ�';

SELECT * 
FROM AAAA
WHERE "15�⵵3,4�б⺯ȭ" <0;   

SELECT SUM("15�⵵4�б�") 
from AAAA;

SELECT SUM("14�⵵1�б�"+"14�⵵2�б�"+"14�⵵3�б�"+"14�⵵4�б�"),SUM("15�⵵1�б�"+"15�⵵2�б�"+"15�⵵3�б�"+"15�⵵4�б�")
FROM QUA_AMT;



SELECT round(SUM("14�⵵1�б�"),0), round(SUM("14�⵵2�б�"),0), ROUND(SUM("14�⵵3�б�"),0), ROUND(SUM("14�⵵4�б�"),0), ROUND(SUM("15�⵵1�б�"),0), ROUND(SUM("15�⵵2�б�"),0), ROUND(SUM("15�⵵3�б�"),0), ROUND(SUM("15�⵵4�б�"),0)
FROM QUA_AMT;

CREATE TABLE AFQY AS
SELECT ���޻� , QYEAR, SUM("���űݾ�") AS "�Ѿ�"  
FROM PURPROD1
GROUP BY ���޻�, QYEAR
ORDER BY ���޻�;

ALTER TABLE AFQY
ADD "�Ѿ�2"  NUMBER;

SELECT SUM(���űݾ�) FROM PURPROD1;

SELECT * FROM QUA_AMT;

SELECT * FROM AB;

UPDATE AFQY
SET �Ѿ� = 
    CASE 
        WHEN QYEAR='20141Q' THEN �Ѿ�2+(0.25-0.2395046536506363210123868665354927691146)*(677019156941/4)
        WHEN QYEAR='20151Q' THEN �Ѿ�2+(0.25-0.2395046536506363210123868665354927691146)*(677019156941/4)
        WHEN QYEAR='20142Q' THEN �Ѿ�2+(0.25-0.2442776395489978442860973176463302673445)*(677019156941/4)
        WHEN QYEAR='20152Q' THEN �Ѿ�2+(0.25-0.2442776395489978442860973176463302673445)*(677019156941/4)
        WHEN QYEAR='20143Q' THEN �Ѿ�2+(0.25-0.2281859591019859008022385519400185518893)*(677019156941/4)
        WHEN QYEAR='20153Q' THEN �Ѿ�2+(0.25-0.2281859591019859008022385519400185518893)*(677019156941/4)
        WHEN QYEAR='20144Q' THEN �Ѿ�2+(0.25-0.2880317476983799338992772638781584116516)*(677019156941/4)
        WHEN QYEAR='20154Q' THEN �Ѿ�2+(0.25-0.2880317476983799338992772638781584116516)*(677019156941/4)
    END;

select *
FROM AFQY; 

UPDATE AAAA
SET ���� = 
    CASE 
        WHEN "15�⵵4�б�" - "14�⵵1�б�" > 0 THEN '������'
        WHEN "15�⵵4�б�" - "14�⵵1�б�" < 0 THEN '���Ұ�'
        ELSE '��Ÿ'
    END;


---------------------- ��׷� 
UPDATE HGROUP
SET "��׷�" = 
 CASE
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" <> 0 then '�ű԰�'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" <> 0 then '�ű԰�'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" <> 0 then '�ű԰�'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" <> 0 then '�����԰�'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" <> 0 then '�����԰�'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" <> 0 then '�����԰�'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" <> 0 then '�����԰�'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" = 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" = 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" <> 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" = 0 then '��Ż��'
    WHEN "14���ݱ�" <> 0 AND "14���Ϲݱ�" = 0 AND "15���ݱ�" <> 0 AND "15���Ϲݱ�" = 0 then '��������Ż��'
    ELSE '������'
 END;

 
 ------------------------------�߱׷� ������
UPDATE aaaa
SET "�߱׷�" = 
 CASE
    WHEN "1����" > 0 THEN
        CASE
            WHEN "2����" > 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '������'
                    WHEN "3����" < 0 THEN '������'
                    ELSE '����0'
                END
            WHEN "2����" < 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '������'
                    WHEN "3����" < 0 THEN '������'
                    ELSE '����0'
                END
            ELSE
                CASE
                    WHEN "3����" > 0 THEN '��0��'
                    WHEN "3����" < 0 THEN '��0��'
                    ELSE '��00'
                END
        END
    WHEN "1����" < 0 THEN
        CASE
            WHEN "2����" > 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '������'
                    WHEN "3����" < 0 THEN '������'
                    ELSE '����0'
                END
            WHEN "2����" < 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '������'
                    WHEN "3����" < 0 THEN '������'
                    ELSE '����0'
                END
            ELSE
                CASE
                    WHEN "3����" > 0 THEN '��0��'
                    WHEN "3����" < 0 THEN '��0��'
                    ELSE '��00'
                END
        END
    ELSE
        CASE
            WHEN "2����" > 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '0����'
                    WHEN "3����" < 0 THEN '0����'
                    ELSE '0��0'
                END
            WHEN "2����" < 0 THEN
                CASE
                    WHEN "3����" > 0 THEN '0����'
                    WHEN "3����" < 0 THEN '0����'
                    ELSE '0��0'
                END
            ELSE
                CASE
                    WHEN "3����" > 0 THEN '00��'  
                    WHEN "3����" < 0 THEN '00��'
                    ELSE '00'
                END
        END
 END;


-----------------
SELECT H.�߱׷�, D.QYEAR, D.��з��ڵ�, SUM(D.���űݾ�) AS �ѱ��ž�
FROM HGROUP H, DEMOPURPROD D
WHERE H.����ȣ = D.����ȣ AND H.�߱׷�='������' AND D.���޻�='A'
GROUP BY H.�߱׷�, D.QYEAR, D.��з��ڵ�
ORDER BY QYEAR, �ѱ��ž� DESC;

--------------------�ߺз��ڵ庰
SELECT H.�߱׷�, D.HYEAR, D.��з��ڵ�, D.�ߺз��ڵ�,P.�ߺз���, SUM(D.���űݾ�) AS �ѱ��ž�
FROM HGROUP H, DEMOPURPROD D, PRODCL P
WHERE H.����ȣ = D.����ȣ AND D.�ߺз��ڵ�=P.�ߺз��ڵ� AND H.�߱׷�='������' AND P.���޻�='A'
GROUP BY H.�߱׷�, D.HYEAR, D.��з��ڵ�, D.�ߺз��ڵ�, P.�ߺз���
ORDER BY HYEAR,��з��ڵ�, �ѱ��ž� DESC;

--------------------------------------
SELECT H.��׷�, D.QYEAR, D.��з��ڵ�, SUM(D.���űݾ�) AS �ѱ��ž�
FROM HGROUP H, DEMOPURPROD D
WHERE H.����ȣ = D.����ȣ AND H.��׷�='������' AND D.���޻�='A'
GROUP BY H.��׷�, D.QYEAR, D.��з��ڵ�
ORDER BY QYEAR, �ѱ��ž� DESC;


SELECT QYEAR AS, SUM(���űݾ�) 
FROM DEMOPURPROD
GROUP BY QYEAR
ORDER BY QYEAR;   

SELECT * FROM PURPROD1;

CREATE TABLE AABBCC AS
SELECT ����ȣ, COUNT(DISTINCT(��������ȣ)) AS �Ǽ�  
FROM PURPROD1
WHERE QYEAR='20154Q'
GROUP BY ����ȣ;  

SELECT * FROM DEMOPURPROD;

SELECT COUNT(DISTINCT(����ȣ))
FROM DEMOPURPROD;
    
--AAAAAAAAAAAAAAAAAAA
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
CREATE TABLE AAAA AS
SELECT ����ȣ, ����, ���ɴ�, ��������, SUM(���űݾ�) AS ���űݾ�, COUNT(DISTINCT(��������ȣ)) AS �ŷ��Ǽ�
FROM demopurpROD
GROUP BY ����ȣ, ����, ���ɴ�, ��������
ORDER BY ����ȣ;

SELECT * FROM AAAA;

----------���� ���̻� ǰ��

SELECT ����ȣ, �Һз��ڵ�, �ŷ��Ǽ�
FROM (
  SELECT ����ȣ, �Һз��ڵ�, �ŷ��Ǽ�,
         ROW_NUMBER() OVER(PARTITION BY ����ȣ ORDER BY �ŷ��Ǽ� DESC) AS rn
  FROM (
    SELECT ����ȣ, �Һз��ڵ�, COUNT(�Һз��ڵ�) AS �ŷ��Ǽ�
    FROM DEMOPURPROD
    GROUP BY ����ȣ, �Һз��ڵ�
  )
) t
WHERE rn = 1
ORDER BY ����ȣ;


SELECT * FROM DEMOPURPROD;

ALTER TABLE DEMOPURPROD
DROP COLUMN "���з�";

ALTER TABLE DEMOPURPROD
RENAME COLUMN "���з�" TO "���з��ڵ�";

SELECT * FROM DEMOPURPROD;


------------���� ��� �Һз��ڵ� 
SELECT ����ȣ, �Һз��ڵ�, ���űݾ�
FROM (
  SELECT ����ȣ, �Һз��ڵ�, ���űݾ�,
         ROW_NUMBER() OVER(PARTITION BY ����ȣ ORDER BY ���űݾ� DESC) AS rn
  FROM (
    SELECT ����ȣ, �Һз��ڵ�, MAX(���űݾ�) AS ���űݾ�
    FROM DEMOPURPROD
    GROUP BY ����ȣ, �Һз��ڵ�
  )
) t
WHERE rn = 1;

------------���� �� �Һз��ڵ� 
SELECT ����ȣ, �Һз��ڵ�, ���űݾ�
FROM (
  SELECT ����ȣ, �Һз��ڵ�, ���űݾ�,
         ROW_NUMBER() OVER(PARTITION BY ����ȣ ORDER BY ���űݾ�) AS rn
  FROM (
    SELECT ����ȣ, �Һз��ڵ�, MAX(���űݾ�) AS ���űݾ�
    FROM DEMOPURPROD
    GROUP BY ����ȣ, �Һз��ڵ�
  )
) t
WHERE rn = 1;


SELECT c.����ȣ, COALESCE(SUM(d.���űݾ�), 0) AS ���űݾ�
FROM (SELECT DISTINCT ����ȣ FROM ddpp) c
LEFT JOIN ddpp d ON c.����ȣ = d.����ȣ AND d.���з��ڵ� = '7' AND d.qyear = '20152Q'
GROUP BY c.����ȣ
ORDER BY c.����ȣ;


SELECT c.����ȣ,COALESCE(SUM(CASE WHEN d.���з��ڵ� = '1' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�1_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '2' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�2_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '3' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�3_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '4' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�4_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '5' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�5_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '6' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�6_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '7' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�7_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '8' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�8_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '9' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�9_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '10' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�10_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '11' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�11_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '12' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�12_���űݾ�,
COALESCE(SUM(CASE WHEN d.���з��ڵ� = '13' THEN d.���űݾ� ELSE 0 END), 0) AS ���з��ڵ�13_���űݾ�
FROM (SELECT DISTINCT ����ȣ FROM ddpp) c
LEFT JOIN ddpp d ON c.����ȣ = d.����ȣ AND d.qyear IN ('20141Q', '20142Q', '20143Q', '20144Q', '20151Q', '20152Q', '20153Q', '20154Q')
GROUP BY c.����ȣ
ORDER BY c.����ȣ;





SELECT *
FROM DEMOPURPROD;

DROP TABLE AABBCC;
SELECT * FROM AABBCC;

SELECT SUM(���űݾ�) FROM DEMOPURPROD
WHERE QYEAR='20141Q' AND ���޻�='B';

SELECT SUM(ä��_�̿�Ƚ��) FROM ABCD;

3451785
119736


select * FROM ABCD;
 
---------������ ���� �Ѿ�------
SELECT
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) AS "1Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "1Q",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) AS "2Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "2Q",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) AS "3Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "3Q",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) AS "4Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "4Q",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N4Q_total_amount",
    SUM(���űݾ�) AS total_amount
FROM DEMOPURPROD;

----------------------------
SELECT sum(���űݾ�)
FROM DEMOPURPROD
where qyear='20154Q';


ALTER DEMOPURPROD
drop column "���űݾ�2";
SELECT * FROM DEMOPURPROD;

UPDATE DEMOPURPROD
SET "���űݾ�" = (SELECT "���űݾ�" FROM PURPROD1);


UPDATE DEMOPURPROD
SET "���űݾ�" = 
  CASE 
    WHEN QYEAR LIKE '%1Q' THEN "���űݾ�" * 1.01049534634936367898761313346450723089
    WHEN QYEAR LIKE '%2Q' THEN "���űݾ�" * 1.00572236045100215571390268235366973266
    WHEN QYEAR LIKE '%3Q' THEN "���űݾ�" * 1.02181404089801409919776144805998144811
    WHEN QYEAR LIKE '%4Q' THEN "���űݾ�" * 0.9619682523016200661007227361218415883484
    ELSE "���űݾ�"  
  END;

SELECT sum(���űݾ�) FROM demoPURPROD;

SELECT * FROM HGROUP;

SELECT * FROM INCDECALL;

---------������ ���� �Ѿ�------
   SELECT
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) AS "1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�) AS "1Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) AS "2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�) AS "2Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) AS "3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END)   / SUM(���űݾ�) AS "3Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) AS "4Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�) AS "4Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN ���űݾ� ELSE 0 END) / SUM(���űݾ�))) AS "N4Q_total_amount",
    SUM(���űݾ�) AS total_amount
FROM DEMOPURPROD;


+(0.25-0.2395046536506363210123868665354927691146)*("14��,15���ѱ��űݾ�"/4)
+(0.25-0.2442776395489978442860973176463302673445)*("14��,15���ѱ��űݾ�"/4)
+(0.25-0.2281859591019859008022385519400185518893)*("14��,15���ѱ��űݾ�"/4)
+(0.25-0.2880317476983799338992772638781584116516)*("14��,15���ѱ��űݾ�"/4)

SELECT SUM(���űݾ�) FROM PURPROD1;

SELECT "��������", sum("14,15���ѱ��űݾ�")
FROM DEMO
JOIN QUA_AMT ON QUA_AMT."����ȣ"=DEMO."����ȣ"
group by "��������"
ORDER BY "��������";


select*
FROM DEMO
JOIN QUA_AMT ON QUA_AMT."����ȣ"=DEMO."����ȣ";
select*
from HGROUP;

SELECT * FROM QUA_AMT;


select * 
from qua_amt
where "qua_amt IS NULL