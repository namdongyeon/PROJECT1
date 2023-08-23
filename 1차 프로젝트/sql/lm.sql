select * from channel;
select * from compet;
select * from demo;
select * from membership;
select * from prodcl;
select * from purprod;

--demographic data
select count(*) from demo
order by 고객번호;

--제휴사별 경쟁사 이용현황
select * from compet;

-- 멤버십
select * from membership;

-- 상품분류
select * from prodcl;

-- 구매데이터
select count(*) from purprod;
select * from purprod;

-- 구매합계
select sum(구매금액)
from purprod;

--purprod 복사
create table purprod1 as 
select * from purprod;

-- 연도별 구매합계
alter table purprod1 add year varchar2(20);

update purprod1 set year=substr(구매일자,1,4);

commit;

select year, sum(구매금액) 구매액
from purprod1
group by year;

--고객별 구매합계
select 고객번호, sum(구매금액) 구매액
from purprod1
group by 고객번호
order by 구매액 desc;

--고객별 제휴사별 기준 합계
select 고객번호, 제휴사, sum(구매금액) 구매액
from purprod1
group by 고객번호, 제휴사
order by 고객번호;

--고객별 제휴사별 상품대분류 기준 합계
select 고객번호, 제휴사, 대분류코드, sum(구매금액) 구매액
from purprod1
group by 고객번호, 제휴사, 대분류코드
order by 고객번호;

CREATE TABLE AMT14
AS SELECT 고객번호, 제휴사, SUM(구매금액) 구매금액 
FROM PURPROD
WHERE 구매일자 < 20150101
GROUP BY 고객번호, 제휴사
ORDER BY 고객번호;

select * from amt14;
select * from amt15;
CREATE TABLE AMT15
AS SELECT 고객번호, 제휴사, SUM(구매금액) 구매금액 
FROM PURPROD
WHERE 구매일자 > 20141231
GROUP BY 고객번호, 제휴사
ORDER BY 고객번호;

--FULL OUTER JOIN 테이블 생성
CREATE TABLE AMT_YEAR_FOJ
AS SELECT A4.고객번호, A4.제휴사, A4.구매금액 구매14, A5.구매금액 구매15
FROM AMT14 A4 FULL OUTER JOIN AMT15 A5
ON (A4.고객번호=A5.고객번호 AND A4.제휴사=A5.제휴사);
select * from AMT_YEAR_FOJ;

--FULL OUTER JOIN 적용시 증감 출력
SELECT 고객번호,제휴사, NVL(구매14,0) 구매14, NVL(구매15,0) 구매15,
(NVL(구매15,0)-NVL(구매14,0)) 증감
FROM AMT_YEAR_FOJ A;

--반기별 구매금액
ALTER TABLE PURPROD1 ADD MONTH VARCHAR2(20);
UPDATE PURPROD1 SET MONTH=SUBSTR(구매일자,1,6);
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

--과제8_0511. lm 데이터 테이블 6개로 l사의 비즈 현황을 파악할 수 있는 요약 테이블을 5개 이상 생성하고 설명하세요.
select * from membership;

select 연령대,count(멤버십명)
from demo d, membership m
where d.고객번호=m.고객번호
group by 연령대
order by 연령대;

select count(*) from purprod1;

select count(대분류코드), count(중분류코드),count(소분류코드),count(중분류명),count(소분류명) from purprod1
where 소분류 is not null;

select 연령대, count(연령대)
from demo
group by 연령대
order by 연령대;



select 성별, count(고객번호)
from demo
group by 성별; 


SELECT 성별, COALESCE(COUNT(d.고객번호), 0) AS 고객수, COALESCE(COUNT(m.고객번호), 0) AS 멤버십수
FROM demo d
LEFT JOIN membership m ON d.고객번호 = m.고객번호
WHERE 성별 IN ('M', 'F') 
GROUP BY 성별
ORDER BY 성별;


select 제휴사, count(제휴사)
from purprod1
group by 제휴사
order by 제휴사; 


select * from prodcl
where 제휴사 ='D';

select count(*) 
from compet c, prodcl p
where p.제휴사= c.제휴사;



SELECT COUNT(*)
FROM (
    SELECT demo.고객번호
    FROM demo
    MINUS
    SELECT membership.고객번호
    FROM membership
) result;


select 연령대, count(eo)
from demo
group by 연령대
order by 연령대;





--테이블 결합 : DEMO + PURPROD
SELECT d.고객번호, SUM(p.HYEAR='201406'), sum(p.HYEAR='201412') 
FROM DEMO d, PURPROD1 p
WHERE d.고객번호 = p.고객번호
GROUP BY d.고객번호;

SELECT d.고객번호,
       SUM(CASE WHEN p.HYEAR = '201406' THEN 1 ELSE 0 END) AS "201406 총 구매 횟수",
       SUM(CASE WHEN p.HYEAR = '201412' THEN 1 ELSE 0 END) AS "201412 총 구매 횟수"
FROM DEMO d
JOIN PURPROD1 p ON d.고객번호 = p.고객번호
GROUP BY d.고객번호;





--고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성
SELECT * FROM PURPROD1;

CREATE TABLE CUSPUR
AS SELECT 고객번호, 
SUM(CASE WHEN HYEAR='20141H' THEN 구매금액 ELSE 0 END) AS H1,
SUM(CASE WHEN HYEAR='20142H' THEN 구매금액 ELSE 0 END) AS H2,
SUM(CASE WHEN HYEAR='20151H' THEN 구매금액 ELSE 0 END) AS H3,
SUM(CASE WHEN HYEAR='20152H' THEN 구매금액 ELSE 0 END) AS H4
FROM PURPROD1
GROUP BY 고객번호
ORDER BY 고객번호;

drop table cuspur2;

