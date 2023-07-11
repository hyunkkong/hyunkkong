SELECT USER
FROM DUAL;


--�� EMP ���̺��� �������
--   �Ի��� ����� ���� ���� ������ ���� 
--   �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
------------------ ----------
�Ի���            �ο���
------------------ ----------
 1981-02                2
 1981-09                2
 1987-07                2
------------------ ---------- 
*/

SELECT 
(
SELECT TO_CHAR(HIREDATE,'YYYY-MM')
FROM EMP "�Ի���"
)T
G;

SELECT ENAME, HIREDATE
FROM EMP
ORDER BY 2;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
       , COUNT(*) "�ο���"
FROM EMP;

SELECT T1.�Ի���, T1.�ο���
FROM
(
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP 
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
) T1
    WHERE T1.�ο��� = (
        SELECT MAX(T2.�ο���)
        FROM
        (
        SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"�Ի���"
             , COUNT(*) "�ο���"
        FROM EMP
        GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
        )T2
    )
ORDER BY 1;

--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--------------------------------------------------------------------------------

--���� ROW_NUMBER ����--

SELECT ENAME "�����", SAL"�޿�", HIREDATE "�Ի���"
FROM EMP;


SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ" 
    , ENAME "�����", SAL"�޿�", HIREDATE "�Ի���"
FROM EMP;
--==>>
/*
1	KING	5000	81/11/17
2	FORD	3000	81/12/03
3	SCOTT	3000	87/07/13
4	JONES	2975	81/04/02
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
7	ALLEN	1600	81/02/20
8	TURNER	1500	81/09/08
9	MILLER	1300	82/01/23
10	WARD	1250	81/02/22
11	MARTIN	1250	81/09/28
12	ADAMS	1100	87/07/13
13	JAMES	 950	81/12/03
14	SMITH	 800	80/12/17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ" 
    , ENAME "�����", SAL"�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
12	ADAMS	1100	87/07/13
7	ALLEN	1600	81/02/20
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
2	FORD	3000	81/12/03
13	JAMES	 950	81/12/03
4	JONES	2975	81/04/02
1	KING	5000	81/11/17
11	MARTIN	1250	81/09/28
9	MILLER	1300	82/01/23
3	SCOTT	3000	87/07/13
14	SMITH	 800	80/12/17
8	TURNER	1500	81/09/08
10	WARD	1250	81/02/22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ" 
    , ENAME "�����", SAL"�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	87/07/13
2	ALLEN	1600	81/02/20
3	BLAKE	2850	81/05/01
4	CLARK	2450	81/06/09
5	FORD	3000	81/12/03
6	JAMES	 950	81/12/03
7	JONES	2975	81/04/02
8	KING	5000	81/11/17
9	MARTIN	1250	81/09/28
10	MILLER	1300	82/01/23
11	SCOTT	3000	87/07/13
12	SMITH	 800	80/12/17
13	TURNER	1500	81/09/08
14	WARD	1250	81/02/22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ" 
    , ENAME "�����", SAL"�޿�", HIREDATE "�Ի���"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;



--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���... ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�... ���ȼ� �����̳�... �̰���... �ٶ������� ���� ������ �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������,
--   �ܼ��� �Խù��� ���ȭ �Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� �ٶ��� �� �� �ִ�.

--   ����Ŭ ����(SEQUENCE), SLQ(IDENTITY)

--�� SEQUENCE(������:�ֹ���ȣ)
-- �� �������� �ǹ� :1.(�Ϸ���) �������� ��ǵ�, 2. (���, �ൿ ����) ����

CREATE SEQUENCE SEQ_BOARD       -- �⺻���� ������ ���� ����
START WITH 1                    -- 1���� ���� (���۰�)
INCREMENT BY 1                 -- 1�� ����(������)
NOMAXVALUE                      -- �ִ밪(�Ϲ������� ������� ����)
NOCACHE;                        -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD                  -- TBL_BOARD ���̺� ������ ���� �� �Խ��� ���̺�
( NO            NUMBER                  -- �Խù� ��ȣ       �ۼ��� ���� �Է� X
, TITLE         VARCHAR2(50)            -- �Խù� ����                        ��
, CONTENTS      VARCHAR2(1000)          -- �Խù� ����                        ��
, NAME          VARCHAR2(20)            -- �Խù� �ۼ���                      ��
, PW            VARCHAR2(20)            -- �Խù� �н�����                    ��
, CREATED       DATE DEFAULT SYSDATE    -- �Խù� �ۼ���                      X
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.

--�� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��� �׼�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~�ڰ�ʹ�', '10�и� �ڰ� �ò���','������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~����', '������ ���� ����־��','���ҿ�', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����ʹ�', '�����̰� �ʹ� ����;��','������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����Ŀ�', '��ħ�ε� ����Ŀ�', '������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�ʹ��־��', '������ ���������� �ʹ� �־��', '���¹�', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ڶ��', '���� ���� ���ڶ��', '������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ο�', '���� ���� ���� ���ڶ��', '������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��´��', '���ù���� ��´��', '�ڿ���', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	��~�ڰ�ʹ�	10�и� �ڰ� �ò���	            ������	java002$	2022-08-22 10:25:08
2	��~����	    ������ ���� ����־��	        ���ҿ�	java002$	2022-08-22 10:25:08
3	����ʹ�	    �����̰� �ʹ� ����;��	        ������	java002$	2022-08-22 10:25:08
4	����Ŀ�	��ħ�ε� ����Ŀ�	            ������	java002$	2022-08-22 10:25:08
5	�ʹ��־��	������ ���������� �ʹ� �־��	���¹�	java002$	2022-08-22 10:25:08
6	���ڶ��    	���� ���� ���ڶ��	            ������	java002$	2022-08-22 10:25:08
7	���ο�	    ���� ���� ���� ���ڶ��	        ������	java002$	2022-08-22 10:25:08
8	��´��    	���ù���� ��´��	            �ڿ���	java002$	2022-08-22 10:25:08
*/
DROP SEQUENCE SEQ_BOARD;
DROP TABLE TBL_BOARD;
PURGE RECYCLEBIN;

--�� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO = 1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 8;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;

--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����սô�.', '�� ���� ������ �ʾƿ�', '������', 'java002$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� �Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
2	��~����	    ������ ���� ����־��	            ���ҿ�	java002$	2022-08-22 10:25:08
3	����ʹ�	    �����̰� �ʹ� ����;��   	        ������	java002$	2022-08-22 10:25:08
4	����Ŀ�	��ħ�ε� ����Ŀ�	                ������	java002$	2022-08-22 10:25:08
5	�ʹ��־��	������ ���������� �ʹ� �־��	    ���¹�	java002$	2022-08-22 10:25:08
9	�����սô�.	�� ���� ������ �ʾƿ�	            ������	java002$	2022-08-22 10:35:53
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խ����� �Խù� ����Ʈ ��ȸ
SELECT NO "�۹�ȣ", TITLE"����", NAME"�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD;
--==>>
/*
2	��~����	���ҿ�	2022-08-22 10:25:08
3	����ʹ�	������	2022-08-22 10:25:08
4	����Ŀ�	������	2022-08-22 10:25:08
5	�ʹ��־��	���¹�	2022-08-22 10:25:08
9	�����սô�.	������	2022-08-22 10:35:53
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE"����", NAME"�ۼ���", CREATED"�ۼ���"
FROM TBL_BOARD
ORDER BY CREATED DESC;



--------------------------------------------------------------------------------

--���� JOIN(����) ����--

-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CATERSIAN PRODUCT)
--  �� ���̺��� ������ ��� ����� ��


-- EQUI JOIN :���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;


SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY HIREDATE;

SELECT *
FROM EMP;

-- NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ű�� ���� ���
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S. HISAL;

-- EQUI JOIN �� (+) �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5) ��� ����
--  ����, �Ҽ� ����� ���� ���� �μ�(1) ��� ����


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �Ҽ� ����� ���� ���� �μ�(1) ���� --------------------(+)
--  �μ���ȣ�� ���� ���� �����(5) ��� ��ȸ


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 15 ���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  �μ���ȣ�� ���� ���� �����(5) ��� ���� --------------(+)
--  �Ҽ� ����� ���� ���� �μ�(1) ��ȸ

--�� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��              -- ����
--   (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�  -- �߰�(÷��)
--   JOIN �� �̷������.

--   �̿� ���� ������...
SELECT *
FROM TBL_EMP, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--   �̷� ������ JOIN�� �������� �ʴ´�.



-- 2. SQL 1999 CODE     �� ��JOIN�� Ű���� ���� �� JOIN(����)�� ���� ���
--                      �� ��ON�� Ű���� ���� �� ���� ������ WHERE ��� ON

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;
-- INNER JOIN ���� INNER �� ���� ����


-- OUTER JOIN
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- OUTER JOIN ���� OUTER �� ���� ����

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- LEFT RIGTH FULL �� ������ INNER JOIN


--------------------------------------------------------------------------------
-- ���� ����
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> �̿� ���� ������� �������� �����ص�
--  ��ȸ ����� ��� ������ ������ ����.

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK';
--> ������, �̿� ���� �����Ͽ�
--  ��ȸ�ϴ� ���� �����Ѵ�.

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO          -- ��������
WHERE E.JOB = 'CLERK';          -- ��������
-- �� ���� ���� ���� 
--------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.
SELECT D.DEPTNO"�μ���ȣ", ENAME"�μ���",  ENAME"�����", JOB "������", SAL"�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO                  --���� ����
WHERE JOB IN ('MANAGER','CLERK');       --���� ����

-- �μ���ȣ, �μ���, �����, ������, �޿�
-- DEPTNO    DNAME   ENAME   JOB     SAL
-- E, D      D       E       E       E

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
--      (ORA-00918: column ambiguously defined)
--      �� ���̺� �� �ߺ��Ǵ� �÷��� ����
--      �Ҽ� ���̺��� �������(��������) �Ѵ�.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--�� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� â���� �� �ֵ��� ó���ؾ� �Ѵ�.

SELECT *
FROM EMP;       -- �ڽ� ���̺�

SELECT *
FROM DEPT;      -- �θ� ���̺�

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL -- ORACLE�� ��� ����� �÷����� Ȯ���ϱ⶧���� ����(FROM) �÷��� Ȯ���� �ʿ䰡 ����.
FROM EMP E, DEPT D
WHERE E. DEPTNO = D.DEPTNO;

-- �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
-- �÷��� �Ҽ� ���̺��� ����� �� �� �ֵ��� �����Ѵ�.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;


--------------------------------------------------------------------------------

--�� SELF JOIN (�ڱ� ����)

-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------------------------------------------------------
-- �����ȣ  �����  ������  �����ڹ�ȣ  �����ڸ�  ����������
--------------------------------------------------------------------------------
-- 7369      SMITH    CLERK     7902       FORD     ANALYST
-- ----------------------------------- E1
--                           -------------------------------- E2

SELECT E.EMPNO"�����ȣ" 
     , E.ENAME"�����"
     , E.JOB"������"
     , E.MGR "�����ڹ�ȣ"
     , S.ENAME"�����ڸ�"
     , S.JOB"����������"
FROM EMP E, EMP S
WHERE E.MGR = S.EMPNO(+);


SELECT E.EMPNO"�����ȣ"
     , E.ENAME"�����"
     , E.JOB"������"
     , E.MGR"�����ڹ�ȣ"
     , S.ENAME"�����ڸ�"
     , S.JOB"����������"
FROM EMP E LEFT JOIN EMP S
ON S.EMPNO = E.MGR;





SELECT EMPNO" �����ȣ",ENAME"�����", JOB"������", MGR "�����ڹ�ȣ", ENAME"�����ڸ�", JOB "������������"
FROM EMP;

-- 1.
SELECT E1.EMPNO" �����ȣ",E1.ENAME"�����", E1.JOB"������"
     , E1.MGR "�����ڹ�ȣ", E2.ENAME"�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
-- 2.
SELECT E1.EMPNO" �����ȣ",E1.ENAME"�����", E1.JOB"������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME"�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;


SELECT E1.EMPNO" �����ȣ",E1.ENAME"�����", E1.JOB"������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME"�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;


SELECT E1.EMPNO" �����ȣ",E1.ENAME"�����", E1.JOB"������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME"�����ڸ�", E2.JOB "������������"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);