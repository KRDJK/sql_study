

CREATE TABLE ���ں�����_93 (
    ���� DATE,
    ����� NUMBER(5)
);

INSERT INTO ���ں�����_93 VALUES ('2015-11-01', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-02', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-03', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-04', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-05', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-06', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-07', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-08', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-09', 1000);
INSERT INTO ���ں�����_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT * FROM ���ں�����_93;

-- ���� 1��

SELECT A.����, SUM(A.�����) AS ���������
FROM ���ں�����_93 A
GROUP BY A.����
ORDER BY A.����
;

-- ���� 2��
SELECT B.����, SUM(B.�����) AS ���������
FROM ���ں�����_93 A
JOIN ���ں�����_93 B 
ON (A.���� >= B.����)
GROUP BY B.����
ORDER BY B.����;

-- GROUP BY�� �غ��� ����.
SELECT A.����, A.�����, B.����, B.�����
FROM ���ں�����_93 A
JOIN ���ں�����_93 B 
ON (A.���� >= B.����)
ORDER BY A.����;



-- 86��
drop table ȸ���⺻����_86;
drop table ȸ��������_86;
CREATE TABLE ȸ���⺻����_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE ȸ��������_86 (
    user_id VARCHAR2(200)
    
);
ALTER TABLE ȸ��������_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references ȸ���⺻����_86 (user_id);


INSERT INTO ȸ���⺻����_86 VALUES ('abc01');
INSERT INTO ȸ���⺻����_86 VALUES ('abc02');
INSERT INTO ȸ���⺻����_86 VALUES ('abc03');
COMMIT;

INSERT INTO ȸ��������_86 VALUES ('abc01');
INSERT INTO ȸ��������_86 VALUES ('abc02');
INSERT INTO ȸ��������_86 VALUES ('abc03');
INSERT INTO ȸ��������_86 VALUES ('abc04');
COMMIT;



SELECT * FROM ȸ���⺻����_86;
SELECT * FROM ȸ��������_86;

-- ���� 1
SELECT user_id FROM ȸ���⺻����_86
MINUS
SELECT user_id FROM ȸ��������_86
;


-- ���� 2
SELECT user_id FROM ȸ���⺻����_86
UNION ALL
SELECT user_id FROM ȸ��������_86
;


-- ���� 3
SELECT user_id FROM ȸ���⺻����_86
INTERSECT
SELECT user_id FROM ȸ��������_86
;

SELECT A.user_id 
FROM ȸ���⺻����_86 A 
JOIN ȸ��������_86 B 
ON A.user_id = B.user_id
;

-- ���� 4
SELECT user_id FROM ȸ���⺻����_86
INTERSECT
SELECT user_id FROM ȸ��������_86
;

SELECT user_id FROM ȸ���⺻����_86
UNION
SELECT user_id FROM ȸ��������_86
;







