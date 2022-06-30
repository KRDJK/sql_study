-- ���� ���̺� ����
CREATE TABLE employee (
  emp_no NUMBER(10) PRIMARY KEY
  , emp_nm VARCHAR(20) NOT NULL
  , emp_rank VARCHAR(20) DEFAULT '����' NOT NULL
  , bir_de DATE NOT NULL
  , salary NUMBER(7)
);

SELECT * FROM employee;

CREATE SEQUENCE seq_employee;
DROP SEQUENCE seq_employee;


ALTER TABLE employee
MODIFY (bir_de CHAR(8));

INSERT INTO employee VALUES (SEQ_EMPLOYEE.nextval, 'ȫ�浿', '����', '19680207', 4000000);
INSERT INTO employee VALUES (SEQ_EMPLOYEE.nextval, '������', '����', '19710822', 3000000);
COMMIT;


DELETE FROM employee;
COMMIT;



-- ���� ���̺� ����
CREATE TABLE schedule (
    schedule_no NUMBER(10) PRIMARY KEY
    , schedule_nm VARCHAR2(50) DEFAULT '����' NOT NULL
    , start_date CHAR(8) DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD') NOT NULL
    , end_date CHAR(8) DEFAULT '������' NOT NULL
    , manager_nm VARCHAR2(10) DEFAULT '����' NOT NULL
    , manager_no NUMBER(10) DEFAULT '����' NOT NULL
    , manager_rank VARCHAR2(10) NOT NULL
);

CREATE SEQUENCE seq_schedule;