CREATE TABLE CUSPUR2
AS SELECT 고객번호, 
SUM(CASE WHEN QYEAR='20141Q' THEN 구매금액 ELSE 0 END) AS Q1,
SUM(CASE WHEN QYEAR='20142Q' THEN 구매금액 ELSE 0 END) AS Q2,
SUM(CASE WHEN QYEAR='20143Q' THEN 구매금액 ELSE 0 END) AS Q3,
SUM(CASE WHEN QYEAR='20144Q' THEN 구매금액 ELSE 0 END) AS Q4,
SUM(CASE WHEN QYEAR='20151Q' THEN 구매금액 ELSE 0 END) AS Q5,
SUM(CASE WHEN QYEAR='20152Q' THEN 구매금액 ELSE 0 END) AS Q6,
SUM(CASE WHEN QYEAR='20153Q' THEN 구매금액 ELSE 0 END) AS Q7,
SUM(CASE WHEN QYEAR='20154Q' THEN 구매금액 ELSE 0 END) AS Q8
FROM PURPROD1
GROUP BY 고객번호
ORDER BY 고객번호;

SELECT * FROM CUSPUR2;

--DEMO와 CUSPUR 고객번호 기준 결합 : CUSDP
DESC DEMO;
DROP TABLE CUSDP;

CREATE TABLE CUSDP
AS SELECT CP.*, D.성별, D.연령대, D.거주지역
FROM CUSPUR CP, DEMO D 
WHERE D.고객번호 = CP.고객번호;

CREATE TABLE CUSDP2
AS SELECT CP.*, D.성별, D.연령대, D.거주지역
FROM CUSPUR2 CP, DEMO D 
WHERE D.고객번호 = CP.고객번호;

SELECT * FROM CUSDP;

CREATE TABLE CUSDEPU
AS SELECT * 
FROM CUSDP
ORDER BY 고객번호;

CREATE TABLE CUSDEPU2
AS SELECT * 
FROM CUSDP2
ORDER BY 고객번호;

SELECT * FROM compet;

SELECT * FROM CUSDEPU2;


-- 과제1_0512. LM 사업 현안을 파악할 수 있는 전체, 고객, 상품별 테이블을 3개 이상 작성하세요.
CREATE TABLE GENDER_M
as SELECT 성별, COALESCE(COUNT(d.고객번호), 0) AS 고객수, COALESCE(COUNT(m.고객번호), 0) AS 멤버십수
FROM demo d
LEFT JOIN membership m ON d.고객번호 = m.고객번호
WHERE 성별 IN ('M', 'F') 
GROUP BY 성별
ORDER BY 성별;

drop table GENDER_M;
select * from GENDER_M;
select * from pro_Age;

drop Table PRO_AGE;



--상품별 어떤 연령대가 많이 샀나
CREATE TABLE PRO_AGE
as;
SELECT p.중분류명, d.연령대, COUNT(*) AS 구매건수
FROM prodcl p, compet c, demo d
WHERE p.제휴사 = c.제휴사 
  AND c.고객번호 = d.고객번호
GROUP BY p.중분류명, d.연령대
ORDER BY  중분류명;

select YEAR from purprod1;

sel

-- 2014년 구매건수 연령대별
SELECT p.중분류코드, d.연령대, COUNT(*) AS 구매건수, sum(p.구매금액)
FROM purprod1 p, compet c, demo d
WHERE p.고객번호 = d.고객번호 
  AND p.YEAR=2014
GROUP BY p.중분류코드, d.연령대
ORDER BY  중분류코드;

drop table AF_PR;

select * from purprod1;

-- 제휴사 별 고객번호 금액

create table AF_PR as 
SELECT p.고객번호, p.제휴사, p.YEAR, SUM(p.구매금액) as 총구매금액
FROM purprod1 p, demo d
WHERE p.고객번호 = d.고객번호
GROUP BY p.고객번호, p.제휴사, p.YEAR
ORDER BY p.고객번호;


-- 2015년 구매건수 연령대별
SELECT p.중분류코드, d.연령대, COUNT(*) AS 구매건수
FROM purprod1 p, compet c, demo d
WHERE p.제휴사 = c.제휴사 
  AND c.고객번호 = d.고객번호
  AND p.YEAR=2015
GROUP BY p.중분류코드, d.연령대
ORDER BY  중분류코드;

CREATE TABLE PRO_AGE
AS;

SELECT p.중분류명, d.연령대, SUM(pd.구매금액) AS 총구매액
FROM purprod1 pd, prodcl p, compet c, demo d
WHERE p.제휴사 = c.제휴사 
  AND c.고객번호 = d.고객번호
  AND p.제휴사 = pd.제휴사
GROUP BY p.중분류명, d.연령대
ORDER BY 중분류명;

SELECT p.중분류명, d.연령대, SUM(pd.구매금액) AS 총구매액
FROM prodcl p
JOIN compet c ON p.제휴사 = c.제휴사
JOIN demo d ON c.고객번호 = d.고객번호
JOIN (
    SELECT DISTINCT 제휴사, 고객번호, 구매금액
    FROM purprod1
) pd ON p.제휴사 = pd.제휴사 AND c.고객번호 = pd.고객번호
GROUP BY p.중분류명, d.연령대
ORDER BY 중분류명;



SELECT p.중분류명, d.연령대, COUNT(*) AS 구매건수
FROM prodcl p, compet c, demo d
WHERE p.제휴사 = c.제휴사 
  AND c.고객번호 = d.고객번호
GROUP BY p.중분류명, d.연령대
ORDER BY  중분류명;


-- 월별 총액 구하기
SELECT SUBSTR(구매일자, 1, 6) AS 월별, SUM(구매금액) AS 월별_총액
FROM purprod1
WHERE SUBSTR(구매일자, 1, 6) = '201405'
GROUP BY SUBSTR(구매일자, 1, 6);


