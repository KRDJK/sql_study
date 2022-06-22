

-- WHERE 조건절 : 조회 결과 '행'을 제한하는 조건절
SELECT
    emp_no, emp_nm, addr, sex_cd -- 이 줄에 쓰는건 열을 제한하는 것이다.
FROM tb_emp
WHERE sex_cd = 2; -- 행을 제한


-- PK로 WHERE절 동등조건을 만들면 반드시 단일행이 조회된다.
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000003;


-- 비교 연산자
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101'
    AND birth_de <= '19991231';


-- BETWEEN 연산자 (NOT BETWEEN도 있다)
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231';


-- OR 연산
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
    OR dept_cd = '100006';


-- IN 연산자 (이 경우, OR연산과 동일하다)
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN ('100004', '100006');


-- NOT IN 연산자 (걔네 빼고 전부!)
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN ('100004', '100006');


-- LIKE 연산자 (주로 내용으로 검색, 제목으로 검색 등 검색시 많이 사용)
-- 와일드 카드 맵핑 (% : 0글자 이상, _ : 단 1글자만)
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이%'; -- '이'로 시작하는~ 이라는 뜻


SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%심'; -- 끝이 무조건 심으로 끝나야 함


SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%용인%';


-- 성씨가 김씨이면서, 부서가 100003, 100004, 100006번 중에 하나이면서, 
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드를 조회
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE 1=1 -- 실무적 팁. 무조건 만족하는 조건
    AND emp_nm LIKE '김%'
    AND dept_cd IN ('100003', '100004', '100006')
    AND birth_de BETWEEN '19900101' AND '19991231'
;


-- 부정 일치 비교 연산자 (아래 경우들이 다 같은 결과를 도출하지만 보통 오라클에서 <>를 많이 쓴다.)
SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd != 2
;


SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd ^= 2 -- !=과 같은 효과다
;


SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd <> 2 -- 이것도 !=, ^=과 같다.
;


SELECT
    emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE NOT sex_cd = 2
;


-- 성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의
-- 사번, 이름, 성별코드를 조회하세요.
SELECT
    emp_no, emp_nm, sex_cd
FROM tb_emp
WHERE 1=1
    AND sex_cd <> 1
    AND emp_nm NOT LIKE '이%'
;


-- null값 조회 : 반드시 IS NULL 연산자로 조회
SELECT
    emp_no, emp_nm, direct_manager_emp_no -- 직속 상사의 사번
FROM tb_emp
WHERE direct_manager_emp_no IS NULL
;

SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL
;


-- 연산자  우선순위 : NOT > AND > OR
-- 사원정보 중에서 김씨이면서 수원 또는 일산에 사는 사원들의 정보를 조회하고 싶으면??
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE 1=1
    AND emp_nm LIKE '김%'
    AND (addr LIKE '%수원%' OR addr LIKE '%일산%') 
    -- 괄호를 하지 않으면 김씨면서 수원사는 애를 거르고, 또는! 그냥 일산 사는애.. 이런 식으로 되어버린다.
;





