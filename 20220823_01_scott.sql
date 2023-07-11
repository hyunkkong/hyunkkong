SELECT USER
FROM DUAL;
--==>> SCOTT

--�� UNION �� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�. (���ı��)
--   �ݸ�, UNION ALL �� ���յ� ����(�������� ���̺��� ����� ����)���
--   ��ȸ�� ����� �ִ� �״�� ��ȯ�Ѵ�. (���� ����)
--   �̷� ���� UNION �� ���ϰ� �� ũ��. (���ҽ� �Ҹ� �� ũ��.)
--   ����, UNION �� ������� �ߺ��� ���ڵ�(��)�� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�.


--�� ���ݱ��� �ֹ����� �����͸� ����
--   ��ǰ �� �� �ֹ����� ��ȸ�� �� �ִ� �������� �����Ѵ�.

SELECT T.��ǰ��, SUM(T.�ֹ���)"�� �ֹ���"
FROM
(
    SELECT JECODE"��ǰ��", JUSU"�ֹ���"
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE"��ǰ��", JUSU"�ֹ���"
    FROM TBL_JUMUNBACKUP
) T
GROUP BY T.��ǰ��
ORDER BY 1;





------------���� ������
SELECT T.JECODE "��ǰ�ڵ�", SUM(T.JUSU)"�ֹ�����"
FROM
(
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT JECODE, JUSU
FROM TBL_JUMUN
) T
GROUP BY T.JECODE;
--==>>
/*
����Ĩ	30
������	20
ġ�佺	20
������	70
�����	10
���Ͻ�	20
���̽�	40
��īĨ	20
����Ĩ	20
������	30
��ǹ�	20
������	110
������	30
���ڱ�	40
Ȩ����	40
������	10
�Ҹ���	10
����ƽ	40
*/


--�� INTERSECT / MINUS (�����հ� ������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
-- ��ǰ�ڵ�� �ֹ������� ���� �Ȱ��� �ุ �����ϰ��� �Ѵ�.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���ڱ�	20
������	30
Ȩ����	10
*/


SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
������	20
����Ĩ	20
������	10
������	10
��ǹ�	20
�����	10
����Ĩ	20
������	20
������	10
�Ҹ���	10
ġ�佺	20
����ƽ	10
����ƽ	20
��īĨ	20
*/


--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� �������
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ�����




--JOIN
    
SELECT T.JUNO"�ֹ���ȣ",T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", T.JUDAY"�ֹ�����"
FROM
    (
        SELECT JUNO, JUSU, JECODE, JUDAY
        FROM TBL_JUMUNBACKUP
        UNION ALL
        SELECT JUNO, JUSU, JECODE, JUDAY
        FROM TBL_JUMUN
    ) T
    JOIN
    (
        SELECT JUSU, JECODE
        FROM TBL_JUMUNBACKUP
        INTERSECT
        SELECT JUSU, JECODE
        FROM TBL_JUMUN
    ) S
ON T.JECODE = S.JECODE
AND T.JUSU = S.JUSU
ORDER BY 1;



SELECT T.JUNO"�ֹ���ȣ",T.JECODE"��ǰ�ڵ�", T.JUSU"�ֹ���", T.JUDAY"�ֹ�����"
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE T.JECODE ||;




--------------------------------------------------------------------------------
SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    ġ�佺	20	2001-11-01
2	    ������	10	2001-11-01
3	    ������	30	2001-11-01
4	    ������	10	2001-11-02
5	    ��īĨ	20	2001-11-02
6	    �Ҹ���	10	2001-11-03
7	    ���ڱ�	20	2001-11-03
8	    ��ǹ�	20	2001-11-04
9	    �����	10	2001-11-05
10	    ����Ĩ	20	2001-11-05
11	    Ȩ����	10	2001-11-05
12	    Ȩ����	10	2001-11-05
13	    ����Ĩ	20	2001-11-06
14	    ������	10	2001-11-07
15	    ������	20	2001-11-08
16	    ����ƽ	10	2001-11-09
17	    ������	20	2001-11-10
18	    Ȩ����	10	2001-11-11
19	    ����ƽ	10	2001-11-12
20	    ����ƽ	20	2001-11-13
98764	����Ĩ	10	2022-08-22
98765	������	30	2022-08-22
98766	������	20	2022-08-22
98767	���̽�	40	2022-08-22
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98770	������	10	2022-08-22
98771	���Ͻ�	20	2022-08-22
98772	������	30	2022-08-22
98773	������	20	2022-08-22
98774	������	50	2022-08-22
98775	������	10	2022-08-22
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
���ڱ�	20
������	30
Ȩ����	10
*/


SELECT *
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT *
FROM TBL_JUMUN;
--==>> ��ȸ ��� ����

-- ��� 1.



SELECT T2.JUNO "�ֹ���ȣ", T1.JECODE "��ǰ�ڵ�"
     , T1.JUSU "�ֹ�����", T2.JUDAY "�ֹ�����"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN    
) T1
JOIN
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU;