create table AMTMon_14 as
SELECT SUBSTR(구매일자, 1, 6) AS 월별, SUM(구매금액) AS 월별_총액
FROM purprod1
WHERE SUBSTR(구매일자, 1, 6) BETWEEN '201401' AND '201412'
GROUP BY SUBSTR(구매일자, 1, 6)
ORDER BY 월별;


SELECT SUBSTR(구매일자, 1, 6) AS 월별, SUM(구매금액) AS 월별_총액
FROM purprod1
WHERE SUBSTR(구매일자, 1, 6) BETWEEN '201501' AND '201512'
GROUP BY SUBSTR(구매일자, 1, 6)
order by 월별;

SELECT SUBSTR(구매일자, 1, 6) AS 월별, SUM(구매금액) AS 월별_총액
FROM purprod1
WHERE SUBSTR(구매일자, 1, 6) IN ('201501','201502','201503','201504','201505', '201506', '201507','201508','201509',
'201510','201511','201512') and 제휴사='D'
GROUP BY SUBSTR(구매일자, 1, 6)
order by 월별;

SELECT SUBSTR(구매일자, 1, 6) AS 월별, SUM(구매금액) AS 월별_총액
FROM purprod1
WHERE SUBSTR(구매일자, 1, 6) IN ('201401','201402','201403','201404','201405', '201406', '201407','201408','201409',
'201410','201411','201412','201501','201502','201503','201504','201505', '201506', '201507','201508','201509',
'201510','201511','201512') and 제휴사='A'
GROUP BY SUBSTR(구매일자, 1, 6)
order by 월별;



select 고객번호, sum(구매금액) as 총액


from purprod1
where year=2014
group by 고객번호
order by 총액 desc;

drop table CUSGRADE15;

create table cusgrade15 as
SELECT p.고객번호,d.성별, d.연령대, d.거주지역, SUM(p.구매금액) AS 총액,
  CASE
    WHEN SUM(p.구매금액) >= 200000000 THEN 'VVIP'
    WHEN SUM(p.구매금액) >= 80000000 THEN 'VIP'
    WHEN SUM(p.구매금액) >= 30000000 THEN 'A'
    WHEN SUM(p.구매금액) >= 10000000 THEN 'B'
    WHEN SUM(p.구매금액) >= 3000000 THEN 'C'
    ELSE 'N'
  END AS 등급
FROM purprod1 p, demo d
WHERE p.고객번호 = d.고객번호 AND p.year = 2015
GROUP BY p.고객번호,d.성별,  d.연령대, d.거주지역
ORDER BY 총액 DESC;

select * from cusgrade15;

create table year_purprod as
SELECT 제휴사, 대분류코드, 중분류코드, 소분류코드, 고객번호, 점포코드, sum(구매금액) 구매금액, 구매시간,
    SUM(CASE WHEN 구매일자 LIKE '2014%' THEN 구매금액 ELSE 0 END) "2014구매금액",
    SUM(CASE WHEN 구매일자 LIKE '2015%' THEN 구매금액 ELSE 0 END) "2015구매금액",
    SUM(CASE WHEN 구매일자 LIKE '2015%' THEN 구매금액 END) - SUM(CASE WHEN 구매일자 LIKE '2014%' THEN 구매금액 END) 증감액
FROM purprod1
group by 제휴사, 대분류코드, 중분류코드, 소분류코드, 고객번호, 점포코드, 구매시간;

create table year_pur_demo as
select d.*, 제휴사, 대분류코드, 중분류코드, 소분류코드, 점포코드, 구매금액, "2014구매금액", "2015구매금액", 구매시간
from year_purprod y, demo d
where y.고객번호=d.고객번호;

select * from year_pur_demo;



SELECT p.중분류코드, pd.중분류명, COUNT(DISTINCT p.고객번호) AS VVIP_구매수
FROM purprod1 p, cusgrade14 c, prodcl pd
WHERE p.고객번호 = c.고객번호 AND p.중분류코드 = pd.중분류코드 AND c.등급 = 'VVIP' AND p.제휴사='D'
GROUP BY p.중분류코드, pd.중분류명
HAVING COUNT(DISTINCT p.고객번호) > 1
order by VVIP_구매수 desc;

select pd.중분류코드, pd.중분류명
from prodcl pd
where pd.중분류코드='0601' and pd.제휴사='A';

select p.중분류코드
from purprod1 p
where p.중분류코드='0601' and p.제휴사='A';


SELECT p.중분류코드, pd.중분류명, COUNT(DISTINCT p.고객번호) AS VVIP_구매수
FROM purprod1 p, cusgrade15 c, prodcl pd
WHERE p.고객번호 = c.고객번호 AND p.중분류코드 = pd.중분류코드 AND c.등급 = 'VVIP' AND p.제휴사='D'
GROUP BY p.중분류코드, pd.중분류명
HAVING COUNT(DISTINCT p.고객번호) > =1
order by VVIP_구매수 desc;

SELECT pd.중분류코드, pd.중분류명, COUNT(DISTINCT p.고객번호) AS VVIP_구매수, p.제휴사
FROM purprod1 p, cusgrade14 c, prodcl pd
WHERE p.고객번호 = c.고객번호 AND p.제휴사 = pd.제휴사 AND c.등급 = 'VVIP' AND p.제휴사='B'
GROUP BY pd.중분류코드, pd.중분류명, p.제휴사
HAVING COUNT(DISTINCT p.고객번호) > =1
order by VVIP_구매수 desc;

-- 성별 별 총 구매금액 비율
select d.성별, sum(p.구매금액) 구매금액, ROUND(SUM(p.구매금액) / (SELECT SUM(구매금액) FROM purprod1 WHERE year = '2014') * 100, 2) AS 비율
from demo d, purprod1 p
where d.고객번호=p.고객번호 and year='2014'
group by 성별
order by 구매금액 desc;

