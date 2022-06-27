



-- �߰����� 21��
CREATE TABLE tb_dept_21 (
    dept_no char(6)
    , dept_nm varchar2(150) not null
    , upper_dept_no char(6) null
    , constraint tb_dept_21_pk primary key (dept_no)
);

insert into tb_dept_21 values ('D00001', 'ȭ���', null);

insert into tb_dept_21 values ('D00002', '��������', 'D00001');
insert into tb_dept_21 values ('D00003', '�������', 'D00001');

insert into tb_dept_21 values ('D00004', '����������', 'D00002');
insert into tb_dept_21 values ('D00005', '�ؿܿ�����', 'D00002');

insert into tb_dept_21 values ('D00006', '���߻����', 'D00003');
insert into tb_dept_21 values ('D00007', '�����ͻ����', 'D00003');
commit;

SELECT 
    b.dept_no, b.dept_nm, b.upper_dept_no, a.upper_dept_no
FROM tb_dept_21 A
JOIN tb_dept_21 B
ON (B.upper_dept_no = A.dept_no)
WHERE A.upper_dept_no is null
ORDER BY b.dept_no
;

SELECT 
    *
FROM tb_dept_21 A
left JOIN tb_dept_21 B
ON (B.upper_dept_no = A.dept_no)
WHERE A.upper_dept_no is null
ORDER BY a.dept_no
;


SELECT 
    a.dept_no, a.dept_nm, a.upper_dept_no
FROM tb_dept_21 A
-- WHERE A.upper_dept_no is null
ORDER BY a.dept_no
;
-- end �߰� 21��



-- 9�� 
DROP TABLE T ;
CREATE TABLE T (
C INTEGER PRIMARY KEY, D INTEGER
);
INSERT INTO T VALUES (1 , 1);
INSERT INTO T VALUES (2 , 1);

CREATE TABLE S (
B INTEGER PRIMARY KEY, c INTEGER REFERENCES T(C) ON DELETE CASCADE 
);

INSERT INTO S VALUES (1 , 1);
INSERT INTO S VALUES (2 , 1);

CREATE TABLE R (
A INTEGER PRIMARY KEY, B INTEGER REFERENCES S(B) ON DELETE SET NULL
);

INSERT INTO R VALUES (1 , 1);
INSERT INTO R VALUES (2 , 2);

SELECT *FROM T ;
SELECT *FROM S ;
SELECT *FROM R ;

-- �Ҷ� 
DELETE FROM T ;

-- �� ���� ? 
SELECT *FROM R ;



-- #91��
DROP TABLE �μ�_91;

-- ���̺� �ۼ�
-- �μ����̺�
CREATE TABLE �μ�_91 (
 �μ��ڵ� VARCHAR2(20),
 �μ��� VARCHAR2(100),
 �����μ��ڵ� VARCHAR2(20),
 CONSTRAINT pk_�μ�_91 PRIMARY KEY(�μ��ڵ�)
);

-- fk ����
ALTER TABLE �μ�_91 
ADD CONSTRAINT fk_�����μ��ڵ�_91 
FOREIGN KEY (�����μ��ڵ�)
REFERENCES �μ�_91 (�μ��ڵ�);

INSERT INTO �μ�_91 VALUES(100, '�ƽþƺ�', NULL);
INSERT INTO �μ�_91 VALUES(110, '�ѱ�����', 100);
INSERT INTO �μ�_91 VALUES(111, '��������', 110);
INSERT INTO �μ�_91 VALUES(112, '�λ�����', 110);
INSERT INTO �μ�_91 VALUES(120, '�Ϻ�����', 100);
INSERT INTO �μ�_91 VALUES(121, '��������', 120);
INSERT INTO �μ�_91 VALUES(122, '����ī����', 120);
INSERT INTO �μ�_91 VALUES(130, '�߱�����', 100);
INSERT INTO �μ�_91 VALUES(131, '����¡����', 130);
INSERT INTO �μ�_91 VALUES(132, '����������', 130);
INSERT INTO �μ�_91 VALUES(200, '����������', NULL);
INSERT INTO �μ�_91 VALUES(210, '����������', 200);
INSERT INTO �μ�_91 VALUES(211, '���帮������', 210);
INSERT INTO �μ�_91 VALUES(212, '�׶󳪴�����', 210);
INSERT INTO �μ�_91 VALUES(220, '������������', 200);
INSERT INTO �μ�_91 VALUES(221, '����������', 220);
INSERT INTO �μ�_91 VALUES(222, '�׶󳪴�����', 220);

