/*
    <JOIN>
    - 두 개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
    - 조회 결과는 하나의 결과문(RESULT SET)으로 나온다.
    - 관계형데이터베이스()에서는 데이터의 중복을 피하기 위해, 다양한 테이블에 데이터
    를 나눠서 보관하고 있으며, 이때 여러테이블의 데이터를 동시에 조회하기 위해서는
    각 테이블이 가지고 있는 외래키를 활용하여 JOIN시켜줘야 한다.
    
    JOIN문은 "오라클전용구문"과 "ANSI구문"으로 나뉘어져 있다.

        오라클 전용 구문           |   ANSI구문
    =====================================================
        등가조인(EQUAL JOIN)      |  내부조인(INNER JOIN)
    -----------------------------------------------------
        포괄조인                  |  외부조인(OUTER JOIN)    
    (LEFT OUTER JOIN)            |  LEFT OUTER JOIN 
    (RIGHT OUTER JOIN)          |  RIGHT OUTER JOIN 
                                |   FULL OUTER JOIN 
    ----------------------------------------------------
    카데시안의 곱(CARTECIAN RODUCT)| 교차조인
    ------------------
        자체조인(SELF JOIN)
        비등가조인(NON EQUAL JOIN)

*/
-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 알아내고자 한다.
/*
    1. 등가조인()/내부조인
    - 연결시키고자 하는 컬림의 값이 "일치"하는 행들만 조인
    
    [표현법]
    등가조인 (오라클 구문)]
    SELECT 조회하고자 하는 칼럼명들 나열
    FROM 조인 하고자 하는 테이블명 나열
    WHERE 연결할 칼럼에대한 조건을 제시
    
    내부조인(ANSI구문)
    SELECT 칼럼명들
    FROM 테이블1
    JOIN 조인할테이블2 [ON/USING]연결할 칼럼에대한 조건을 제시
*/
-- 오라클 전용구문
-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 알아내고자 한다.
SELECT emp_id, EMP_NAME, J.job_code, JOB_NAME
FROM employee E, JOB J -- E,J는 별칭을 부여한거
WHERE E.job_code = J.job_code; -- 


-- 전체 사원들의 사번, 사원명, 부서코드, 부서명을 조회
SELECT emp_id, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM employee, department
WHERE DEPT_CODE = DEPT_ID;

-- ANSI구문
-- ON구문
SELECT emp_id, EMP_NAME, E.job_code, JOB_NAME
FROM employee E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- USING구문
-- 조인할 두 테이블간의 컬럼명이 동일한 경우에만 사용이 가능한다.
-- 동일한 칼럼명 기준으로 각 행을 매칭시켜준다.
SELECT emp_id, EMP_NAME, job_code, JOB_NAME
FROM employee 
JOIN JOB USING(JOB_CODE);
-- employee와 JOB의 job_code를 하나로 합침

-- 자연조인(NATURAL JOIN) -- 실무에서는 안쓰나 (SQL시험에서는 알아야함)
-- 등가조인중 하나로, 동일한 타입과 칼럼명을 가진 칼럼을 조인조건으로 이용
-- 하는 조인문
SELECT emp_id, EMP_NAME, job_code, JOB_NAME
FROM employee 
NATURAL JOIN JOB;

-- 직급이 대리인 사원들의 다음 정보를 조회
-- 사번, 사원명, 월급, 직급명
SELECT emp_id, EMP_NAME, SALARY, JOB_NAME
FROM employee E, JOB J
WHERE E.job_code = J.job_code
AND JOB_NAME = '대리';

---------
SELECT *
FROM employee E
JOIN JOB J ON e.job_code = J.JOB_CODE
WHERE JOB_NAME = '대리';


--아래 문제를 오라클전용구문과 ANSI구문 모두 사용하여 실행
-- 1. 부서가 '인사관리부' 인 사원들의 사번, 사원명, 보너스를 조회
-- 오라클
SELECT emp_id, EMP_NAME, BONUS,e.dept_code, d.dept_title
FROM employee E, department D
WHERE E.dept_code = d.dept_ID
AND d.dept_title = '인사관리부';

-- ANSI
SELECT emp_id, EMP_NAME, BONUS
FROM employee
JOIN department ON (dept_code = DEPT_ID)
WHERE dept_title = '인사관리부';