SELECT * FROM ddpp;

-- 연령대 별 총 구매금액 비율
select d. 연령대, sum(p.구매금액) 구매금액, ROUND(SUM(p.구매금액) / (SELECT SUM(구매금액) FROM purprod1 WHERE year = '2014') * 100, 2) AS 비율
from demo d, purprod1 p
where d.고객번호=p.고객번호 and year='2014'
group by 연령대
order by 구매금액 desc;

SELECT c.고객번호, COALESCE(SUM(d.구매금액), 0) AS 구매금액
FROM (SELECT DISTINCT 고객번호 FROM ddpp) c
LEFT JOIN ddpp d ON c.고객번호 = d.고객번호 AND d.대대분류코드 = '1' AND d.qyear = '2014Q'
GROUP BY c.고객번호
ORDER BY c.고객번호;



-- 고객 등급 그룹화
create table cusgrade15 as
SELECT p.고객번호,d.성별, d.연령대, d.거주지역, SUM(p.구매금액) AS 총액,
  CASE
    WHEN SUM(p.구매금액) >= 200000000 THEN 'VVIP'
    WHEN SUM(p.구매금액) >= 80000000 THEN 'VIP'
    WHEN SUM(p.구매금액) >= 30000000 THEN 'A'
    WHEN SUM(p.구매금액) >= 10000000 THEN 'B'
    WHEN SUM(p.구매금액) >= 3000000 THEN 'C'
    ELSE 'N'
  END AS 등급
FROM purprod1 p, demo d
WHERE p.고객번호 = d.고객번호 AND p.year = 2015
GROUP BY p.고객번호,d.성별,  d.연령대, d.거주지역
ORDER BY 총액 DESC;


-- 등급별 인원 총액 비율
SELECT 등급, COUNT(*) AS 인원수, SUM(총액) AS 총액, ROUND(SUM(총액) / (SELECT SUM(총액) FROM cusgrade14) * 100, 2) AS 비율
FROM cusgrade14
GROUP BY 등급
ORDER BY CASE 등급
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END;

-- 등급별 성별 총액 비율
select * from cusgrade15;
SELECT 등급,
       COUNT(*) AS 인원수,
       성별,
       ROUND(COUNT(*) / (SELECT COUNT(*) FROM cusgrade15 WHERE 등급 = g.등급) * 100, 2) AS 퍼센트,
       SUM(총액) AS 총액
FROM cusgrade15 g
GROUP BY 등급, 성별
ORDER BY CASE 등급
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END;

-- 등급별 연령대 
SELECT 등급, 연령대, COUNT(*) AS 인원수, ROUND(COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY 등급) * 100, 2) AS 퍼센트,SUM(총액) AS 총액
FROM cusgrade15
GROUP BY 등급, 연령대
ORDER BY CASE 등급
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
END, 연령대;


select * from cusgrade14;


select 구매시간, count(*) 구매건수, sum(구매금액) 구매금액
from purprod1 
where 제휴사='A' AND year='2015'
group by 구매시간
order by 구매금액 desc;

-- 점포코드별 제휴ㅜ사
 SELECT 점포코드, COUNT(*) AS 개수, 제휴사
FROM YEAR_PUR_DEMO
WHERE 제휴사='A'
GROUP BY 점포코드, 제휴사
ORDER BY 점포코드;

-- 14 15 전체 등급 고객 증감액, 등급변화
CREATE TABLE CUSGRADE AS
SELECT
  COALESCE(c14.고객번호, c15.고객번호) AS 고객번호,
  COALESCE(c14.성별, c15.성별) AS 성별,
  COALESCE(c14.연령대, c15.연령대) AS 연령대,
  COALESCE(c14.거주지역, c15.거주지역) AS 거주지역,
  COALESCE(c14.총액, 0) AS 총액_14,
  c15.총액 AS 총액_15,   
  c15.총액 - COALESCE(c14.총액, 0) AS 총액_증감액,
  c14.등급 AS 등급_14,
  c15.등급 AS 등급_15,
  CASE
    WHEN c14.등급 IS NULL THEN '신규고객'
    WHEN c15.등급 > c14.등급 THEN '등급 상승'
    WHEN c15.등급 < c14.등급 THEN '등급 하락'
    ELSE '등급 변화 없음'
  END AS 등급_변화
FROM
  cusgrade15 c15
LEFT JOIN
  cusgrade14 c14
ON c14.고객번호 = c15.고객번호;


ALTER TABLE CUSGRADE ADD 전체_총액 NUMBER;
UPDATE CUSGRADE SET 전체_총액 = 총액_14 + 총액_15;

select * from CUSGRADE
order by 전체_총액 desc;



SELECT
  등급_14,
  등급_15,
  COUNT(*) AS 등급변화_고객수
FROM
  CUSGRADE
WHERE
  등급_14 IS NOT NULL
  AND 등급_15 IS NOT NULL
GROUP BY
  등급_14,
  등급_15
ORDER BY CASE 등급_14
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
  END,
  CASE 등급_15
    WHEN 'VVIP' THEN 1
    WHEN 'VIP' THEN 2
    WHEN 'A' THEN 3
    WHEN 'B' THEN 4
    WHEN 'C' THEN 5
    WHEN 'N' THEN 6
    ELSE 7
  END;
------------------------------ channel 제휴사 고객
SELECT *
FROM channel
WHERE 제휴사 IN (
    SELECT 제휴사
    FROM channel
    GROUP BY 제휴사
    HAVING COUNT(*) >= 2
)
order by 고객번호;


select 제휴사, count(*)
from channel
group by 제휴사
order by 제휴사;



