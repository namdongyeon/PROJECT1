--[DDL]
--Table 생성
create table test1(
eno number(4),
ename varchar2(20),
esal number(7)
);
desc test1;
drop table test1;
--Table 복사
create table test2 as select * from test1;
insert into test1 values (1, '박찬호', 5);
select * from test1;

--Table 구조 복사
--조건절에 거짓 조건을 지정하면 해당 로우를 발견하지 못하기 때문에 빈 테이블을 생성 
create table test3 as select * from test1 where 1=0;
select * from test3;
desc test3

--컬럼 추가하기
alter table test1 add(email varchar2(10));

--컬럼 변경하기
alter table test1 modify(email varchar2(40));

--컬럼 삭제하기
alter table test1 drop column email;

--테이블의 모든 로우 삭제 내용만 삭제
select * from test1;
truncate table test1;

----[테이블 생성 규칙]

--테이블명은 객체를 의미할 수 있는 적절한 이름을 사용한다. 가능한 단수형을 권고한다.--
--테이블명은 다른 테이블의 이름과 중복되지 않아야 한다.--
--한 테이블 내에서는 칼럼명이 중복되게 지정될 수 없다. --
--테이블 이름을 지정하고 각 칼럼들은 괄호 "( )" 로 묶어 지정한다.--
--각 칼럼들은 콤마" ", 로 구분되고, 항상 끝은 세미콜론 ";"으로 끝난다.--
--칼럼에 대해서는 다른 테이블까지 고려하여 데이터베이스 내에서는 일관성 있게 사용하는 것이 좋다. (데이터 표준화 관점)--
--칼럼 뒤에 데이터 유형은 꼭 지정되어야 한다.--
--테이블명과 칼럼명은 반드시 문자로 시작해야 하고, 벤더별로 길이에 대한 한계가 있다.--
--벤더에서 사전에 정의한 예약어(Reserved word)는 쓸 수 없다.--
--A-Z, a-z, 0-9, _, $, # 문자만 허용된다.

--테이블 리스트를 조회 
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

-- Q. MEMBER1 테이블을 생성(모든 데이터 타입 적용)하고 2개의 데이터 입력 및 칼럼 추가, 타입 변경,
-- 칼럼 삭제, 제약조건 추가, 삭제한 후 출력하세요.
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

-- 과제 1_0510. member2 테이블을 생성하여 ddl 전체 명령어를 사용하는 코드를 작성하세요.
create table member2(
name varchar2(10),
kind varchar2(20),
company varchar2(20),
years date,
price number(10),
repaired char(1)
);
insert into member2 values('김철수','sorento','kia',(date '2022-10-20'),30000000,'N');
insert into member2 values('박짱구','sonata','hyundai',(date '2019-8-20'),18000000,'N');

alter table member2 add(phone number(20));
alter table member2 modify(phone varchar2(20));
alter table member2 add constraint member2_pk primary key(name);
alter table member2 drop column phone;

UPDATE member2
SET phone = '010-1234-5678'
WHERE name = '김철수';

truncate table member2;
desc member2;
select * from member2;

-- [DML]

-- IN: or 대신 사용
select * from employees;
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in (101,102,103);

select employee_id, manager_id from employees;
-- between and: and 대신 사용 101~ 105까지
select employee_id, manager_id from employees where manager_id between 101 and 105;

-- null 값인지를 확인, 아닌것만 출력
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
--select 절 다음에 반드시 from 절을 기술해야 한다.
--연산의 경우 select 절 자체적으로 연산이 가능하기 때문에 from 절 뒤에 올 테이블이 필요없다.
--이런 경우 사용할 수 있는 Dummy 테이블이 DUAL 테이블이다.

--mod: 나머지
select employee_id, last_name from employees where mod(employee_id, 2)=1;
select mod(10,3) from dual;

-- round() : 반올림 함수
select round(355.95555,2) from dual;
select round(355.95555,-2) from dual;


--trunc() 버림 함수, 지정한 자리수 이하를 버린 결과를 반환
select trunc(45.5555) from dual;
select trunc(45.5555,-1) from dual;
select trunc(45.5555,1) from dual;

--날짜 관련 함수
select sysdate from dual;
select sysdate+1 from dual;
select sysdate-1 from dual;

