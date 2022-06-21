

-- SELECT �⺻
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
    emp_nm, emp_no -- ������ �ٲ�� ��ȸ�� ���� �ٲ� ������ ���� ��, ���� ��ȸ�ȴ�. // ���� �����Ϳ� ���� ����
FROM tb_emp;


-- DISTINCT : �ߺ����� �����ϰ� ��ȸ
SELECT ALL
    issue_insti_nm
FROM tb_certi;


SELECT DISTINCT
    issue_insti_nm
FROM tb_certi;


SELECT DISTINCT
    certi_nm, issue_insti_nm -- �� ���� �� �ߺ��Ǵ� ��츦 �������ش�.
FROM tb_certi;


-- �� ��Ī (column alias) ����
SELECT
    certi_cd AS "�ڰ��� �ڵ�" -- AS�� �׻� ���������ϴ�.
    , certi_nm AS �ڰ����� -- ""�� ���⸦ ���Ÿ� ������ �ֵ���ǥ�� ����Ѵ�. �װ� �ƴ϶�� �׳� �ᵵ �ȴ�.
    , issue_insti_nm �߱ޱ����
FROM tb_certi; 


-- ���ڿ� ���� ������ ||(��������)
-- ex) SQLLD (100002) - �ѱ������������ 
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm "�ڰ��� ����"
FROM tb_certi;


-- ���� ���̺� (dual) : �ܼ� �������� ��ȸ�� �� ���
-- ���������� ����Ŭ���� ������ ���̺�
SELECT
    3 * 7 "���� ���"
FROM dual;

SELECT
    SYSDATE "���� ��¥"
FROM dual;