select
case when 제휴사 like 'A%' then 'A'
when 제휴사 like 'B%' then 'B'
when 제휴사 like 'C%' then 'C'
else 'D' end 유형, sum(이용횟수) 이용횟수
from channel
group by case when 제휴사 like 'A%' then 'A'
when 제휴사 like 'B%' then 'B'
when 제휴사 like 'C%' then 'C'
else 'D' end
order by 유형;


select c.고객번호, c.이용횟수
from channel c, purprod1 p
where c.고객번호= p.고객번호;

-- 같은 영수증 번호 다른 제휴사에 더 있는지
SELECT 영수증번호
FROM purprod1
GROUP BY 영수증번호
HAVING COUNT(DISTINCT 제휴사) > 1;


SELECT p.고객번호, COUNT(p.영수증번호) 이용횟수
from purprod1 p
GROUP BY p.고객번호
ORDER BY 이용횟수 desc;

SELECT c.고객번호, SUM(c.이용횟수) 이용횟수
FROM channel c
GROUP BY c.고객번호
order by c.고객번호;


-- 고객 번호 별 전체 이용횟수 채널 이용횟수
create table abcd as
SELECT p.고객번호,c.이용횟수 AS 채널_이용횟수, p.이용횟수 AS purprod1_이용횟수
FROM (
  SELECT 고객번호, COUNT(영수증번호) AS 이용횟수
  FROM purprod1
  GROUP BY 고객번호
) p
LEFT JOIN (
  SELECT 고객번호, SUM(이용횟수) AS 이용횟수
  FROM channel
  GROUP BY 고객번호
) c ON c.고객번호 = p.고객번호
ORDER BY p.고객번호;

select * from abcd
where 채널_이용횟수 is not null;
------------------------------------------------
--백화점 점포별 매출 순위 - 고객데이터로 지역도 비교해 보자

SELECT 점포코드, SUM(구매금액) 
FROM year_pur_demo
where 제휴사='A'
GROUP BY 점포코드
ORDER BY SUM(구매금액) DESC;


SELECT 점포코드, 거주지역, SUM(구매금액) 
FROM year_pur_demo  
WHERE 제휴사 = 'A'
GROUP BY 점포코드, 거주지역
ORDER BY SUM(구매금액) DESC;



-----------
CREATE TABLE QUA_AMT AS
SELECT "고객번호",    
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140101 and "구매일자" < 20140401 THEN "구매금액" END), 0) as "14년도1분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140401 and "구매일자" < 20140701 THEN "구매금액" END), 0) as "14년도2분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140701 and "구매일자" < 20141001 THEN "구매금액" END), 0) AS "14년도3분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20141001 and "구매일자" < 20150101 THEN "구매금액" END), 0) AS "14년도4분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150101 and "구매일자" < 20150401 THEN "구매금액" END), 0) AS "15년도1분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150401 and "구매일자" < 20150701 THEN "구매금액" END), 0) AS "15년도2분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150701 and "구매일자" < 20151001 THEN "구매금액" END), 0) AS "15년도3분기",
    COALESCE(SUM(CASE WHEN "구매일자" >= 20151001 and "구매일자" < 20160101 THEN "구매금액" END), 0) AS "15년도4분기",
    
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140101 and "구매일자" < 20140401 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140401 and "구매일자" < 20140701 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20140701 and "구매일자" < 20141001 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20141001 and "구매일자" < 20150101 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150101 and "구매일자" < 20150401 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150401 and "구매일자" < 20150701 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20150701 and "구매일자" < 20151001 THEN "구매금액" END), 0) +
    COALESCE(SUM(CASE WHEN "구매일자" >= 20151001 and "구매일자" < 20160101 THEN "구매금액" END), 0) AS "14,15년총구매금액"
FROM PURPROD1
GROUP BY "고객번호"
order by"14,15년총구매금액" desc;
-------------------------------- 분기 반기 변화 모든 고객
    
drop table incdecall;
---------    

CREATE TABLE incdecall AS
select "고객번호",
"14년도1분기",
"14년도2분기",
"14년도3분기",
"14년도4분기",
"15년도1분기",
"15년도2분기",
"15년도3분기",
"15년도4분기",
"14,15년총구매금액",
("14년도2분기"-"14년도1분기") as "14년도1,2분기변화",
("14년도3분기"-"14년도2분기") as "14년도2,3분기변화",
("14년도4분기"-"14년도3분기") as "14년도3,4분기변화",
("15년도2분기"-"15년도1분기") as "15년도1,2분기변화",
("15년도3분기"-"15년도2분기") as "15년도2,3분기변화",
("15년도4분기"-"15년도3분기") as "15년도3,4분기변화",
("14년도2분기"+"14년도1분기") as "14년상반기",
("14년도4분기"+"14년도3분기") as  "14년하반기",
("15년도2분기"+"15년도1분기") as "15년상반기",
("15년도4분기"+"15년도3분기") as  "15년하반기",
(("15년도4분기"+"15년도3분기")-("15년도2분기"+"15년도1분기"))as "15년상하반기증감",
(("14년도4분기"+"14년도3분기")-("14년도2분기"+"14년도1분기"))as "14년상하반기증감",
("14년도2분기"+"14년도1분기"+"14년도4분기"+"14년도3분기") as "14년도총구매금액",
("15년도2분기"+"15년도1분기"+"15년도4분기"+"15년도3분기") as "15년도총구매금액",
("14년도2분기"+"14년도1분기"+"14년도4분기"+"14년도3분기"+"15년도2분기"+"15년도1분기"+"15년도4분기"+"15년도3분기") as "1415년도총구매금액",
    CASE WHEN "14년도1분기" = 0 AND "14년도2분기" = 0 AND "14년도3분기" = 0 AND "14년도4분기" = 0
         THEN '신규고객'
         WHEN "15년도1분기" = 0 AND "15년도2분기" = 0 AND "15년도3분기" = 0 AND "15년도4분기" = 0
         THEN '이탈고객'
         ELSE '기존고객'
    END AS "고객유형"
