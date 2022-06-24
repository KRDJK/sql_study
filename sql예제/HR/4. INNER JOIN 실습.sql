

-- 1. employees테이블과 departments테이블을 inner join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT * FROM employees; -- 총 사원 107명인데 inner join하면 결과 행 106개가 나옴.
                        -- 부서번호가 null인 사원이 있기 때문임 ㅇㅇ 
                        -- : outer join을 활용해야 하는 이유다.

SELECT
    e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
;

-- 2. employees테이블과 departments테이블을 natural join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT
    e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees E
NATURAL JOIN departments D -- 32행만 나옴 왜?? 예상은 department_id만 같을거라 예상했는데 겹치는게 더 있었다.
;

-- 3. employees테이블과 departments테이블을 using절을 사용하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT
    e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees E
INNER JOIN departments D
USING (department_id, manager_id)
;

-- 4. employees테이블과 departments테이블과 locations 테이블을 
--    join하여 employee_id, first_name, department_name, city를 조회하세요
SELECT
    e.employee_id, e.first_name, d.department_name, L.city
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
INNER JOIN locations L
ON D.location_id = L.location_id
;


