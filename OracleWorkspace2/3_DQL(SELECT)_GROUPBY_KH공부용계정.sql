/*
    <GROUP BY 절>
     - 그룹을 묶어줄 기준을 제시할 수 있는 구문
     - 제시된 기준별로 그룹을 묶을 수 있다.
     - 여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
     
     [표현법]
     GROUP BY 칼럼
*/
-- 각 부서별 총 급여의 합 
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 'D1'부서의 총 급여의 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 각 부서별 사원의 수
SELECT COUNT(*), DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여의 합을 내림차순으로 정렬후 조회.  
SELECT DEPT_CODE, SUM(SALARY) -- 4.
FROM EMPLOYEE -- 1.
WHERE 1 = 1 -- 2.
GROUP BY DEPT_CODE  -- 3.
ORDER BY SUM(SALARY) DESC; -- 5.

-- 성별 별 사원의 수 구하기. 
SELECT DECODE(SUBSTR(EMP_NO, 8,1),'1','남','3','남','여') 성별, COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1),'1','남','3','남','여');

-- 부서별로 사수가 존재하는 사원의 수 구하기
-- 부서내 모든사람이 사수가 없다면 0을 출력하시오 
SELECT DEPT_CODE, COUNT(MANAGER_ID)
FROM EMPLOYEE
-- WHERE MANAGER_ID IS NOT NULL
GROUP BY DEPT_CODE;

-- 부서별 월급이 200만원 이하인 사원의 수?
SELECT DEPT_CODE, COUNT( CASE WHEN SALARY <= 2000000 THEN 1 ELSE NULL END) 수
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY)) 평균급여
FROM EMPLOYEE
-- WHERE ROUND(AVG(SALARY)) >= 3000000 문법상 그룹함수를 WHERE에서 사용할 수 없다.
GROUP BY DEPT_CODE;
/* 
    <HAVING 절>
     - 그룹에 대한 조건을 제시하고자 할 때 사용되는 구문
     - 항상 GROUP BY절과 함께 사용되며, 주로 그룹함수를 조건으로 제시한다 
*/
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 각 직급별 총 급여합이 1000만원 이상인 직급의 직급코드, 급여합을 조회 
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY JOB_cODE
HAVING SUM(SALARY) >= 10000000;

/* 
    <SELECT 문 구조 및 실행순서>
    5. SELECT 조회할 칼럼
    1. FROM 조회할테이블
    2. WHERE 조건식
    3. GROUP BY 그룹에해당하는 칼럼 
    4. HAVING 그룹에 대한 조건식
    6. ORDER BY 정렬기준
*/
-----------------------------------------------------------------------------
/* 
    <집합 연산자 SET OPERATOR> 
     - 여러개의 쿼리문을 실행하여 하나의 RESULTSET을 만드는 연산자  
     
     1. UNION(합집합) : 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분은 제거한 결과를 반환
     2. UNION ALL : UNION집합결과에서 중복값을 제거하지 않은 결과를 반환
     3. INTERSECT(교집합) : 두 쿼리문을 수행한 결과값의 중복된 부분을 반환
     4. MINUS(차집합) : 선행쿼리문의 결과에서 후행쿼리문의 결과를 뺀 나머지 값. 
*/
-- 1. UNION(합집합) 
--  부서코드가 D5이거나 또는 급여가 300만원을 초과하는 사원들의 사번, 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

SELECT EMP_NAME, EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

SELECT EMP_NAME, EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 직급코드가 J6이거나 부서코드가 D1인 사원들을 조회(UNION연산자를 활용하여)
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE JOB_cODE ='J6'
UNION 
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 2. UNION ALL : UNION처럼 여러개의 쿼리의 결과를 하나로 합쳐 반환하는 연산자로,
-- UNION과는 달리 중복값을 제거하지 않는다. 
-- 직급코드가 J6이거나 부서코드가 D1인 사원들의 (사번,사원명,부서코드, 직급코드) 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE='J6'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
--3. INTERSECT : 교집합. 여러 쿼리 결과의 중복된 결과만을 조회하는 연산자
-- 직급코드가 J6이고, 부서코드가 D1인 사원들의 사번, 사원명, 부서코드 , 직급코드
SELECT EMP_ID, EMP_NAME, DEPT_cODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_cODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
-- 4. MINUS : 차집합. 선행 쿼리 결과에서 후행쿼리와 일치하는 요소를 뺀 나머지값
SELECT EMP_ID, EMP_NAME, DEPT_cODE, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_cODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';
/* 
    그룹별 집계함수
    - GROUP BY로 계산된 그룹별 산출 결과물들을 "소그룹"별로 다시 추가 집계해주는 함수

    1. <ROLLUP>
     - ROLLUP(칼럼1, 칼럼2,...) 
     - GROUP BY로 묶은 소그룹간의 합계와, 전체합계, 칼럼1기준 합계를 산출할 수 있는 메서드
     
    2. <CUBE>
     - CUBE(칼럼1, 칼럼2,...)
     - GROUP BY로 묶은 소그룹의 합계, 전체합계, 칼럼1그룹의 합계, 칼럼2그룹의 합계를 모두
       반환하는 함수
    
    3. <GROUPING SETS>
    GROUPING SETS(칼럼1, 칼럼2)
     - GROUP BY로 묶은 칼럼1그룹의 합계와 칼럼2 그룹의 합계만 반환하는 함수
*/
-- 1. DEPT_CODE별 급여의 합
SELECT DEPT_CODE, NULL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
UNION ALL
-- 2. 총 급여의 합
SELECT NULL, NULL, SUM(SALARY)
FROM EMPLOYEE
UNION ALL
-- 3. 부서내부의 직급별 급여의합.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1, 2;
/* 
    GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
    == 
    1. GROUP BY DEPT_cODE, JOB_CODE
    UNION ALL
    2. GROUP BY DEPT_CODE
    UNION ALL
    3. 모든 집합그룹 결과
*/
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1, 2;

-- 1. DEPT_CODE, JOB_CODE 
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
UNION ALL
-- 2.DEPT_CODE
SELECT DEPT_CODE, NULL, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
UNION ALL
-- 3. JOB_CODE 
SELECT NULL, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE 
-- 4. * 
UNION ALL
SELECT NULL, NULL, SUM(SALARY)
FROM EMPLOYEE
ORDER BY 1, 2;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1, 2;


/*
    GROUPING SETS(칼럼1,칼럼2)
    ==
    GROUP BY 칼럼1
    UNION ALL
    GROUP BY 칼럼2
*/
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
GROUP BY GROUPING SETS(DEPT_CODE, JOB_CODE);