FROM
    QUA_AMT;


----연도별 증감고객 총액
CREATE TABLE incdecyear AS
SELECT 그룹, sum("14년도총구매금액") AS "14년도총구매금액", sum("15년도총구매금액") AS "15년도총구매금액", sum(연도별차액) AS 연도별차액
FROM ab
GROUP BY 그룹;

select * from abcd
where 채널_이용횟수 is not null;

create table aaaa as 
select 고객번호,"14년상반기","14년하반기","15년상반기","15년하반기" 
from incdecall;

ALTER TABLE AAAA
CHANGE '14년도1분기' Q1 MONEY;

SELECT SUM(구매금액) FROM PURPROD1; 

ALTER TABLE AAAA
DROP column "15년도3,4분기변화";


ALTER TABLE QUA_AMT
ADD "대그룹"  VARCHAR(30);


   CASE 
        WHEN "15년도4분기" - "14년도1분기" > 0 THEN '증가고객'
        WHEN "15년도4분기" - "14년도1분기" < 0 THEN '감소고객'
        ELSE '기타'



ALTER TABLE aaaa
ADD "W"  VARCHAR(20);

UPDATE QUA_AMT
SET "대그룹"  =  
    CASE 
        WHEN "8분기-1분기" > 0 THEN '증가고객'
        WHEN "8분기-1분기" < 0 THEN '감소고객'
        ELSE '기타'
    END;

select SUM("14,15년총구매금액") fROM INCDECALL;

UPDATE aaaa
SET "총증감액" = "14년도1,2분기변화"+"14년도2,3분기변화"+"14년도3,4분기변화"+"15년도1,14년도4분기변화"+"15년도1,2분기변화"+"15년도2,3분기변화"+"15년도3,4분기변화"; 

SELECT * FROM AAAA;
select * 
from DEMO D, PURPROD1 P
WHERE D.고객번호=P.고객번호;

ALTER TABLE HGROUP
MODIFY (대그룹 VARCHAR2(30));

UPDATE AFQY
SET 총액 = 총액2;


SELECT *
FROM QUA_AMT;


SELECT *
FROM AAAA
WHERE "15년도4분기" - "14년도1분기" < 0 AND 총증감액 > 0 AND 유형 = '감소고객';

SELECT * 
FROM AAAA
WHERE "15년도3,4분기변화" <0;   

SELECT SUM("15년도4분기") 
from AAAA;

SELECT SUM("14년도1분기"+"14년도2분기"+"14년도3분기"+"14년도4분기"),SUM("15년도1분기"+"15년도2분기"+"15년도3분기"+"15년도4분기")
FROM QUA_AMT;



SELECT round(SUM("14년도1분기"),0), round(SUM("14년도2분기"),0), ROUND(SUM("14년도3분기"),0), ROUND(SUM("14년도4분기"),0), ROUND(SUM("15년도1분기"),0), ROUND(SUM("15년도2분기"),0), ROUND(SUM("15년도3분기"),0), ROUND(SUM("15년도4분기"),0)
FROM QUA_AMT;

CREATE TABLE AFQY AS
SELECT 제휴사 , QYEAR, SUM("구매금액") AS "총액"  
FROM PURPROD1
GROUP BY 제휴사, QYEAR
ORDER BY 제휴사;

ALTER TABLE AFQY
ADD "총액2"  NUMBER;

SELECT SUM(구매금액) FROM PURPROD1;

SELECT * FROM QUA_AMT;

SELECT * FROM AB;

UPDATE AFQY
SET 총액 = 
    CASE 
        WHEN QYEAR='20141Q' THEN 총액2+(0.25-0.2395046536506363210123868665354927691146)*(677019156941/4)
        WHEN QYEAR='20151Q' THEN 총액2+(0.25-0.2395046536506363210123868665354927691146)*(677019156941/4)
        WHEN QYEAR='20142Q' THEN 총액2+(0.25-0.2442776395489978442860973176463302673445)*(677019156941/4)
        WHEN QYEAR='20152Q' THEN 총액2+(0.25-0.2442776395489978442860973176463302673445)*(677019156941/4)
        WHEN QYEAR='20143Q' THEN 총액2+(0.25-0.2281859591019859008022385519400185518893)*(677019156941/4)
        WHEN QYEAR='20153Q' THEN 총액2+(0.25-0.2281859591019859008022385519400185518893)*(677019156941/4)
        WHEN QYEAR='20144Q' THEN 총액2+(0.25-0.2880317476983799338992772638781584116516)*(677019156941/4)
        WHEN QYEAR='20154Q' THEN 총액2+(0.25-0.2880317476983799338992772638781584116516)*(677019156941/4)
    END;

select *
FROM AFQY; 

UPDATE AAAA
SET 유형 = 
    CASE 
        WHEN "15년도4분기" - "14년도1분기" > 0 THEN '증가고객'
        WHEN "15년도4분기" - "14년도1분기" < 0 THEN '감소고객'
        ELSE '기타'
    END;