--==>>
/*
    3	������	30	2001-11-01
    7	���ڱ�	20	2001-11-03
   11	Ȩ����	10	2001-11-05
   12	Ȩ����	10	2001-11-05
   18	Ȩ����	10	2001-11-11
98768	Ȩ����	10	2022-08-22
98769	���ڱ�	20	2022-08-22
98772	������	30	2022-08-22
*/

-- ��� 2.
SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('���ڱ�','������','Ȩ����')
  AND T.JUSU IN (20, 30, 10);
--==>>
/*
    3	30	������	2001-11-01
    7	20	���ڱ�	2001-11-03
   11	10	Ȩ����	2001-11-05
   12	10	Ȩ����	2001-11-05
   18	10	Ȩ����	2001-11-11
98768	10	Ȩ����	2022-08-22
98769	20	���ڱ�	2022-08-22
98770	10	������	2022-08-22
98772	30	������	2022-08-22
*/


SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE�� T.JUSU�� ���� ����� '���ڱ�20', '������30', 'Ȩ����10';


SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ('���ڱ�20', '������30', 'Ȩ����10');
--==>>
/*
    3	30	������	2001-11-01
    7	20	���ڱ�	2001-11-03
   11	10	Ȩ����	2001-11-05
   12	10	Ȩ����	2001-11-05
   18	10	Ȩ����	2001-11-11
98768	10	Ȩ����	2022-08-22
98769	20	���ڱ�	2022-08-22
98772	30	������	2022-08-22
*/

SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ( SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUNBACKUP
                                    INTERSECT
                                    SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUN);
--==>>
/*
    3	30	������	2001-11-01
    7	20	���ڱ�	2001-11-03
   11	10	Ȩ����	2001-11-05
   12	10	Ȩ����	2001-11-05
   18	10	Ȩ����	2001-11-11
98768	10	Ȩ����	2022-08-22
98769	20	���ڱ�	2022-08-22
98772	30	������	2022-08-22
*/


--------------------------------------------------------------------------------
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
--==>> ���� �߻�


SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
--�����Ͱ� ���� �ʰų�, ������ �������� ������ 


SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D
USING(DEPTNO);
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600    
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/


--------------------------------------------------------------------------------



--�� TBL_EMP ���̺��� �޿��� ���� ���� ����� 
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�.

SELECT *
FROM TBL_EMP
ORDER BY SAL DESC;

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE �޿��� ���� ���� ����� ;

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL > = ( SELECT MAX(SAL)
                FROM TBL_EMP);
 
                   
                   
                   
-- �޿��� ���� ���� �޴� ����� �޿�
SELECT MAX(SAL)
FROM TBL_EMP;
--==>> 5000

SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE �޿��� ���� ���� ���;
                
SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL = ( �޿��� ���� ���� ���); 


