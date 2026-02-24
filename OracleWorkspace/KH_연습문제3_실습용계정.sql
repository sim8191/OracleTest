-- 연습문제
-- 1 70년대생
SELECT emp_name, EMP_NO, d.dept_title, J.JOB_NAME
FROM employee E, JOB J, DEPARTMENT D
WHERE D.dept_ID = E.DEPT_CODE
AND J.JOB_CODE = e.job_code
AND EMP_NAME LIKE '전%'
AND SUBSTR(EMP_NO, 8, 1) IN (2,4)
AND SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79;
--
SELECT emp_name, EMP_NO, dept_title, JOB_NAME
FROM employee E
LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
JOIN JOB J ON J.JOB_CODE = e.job_code
AND SUBSTR(EMP_NO, 8, 1) IN (2,4)
AND SUBSTR(EMP_NO, 1, 1) = '7'
AND SUBSTR(EMP_NAME, 1, 1) = '전';

-- 2
SELECT *
FROM employee;
--
SELECT emp_ID, EMP_NAME,
    EXTRACT(YEAR FROM SYSDATE)-
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', 19, '2', 19, 20)||SUBSTR(EMP_NO, 1, 2) 나이
--    EXTRACT(YEAR FROM SUBSTR(EMP_NO, 1, 2))
, DEPT_TITLE, JOB_NAME
FROM employee E
LEFT JOIN department D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
ORDER BY 3;
--WHERE ROWNUM = 1; -- 여기 놓침

-- 3
SELECT e.emp_id, emp_name, d.dept_title, J.JOB_NAME
FROM employee E, JOB J, DEPARTMENT D
WHERE D.dept_ID = E.DEPT_CODE
AND J.JOB_CODE = e.job_code
AND EMP_NAME LIKE '%형%';
--
SELECT emp_id, emp_name, JOB_NAME
FROM employee 
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

--4
SELECT emp_name, J.JOB_NAME, E.dept_CODE, d.dept_title
FROM employee E, JOB J, DEPARTMENT D
WHERE D.dept_ID = E.DEPT_CODE
AND J.JOB_CODE = e.job_code
AND E.dept_CODE IN ('D5','D6');
--
SELECT emp_name, JOB_NAME, E.dept_CODE, d.dept_title
FROM employee E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE E.dept_CODE IN ('D5','D6');

--5
SELECT emp_name, e.bonus, d.dept_title, l.local_name
FROM employee E, DEPARTMENT D, location L
WHERE D.dept_ID = E.DEPT_CODE
AND L.local_code = d.location_id
AND BONUS IS NOT NULL;
--
--선생님 풀이는 나중에 선생님이 주신 자료로 보기
--LEFT JOIN 해서 하동훈까지 보기게 할수 있음 9시 40분

--6 22명 나와야함
SELECT emp_name, J.JOB_NAME, d.dept_title, l.local_name
FROM employee E, DEPARTMENT D, JOB J, location L
WHERE D.dept_ID = E.DEPT_CODE
AND J.JOB_CODE = e.job_code
AND L.local_code = d.location_id;
--
SELECT emp_name, JOB_NAME, dept_title, local_name
FROM employee E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
LEFT JOIN DEPARTMENT D ON D.dept_ID = E.DEPT_CODE
LEFT JOIN  location L ON L.local_code = d.location_id;

-- 7 
SELECT emp_name, d.dept_title, l.local_name,n.national_name
FROM employee E, DEPARTMENT D, location L, NATION N
WHERE D.dept_ID = E.DEPT_CODE
AND L.local_code = d.location_id
AND N.national_CODE = L.NATIONAL_CODE
AND n.national_name IN ('한국','일본');
--
SELECT emp_name, d.dept_title, l.local_name, n.national_name
FROM employee E 
LEFT JOIN DEPARTMENT D ON  E.DEPT_CODE = D.dept_ID
LEFT JOIN location L ON L.local_code = d.location_id
LEFT JOIN NATION N USING(national_CODE)
WHERE n.national_name IN ('한국','일본');

--8

--
SELECT E1.emp_name, E1.DEPT_CODE, E2.EMP_NAME
FROM employee E1
JOIN employee E2 ON (E1.DEPT_CODE = E2.DEPT_CODE 
AND E1.EMP_ID != E2.EMP_ID)
ORDER BY 1;

--9 NVL이용문제
SELECT emp_name, e.bonus, d.dept_title, l.local_name
FROM employee E, DEPARTMENT D, location L
WHERE D.dept_ID = E.DEPT_CODE
AND L.local_code = d.location_id
AND BONUS IS NOT NULL;
--
SELECT emp_name, JOB_NAME, SALARY
FROM employee 
JOIN JOB USING(JOB_CODE)
WHERE JOB_CODE IN('J4','J7')
AND NVL(BONUS, 0) = 0;

--10 연봉이 높은 5명 (실무에서 로우 넘쓴다고함)

--
SELECT emp_name, JOB_NAME, SALARY, ROWNUM
FROM(
(SELECT emp_name, JOB_NAME, SALARY, ROWNUM
FROM employee
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING(JOB_CODE)
ORDER BY(SALARY + SALARY*NVL(BONUS,0)) * 12 DESC)
WHERE ROWNUM <= 5; -- 뻑남 나중에 확인해보기

--11

--11-1
SELECT DEPT_TITLE, SUM(SALARY)
FROM employee
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (
    SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE
);
--11-2
SELECT * FROM(
SELECT DEPT_TITLE, SUM(SALARY) AS 급여합
FROM employee
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE)
WHERE 급여합 > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);
--11-3
WITH EMP_SALARY AS(
SELECT DEPT_TITLE, SUM(SALARY) AS 급여합
FROM employee
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE)
SELECT *
FROM EMP_SALARY
WHERE 급여합 > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);

--12

--


--13

--
WITH EMP_SUMMARY AS (
    SELECT SUM(SALARY), AVG(SALARY)
    FROM EMPLOYEE
    UNION
    SELECT AVG(SALARY) FROM EMP_SUMMARY
)
SELECT * FROM EMP_SUMMARY; -- 뻑남








