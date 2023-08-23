--m4_db test 

--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	

--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
   
--Q4. manager_id 가 101에서 103인 사람만 출력

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 
--현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 
--W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 
--단 월급은 소수점 둘째자리까지만 표현하세요.

--Q10. employees 테이블에서 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'    

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력
--(join~on, where 로 조인하는 두 가지 방법 모두)

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King

--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
   
--Q18. Seo라는 사람의 부서명을 출력하세요.

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 
--1. DEMO 테이블과 고객번호를 기준으로 결합하여 출력하세요.
--2. DEMO와 CUSPUR 고객번호 기준 결합

--Q20.PURPROD 테이블로 부터 아래 사항을 수행하세요.
--1. 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 
--테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
--2. AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 
--AMT_YEAR_FOJ 테이블 생성
--3. 14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력
--(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)