---------------------- 대그룹 
UPDATE HGROUP
SET "대그룹" = 
 CASE
    WHEN "14년상반기" = 0 AND "14년하반기" <> 0 AND "15년상반기" <> 0 AND "15년하반기" <> 0 then '신규고객'
    WHEN "14년상반기" = 0 AND "14년하반기" = 0 AND "15년상반기" <> 0 AND "15년하반기" <> 0 then '신규고객'
    WHEN "14년상반기" = 0 AND "14년하반기" = 0 AND "15년상반기" = 0 AND "15년하반기" <> 0 then '신규고객'
    WHEN "14년상반기" = 0 AND "14년하반기" <> 0 AND "15년상반기" = 0 AND "15년하반기" <> 0 then '재진입고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" = 0 AND "15년상반기" <> 0 AND "15년하반기" <> 0 then '재진입고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" = 0 AND "15년상반기" = 0 AND "15년하반기" <> 0 then '재진입고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" <> 0 AND "15년상반기" = 0 AND "15년하반기" <> 0 then '재진입고객'
    WHEN "14년상반기" = 0 AND "14년하반기" = 0 AND "15년상반기" <> 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" = 0 AND "14년하반기" <> 0 AND "15년상반기" = 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" = 0 AND "14년하반기" <> 0 AND "15년상반기" <> 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" = 0 AND "15년상반기" = 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" <> 0 AND "15년상반기" = 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" <> 0 AND "15년상반기" <> 0 AND "15년하반기" = 0 then '이탈고객'
    WHEN "14년상반기" <> 0 AND "14년하반기" = 0 AND "15년상반기" <> 0 AND "15년하반기" = 0 then '재진입이탈고객'
    ELSE '기존고객'
 END;

 
 ------------------------------중그룹 증증감
UPDATE aaaa
SET "중그룹" = 
 CASE
    WHEN "1구간" > 0 THEN
        CASE
            WHEN "2구간" > 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '증증증'
                    WHEN "3구간" < 0 THEN '증증감'
                    ELSE '증증0'
                END
            WHEN "2구간" < 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '증감증'
                    WHEN "3구간" < 0 THEN '증감감'
                    ELSE '증감0'
                END
            ELSE
                CASE
                    WHEN "3구간" > 0 THEN '증0증'
                    WHEN "3구간" < 0 THEN '증0감'
                    ELSE '증00'
                END
        END
    WHEN "1구간" < 0 THEN
        CASE
            WHEN "2구간" > 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '감증증'
                    WHEN "3구간" < 0 THEN '감증감'
                    ELSE '감증0'
                END
            WHEN "2구간" < 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '감감증'
                    WHEN "3구간" < 0 THEN '감감감'
                    ELSE '감감0'
                END
            ELSE
                CASE
                    WHEN "3구간" > 0 THEN '감0증'
                    WHEN "3구간" < 0 THEN '감0감'
                    ELSE '감00'
                END
        END
    ELSE
        CASE
            WHEN "2구간" > 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '0증증'
                    WHEN "3구간" < 0 THEN '0증감'
                    ELSE '0증0'
                END
            WHEN "2구간" < 0 THEN
                CASE
                    WHEN "3구간" > 0 THEN '0감증'
                    WHEN "3구간" < 0 THEN '0감감'
                    ELSE '0감0'
                END
            ELSE
                CASE
                    WHEN "3구간" > 0 THEN '00증'  
                    WHEN "3구간" < 0 THEN '00감'
                    ELSE '00'
                END
        END
 END;


-----------------
SELECT H.중그룹, D.QYEAR, D.대분류코드, SUM(D.구매금액) AS 총구매액
FROM HGROUP H, DEMOPURPROD D
WHERE H.고객번호 = D.고객번호 AND H.중그룹='증증증' AND D.제휴사='A'
GROUP BY H.중그룹, D.QYEAR, D.대분류코드
ORDER BY QYEAR, 총구매액 DESC;

--------------------중분류코드별
SELECT H.중그룹, D.HYEAR, D.대분류코드, D.중분류코드,P.중분류명, SUM(D.구매금액) AS 총구매액
FROM HGROUP H, DEMOPURPROD D, PRODCL P
WHERE H.고객번호 = D.고객번호 AND D.중분류코드=P.중분류코드 AND H.중그룹='증증증' AND P.제휴사='A'
GROUP BY H.중그룹, D.HYEAR, D.대분류코드, D.중분류코드, P.중분류명
ORDER BY HYEAR,대분류코드, 총구매액 DESC;

--------------------------------------
SELECT H.대그룹, D.QYEAR, D.대분류코드, SUM(D.구매금액) AS 총구매액
FROM HGROUP H, DEMOPURPROD D
WHERE H.고객번호 = D.고객번호 AND H.대그룹='기존고객' AND D.제휴사='A'
GROUP BY H.대그룹, D.QYEAR, D.대분류코드
ORDER BY QYEAR, 총구매액 DESC;


SELECT QYEAR AS, SUM(구매금액) 
FROM DEMOPURPROD
GROUP BY QYEAR
ORDER BY QYEAR;   

SELECT * FROM PURPROD1;

CREATE TABLE AABBCC AS
SELECT 고객번호, COUNT(DISTINCT(영수증번호)) AS 건수  
FROM PURPROD1
WHERE QYEAR='20154Q'
GROUP BY 고객번호;  

SELECT * FROM DEMOPURPROD;

SELECT COUNT(DISTINCT(고객번호))
FROM DEMOPURPROD;
    
--AAAAAAAAAAAAAAAAAAA
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
CREATE TABLE AAAA AS
SELECT 고객번호, 성별, 연령대, 거주지역, SUM(구매금액) AS 구매금액, COUNT(DISTINCT(영수증번호)) AS 거래건수
FROM demopurpROD
GROUP BY 고객번호, 성별, 연령대, 거주지역
ORDER BY 고객번호;

SELECT * FROM AAAA;

----------고객별 많이산 품목

SELECT 고객번호, 소분류코드, 거래건수
FROM (
  SELECT 고객번호, 소분류코드, 거래건수,
         ROW_NUMBER() OVER(PARTITION BY 고객번호 ORDER BY 거래건수 DESC) AS rn
  FROM (
    SELECT 고객번호, 소분류코드, COUNT(소분류코드) AS 거래건수
    FROM DEMOPURPROD
    GROUP BY 고객번호, 소분류코드
  )
) t
WHERE rn = 1
ORDER BY 고객번호;


SELECT * FROM DEMOPURPROD;

ALTER TABLE DEMOPURPROD
DROP COLUMN "대대분류";

