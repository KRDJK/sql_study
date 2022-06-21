-- UNDO�� 

-- DML : ������ ���۾�
-- SELECT(READ), INSERT(CREATE), UPDATE(U), DELETE(D)


INSERT INTO board
    (bno, title, content, writer, reg_date)
VALUES
    (1, '�����̾�~', '������~~~', '�Ѹ�', SYSDATE + 1);
    

-- NN(NOT NULL) �������� ���� - ���� ����
INSERT INTO board
    (bno, content, writer)
VALUES
    (2, '����ȣȣ~~~', '������');
    

-- PK�� UNIQUE �������� ����
INSERT INTO board
    (bno, title, writer)
VALUES
    (1, '����ȣȣ~~~', '������');    
    
    
INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '����ȣȣ����~~~', '±±��');   
    
    
-- �÷����� ������ ���, ������ ��� �÷����� ���� �־���� �Ѵ�. ���� �������!!    
INSERT INTO board
    
VALUES
    (3, '��������~@@~~~', '�в���', '���볻��!', SYSDATE + 30);      
    
    
    
-- ������ ����
UPDATE board
SET title = '������ �����̾�~'
WHERE bno = 3;
    
UPDATE board
SET writer = '������'
    , content = '�޷ո޷ո޷� fix'
WHERE bno = 2;

-- WHERE�� ������ �������� ��.. ��ü�� �����Ǿ� ����..
UPDATE board
SET writer = '���۳�';
    
    
-- ������ ���� : �� ���� ���� ����� ��!
DELETE FROM board
WHERE bno = 1; -- ���⼭�� where�� �����ϸ� ��ü ������ �ȴ�.. truncateó��!! ��ġ�� �ѹ� ����! TRUNCATE�� �ѹ� �Ұ�.. �Ф�


-- ��ü ������ ����
-- 1. WHERE���� ������ DELETE�� (Ŀ�Ը� ���ߴٸ� �ѹ� ����, ���� Ŀ�� ����, �α� ����� ����)
DELETE FROM board;   

-- 2. TRUNCATE TABLE 
-- (�ѹ� �Ұ���, �ڵ� Ŀ��, �α׸� ���� �� ����, ���̺� ���� �ʱ���·� ����)
TRUNCATE TABLE board;
-- ����! TRUNCATE TABLE�� �ϴ� ���� �׵��� Ŀ�� ���ϰ� �־����� �ڵ������� ���� �� Ŀ�ԵǾ����..


-- 3. DROP TABLE
-- (�ѹ� �Ұ���, �ڵ� Ŀ��, �α׸� ���� �� ����, ���̺� ������ ���� ������)
DROP TABLE board;
   
    
COMMIT;
ROLLBACK;

SELECT * FROM board;