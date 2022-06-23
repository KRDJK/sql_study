

-- ���� �Լ� (������ �Լ�)
-- : ���� ���� ��� �Լ��� ����
SELECT * FROM tb_sal_his;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005' -- 5�� ����� ���� �޿� �̷� ��ȸ
;


SELECT DISTINCT
    SUBSTR(emp_nm, 1, 1) ����
FROM tb_emp
;


-- GROUP BY�� �ұ׷�ȭ ���� ������ �����Լ��� ��ü����� �������� �����Ѵ�.
SELECT
    SUM(pay_amt) "���� �Ѿ�"
    , AVG(pay_amt) "��� ���޾�"
    , COUNT(pay_amt) "���� Ƚ��" -- ��ü ���� ������ ����
FROM tb_sal_his
;


SELECT * FROM tb_emp;


SELECT
    COUNT(emp_no) "�� �����"
    , MIN(birth_de) "�ֿ������� ����"
    , MAX(birth_de) "�ֿ������� ����"
    , COUNT(direct_manager_emp_no) "dmen"
FROM tb_emp;
-- count�� �ߺ��� �����ؼ��� ī�����Ѵ�.
-- �׷��� null ���� �ƿ� �����ϰ� ī�����Ѵ�.
    -- but, count(*)�̶�� �ϸ� null�� ī���� �Ѵ�.
-- ��� ���� ���� null�� �ƿ� ����. ���� ���� ������ �ݿ� x



-- GROUP BY : ������ �÷����� �ұ׷�ȭ �� �� �����Լ� ����
-- WHERE������ �ڿ�, ORDER BY�����ٴ� �տ� ���;� ��. ���� ������ �ȵ�.
-- �μ����� ���� ������ �������, �������� ������� �μ��� �� ��� ���� ��ȸ�ϰ� �ʹٸ�??

SELECT * FROM tb_emp
ORDER BY dept_cd
;

SELECT
    dept_cd -- �׷�ȭ�� �κ��̱� ������ ��ȸ �����ϴ�.
--    , emp_nm : �׷�ȭ�� �κ��� �ƴϱ� ������ ��ȸ �Ұ����ϴ�.
    , MAX(birth_de) �ֿ�����
    , MIN(birth_de) �ֿ�����
    , COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd -- ���� �μ���ȣ���� �׷�ȭ�� ���Ѽ� �����Լ��� �����϶�.
ORDER BY dept_cd
;


-- ����� ���� �޿����ɾ� ��ȸ
SELECT
    emp_no "���"
    , SUM(pay_amt) "���� ���ɾ�"
    , AVG(pay_amt) "���� ���� ��վ�"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;


-- ������� ���� �߿� �޿��� ���� ���� �޾��� ��, ���� ���� �޾��� ��, ��������� �� �޾Ҵ��� ��ȸ
SELECT
    emp_no "���"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "�ְ� ���ɾ�"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "���� ���� ��վ�"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;


SELECT * FROM tb_sal_his
ORDER BY emp_no, pay_de
;


-- ������� 2019�⿡ �޿��� ���� ���� �޾��� ��, ���� ���� �޾��� ��, ��������� �� �޾Ҵ��� ��ȸ
SELECT
    emp_no "���"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "2019�� �ְ� ���ɾ�"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "2019�� ���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "2019�� ���� ��վ�"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019�� ����"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;


-- where�� : �׷�ȭ �ϱ� ���� �ɷ�����.
-- having�� : ���踦 �� �ϰ��� �ű⼭ �ɷ�����.

-- HAVING : �׷�ȭ�� ������� ������ �ɾ� �� ���� ����

-- �μ����� ���� ������ �������, �������� �������, �μ��� �� ��� ���� ��ȸ
-- �׷��� �μ��� ����� 1���� �μ��� ������ ��ȸ�ϰ� ���� ����.
SELECT
    dept_cd
    , MAX(birth_de) �ֿ�����
    , MIN(birth_de) �ֿ�����
    , COUNT(emp_no) ������
FROM tb_emp
GROUP BY dept_cd 
HAVING COUNT(emp_no) > 1
ORDER BY dept_cd
;


-- ������� ���� �߿� �޿��� ���� ���� �޾��� ��, ���� ���� �޾��� ��, ��������� �� �޾Ҵ��� ��ȸ
-- ��� �޿��� 450���� �̻��� ����� ��ȸ
SELECT
    emp_no "���"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "�ְ� ���ɾ�"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "���� ���ɾ�"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "���� ��վ�"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;


-- ������� 2019�� ����� ���ɾ��� 450���� �̻��� ����� �����ȣ�� 2019�� ���� ��ȸ
SELECT
    emp_no "���"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019�� ����"
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
GROUP BY dept_cd, sex_cd -- �� ������ �����ؾ� �� �׷��� ��.
ORDER BY dept_cd
;


-- ORDER BY : ����
-- ASC : ������ ���� (�⺻��), DESC : ������ ����
    -- �⺻���̶�!! '�Ⱦ���' �ڵ� ����Ǵ� ��
-- �׻� SELECT���� �� �������� ��ġ
SELECT
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;


-- �̸��� �����ڵ� �������� ���ĵ� (����, �ѱ� ȥ���̸� ��� �տ� ����)
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
ORDER BY dept_cd ASC, emp_nm DESC -- �μ��ڵ�� �����ϵ�, ���� �μ��ڵ� ������ ������� �����ض�
;


SELECT
    emp_no ���
    , emp_nm �̸�
    , addr �ּ�
FROM tb_emp
ORDER BY �̸� DESC -- ��Ī���� ���ĵ� ����
;


SELECT
    emp_no -- �÷����� ���������� �ѹ����� �Ǿ��ִ�. ��� 1�� �÷�
    , emp_nm -- 2�� �÷�
    , dept_cd -- 3�� �÷�
FROM tb_emp
ORDER BY 3 ASC, 1 DESC -- �÷� ��ȣ�� ���ĵ� ����
;


SELECT
    emp_no 
    , emp_nm 
    , dept_cd 
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC -- ȥ�뵵 ����, ��Ī ȥ�뵵 ok!
;


SELECT
    emp_no "���" -- 2. ���⼭ ��� ����!! �ٸ� �׸��� �Ұ�
                -- �ٸ� �׸��� �����Լ��θ� ���� �� �ִ�.
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "2019�� ����"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no -- 1. �׷����� ������ �÷��� 
HAVING AVG(pay_amt) >= 4500000
ORDER BY "2019�� ����" desc
;






