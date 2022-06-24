

-- 1. employees���̺�� departments���̺��� inner join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT * FROM employees; -- �� ��� 107���ε� inner join�ϸ� ��� �� 106���� ����.
                        -- �μ���ȣ�� null�� ����� �ֱ� ������ ���� 
                        -- : outer join�� Ȱ���ؾ� �ϴ� ������.

SELECT
    e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
;

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees E
NATURAL JOIN departments D -- 32�ุ ���� ��?? ������ department_id�� �����Ŷ� �����ߴµ� ��ġ�°� �� �־���.
;

-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT
    e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees E
INNER JOIN departments D
USING (department_id, manager_id)
;

-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���
SELECT
    e.employee_id, e.first_name, d.department_name, L.city
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id
INNER JOIN locations L
ON D.location_id = L.location_id
;


