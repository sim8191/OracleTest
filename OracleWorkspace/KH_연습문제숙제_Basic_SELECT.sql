-- 1
SELECT department_name, category
FROM TB_DEPARTMENT;

-- 2
SELECT department_name || '의 정원은 ' ||  capacity || '명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT;

-- 3
SELECT * FROM tb_department WHERE department_name = '국어국문학과';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001
AND SUBSTR(STUDENT_SSN, 8, 1) IN (2, 4) 
--AND STUDENT_SSN LIKE '_______2%' -- 선생님 풀이
AND ABSENCE_YN = 'Y';

-- 4
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119');

-- 5
SELECT department_name, category
FROM tb_department
--WHERE CAPACITY <= 30 AND CAPACITY >= 20;
WHERE CAPACITY BETWEEN 20 AND 30;

--6
SELECT PROFESSOR_NAME
FROM tb_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7
--SELECT student_name
--FROM tb_student
--WHERE COACH_PROFESSOR_NO IS NULL;
SELECT student_name
FROM tb_student
WHERE department_no IS NULL;
--이거는 결과값이 안나와야함(학과 설정이 다잘 들어가 있음)

--8
SELECT CLASS_NO
FROM tb_class
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9
SELECT DISTINCT CATEGORY
FROM tb_department;

--10
SELECT student_no, student_name, student_ssn
FROM tb_student
WHERE student_address LIKE '%전주%' 
AND ABSENCE_YN = 'N' 
AND entrance_date BETWEEN '02/01/01' AND  '03/01/01';

SELECT student_no, student_name, student_ssn
FROM tb_student
WHERE student_NO LIKE 'A2%'
AND student_address LIKE '%전주%'
AND ABSENCE_YN = 'N';











