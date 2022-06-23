

-- 집계 함수 (다중행 함수)
-- : 여러 행을 묶어서 함수를 적용
SELECT * FROM tb_sal_his;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005' -- 5번 사원이 받은 급여 이력 조회
;


SELECT DISTINCT
    SUBSTR(emp_nm, 1, 1) 성씨
FROM tb_emp
;


-- GROUP BY로 소그룹화 하지 않으면 집계함수는 전체행수를 기준으로 집계한다.
SELECT
    SUM(pay_amt) "지급 총액"
    , AVG(pay_amt) "평균 지급액"
    , COUNT(pay_amt) "지급 횟수" -- 전체 행의 개수와 동일
FROM tb_sal_his
;


SELECT * FROM tb_emp;


SELECT
    COUNT(emp_no) "총 사원수"
    , MIN(birth_de) "최연장자의 생일"
    , MAX(birth_de) "최연소자의 생일"
    , COUNT(direct_manager_emp_no) "dmen"
FROM tb_emp;
-- count는 중복을 포함해서도 카운팅한다.
-- 그러나 null 값은 아예 배제하고 카운팅한다.
    -- but, count(*)이라고 하면 null도 카운팅 한다.
-- 평균 구할 때도 null을 아예 배제. 나눌 때의 수에도 반영 x



-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- WHERE절보다 뒤에, ORDER BY절보다는 앞에 나와야 함. 먼저 나오면 안됨.
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회하고 싶다면??

SELECT * FROM tb_emp
ORDER BY dept_cd
;

SELECT
    dept_cd -- 그룹화된 부분이기 때문에 조회 가능하다.
--    , emp_nm : 그룹화된 부분이 아니기 때문에 조회 불가능하다.
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd -- 같은 부서번호끼리 그룹화를 시켜서 집계함수를 실행하라.
ORDER BY dept_cd
;


-- 사원별 누적 급여수령액 조회
SELECT
    emp_no "사번"
    , SUM(pay_amt) "누적 수령액"
    , AVG(pay_amt) "누적 수령 평균액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;


-- 사원별로 재직 중에 급여를 제일 많이 받았을 때, 제일 적게 받았을 때, 평균적으로 얼마 받았는지 조회
SELECT
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "누적 수령 평균액"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;


SELECT * FROM tb_sal_his
ORDER BY emp_no, pay_de
;


-- 사원별로 2019년에 급여를 제일 많이 받았을 때, 제일 적게 받았을 때, 평균적으로 얼마 받았는지 조회
SELECT
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "2019년 최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "2019년 최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "2019년 수령 평균액"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019년 연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;


-- where절 : 그룹화 하기 전에 걸러낸다.
-- having절 : 집계를 다 하고나서 거기서 걸러낸다.

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd 
HAVING COUNT(emp_no) > 1
ORDER BY dept_cd
;


-- 사원별로 재직 중에 급여를 제일 많이 받았을 때, 제일 적게 받았을 때, 평균적으로 얼마 받았는지 조회
-- 평균 급여가 450만원 이상인 사람만 조회
SELECT
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "수령 평균액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;


-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT
    emp_no "사번"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019년 연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
;


-- 
SELECT
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, sex_cd
;


SELECT
    dept_cd
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd -- 두 조건을 만족해야 한 그룹이 됨.
ORDER BY dept_cd
;


-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
    -- 기본값이란!! '안쓰면' 자동 적용되는 값
-- 항상 SELECT절의 맨 마지막에 위치
SELECT
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;


-- 이름은 유니코드 기준으로 정렬됨 (영어, 한글 혼용이면 영어가 앞에 나옴)
SELECT
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm
;


SELECT
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC -- 부서코드로 정렬하되, 같은 부서코드 끼리는 사번으로 정렬해라
;


SELECT
    emp_no 사번
    , emp_nm 이름
    , addr 주소
FROM tb_emp
ORDER BY 이름 DESC -- 별칭으로 정렬도 가능
;


SELECT
    emp_no -- 컬럼에는 묵시적으로 넘버링이 되어있다. 얘는 1번 컬럼
    , emp_nm -- 2번 컬럼
    , dept_cd -- 3번 컬럼
FROM tb_emp
ORDER BY 3 ASC, 1 DESC -- 컬럼 번호로 정렬도 가능
;


SELECT
    emp_no 
    , emp_nm 
    , dept_cd 
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC -- 혼용도 가능, 별칭 혼용도 ok!
;


SELECT
    emp_no "사번" -- 2. 여기서 사용 가능!! 다른 항목은 불가
                -- 다른 항목은 집계함수로만 들어올 수 있다.
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019년 연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no -- 1. 그룹으로 지정한 컬럼만 
HAVING AVG(pay_amt) >= 4500000
ORDER BY "2019년 연봉" desc
;