select last_name, hire_date, sysdate-hire_date 근무일수 from employees;
select last_name, hire_date, add_months(hire_date,6) from employees;
select last_name, hire_date, last_day(hire_date) from employees;
select last_day(sysdate)-sysdate from dual;
select hire_date, next_day(hire_date,'월') from employees;
select last_name, months_between(sysdate, hire_date) from employees;

-- 형 변환
-- to_date: 문자를 날짜로 변환
select to_date('20210101') from dual;

-- to_char: 날짜를 문자로 변환
select to_char(sysdate, 'yy/mm/dd') from dual;
select to_char(sysdate, 'yy/mm/dd hh24:mi:ss') from dual;

--형식
--YYYY 		네 자리 연도
--YY		두 자리 연도
--YEAR		연도 영문 표기
--MM		월을 숫자로
--MON		월을 알파벳으로
--DD		일을 숫자로
--DAY		요일 표현
--DY		요일 약어 표현
--D		요일 숫자 표현
--
--AM 또는 PM	오전 오후
--HH 또는 HH12	12시간
--HH24		24시간
--MI		분
--SS		초

-- 문자 함수
select upper('Hello World') from dual;
select lower('Hello World') from dual;

select last_name, salary from employees where upper(last_name)='SEO';
select last_name, salary from employees where lower(last_name)='seo';

-- 첫글자만 대문자
select job_id, initcap(job_id) from employees;

--length()
select job_id, length(job_id) from employees;

--instr() 문자열, 찾을 문자, 찾을 위치, 찾은 문자 중 몇 번 째
select instr('Hello World' , 'o' , 2, 2) from dual;

--substr(문자열, 시작위치, 개수)
select substr('Hello World', 3, 3) from dual;
select substr('Hello World', -3, 3) from dual;

--lpad(), rpad() 왼쪽, 오른쪽 정렬 후 문자를 채운다.
select lpad('Hello World', 20,'#') from dual;
select rpad('Hello World', 20,'#') from dual;

--ltrim(), rtrim() 앞, 뒤의 특정 문자 제거
select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;

--trim() 앞뒤의 특정 문자 제거
select last_name, trim('A' from last_name) new_name from employees;

--nvl() : null을 0 또는 다른 값으로 변환
select salary, nvl(commission_pct, 0) 
from employees;
select last_name, nvl(to_char(manager_id),'ceo') from employees;
select last_name, department_id from employees;
--decode(): if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
select last_name, department_id,
decode(department_id,
90, '경영지원실',
60, '프로그래머',
100, '인사부') 부서명
from employees;

--case(): decode() 함수와 동일하나 decode() 함수는 조건이 동일한 경우만 가능하지만
--case() 함수는 다양한 비교연산자로 조건을 제시

select last_name, department_id,
case when department_id=90 then '경영지원실'
     when department_id=60 then '프로그래머'
     when department_id=100 then '인사부'
     when department_id=30 then '영업부'
     when department_id=50 then '관리부' end as 부서명
from employees;

--first_value() over() : 그룹의 첫번째 값을 구한다.
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc) 최고연봉
from employees;

--3줄 위의 값까지 중 첫번째 값
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc rows 3 preceding) 최고연봉
from employees;

--연봉+2000까지 중 첫번째 값
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary desc range 2000 preceding) 최고연봉
from employees;
select department_id, salary from employees
order by department_id;

--sum() over(): 정렬에 따라 그룹의 누적 합계를 구한다.
select department_id, last_name, sum(salary) over(order by department_id)
from employees;

--insert
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUM    N_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);
select * from member;
insert into member (id, pwd, name) values('200903','113','김연아');
insert into member values('200103','113','김연경','F',25,(date'1999-1-2'),sysdate);

--* UPDATE
--UPDATE 다음에 수정되어야 할 칼럼이 존재하는 테이블명을 입력하고, SET  다음에 수정되어야 할 칼럼명과 해당 칼럼 수정 값으로 변경이 이루어진다.
--UPDATE 테이블명 SET 수정되어야 할 칼럼명 = 수정되기를 원하는 새로운 값;
--[예제] UPDATE PLAYER SET POSITION = 'MF’;
select * from member;

UPDATE member
SET name = '추신수'
WHERE id = 'hmkd2';