COMMIT;

-- ���� ���̺�
DROP TABLE ����_91;
CREATE TABLE ����_91(
�μ��ڵ� VARCHAR2(20),
����� NUMBER(20));

INSERT INTO ����_91 VALUES(111,1000);
INSERT INTO ����_91 VALUES(112,2000);
INSERT INTO ����_91 VALUES(121,1500);
INSERT INTO ����_91 VALUES(122,1000);
INSERT INTO ����_91 VALUES(131,1500);
INSERT INTO ����_91 VALUES(132,2000);
INSERT INTO ����_91 VALUES(211,2000);
INSERT INTO ����_91 VALUES(212,1500);
INSERT INTO ����_91 VALUES(221,1000);
INSERT INTO ����_91 VALUES(222,2000);
COMMIT;

SELECT * FROM �μ�_91;
SELECT * FROM ����_91;

-- ���� 1��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '120'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�
    UNION
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '120'
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�) 
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 2��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '100'
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�
    )
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 3��
SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    START WITH �μ��ڵ� = '121'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�)
    A LEFT OUTER JOIN ����_91 B
ON (A.�μ��ڵ� = B.�μ��ڵ�)
ORDER BY A.�μ��ڵ�;

-- ���� 4��

SELECT A.�μ��ڵ�, A.�μ���, A.�����μ��ڵ�, B.�����, LVL
FROM (
    SELECT �μ��ڵ�, �μ���, �����μ��ڵ�, LEVEL AS LVL
    FROM �μ�_91
    
    START WITH �μ��ڵ� =
    
    (SELECT �μ��ڵ� FROM �μ�_91
    WHERE �����μ��ڵ� IS NULL 
    START WITH �μ��ڵ� = '120'
    CONNECT BY PRIOR �����μ��ڵ� = �μ��ڵ�)
    
    CONNECT BY �����μ��ڵ� = PRIOR �μ��ڵ�)
    A LEFT OUTER JOIN ����_91 B
    ON (A.�μ��ڵ� = B.�μ��ڵ�)
    ORDER BY A.�μ��ڵ�;




-- 22�� 
CREATE TABLE �� (
    ��ID VARCHAR2(20) NOT NULL 
    , ���� VARCHAR(20) NULL 
    , �����Ͻ� DATE NOT NULL 
);
ALTER TABLE �� ADD CONSTRAINT PK_��ID PRIMARY KEY (��ID);

CREATE TABLE �ֹ� (
�ֹ���ȣ VARCHAR(20) NOT NULL  
, ��ID VARCHAR(20) NOT NULL
, �ֹ��Ͻ� DATE NOT NULL 
);

ALTER TABLE �ֹ� ADD CONSTRAINT FK_��ID FOREIGN KEY (��ID) REFERENCES ��(��ID);

INSERT INTO �� VALUES('C001','ȫ�浿','2013-12-12');
INSERT INTO �� VALUES('C002','�̼���','2013-12-12');

COMMIT;

INSERT INTO �ֹ� VALUES('0001','C001','2013-12-24');
INSERT INTO �ֹ� VALUES('0002','C001','2013-12-25');
INSERT INTO �ֹ� VALUES('0003','C002','2013-12-26');
INSERT INTO �ֹ� VALUES('0004','C002','2013-12-27');

SELECT * FROM �� ; 
SELECT * FROM �ֹ� ;  

