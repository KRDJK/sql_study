

-- SELECT 기본
SELECT
    emp_no, emp_nm
FROM tb_emp;

SELECT
    certi_cd, certi_nm
FROM tb_certi;

SELECT 
    *
FROM tb_dept;

SELECT
    emp_nm, emp_no -- 순서가 바뀌면 조회할 때도 바뀐 순서로 나올 뿐, 정상 조회된다. // 실제 데이터엔 영향 없다
FROM tb_emp;


-- DISTINCT : 중복값을 제외하고 조회
SELECT ALL
    issue_insti_nm
FROM tb_certi;


SELECT DISTINCT
    issue_insti_nm
FROM tb_certi;


SELECT DISTINCT
    certi_nm, issue_insti_nm -- 두 가지 다 중복되는 경우를 제외해준다.
FROM tb_certi;


-- 열 별칭 (column alias) 지정
SELECT
    certi_cd AS "자격증 코드" -- AS는 항상 생략가능하다.
    , certi_nm AS 자격증명 -- ""은 띄어쓰기를 쓸거면 무조건 쌍따옴표를 써야한다. 그게 아니라면 그냥 써도 된다.
    , issue_insti_nm 발급기관명
FROM tb_certi; 


-- 문자열 결합 연산자 ||(역슬래시)
-- ex) SQLLD (100002) - 한국데이터진흥원 
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm "자격증 정보"
FROM tb_certi;


-- 더미 테이블 (dual) : 단순 연산결과를 조회할 때 사용
-- 내부적으로 오라클에서 만들어둔 테이블
SELECT
    3 * 7 "연산 결과"
FROM dual;

SELECT
    SYSDATE "현재 날짜"
FROM dual;







