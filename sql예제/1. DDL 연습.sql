
-- DDL : ������ ���Ǿ�
-- CREATE, ALTER, DROP, RENAME, TRUNCATE

DROP TABLE board; --DROP�� �ѹ��� ���� �ʴ´�. �ſ� �����ؼ� �ؾ���!!


-- CREATE TABLE : ���̺�(�������� ���� �ڷᱸ��)�� ����
CREATE TABLE board (
    bno NUMBER(10) -- �۹�ȣ�� ������ �־�� �ϰ� �ߺ��� ������ �ȵ�.
    , title VARCHAR2(200) NOT NULL
    , writer VARCHAR2(40) NOT NULL
    , content CLOB -- VARCHAR2�� 4õ����Ʈ �����̸鼭 ������ �Ѿ�� ������ �����ֱ� ������ �� Ŀ�������� ���� CLOB Ȱ��
    , reg_date DATE DEFAULT SYSDATE -- SYSDATE�� ���� �ð��� �ǹ��Ѵ�.
    , view_count NUMBER(10) DEFAULT 0
);


-- ALTER : �����ͺ��̽��� ������ ����

-- bno �÷� ����
ALTER TABLE board
MODIFY (bno NUMBER(10));


-- PK(PRIMARY KEY) ���� -- PK��ü�� NOT NULL�� UNIQUE�� �ִ�.
ALTER TABLE board
ADD CONSTRAINT pk_board_bno -- ADD CONSTRAINT ���������� �߰��ϰڴٴ� ��
PRIMARY KEY (bno);


-- ������ �߰�
INSERT INTO board
    (bno, title, writer, content)
VALUES
    (1, '�ȴ�?', '�ٲٱ��', '�����Ͼ����� ������'); -- Ȭ����ǥ�� �����.


INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '���ִ� ����', '����ȣȣ'); -- �����ݷи��� ��Ʈ�� ���� ����


COMMIT;


SELECT * FROM board;



-- �������� ���� (1:��, ��:1, 1:1 ��)
-- �Խù��� ����� ����
--   1   :  M


-- ��� ���̺� ����
CREATE TABLE REPLY (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10) -- ��� �Ҽ����� ���� �Խñ��� �۹�ȣ�� ��� �־�� �Ѵ�.
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK ����
);


-- �ܷ�Ű ���� (FOREIGN KEY) : ���̺� ���� ���� ���� ����
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);
-- ���� ���°� �ƴϴٺ��� ����� �ȳ� ���� �ִ�. �Ǽ��ϱ⺸�� �˻�  ����!!


-- �÷� ����
-- �÷� �߰�
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE); -- �߰��� �׳� ADD



-- �÷� ����
ALTER TABLE board
DROP COLUMN view_count; -- ���Ŵ� DROP COLUMN


-- �÷� ����
ALTER TABLE board
MODIFY (title VARCHAR2(500));


SELECT * FROM reply;


-- ���̺� ����
DROP TABLE reply; -- ���̺� ���� ��ü�� ���� ������ ���� ���� ����!
TRUNCATE TABLE board; -- ���̺� ���� ��ü ���� // ������ ���� ����
-- ����!! �̰͵� �ѹ� �Ұ�!





