SELECT USER
FROM DUAL;
--==>> SCOTT


--�� ������ �Լ� ���� �۵����� Ȯ��
--   �Լ��� : FN_PAY()

SELECT NUM,NAME,BASICPAY,SUDANG
     , FN_PAY(BASICPAY,SUDANG)
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--�� ������ �Լ� ���� �۵����� Ȯ��
--   �Լ��� : FN_WORKYEAR()

SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
ȫ�浿	1998-10-11	23.9
�̼���	2000-11-29	21.7
�̼���	1999-02-25	23.5
������	2000-10-01	21.9
�Ѽ���	2004-08-13	18
�̱���	2002-02-11	20.5
����ö	1998-03-16	24.4
�迵��	2002-04-30	20.3
������	2003-10-10	18.9
������	1997-08-08	25
������	2000-07-07	22.1
���ѱ�	1999-10-16	22.8
���̼�	1998-06-07	24.2
Ȳ����	2002-02-15	20.5
������	1999-07-26	23.1
�̻���	2001-11-29	20.7
�����	2000-08-28	22
�̼���	2004-08-08	18
�ڹ���	1999-12-10	22.7
������	2003-10-10	18.9
ȫ�泲	2001-09-07	20.9
�̿���	2003-02-25	19.5
���μ�	1995-02-23	27.5
�踻��	1999-08-28	23
�����	2000-10-01	21.9
�����	2002-08-28	20
�迵��	2000-10-18	21.8
�̳���	2001-09-07	20.9
�踻��	2000-09-08	21.9
������	1999-10-17	22.8
����ȯ	2001-01-21	21.6
�ɽ���	2000-05-05	22.3
��̳�	1998-06-07	24.2
������	2005-09-26	16.9
������	2002-05-16	20.3
���翵	2003-08-10	19
�ּ���	1998-10-15	23.8
���μ�	1999-11-15	22.8
������	2003-12-28	18.6
�ڼ���	2000-09-10	21.9
�����	2001-12-10	20.7
ä����	2003-10-17	18.8
��̿�	2003-09-24	18.9
����ȯ	2004-01-21	18.6
ȫ����	2003-03-16	19.4
����	1999-05-04	23.3
�긶��	2001-07-15	21.1
�̱��	2001-06-07	21.2
�̹̼�	2000-04-07	22.4
�̹���	2003-06-07	19.2
�ǿ���	2000-06-04	22.2
�ǿ���	2000-10-10	21.9
��̽�	1999-12-12	22.7
����ȣ	1999-10-16	22.8
���ѳ�	2004-06-07	18.2
������	2004-08-13	18
�̹̰�	1998-02-11	24.5
�����	2003-08-08	19
�Ӽ���	2001-10-10	20.9
��ž�	2001-10-10	20.9
*/


--------------------------------------------------------------------------------


-- ���ν��� ���� �ǽ� ����

-- �ǽ� ���̺� ����
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(30)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.

-- �ǽ� ���̺� ����
CREATE TABLE TBL_IDPW
( ID        VARCHAR2(10)
, PW        VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW��(��) �����Ǿ����ϴ�.


-- �� ���̺��� ������ �Է�
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '�ֵ���', '010-1111-1111', '���ֵ� ��������');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java002$');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

-- Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>> superman	�ֵ���	010-1111-1111	���ֵ� ��������

SELECT *
FROM TBL_IDPW;
--==>> superman	java002$

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