SELECT EMPNO"�����ȣ", ENAME"�����", JOB"������", SAL"�޿�"
FROM TBL_EMP
WHERE SAL = ( SELECT MAX(SAL)
                FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000

-- ��=ANY��

-- ��=ALL��
-- ~�̱⵵ �ϸ鼭, ~�̱⵵ �ϸ鼭 ... (��� ���ǿ� �����ؾ���)

SELECT SAL
FROM TBL_EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
1500
2000
1700
2500
1000
*/
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL =ANY (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7788	SCOTT	ANALYST	    3000
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7902    	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300
8001    	���¹�	CLERK	    1500
8002	    ������	CLERK	    2000
8003	    �躸��	SALESMAN	1700
8004	    ������	SALESMAN	2500
8005	    ������	SALESMAN	1000
*/
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ANY (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7788	SCOTT	ANALYST	    3000
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7902    	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300
8001    	���¹�	CLERK	    1500
8002	    ������	CLERK	    2000
8003	    �躸��	SALESMAN	1700
8004	    ������	SALESMAN	2500
8005	    ������	SALESMAN	1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ALL (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 7839	KING	PRESIDENT	5000

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ALL (SELECT SAL
                 FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000

--�� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ����� ��
--   �޿��� ���� ���� �����
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�.

SELECT *
FROM TBL_EMP;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE 20�� �μ��� �ٹ��ϴ� ����� �� �޿��� ���� ���� ���;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20
  AND SAL >= ALL (SELECT SAL
                 FROM TBL_EMP);
--==>> ��ȸ ��� ����
                 

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM TBL_EMP
             WHERE DEPTNO = 20)
  AND DEPTNO = 20;
--==>>
/*
7788	SCOTT	ANALYST	3000
7902	FORD	ANALYST	3000
*/
 
 SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL (SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20)
  AND DEPTNO = 20;  
--==>>
/*
7902	    FORD	ANALYST	3000
7788	SCOTT	ANALYST	3000
*/

--�� TBL_EMP ���̺��� ����(Ŀ�̼�, COMM)�� ���� ���� �����
--   �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼�
FROM TBL_EMP
WHERE COMM�� ���� ���� ���;

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM�� ���� ���� ���;


SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM = (��� ������ �� �ְ� Ŀ�̼�);

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
              FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT COMM
                    FROM TBL_EMP);
--==>> ��ȸ ��� ����

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( NULL, 300, 500, NULL, 1400, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 10, 10, NULL, NULL, NULL);
--==>> ��ȸ ��� ����

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT NVL(COMM,0)
                      FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT COMM
                    FROM TBL_EMP
                    WHERE COMM IS NOT NULL);
--==>> 7654	MARTIN	30	SALESMAN	1400


-- �� Ǯ��
--------------------------------------------------------------------------------
SELECT EMPNO,ENAME,DEPTNO,JOB,NVL(COMM,0)
FROM TBL_EMP
WHERE NVL(COMM,0) >= ALL (SELECT NVL(COMM,0)
                          FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,NVL(COMM,0)
FROM TBL_EMP
WHERE NVL(COMM,0) = (SELECT MAX(NVL(COMM,0))
                       FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT MAX(NVL(COMM,0))
FROM TBL_EMP;

SELECT ENAME,NVL(COMM,0)
FROM TBL_EMP;
--------------------------------------------------------------------------------


--�� DISTINCT() �ߺ� ��(���ڵ�)�� �����ϴ� �Լ�

-- TBL_EMP ���̺��� �����ڷ� ��ϵ� �����
-- �����ȣ, �����, �������� ��ȸ�Ѵ�.

SELECT *
FROM TBL_EMP;

SELECT �����ȣ, �����, ������
FROM TBL_EMP
WHERE �����ڷ� ��ϵ� ���;

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE �����ȣ = (������(MGR)�� ��ϵ� ���);

SELECT EMPNO, ENAME, JOB, MGR
FROM TBL_EMP
WHERE �����ȣ = (7902,7698,7698,7839,7698,7839,7839,7566,NULL,7698,7788,7698,7566,7782,7566,7566,7698,7698,7698);

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);
                
SELECT DISTINCT(MGR)
FROM TBL_EMP;
--==>>
/*
7839

7782
7698
7902
7566
7788
*/

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN( SELECT DISTINCT(MGR)
                FROM TBL_EMP );
--==>>
/*
7902    	FORD	ANALYST
7698	BLAKE	MANAGER
7839	KING	PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782	CLARK	MANAGER
*/

SELECT JOB
FROM TBL_EMP;

SELECT DISTINCT(JOB)
FROM TBL_EMP;
--==>>
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/

SELECT DEPTNO
FROM TBL_EMP;

SELECT DISTINCT(DEPTNO)
FROM TBL_EMP;
--==>>
/*
30

20
10
*/



--------------------------------------------------------------------------------

SELECT *
FROM TBL_SAWON;



--�� TBL_SAWON ���̺� ���(������ ����) �� �� ���̺� ���� ���質 �������� ���� ������ ����
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
-- TBL_SAWON ���̺��� �����͵鸸 ����� ����
-- ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ


--�� ������ ����
UPDATE TBL_SAWON
SET SANAME = '�ʶ���'
WHERE SANO = 1005;

UPDATE TBL_SAWON
SET SANAME = '�ʶ���';
COMMIT;     -- ���� �ȴ���

SELECT *
FROM TBL_SAWNO;

ROLLBACK;

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME = '�ʶ���';
--==>> 16�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> Ŀ�� �Ϸ�.