-- 2. 부서가 '총무부' 가 아닌 사원들의 사원명, 급여, 입사일을 조회
-- 오라클
SELECT EMP_NAME, e.salary, e.hire_date, d.dept_title
FROM employee E, department D
WHERE E.dept_code = d.dept_ID
AND NOT d.dept_title = '총무부';

-- ANSI -- 되도록 이러한 방식으로 알기
SELECT EMP_NAME, e.salary, e.hire_date
FROM employee E
JOIN department D ON dept_code = DEPT_ID
WHERE NOT dept_title = '총무부';

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- 오라클
SELECT EMP_ID, e.emp_name, e.bonus, d.dept_title
FROM employee E, department D
WHERE E.dept_code = d.dept_ID
AND e.bonus IS NOT NULL;
-- ANSI
SELECT EMP_ID, e.emp_name, e.bonus, d.dept_title
FROM employee E
JOIN department D ON(E.dept_code = d.dept_ID)
WHERE e.bonus IS NOT NULL;

-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회
-- 오라클
SELECT e.emp_name, d.dept_id, d.dept_title, d.location_id
FROM employee E, department D, location L
WHERE E.dept_code = d.dept_ID AND
d.location_id = l.local_code;

SELECT d.dept_id, d.dept_title, d.location_id
FROM department D, location L
WHERE d.location_id = l.local_code; -- 12시 9분

-- ANSI
SELECT d.dept_id, d.dept_title, d.location_id
FROM department D
JOIN location L ON d.location_id = l.local_code;

/*
    2. 포괄조인 / 외부조인(OUTER JOIN)
    - 테이블간의 JOIN시 "일치하지 않는 행도" 포함시켜 조회하는 기능
    단, 반드시 LEFT/RIGHT를 지정해줘야한다.
*/
-- 전체사원의 이름, 급여, 부서명
-- ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM employee
--JOIN department ON(DEPT_CODE = DEPT_ID);
--LEFT OUTER JOIN department ON(DEPT_CODE = DEPT_ID); -- 일치하지 않는 행도 가져옴
--RIGHT OUTER JOIN department ON(DEPT_CODE = DEPT_ID);
LEFT /*OUTER*/ JOIN department ON(DEPT_CODE = DEPT_ID);

-- EMPLOYEE테이블을 기준으로 조회하여, 조인조건과 일치하는 경우/
-- 일치하지 않는경우 모두 조회되게 한다.

-- 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- LEFT
-- 기준으로 삼을 테이블의 반대 테이블의 컬럼명에 (+)를 붙여준다.

-- 2) RIGHT OUTER JOIN
-- ANSI
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN department ON (DEPT_CODE = DEPT_ID);

-- 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; -- RIGHT

-- 3) FULL OUTER JOIN
-- 두 테이블이 가진 모든행으 조회하는 조인문
-- ORACLE문법에는 존재하지 않고 ANSI문에서만 사용 가능
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

/*
    3. 카테시안의 곱/ 교차조인 
     - 모든 테이블의 각 행들이 서로 매핑된 데이터를 반환(곱집합)
     - 즉, 두 테이블의 행들이 모두 곱해진 행들의 조합이 출력
*/-- 보통 분석용으로 쓰임
-- 사원명, 부서명
-- 오라클
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
ORDER BY 1;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

/*
    4. 비등가 조인(NON EQUAL JOIN)
     - '='를 사용하지 않는 모든 조인문
*/
-- 사원명, 급여, 급여등급 조회
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE, sal_grade S
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_NAME, SALARY, S.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL); -- US는 안됨
-- AND 1= 1;

/*
    5. SELF JOIN(자체조인)
    - 같은 테이블끼리의 조인(A JOIN A)
    - 자체조인을 사용할 경우 각 테이블에 "반드시" 별칭을 부여해야 한다.
    - 계층적인 구조의 데이터를 다룰때 주로 사용한다.

    계층적인 데이터 ?
    - 부장 팀장 과장 대리 처럼 계급(계층)이 있는 데이터
*/
-- 각 사원의 사번, 사원명, 사수의 사번, 사수명
-- 오라클
SELECT E.EMP_ID ,E.EMP_NAME, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID
ORDER BY 1;

-- ANSI 구문
SELECT E.EMP_ID ,E.EMP_NAME, M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

/*
    <다중 JOIN>
     - 3개 이상의 테이블을 조인하는 조인문
*/
-- 사번, 사원명, 부서명, 직급명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE e.dept_code = DEPT_ID(+) AND
E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);