ALTER TABLE DEMOPURPROD
RENAME COLUMN "대대분류" TO "대대분류코드";

SELECT * FROM DEMOPURPROD;


------------고객별 비싼 소분류코드 
SELECT 고객번호, 소분류코드, 구매금액
FROM (
  SELECT 고객번호, 소분류코드, 구매금액,
         ROW_NUMBER() OVER(PARTITION BY 고객번호 ORDER BY 구매금액 DESC) AS rn
  FROM (
    SELECT 고객번호, 소분류코드, MAX(구매금액) AS 구매금액
    FROM DEMOPURPROD
    GROUP BY 고객번호, 소분류코드
  )
) t
WHERE rn = 1;

------------고객별 싼 소분류코드 
SELECT 고객번호, 소분류코드, 구매금액
FROM (
  SELECT 고객번호, 소분류코드, 구매금액,
         ROW_NUMBER() OVER(PARTITION BY 고객번호 ORDER BY 구매금액) AS rn
  FROM (
    SELECT 고객번호, 소분류코드, MAX(구매금액) AS 구매금액
    FROM DEMOPURPROD
    GROUP BY 고객번호, 소분류코드
  )
) t
WHERE rn = 1;


SELECT c.고객번호, COALESCE(SUM(d.구매금액), 0) AS 구매금액
FROM (SELECT DISTINCT 고객번호 FROM ddpp) c
LEFT JOIN ddpp d ON c.고객번호 = d.고객번호 AND d.대대분류코드 = '7' AND d.qyear = '20152Q'
GROUP BY c.고객번호
ORDER BY c.고객번호;


SELECT c.고객번호,COALESCE(SUM(CASE WHEN d.대대분류코드 = '1' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드1_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '2' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드2_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '3' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드3_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '4' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드4_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '5' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드5_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '6' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드6_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '7' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드7_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '8' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드8_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '9' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드9_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '10' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드10_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '11' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드11_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '12' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드12_구매금액,
COALESCE(SUM(CASE WHEN d.대대분류코드 = '13' THEN d.구매금액 ELSE 0 END), 0) AS 대대분류코드13_구매금액
FROM (SELECT DISTINCT 고객번호 FROM ddpp) c
LEFT JOIN ddpp d ON c.고객번호 = d.고객번호 AND d.qyear IN ('20141Q', '20142Q', '20143Q', '20144Q', '20151Q', '20152Q', '20153Q', '20154Q')
GROUP BY c.고객번호
ORDER BY c.고객번호;





SELECT *
FROM DEMOPURPROD;

DROP TABLE AABBCC;
SELECT * FROM AABBCC;

SELECT SUM(구매금액) FROM DEMOPURPROD
WHERE QYEAR='20141Q' AND 제휴사='B';

SELECT SUM(채널_이용횟수) FROM ABCD;

3451785
119736


select * FROM ABCD;
 
---------계절성 제거 총액------
SELECT
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) AS "1Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "1Q",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) AS "2Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "2Q",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) AS "3Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "3Q",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) AS "4Q_total_amount",
    (1.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "4Q",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) * (1.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N4Q_total_amount",
    SUM(구매금액) AS total_amount
FROM DEMOPURPROD;

----------------------------
SELECT sum(구매금액)
FROM DEMOPURPROD
where qyear='20154Q';


ALTER DEMOPURPROD
drop column "구매금액2";
SELECT * FROM DEMOPURPROD;

UPDATE DEMOPURPROD
SET "구매금액" = (SELECT "구매금액" FROM PURPROD1);


UPDATE DEMOPURPROD
SET "구매금액" = 
  CASE 
    WHEN QYEAR LIKE '%1Q' THEN "구매금액" * 1.01049534634936367898761313346450723089
    WHEN QYEAR LIKE '%2Q' THEN "구매금액" * 1.00572236045100215571390268235366973266
    WHEN QYEAR LIKE '%3Q' THEN "구매금액" * 1.02181404089801409919776144805998144811
    WHEN QYEAR LIKE '%4Q' THEN "구매금액" * 0.9619682523016200661007227361218415883484
    ELSE "구매금액"  
  END;

SELECT sum(구매금액) FROM demoPURPROD;

SELECT * FROM HGROUP;

SELECT * FROM INCDECALL;

---------계절성 제거 총액------
   SELECT
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) AS "1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액) AS "1Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%1Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N1Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) AS "2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액) AS "2Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%2Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N2Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) AS "3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END)   / SUM(구매금액) AS "3Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%3Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N3Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) AS "4Q_total_amount",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액) AS "4Q_percentage",
    SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END)+ 169254789235 * (0.25-(SUM(CASE WHEN QYEAR LIKE '%4Q' THEN 구매금액 ELSE 0 END) / SUM(구매금액))) AS "N4Q_total_amount",
    SUM(구매금액) AS total_amount
FROM DEMOPURPROD;


+(0.25-0.2395046536506363210123868665354927691146)*("14년,15년총구매금액"/4)
+(0.25-0.2442776395489978442860973176463302673445)*("14년,15년총구매금액"/4)
+(0.25-0.2281859591019859008022385519400185518893)*("14년,15년총구매금액"/4)
+(0.25-0.2880317476983799338992772638781584116516)*("14년,15년총구매금액"/4)

SELECT SUM(구매금액) FROM PURPROD1;

SELECT "거주지역", sum("14,15년총구매금액")
FROM DEMO
JOIN QUA_AMT ON QUA_AMT."고객번호"=DEMO."고객번호"
group by "거주지역"
ORDER BY "거주지역";


select*
FROM DEMO
JOIN QUA_AMT ON QUA_AMT."고객번호"=DEMO."고객번호";
select*
from HGROUP;

SELECT * FROM QUA_AMT;


select * 
from qua_amt
where "qua_amt IS NULL