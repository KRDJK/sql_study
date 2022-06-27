-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 중요 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)

-- join은 가로로 합치는건데, 집합 연산자에선 세로로 합침.(테이블 간의 컬럼 수와 컬럼들의 데이터 타입이 같아야 함)

SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

SELECT
    emp_nm, birth_de --2개
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_nm, birth_de --3개. 이러면 실행시 오류난다.
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

SELECT
    emp_nm EN, birth_de BD
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
--ORDER BY 이 위치에서 하면 안됨
UNION
SELECT
    emp_nm EN2, birth_de BD2 -- 밑에 별칭이 무시되고 위에 기준으로 나옴.
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
ORDER BY BD DESC -- UNION이 끝난 후에 정렬을 시도해야 함.
;


-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.

SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;


-- 교집합, 차집합은 개념만 알고 있으면 된다고 함.
-- ## INTERSECT
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD' -- SQLD 자격증 딴 사람을 보고자 함.
INTERSECT -- 교집합을 걸어버리면 용인에 살면서 SQLD 자격증을 딴 사람을 보고자 함.
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'; -- 용인 사는 사원들이 딴 자격증 목록을 보고자 함.


-- 이게 더 간편하나 억지로 교집합을 쓴 것
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;



-- 계층형 쿼리
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건
-- CONNECT BY PRIOR 자식 = 부모 -> 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모 -> 역방향 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함.
SELECT 
    LEVEL AS LVL, -- 가상 컬럼
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    -- 레벨에 따라 공백을 채워라 레벨이 1이면 0, 2면 4칸, 3이면 8칸 ... 
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF -- 잎새노드냐고 묻는 것, 자식 노드가 없는 경우. 얘도 가상 컬럼
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL -- 핵심 구문 1. 계층 레벨의 첫 단계가 직속상사번호 NULL인 애부터 시작해라.
-- 핵심구문 1 : 누가 ROOT 노드가 될 것인지를 정한다고 보면 된다. 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no -- 핵심 구문 2. 전개 방향을 어디로 짤 것인가??
-- 부모에서부터 자식으로 내려가면서 탐색하면 순방향 탐색, 자식에서부터 올라가면서 탐색하면 역방향 탐색이라고 한다.
-- 이 경우는 PRIOR가 자식에 붙었기 때문에 루트 노드부터 위에서 아래로 순방향으로 가겠다는 뜻이다.
ORDER SIBLINGS BY A.emp_no DESC
;




SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;



-- # SELF JOIN
-- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법.
-- 2. 자기 자신 테이블에서 PK와 FK로 동등 조인한다.

SELECT
    a.emp_no
    , a.emp_nm 사원명
    , a.addr "사원 주소"
    , a.direct_manager_emp_no 
    , b.emp_nm "직속 상사 사원명"
    , b.addr "직속 상사 주소"
FROM tb_emp A
--WHERE dept_cd = '100002'
LEFT JOIN tb_emp B-- 자기 테이블과의 조인 (셀프 조인)
ON a.direct_manager_emp_no = b.emp_no
ORDER BY emp_no
;



ALTER TABLE tb_emp
ADD CONSTRAINT fk_dm_emp_no
FOREIGN KEY (direct_manager_emp_no)
REFERENCES tb_emp(emp_no)
;