-- ���� ������ �����ϴ� ���ν���(INSERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
-- EXECUTE PRC_STUDENTS_INSERT('batman','java002$','���¹�','010-2222-2222','���� ������');
-- EXEC PRC_STUDENTS_INSERT('batman','java002$','���¹�','010-2222-2222','���� ������');
-- �̿� ���� ���� �� �ٷ� ���� ���̺��� ��� ����� �Է��� �� �ִ�.


--�� ���ν��� ���� ������
--   20220901_01_scott(plsql).sql ���� ����~!!!

--�� ���ν��� ȣ���� ���� Ȯ��
EXECUTE PRC_STUDENTS_INSERT('batman','java002$','���¹�','010-2222-2222','���� ������');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� ���ν��� ȣ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	�ֵ���	010-1111-1111	���ֵ� ��������
batman	���¹�	010-2222-2222	���� ������
*/
SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java002$
batman	java002$
*/


--�� �ǽ� ���̺� ����(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN        NUMBER
, NAME          VARCHAR2(40)
, KOR           NUMBER(3)
, ENG           NUMBER(3)
, MAT           NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK��(��) �����Ǿ����ϴ�.


--�� ������ ���̺��� �÷� �߰�
--   (���� �� TOT, ��� �� AVG, ��� �� GRADE)
ALTER TABLE TBL_SUNGJUK
ADD (TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK��(��) ����Ǿ����ϴ�.

--�� ���⼭ �߰��� �÷��� ���� �׸���
--   ���ν��� �ǽ��� ���� �߰��� ���� ��
--   ���� ���̺� ������ ����������, �ٶ��������� ���� �����̴�.

--   ���������� ���� �� �ִ� ���� �÷�ȭ ��Ű�� �ʴ´�.


-- �� ����� ���̺� ���� Ȯ��
DESC TBL_SUNGJUK;
--==>>
/*
�̸�     ��?       ����           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)      
*/


--�� ���ν��� ���� ������
--   20220901_01_scott(plsql).sql ���� ����~!!!
SELECT *
FROM TBL_SUNGJUK;
--==>> ��ȸ ��� ����

EXEC PRC_SUNGJUK_INSERT(1,'���ҿ�',90,80,70);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	���ҿ�	90	80	70	240	80	B



EXEC PRC_SUNGJUK_INSERT(2,'���̰�',80,70,60);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_SUNGJUK_INSERT(3,'�ӽÿ�',80,70,60);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_SUNGJUK_INSERT(4,'������',54,63,72);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_SUNGJUK_INSERT(5,'������',44,33,22);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--==>>
/*
1	���ҿ�	90	80	70	240	80	B
2	���̰�	80	70	60	210	70	C
3	�ӽÿ�	80	70	60	210	70	C
4	������	54	63	72	189	63	D
5	������	44	33	22	99	33	F
*/
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_SUNGJUK_UPDATE(3,82,71,60);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_SUNGJUK_UPDATE(5,100,99,98);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--==>>
/*
1	���ҿ�	50	50	50	150	50	F
2	���̰�	80	70	60	210	70	C
3	�ӽÿ�	82	71	60	213	71	C
4	������	54	63	72	189	63	D
5	������	100	99	98	297	99	A
*/
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
SELECT *
FROM TBL_STUDENTS;





SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 2;
--==>> ��ȸ ��� ����

SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 1;
  --==>>
  /*
  7369	SMITH	CLERK	20
7566	JONES	MANAGER	20
7788	SCOTT	ANALYST	20
7876	ADAMS	CLERK	20
7902	FORD	ANALYST	20
  */
  



--�� ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '������ Ⱦ��');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
ON T1.ID = T2.ID;
--==>>
/*
superman	    java002$	010-9876-5432	������ Ⱦ��
batman	    java002$	010-2222-2222	���� ������
*/


EXEC PRC_STUDENTS_UPDATE('batman', '1234', '010-9999-8888', '���� ���α�');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
/*
superman	    java002$	010-9876-5432	������ Ⱦ��
batman	    java002$	010-2222-2222	���� ������
*/
EXEC PRC_STUDENTS_UPDATE('batman', 'java002$', '010-9999-8888', '���� ���α�');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
/*
superman	    java002$	010-9876-5432	������ Ⱦ��
batman	    java002$	010-9999-8888	���� ���α�
*/


--�� ���ν��� ȣ���� ���� Ȯ��
EXEC PRC_INSA_INSERT('������', '970124-2234567', SYSDATE, '����', '010-7202-6306', '���ߺ�', '�븮', 2000000, 2000000);
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���ν��� ���� ������ ������ ���ٷ� ������ ��




--�� �ǽ� ���̺� ����(TBL_��ǰ)
-- �ǹ������� ���� �ѱ� �̸����� ��������
CREATE TABLE TBL_��ǰ
( ��ǰ�ڵ�              VARCHAR2(20)
, ��ǰ��                VARCHAR2(100)
, �Һ��ڰ���            NUMBER
, �������              NUMBER DEFAULT 0
, CONSTRAINT ��ǰ_��ǰ�ڵ�_PK PRIMARY KEY(��ǰ�ڵ�)
);
--==>> Table TBL_��ǰ��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����(TBL_�԰�)
CREATE TABLE TBL_�԰�
( �԰���ȣ  NUMBER
, ��ǰ�ڵ�  VARCHAR2(20)
, �԰�����  DATE DEFAULT SYSDATE
, �԰�����  NUMBER
, �԰��ܰ�  NUMBER
, CONSTRAINT �԰�_�԰���ȣ_PK PRIMARY KEY(�԰���ȣ)
, CONSTRAINT �԰�_��ǰ�ڵ�_FK FOREIGN KEY(��ǰ�ڵ�)
              REFERENCES TBL_��ǰ(��ǰ�ڵ�)
);
--==>> Table TBL_�԰�(��) �����Ǿ����ϴ�.

--�� TBL_��ǰ ���̺��� ��ǰ ������ �Է�
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C001', '������', 1500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C002', '������', 1500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C003', '�����', 1300);  
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C004', '������', 1800);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('C005', '������', 1900);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 5
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H001', '��ũ����', 1000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H002', 'ĵ���', 300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H003', '�ֹֽ�', 500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H004', '������', 600);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('H005', '�޷γ�', 500);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 5
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E001', '�������̽�', 2500);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E002', '�ؾ�θ���', 2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E003', '���Ǿ�', 2300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E004', '�źϾ�', 2300);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E005', '��Ű��', 2400);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E006', '��ȭ��', 2000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E007', '���Դ�', 3000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E008', '������Ʈ', 3000);
INSERT INTO TBL_��ǰ(��ǰ�ڵ�, ��ǰ��, �Һ��ڰ���) VALUES('E009', '������', 3000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 9

--�� Ȯ��
SELECT *
FROM TBL_��ǰ;
--==>>
/*
C001	������	    1500	0
C002	������	    1500	0
C003	�����    	1300	0
C004	������	    1800	0
C005	������	    1900	0
H001	��ũ����	    1000	0
H002	ĵ���	    300	    0
H003	�ֹֽ�	    500	    0
H004	������	    600	    0
H005	�޷γ�	    500	    0
E001	�������̽�	2500	0
E002	�ؾ�θ���	2000	0
E003	���Ǿ�	    2300	0
E004	�źϾ�	    2300	0
E005	��Ű��	    2400	0
E006	��ȭ��	    2000	0
E007	���Դ�	    3000	0
E008	������Ʈ	3000	0
E009	������	    3000	0
*/
--Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.