
-- DDL : 데이터 정의어
-- CREATE, ALTER, DROP, RENAME, TRUNCATE

DROP TABLE board; --DROP은 롤백이 되지 않는다. 매우 주의해서 해야함!!


-- CREATE TABLE : 테이블(데이터의 집합 자료구조)을 생성
CREATE TABLE board (
    bno NUMBER(10) -- 글번호는 무조건 있어야 하고 중복이 있으면 안됨.
    , title VARCHAR2(200) NOT NULL
    , writer VARCHAR2(40) NOT NULL
    , content CLOB -- VARCHAR2는 4천바이트 제한이면서 제한을 넘어가면 저장을 못해주기 때문에 더 커버범위가 넓은 CLOB 활용
    , reg_date DATE DEFAULT SYSDATE -- SYSDATE는 현재 시간을 의미한다.
    , view_count NUMBER(10) DEFAULT 0
);


-- ALTER : 데이터베이스의 구조를 변경

-- bno 컬럼 수정
ALTER TABLE board
MODIFY (bno NUMBER(10));


-- PK(PRIMARY KEY) 설정 -- PK자체에 NOT NULL과 UNIQUE가 있다.
ALTER TABLE board
ADD CONSTRAINT pk_board_bno -- ADD CONSTRAINT 제약조건을 추가하겠다는 뜻
PRIMARY KEY (bno);


-- 데이터 추가
INSERT INTO board
    (bno, title, writer, content)
VALUES
    (1, '안뇽?', '꾸꾸까까', '아하하아하하 ㅋㅋㅋ'); -- 홑따옴표로 써야함.


INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '맛있는 점심', '하하호호'); -- 세미콜론마다 컨트롤 엔터 가능


COMMIT;


SELECT * FROM board;



-- 연관관계 설정 (1:다, 다:1, 1:1 등)
-- 게시물과 댓글의 관계
--   1   :  M


-- 댓글 테이블 생성
CREATE TABLE REPLY (
    rno NUMBER(10)
    , r_content VARCHAR2(400)
    , r_writer VARCHAR2(40) NOT NULL
    , bno NUMBER(10) -- 어디 소속인지 원본 게시글의 글번호를 들고 있어야 한다.
    , CONSTRAINT pk_reply_rno PRIMARY KEY (rno) -- PK 설정
);


-- 외래키 설정 (FOREIGN KEY) : 테이블 간의 관계 제약 설정
ALTER TABLE reply
ADD CONSTRAINT fk_reply_bno
FOREIGN KEY (bno)
REFERENCES board (bno);
-- 자주 쓰는게 아니다보니 기억이 안날 수도 있다. 실수하기보다 검색  먼저!!


-- 컬럼 변경
-- 컬럼 추가
ALTER TABLE reply
ADD (r_reg_date DATE DEFAULT SYSDATE); -- 추가는 그냥 ADD



-- 컬럼 제거
ALTER TABLE board
DROP COLUMN view_count; -- 제거는 DROP COLUMN


-- 컬럼 수정
ALTER TABLE board
MODIFY (title VARCHAR2(500));


SELECT * FROM reply;


-- 테이블 삭제
DROP TABLE reply; -- 테이블 구조 자체를 삭제 데이터 포함 구조 전부!
TRUNCATE TABLE board; -- 테이블 내부 전체 삭제 // 휴지통 비우기 느낌
-- 주의!! 이것도 롤백 불가!





