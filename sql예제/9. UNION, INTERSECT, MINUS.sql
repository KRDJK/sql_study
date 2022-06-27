-- ���� ������
-- ## UNION
-- 1. ������ ������ �ǹ��Դϴ�.
-- 2. ù��° ������ �ι�° ������ �ߺ������� �ѹ��� �����ݴϴ�.
-- �߿� 3. ù��° ������ ���� ������ Ÿ���� �ι�° ������ ������ Ÿ�԰� �����ؾ� ��.
-- 4. �ڵ����� ������ �Ͼ (ù��° �÷� �������� �⺻��)

-- join�� ���η� ��ġ�°ǵ�, ���� �����ڿ��� ���η� ��ħ.(���̺� ���� �÷� ���� �÷����� ������ Ÿ���� ���ƾ� ��)

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
    emp_nm, birth_de --2��
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_nm, birth_de --3��. �̷��� ����� ��������.
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

SELECT
    emp_nm EN, birth_de BD
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
--ORDER BY �� ��ġ���� �ϸ� �ȵ�
UNION
SELECT
    emp_nm EN2, birth_de BD2 -- �ؿ� ��Ī�� ���õǰ� ���� �������� ����.
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
ORDER BY BD DESC -- UNION�� ���� �Ŀ� ������ �õ��ؾ� ��.
;


-- ## UNION ALL
-- 1. UNION�� ���� �� ���̺�� �������� ���ļ� �����ݴϴ�.
-- 2. UNION���� �޸� �ߺ��� �����͵� �ѹ� �� �����ݴϴ�.
-- 3. �ڵ� ���� ����� �������� �ʾ� ���ɻ� �����մϴ�.

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


-- ������, �������� ���丸 �˰� ������ �ȴٰ� ��.
-- ## INTERSECT
-- 1. ù��° ������ �ι�° �������� �ߺ��� �ุ�� ����մϴ�.
-- 2. �������� �ǹ��Դϴ�.

SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD' -- SQLD �ڰ��� �� ����� ������ ��.
INTERSECT -- �������� �ɾ������ ���ο� ��鼭 SQLD �ڰ����� �� ����� ������ ��.
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%'; -- ���� ��� ������� �� �ڰ��� ����� ������ ��.


-- �̰� �� �����ϳ� ������ �������� �� ��
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%����%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 
-- 1. �ι�° �������� ���� ù��° �������� �ִ� �����͸� �����ݴϴ�.
-- 2. �������� �����Դϴ�.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;



-- ������ ����
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ� -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ� -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL, -- ���� �÷�
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    -- ������ ���� ������ ä���� ������ 1�̸� 0, 2�� 4ĭ, 3�̸� 8ĭ ... 
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF -- �ٻ����İ� ���� ��, �ڽ� ��尡 ���� ���. �굵 ���� �÷�
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL -- �ٽ� ���� 1. ���� ������ ù �ܰ谡 ���ӻ���ȣ NULL�� �ֺ��� �����ض�.
-- �ٽɱ��� 1 : ���� ROOT ��尡 �� �������� ���Ѵٰ� ���� �ȴ�. 
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no -- �ٽ� ���� 2. ���� ������ ���� © ���ΰ�??
-- �θ𿡼����� �ڽ����� �������鼭 Ž���ϸ� ������ Ž��, �ڽĿ������� �ö󰡸鼭 Ž���ϸ� ������ Ž���̶�� �Ѵ�.
-- �� ���� PRIOR�� �ڽĿ� �پ��� ������ ��Ʈ ������ ������ �Ʒ��� ���������� ���ڴٴ� ���̴�.
ORDER SIBLINGS BY A.emp_no DESC
;




SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
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
-- 1. �ϳ��� ���̺��� �ڱ� �ڽ��� ���̺��� �����ϴ� ���.
-- 2. �ڱ� �ڽ� ���̺��� PK�� FK�� ���� �����Ѵ�.

SELECT
    a.emp_no
    , a.emp_nm �����
    , a.addr "��� �ּ�"
    , a.direct_manager_emp_no 
    , b.emp_nm "���� ��� �����"
    , b.addr "���� ��� �ּ�"
FROM tb_emp A
--WHERE dept_cd = '100002'
LEFT JOIN tb_emp B-- �ڱ� ���̺���� ���� (���� ����)
ON a.direct_manager_emp_no = b.emp_no
ORDER BY emp_no
;



ALTER TABLE tb_emp
ADD CONSTRAINT fk_dm_emp_no
FOREIGN KEY (direct_manager_emp_no)
REFERENCES tb_emp(emp_no)
;











