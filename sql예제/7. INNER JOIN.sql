

-- 사원들의 사번, 이름, 주소, 부서명
SELECT
    E.emp_no, E.emp_nm, E.addr, D.dept_nm
FROM tb_emp E
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
;


-- 조인 기초 테스트 데이터
CREATE TABLE TEST_A ( -- 가칭 : 게시판 테이블
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B ( -- 가칭 : 댓글 테이블
    b_id NUMBER(10) PRIMARY KEY -- 댓글 번호
    , reply VARCHAR2(100)
    , a_id NUMBER(10) -- 원본 글번호(FK 역할을 함)
);

INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);
COMMIT;


SELECT * FROM test_a; -- 3줄
SELECT * FROM test_b; -- 4줄


-- JOIN은 각 테이블들을 가로로 합치는 듯한 느낌이다. (3x4가 된다)
SELECT
    *
FROM test_a, test_b -- 두 테이블을 조인하라는 문법이다.
; -- 이 결과는 조인의 제약조건이 따로 없기 때문에 전부 다 크로스한다. (중첩 for문 같이)
-- Cartesion product(카테시안 곱)라고도 하며, cross join이라고도 한다.


-- INNER JOIN (EQUI JOIN의 한 종류) : 두 테이블에서 서로 매칭되는 것만 조인하는 것.
SELECT
    *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id -- 서로 일치하는 내용만 가져와라는 JOIN 조건
;



SELECT
    test_a.id, test_a.content, test_b.reply -- 똑같은 컬럼명이 있을 것을 대비해서 테이블 명을 명시하는 것이 좋다.
FROM test_a, test_b
WHERE test_a.id = test_b.a_id
;

-- 별칭을 부여한 버전
SELECT
    A.id, A.content, B.reply
FROM test_a A, test_b B
WHERE A.id = B.a_id
;


-- 자격증 관련 테이블
SELECT * FROM tb_emp_certi; -- 사원 자격증 테이블
SELECT * FROM tb_certi; -- 그냥 자격증 테이블


-- 사원의 사원번호와 취득 자격증명을 조회하고 싶음
SELECT
    A.emp_no, B.certi_nm
FROM tb_emp_certi A, tb_certi B
WHERE A.certi_cd = B.certi_cd -- 매칭 조건
ORDER BY A.emp_no, B.certi_cd
;

-- 사원의 사원번호와 사원이름과 취득 자격증명을 조회하고 싶으면??
SELECT
    A.emp_no, C.emp_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
ORDER BY A.emp_no, B.certi_cd
;

-- 사원의 사원번호와 사원이름과 부서이름과 취득 자격증명을 조회하고 싶으면??
SELECT
    A.emp_no, C.emp_nm, D.dept_nm, B.certi_nm
FROM tb_emp_certi A, tb_certi B, tb_emp C, tb_dept D
WHERE A.certi_cd = B.certi_cd
    AND A.emp_no = C.emp_no
    AND C.dept_cd = D.dept_cd
ORDER BY A.emp_no, B.certi_cd
;


-- 부서별 총 자격증 취득 수를 조회
SELECT
    B.dept_cd, C.dept_nm, COUNT(A.certi_cd) "부서별 자격증 수"
FROM tb_emp_certi A, tb_emp B, tb_dept C
WHERE A.emp_no = B.emp_no
    AND B.dept_cd = C.dept_cd
GROUP BY B.dept_cd, C.dept_nm
ORDER BY B.dept_cd
;


-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

-- 용인시에 사는 사원의 사원번호, 사원명, 주소, 부서코드, 부서명을 조회하고 싶다.
SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A, tb_dept B
WHERE A.addr LIKE '%용인%'
    AND A.dept_cd = B.dept_cd
    AND A.emp_nm LIKE '김%'
ORDER BY A.emp_no
; -- 오라클의 inner join방식이라 다른 곳에서는 먹히지 않을 수 있다.

-- join 테이블의 수가 n개면 join 조건의 수가 n-1개가 되는 패턴이 발생한다.



-- JOIN ON (ANSI 표준 조인)
-- 1. FROM절 뒤, WHERE절 앞에 위치
-- 2. JOIN 키워드 뒤에는 조인할 테이블명을 명시
-- 3. ON 키워드 뒤에는 조인 조건을 명시
-- 4. JOIN 조건 서술부(ON절) 일반 조건 서술부(WHERE절)를 분리해서 작성하는 방법
-- 5. ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능.
SELECT 
    A.emp_no, A.emp_nm, A.addr, A.dept_cd, B.dept_nm
FROM tb_emp A 
INNER JOIN tb_dept B -- INNER가 생략 가능 (아무것도 안쓴 기본값이 INNER다)
ON A.dept_cd = B.dept_cd
WHERE A.addr LIKE '%용인%'
    AND A.emp_nm LIKE '김%'
ORDER BY A.emp_no
;

-- 1980년대생 사원들의 사번, 사원명, 부서명, 자격증명, 취득일자를 조회
SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E, tb_dept D, tb_emp_certi EC, tb_certi C
WHERE E.dept_cd = D.dept_cd
    AND EC.certi_cd = C.certi_cd
    AND E.emp_no = EC.emp_no
    AND E.birth_de BETWEEN '19800101' AND '19891231'
;

SELECT
    E.emp_no, E.emp_nm, E.birth_de, D.dept_nm, C.certi_nm, EC.acqu_de
FROM tb_emp E 
JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON EC.certi_cd = C.certi_cd
WHERE E.birth_de BETWEEN '19800101' AND '19891231'
;


-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];



-- JOIN ON 구문으로 카테시안 곱 만들기
SELECT 
    *
FROM test_a A, test_B b
;

SELECT 
    *
FROM test_a A 
CROSS JOIN test_B b
;


-- # NATURAL JOIN
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, 
--    ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4. SELECT * 문법을 사용하면, 공통 컬럼은 집합에서 한번만 표기됩니다.
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.(주의)

-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)
SELECT 
    A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;


SELECT 
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm
FROM tb_emp A
NATURAL JOIN tb_dept B
;

-- # USING절 조인
-- 1. NATURAL조인에서는 자동으로 이름과 타입이 일치하는 모든 컬럼에 대해
--    조인이 일어나지만 USING을 사용하면 원하는 컬럼에 대해서면 선택적 조인조건을 
--    부여할 수 있습니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.
SELECT 
    A.emp_no, A.emp_nm, dept_cd, B.dept_nm
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd)
;


-- ALIAS를 쓰면 안되는 이유
SELECT 
    *
FROM tb_emp A
INNER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
;


SELECT 
    *
FROM tb_emp A
NATURAL JOIN tb_dept B
;

SELECT 
    *
FROM tb_emp A
INNER JOIN tb_dept B
USING (dept_cd)
;


