CREATE TABLE score ( -- Repository layer : �����                       
-- ��ü?? model��ü(or ������ ��ü or ����Ƽ��ü?) :: � Ư�� ��ü�� �������� ������ ������ �־���.
    stu_num NUMBER(10), -- �л� �Ϸù�ȣ(�⼮��ȣ)
    stu_name VARCHAR2(20) NOT NULL, -- �л� �̸�
    kor NUMBER(3) NOT NULL, -- ���� ���� ����
    eng NUMBER(3) NOT NULL, -- ���� ����
    math NUMBER(3) NOT NULL, -- ���� ����
    total NUMBER(3), -- ����
    average NUMBER(5,2), -- ���
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- ���ӵ� ���� ����
CREATE SEQUENCE seq_score; -- [�ߺ� ����!!] �Ϸù�ȣ�� ����� ���� �� ����Ѵ�!!
    -- ������ ���̺��� �����, ~~~

SELECT * FROM score;

INSERT INTO score VALUES (seq_score.nextval,  'ȫ�浿', 90, 90, 90, 270, 90); -- �⺻Ű �Է� �κп� ������ Ȱ��
INSERT INTO score VALUES (seq_score.nextval,  '��ö��', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '�ڿ���', 100, 100, 100, 300, 100);
COMMIT;

SELECT AVG(average) AS avg_cls
FROM score;