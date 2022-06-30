

CREATE TABLE 품질평가항목_101 (
    평가항목ID CHAR(7)
    , 평가항목명 VARCHAR2(50)
    , CONSTRAINT 품질평가항목_101_PK PRIMARY KEY (평가항목ID)
);

CREATE TABLE 평가대상상품_101 (
    상품ID CHAR(7)
    , 상품명 VARCHAR2(50)
    , CONSTRAINT 평가대상상품_101_PK PRIMARY KEY (상품ID)
);

CREATE TABLE 평가결과_101 (
    상품ID CHAR(7)
    , 평가회차 NUMBER
    , 평가항목ID CHAR(7)
    , 평가등급 CHAR(1)
    , 평가일자 CHAR(8)
    , CONSTRAINT 평가결과_101_PK PRIMARY KEY (상품ID, 평가회차, 평가항목ID)
);

INSERT INTO 품질평가항목_101 VALUES ('101', '강의자료');
INSERT INTO 품질평가항목_101 VALUES ('102', '기관시설');

INSERT INTO 평가대상상품_101 VALUES ('101', '자바수업');
INSERT INTO 평가대상상품_101 VALUES ('102', '파이썬수업');

INSERT INTO 평가결과_101 VALUES ('101', 1, '101', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 2, '101', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 3, '101', 'B', '20220629');

INSERT INTO 평가결과_101 VALUES ('101', 1, '102', 'B', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 2, '102', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('101', 3, '102', 'S', '20220629');

INSERT INTO 평가결과_101 VALUES ('102', 1, '101', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 2, '101', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 3, '101', 'B', '20220629');

INSERT INTO 평가결과_101 VALUES ('102', 1, '102', 'B', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 2, '102', 'A', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 3, '102', 'S', '20220629');
INSERT INTO 평가결과_101 VALUES ('102', 4, '102', 'C', '20220629');

COMMIT;


SELECT * FROM "평가대상상품_101";
SELECT * FROM "품질평가항목_101";
SELECT * FROM "평가결과_101";


-- 101번 문제
-- 보기 2번
--SELECT
--    B.상품ID, B.상품명,  C.평가항목ID, C.평가항목명, A.평가회차, A.평가등급, A.평가일자
--FROM 평가결과_101 A, 평가대상상품_101 B, 품질평가항목_101 C
--WHERE A.상품ID = B.상품ID
--    AND
--       
--;



--103번 VIEW
-- 테이블 복사
-- 테이블 복사 (CTAS)  : CREATE TABLE AS SELECT (SELECT절로 조회한 내용을 가지고 VIEW를 생성한다.)	
CREATE TABLE tb_emp_copy
AS
SELECT emp_no, emp_nm, addr
FROM tb_emp;

SELECT * FROM tb_emp_copy;


-- 뷰 생성 (cvas) : create view as select
-- 실체가 없기 때문에 view에 업데이트나 alter로 테이블 구조를 변경하는 것이 불가능하다. delete는 되네?? 권한이 있어서..?

CREATE VIEW tb_emp_view
AS
SELECT emp_no, emp_nm, addr, dept_cd
FROM tb_emp;


SELECT * FROM tb_emp;
SELECT * FROM tb_emp_view;


DELETE FROM tb_emp_view -- 원래는 여기서 삭제하면 원본에서는 삭제되면 안된다고 하나 오라클에서는 삭제가 가능하게 해주는 듯하다.
WHERE emp_nm = '김종서'
;

rollback;

-- GROUP BY 절에 쓸 수 있는 그룹핑함수
-- 1. ROLLUP(col_a, col_b) - 3가지 컬럼이 조회됨.
--    : col_a로 그룹바이해서 통계, col_a + col_b를 합쳐서 그룹바이 통계, 전체 통계

-- 2. CUBE(col_a, col_b) - 4가지 컬럼이 조회됨
--    : col_a로 그룹바이 통계, col_b로 그룹바이 통계, col_a + col_b통계, 전체 통계

-- 3. GROUPING SETS(col_a, col_b)
--    : col_a로 통계, col_b로 통계


-- SELECT절에 쓰는 GROUPING 함수
--  : 함수의 인자값이 NULL이면 1 리턴, 아니면 0 리턴
--      ex )) GROUPING(manager_id) = manager_id가 null이면 1 리턴


-- 집에서 얘도 추가해야함.
CREATE TABLE PERSON (
    ssn CHAR(14) PRIMARY KEY
    , person_name VARCHAR2(30) NOT NULL
    , age NUMBER NOT NULL
);

SELECT * FROM person; -- 테스트 해볼 때마다 잘 추가 되네, 삭제, 수정도 잘 됨














