-- 3-1.
-- CREATE TABLE 권한 부여받기 전
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 3-2
-- CREATE TABLE 권한 부여받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- no privileges on tablespace 'SYSTEM'
-- SAMPLE계정에는 TABLESPACE가 할당되지 않아 오류 발생

-- 테이블저장공간을 할당받은 후(2M)
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블생성권한 부여받게 되면, 현제 계정이 소유하고 있는 테이블을 조작(DML)하는 것도
-- 가능해진다
INSERT INTO TEST VALUES(1);
SELECT * FROM TEST;


-- 4. 뷰생성권한 부여받은 후
CREATE TABLE V_TEST AS SELECT * FROM TEST;

SELECT * FROM V_TEST;

-- 5. SAMPLE계정에서 KH계정의 테이블에 접근해서 조회
SELECT * FROM KH.EMPLOYEE; -- 접근권한이 없으면 오류

-- 6. KH.DEPARTMENT테이블 조회
SELECT * FROM KH.DEPARTMENT;
INSERT INTO KH.DEPARTMENT VALUES ('D0','회계부','L2'); -- 뻑남 다시해보기
COMMIT;

-- 7. 권한 회수후 테이블 생성
CREATE TABLE TEST3(
    TEST_ID NUMBER
);


