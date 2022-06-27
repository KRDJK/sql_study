



-- 추가문제 21번
CREATE TABLE tb_dept_21 (
    dept_no char(6)
    , dept_nm varchar2(150) not null
    , upper_dept_no char(6) null
    , constraint tb_dept_21_pk primary key (dept_no)
);

insert into tb_dept_21 values ('D00001', '화장실', null);

insert into tb_dept_21 values ('D00002', '영업본부', 'D00001');
insert into tb_dept_21 values ('D00003', '기술본부', 'D00001');

insert into tb_dept_21 values ('D00004', '국내영업부', 'D00002');
insert into tb_dept_21 values ('D00005', '해외영업부', 'D00002');

insert into tb_dept_21 values ('D00006', '개발사업부', 'D00003');
insert into tb_dept_21 values ('D00007', '데이터사업부', 'D00003');
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
-- end 추가 21번



-- 9번 
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

-- 할때 
DELETE FROM T ;

-- 의 값은 ? 
SELECT *FROM R ;



-- #91번
DROP TABLE 부서_91;

-- 테이블 작성
-- 부서테이블
CREATE TABLE 부서_91 (
 부서코드 VARCHAR2(20),
 부서명 VARCHAR2(100),
 상위부서코드 VARCHAR2(20),
 CONSTRAINT pk_부서_91 PRIMARY KEY(부서코드)
);

-- fk 선언
ALTER TABLE 부서_91 
ADD CONSTRAINT fk_상위부서코드_91 
FOREIGN KEY (상위부서코드)
REFERENCES 부서_91 (부서코드);

INSERT INTO 부서_91 VALUES(100, '아시아부', NULL);
INSERT INTO 부서_91 VALUES(110, '한국지사', 100);
INSERT INTO 부서_91 VALUES(111, '서울지점', 110);
INSERT INTO 부서_91 VALUES(112, '부산지점', 110);
INSERT INTO 부서_91 VALUES(120, '일본지사', 100);
INSERT INTO 부서_91 VALUES(121, '도쿄지점', 120);
INSERT INTO 부서_91 VALUES(122, '오사카지점', 120);
INSERT INTO 부서_91 VALUES(130, '중국지사', 100);
INSERT INTO 부서_91 VALUES(131, '베이징지점', 130);
INSERT INTO 부서_91 VALUES(132, '상하이지점', 130);
INSERT INTO 부서_91 VALUES(200, '남유럽지부', NULL);
INSERT INTO 부서_91 VALUES(210, '스페인지사', 200);
INSERT INTO 부서_91 VALUES(211, '마드리드지점', 210);
INSERT INTO 부서_91 VALUES(212, '그라나다지점', 210);
INSERT INTO 부서_91 VALUES(220, '포루투갈지사', 200);
INSERT INTO 부서_91 VALUES(221, '리스본지점', 220);
INSERT INTO 부서_91 VALUES(222, '그라나다지점', 220);

COMMIT;

-- 매출 테이블
DROP TABLE 매출_91;
CREATE TABLE 매출_91(
부서코드 VARCHAR2(20),
매출액 NUMBER(20));

INSERT INTO 매출_91 VALUES(111,1000);
INSERT INTO 매출_91 VALUES(112,2000);
INSERT INTO 매출_91 VALUES(121,1500);
INSERT INTO 매출_91 VALUES(122,1000);
INSERT INTO 매출_91 VALUES(131,1500);
INSERT INTO 매출_91 VALUES(132,2000);
INSERT INTO 매출_91 VALUES(211,2000);
INSERT INTO 매출_91 VALUES(212,1500);
INSERT INTO 매출_91 VALUES(221,1000);
INSERT INTO 매출_91 VALUES(222,2000);
COMMIT;

SELECT * FROM 부서_91;
SELECT * FROM 매출_91;

-- 보기 1번
SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '120'
    CONNECT BY PRIOR 상위부서코드 = 부서코드
    UNION
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '120'
    CONNECT BY 상위부서코드 = PRIOR 부서코드) 
    A LEFT OUTER JOIN 매출_91 B
ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

-- 보기 2번
SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '100'
    CONNECT BY 상위부서코드 = PRIOR 부서코드
    )
    A LEFT OUTER JOIN 매출_91 B
ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

-- 보기 3번
SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    START WITH 부서코드 = '121'
    CONNECT BY PRIOR 상위부서코드 = 부서코드)
    A LEFT OUTER JOIN 매출_91 B
ON (A.부서코드 = B.부서코드)
ORDER BY A.부서코드;

-- 보기 4번

SELECT A.부서코드, A.부서명, A.상위부서코드, B.매출액, LVL
FROM (
    SELECT 부서코드, 부서명, 상위부서코드, LEVEL AS LVL
    FROM 부서_91
    
    START WITH 부서코드 =
    
    (SELECT 부서코드 FROM 부서_91
    WHERE 상위부서코드 IS NULL 
    START WITH 부서코드 = '120'
    CONNECT BY PRIOR 상위부서코드 = 부서코드)
    
    CONNECT BY 상위부서코드 = PRIOR 부서코드)
    A LEFT OUTER JOIN 매출_91 B
    ON (A.부서코드 = B.부서코드)
    ORDER BY A.부서코드;




-- 22번 
CREATE TABLE 고객 (
    고객ID VARCHAR2(20) NOT NULL 
    , 고객명 VARCHAR(20) NULL 
    , 가입일시 DATE NOT NULL 
);
ALTER TABLE 고객 ADD CONSTRAINT PK_고객ID PRIMARY KEY (고객ID);

CREATE TABLE 주문 (
주문번호 VARCHAR(20) NOT NULL  
, 고객ID VARCHAR(20) NOT NULL
, 주문일시 DATE NOT NULL 
);

ALTER TABLE 주문 ADD CONSTRAINT FK_고객ID FOREIGN KEY (고객ID) REFERENCES 고객(고객ID);

INSERT INTO 고객 VALUES('C001','홍길동','2013-12-12');
INSERT INTO 고객 VALUES('C002','이순신','2013-12-12');

COMMIT;

INSERT INTO 주문 VALUES('0001','C001','2013-12-24');
INSERT INTO 주문 VALUES('0002','C001','2013-12-25');
INSERT INTO 주문 VALUES('0003','C002','2013-12-26');
INSERT INTO 주문 VALUES('0004','C002','2013-12-27');

SELECT * FROM 고객 ; 
SELECT * FROM 주문 ;  

