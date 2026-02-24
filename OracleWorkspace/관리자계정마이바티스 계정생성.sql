/*
    관리자 계정에서 마이바티스 유저 게정 생성
*/
CREATE USER MYBATIS IDENTIFIED BY MYBATIS;
GRANT CONNECT, RESOURCE, CREATE SYNONYM TO MYBATIS;

GRANT ALL ON KH.EMPLOYEE TO MYBATIS;
GRANT SELECT ON KH.DEPARTMENT TO MYBATIS;
GRANT SELECT ON KH.JOB TO MYBATIS;

--=============================
-- mybatis 계정
--=============================
create table student(
    no number,
    name varchar2(100) not null,
    tel char(11) not null,
    reg_date date default sysdate,
    constraint pk_student_no primary key(no)
);

create sequence seq_student_no;

-- 동의어 생성
create synonym emp for kh.employee;
create synonym dept for kh.department;
create synonym job for kh.job;