--* DELETE
--DELETE FROM 다음에 삭제를 원하는 자료가 저장되어 있는 테이블명을 입력하고 실행한다. 이때 FROM 문구는 생략이 가능한 키워드이다. 
--DELETE [FROM] 삭제를 원하는 정보가 있는 테이블명;
--[예제] DELETE FROM PLAYER;

delete member where pwd is null;

insert into member (id) values('200103');
alter table member add constraint member_pk primary key(id);
alter table member drop constraint member_pk;
desc member;

--UNION
--UNION( 합집합 ) INTERSECT( 교집합 ) MINUS( 차집합 ) UNION ALL( 겹치는 것까지 포함 )
--두 개의 쿼리문을 사용해야 한다. 데이터 타입을 일치 시켜야 한다.

select first_name 이름, hire_date 입사일, salary 급여 from employees
where salary<5000
union
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date<'05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees
where salary<5000
intersect
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date<'05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees
where salary<5000
minus
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date<'05/01/01'
order by 입사일;

select first_name 이름, hire_date 입사일, salary 급여 from employees
where salary<5000
union all
select first_name 이름, hire_date 입사일, salary 급여 from employees
where hire_date<'05/01/01'
order by 입사일;

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
--과제2_0510. test5, test6의 합집합, 교집합, 차이를 where를 이용해서 구하세요.

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


--과제3_0510. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
--join~on, where 로 조인하는 두 가지 방법 모두 사용.
select *
from jobs;

select employees.employee_id, empoyees.last_name, employees.job_id, jobs.job_title
from employees
join jobs on employees.job_id=jobs.job_id and employee_id = 120;

select em.employee_id, em.first_name, em.last_name, em.job_id, j.job_title
from employees em, jobs j
where employee_id=120 and em.job_id=j.job_id;


--과제4_0510. employees, jobs, departments 세개의 테이블을 연결해서 employee_id, job_title, 
--department_name을 출력하세요.

select em.employee_id, j.job_title, d.department_name
from employees em, jobs j, departments d
where em.job_id=j.job_id and em.manager_id=d.manager_id
order by em.employee_id;


--과제5_0510. hr에 포함되는 6개의 테이블들을 분석해서 인사이트를 얻을 수 있는
--결과물을 5개 이상 출력하세요. 
--(예 : 부서별 평균 SALARY 순위)

SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;

-- 근무일수에 따른 직책과 최대연봉
select round(sysdate-e.hire_date,1) 근무일수,j.job_title, j.max_salary
from employees e, jobs j
where e.job_id=j.job_id
order by j.max_salary desc;

-- 부서별 최대급여와 최소급여 차이의 평균
SELECT d.DEPARTMENT_NAME, ROUND(AVG(j.max_salary-j.min_salary))
from departments d, employees e, jobs j
where d.department_id=e.department_id and j.job_id=e.job_id
group by department_name
order by ROUND(AVG(j.max_salary-j.min_salary)) desc;

-- 부서별 평균 근무기간(년)
select department_name, round(avg(sysdate-hire_date)/365,1)
from departments d, employees e
where d.department_id =e.department_id
group by d.department_name
order by avg(sysdate-hire_date) desc;


--rank() within group(order by 컬럼명 정렬)
select commission_pct from employees
order by commission_pct desc;

--rank 1위가 73번째
select rank(0.31) within group( order by commission_pct desc) from employees;
select rank() over(order by salary) from employees;
select rank(3000) within group( order by salary) from employees;

--count() 
--null은 제외, 중복은 count
select count(commission_pct) from employees;
select count(distinct commission_pct) from employees;

--전체행의 수
select count(*) from employees;

--group by
-- 주의 select 뒤에는 그룹으로 묶을 수 있는 컬럼 만 올 수 있다.

select department_id, round(avg(salary)) from employees group by department_id;
select job_id, avg(salary) from employee group by job_id;

select job_id, avg(salary), max(salary), min(salary)
from employees
group by job_id;

--Q. 평균연봉이 5000이상인 부서들에 대해서 job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
select job_id, sum(salary), avg(salary), max(salary), min(salary)
from employees
group by job_id
having avg(salary)>=5000;

--Q. 평균연봉이 10000이상인 부서들에 대해서 job_id 별로 연봉평균 부서인원 출력(연봉평균 기준 내림차순 정렬)
select job_id, avg(salary), count(employee_id)
from employees
group by job_id
having avg(salary)>=10000
order by avg(salary) desc;

