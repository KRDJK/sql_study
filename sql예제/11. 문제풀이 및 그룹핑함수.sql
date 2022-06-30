

CREATE TABLE ǰ�����׸�_101 (
    ���׸�ID CHAR(7)
    , ���׸�� VARCHAR2(50)
    , CONSTRAINT ǰ�����׸�_101_PK PRIMARY KEY (���׸�ID)
);

CREATE TABLE �򰡴���ǰ_101 (
    ��ǰID CHAR(7)
    , ��ǰ�� VARCHAR2(50)
    , CONSTRAINT �򰡴���ǰ_101_PK PRIMARY KEY (��ǰID)
);

CREATE TABLE �򰡰��_101 (
    ��ǰID CHAR(7)
    , ��ȸ�� NUMBER
    , ���׸�ID CHAR(7)
    , �򰡵�� CHAR(1)
    , ������ CHAR(8)
    , CONSTRAINT �򰡰��_101_PK PRIMARY KEY (��ǰID, ��ȸ��, ���׸�ID)
);

INSERT INTO ǰ�����׸�_101 VALUES ('101', '�����ڷ�');
INSERT INTO ǰ�����׸�_101 VALUES ('102', '����ü�');

INSERT INTO �򰡴���ǰ_101 VALUES ('101', '�ڹټ���');
INSERT INTO �򰡴���ǰ_101 VALUES ('102', '���̽����');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('101', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('101', 3, '102', 'S', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '101', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '101', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '101', 'B', '20220629');

INSERT INTO �򰡰��_101 VALUES ('102', 1, '102', 'B', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 2, '102', 'A', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 3, '102', 'S', '20220629');
INSERT INTO �򰡰��_101 VALUES ('102', 4, '102', 'C', '20220629');

COMMIT;


SELECT * FROM "�򰡴���ǰ_101";
SELECT * FROM "ǰ�����׸�_101";
SELECT * FROM "�򰡰��_101";


-- 101�� ����
-- ���� 2��
--SELECT
--    B.��ǰID, B.��ǰ��,  C.���׸�ID, C.���׸��, A.��ȸ��, A.�򰡵��, A.������
--FROM �򰡰��_101 A, �򰡴���ǰ_101 B, ǰ�����׸�_101 C
--WHERE A.��ǰID = B.��ǰID
--    AND
--       
--;



--103�� VIEW
-- ���̺� ����
-- ���̺� ���� (CTAS)  : CREATE TABLE AS SELECT (SELECT���� ��ȸ�� ������ ������ VIEW�� �����Ѵ�.)	
CREATE TABLE tb_emp_copy
AS
SELECT emp_no, emp_nm, addr
FROM tb_emp;

SELECT * FROM tb_emp_copy;


-- �� ���� (cvas) : create view as select
-- ��ü�� ���� ������ view�� ������Ʈ�� alter�� ���̺� ������ �����ϴ� ���� �Ұ����ϴ�. delete�� �ǳ�?? ������ �־..?

CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;


SELECT * FROM tb_emp;
SELECT * FROM tb_emp_view;


DELETE FROM tb_emp_view -- ������ ���⼭ �����ϸ� ���������� �����Ǹ� �ȵȴٰ� �ϳ� ����Ŭ������ ������ �����ϰ� ���ִ� ���ϴ�.
WHERE emp_nm = '������'
;

rollback;

-- GROUP BY ���� �� �� �ִ� �׷����Լ�
-- 1. ROLLUP(col_a, col_b) - 3���� �÷��� ��ȸ��.
--    : col_a�� �׷�����ؼ� ���, col_a + col_b�� ���ļ� �׷���� ���, ��ü ���

-- 2. CUBE(col_a, col_b) - 4���� �÷��� ��ȸ��
--    : col_a�� �׷���� ���, col_b�� �׷���� ���, col_a + col_b���, ��ü ���

-- 3. GROUPING SETS(col_a, col_b)
--    : col_a�� ���, col_b�� ���


-- SELECT���� ���� GROUPING �Լ�
--  : �Լ��� ���ڰ��� NULL�̸� 1 ����, �ƴϸ� 0 ����
--      ex )) GROUPING(manager_id) = manager_id�� null�̸� 1 ����


-- ������ �굵 �߰��ؾ���.
CREATE TABLE PERSON (
    ssn CHAR(14) PRIMARY KEY
    , person_name VARCHAR2(30) NOT NULL
    , age NUMBER NOT NULL
);

SELECT * FROM person; -- �׽�Ʈ �غ� ������ �� �߰� �ǳ�, ����, ������ �� ��














