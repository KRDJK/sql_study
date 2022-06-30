-- 직원 테이블 생성
CREATE TABLE employee (
  emp_no NUMBER(10) PRIMARY KEY
  , emp_nm VARCHAR(20) NOT NULL
  , emp_rank VARCHAR(20) DEFAULT '미정' NOT NULL
  , bir_de DATE NOT NULL
  , salary NUMBER(7)
);

SELECT * FROM employee;

CREATE SEQUENCE seq_employee;
DROP SEQUENCE seq_employee;


ALTER TABLE employee
MODIFY (bir_de CHAR(8));

INSERT INTO employee VALUES (SEQ_EMPLOYEE.nextval, '홍길동', '부장', '19680207', 4000000);
INSERT INTO employee VALUES (SEQ_EMPLOYEE.nextval, '유관순', '과장', '19710822', 3000000);
COMMIT;


DELETE FROM employee;
COMMIT;



-- 일정 테이블 생성
DROP TABLE schedule;
CREATE TABLE schedule (
    schedule_no NUMBER(10) PRIMARY KEY
    , schedule_nm VARCHAR2(50) NOT NULL
    , start_date CHAR(8) DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD') NOT NULL
    , end_date CHAR(8) NOT NULL
    , manager_nm VARCHAR2(10) NOT NULL
    --, manager_no NUMBER(10) DEFAULT '미정' NOT NULL
    , manager_rank VARCHAR2(10) NOT NULL
);

SELECT * FROM schedule;

CREATE SEQUENCE seq_schedule;
DROP SEQUENCE seq_schedule;

INSERT INTO schedule
VALUES 
    (seq_schedule.nextval, '테스트 일정', '20220630', '20220701', '김동진', '사원')
;
COMMIT;