-- 서브 쿼리
--Seo 라는 사람의 부서명을 얻어 오려면 두 번 검색해야 한다.
select department_id from employees where last_name='Seo';
select department_name from departments where department_id=50;

select department_id, department_name
from departments
where department_id=(select department_id from employees where last_name='Seo');

-- 평균보다 많은 급여를 받는 직원 검색
select last_name, salary
from employees
where salary>(select avg(salary) from employees);

--'Seo' 는 한명이기 때문에 단일행 서브 쿼리
select last_name, hire_date, department_id from employees
where department_id=(select department_id from employees where last_name='Seo');

--'King'은 두명이기 때문에 다중행 서브 쿼리
select last_name, hire_date, department_id from employees
where department_id in (select department_id from employees where last_name='King');

-- 다중행
select last_name, salary from employees
where salary>all(select salary from employees where department_id =100);

-- 단일행
select last_name, salary from employees
where salary>(select max(salary) from employees where department_id =100);

--특정부서보다 먼저 입사
select last_name, salary, department_id, hire_date
from employees
where hire_date<all(select hire_date from employees where department_id=100);

select last_name, salary from employees
where salary > any (select salary from employees where department_id=100);



--과제1_0511. 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'


select employee_id, last_name,
case when salary > 20000 then '대표이사'
     when salary > 15000 then '이사' 
     when salary > 10000 then '부장' 
     when salary > 5000 then '과장' 
     when salary > 3000 then '대리' 
     else '사원' end as 직급
from employees;

--과제2_0511. 부서별 연봉 순위를 출력하세요.


select * from employee_salary;
--과제3_0511. employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하세요.
create table employee_salary as select employee_id, salary from employees;

--과제4_0511. employees_salary 테이블에 first_name, last_name 컬럼을 추가하세요.
alter table employee_salary add(first_name varchar2(20));
alter table employee_salary add(last_name varchar2(20));

--과제5_0511. last_name을 name으로 변경하세요.
alter table employee_salary rename column last_name to name;

--과제6_0511. employees_salary 테이블의 employee_id에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 
--출력하세요.
alter table employee_salary add constraint ES_PK primary key(employee_id);
desc employee_salary;

--과제7_0511. employees_salary 테이블의 employee_id에서 CONSTRAINT_NAME을 삭제후 삭제 여부를 확인하세요.
alter table employee_salary drop constraint ES_PK;
desc employee_salary;

--m4_db test 
select * from employees;
select * from jobs;
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
select last_name, salary, salary * 1.1
from employees;

--Q2.  2005년 상반기에 입사한 사람들만 출력	
select * from employees
where hire_date;

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
select * 
from employees e, jobs j
where j.job_id= 'SA_MAN' or j.job_id= 'IT_PROG' or j.job_id= 'ST_MAN';

--Q4. manager_id 가 101에서 103인 사람만 출력
select * from employees
where manager_id>=101 and manager_id<=103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
select last_name, hire_date,next_day(add_months(hire_date,6),'월')  from employees;

select * from employees;
select * from jobs;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 
--현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)


--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 
--W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
select employee_id, last_name 
from employees
where mod(employee_id, 2)=1;
--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 
--단 월급은 소수점 둘째자리까지만 표현하세요.
select employee_id, last_name, round(salary/12,2) M_SALARY 
from employees;

--Q10. employees 테이블에서 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'    

select employee_id, last_name,
case when salary > 20000 then '대표이사'
     when salary > 15000 then '이사' 
     when salary > 10000 then '부장' 
     when salary > 5000 then '과장' 
     when salary > 3000 then '대리' 
     else '사원' end as 직급
from employees;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.

select * 
from employees
where commission_pct is null;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
select * 
from employees
where department_id is null;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력
--(join~on, where 로 조인하는 두 가지 방법 모두)

select employees.employee_id, employees.last_name, employees.job_id, jobs.job_title
from employees
join jobs on employees.job_id=jobs.job_id and employee_id = 120;

select em.employee_id, em.first_name, em.last_name, em.job_id, j.job_title
from employees em, jobs j
where employee_id=120 and em.job_id=j.job_id;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
alter table employees add(name varchar2(20))