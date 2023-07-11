select user
from dual;
--==>> SYS


select 1+5
from dual;
--==>> 6

select   1+5
from dual;
--==>> 6

select ������ �����ϱ⸸ �� ����Ŭ ����
from dual;
--==>> ���� �߻�

select "������ �����ϱ⸸ �� ����Ŭ ����"
from dual;
--==>> ���� �߻�

select '������ �����ϱ⸸ �� ����Ŭ ����'
from dual;
--==>> ������ �����ϱ⸸ �� ����Ŭ ����

select 3.14 + 3.14
from dual;
--==>> 6.28

select 10 * 5
from dual;
--==>> 50

SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2
FROM DUAL;
--==>> 2

SELECT 4 / 2.0
FROM DUAL;
--==>> 2

SELECT 4.0 / 2.0
FROM DUAL;
--==>> 2

SELECT 5 / 2
FROM DUAL;
--==>> 2.5

SELECT 100 - 23
FROM DUAL;
--==>> 77

SELECT 100 - 3.14
FROM DUAL;
--==>> 96.86

SELECT '���¹�' + '������'
FROM DUAL;
--==>> ���� �߻�
-- (ORA-01722: invalid number)

-- �� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
--SELECT USERNAME, ACCOUNT_STATUS
--FROM DBA_USERS
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
HR	                EXPIRED & LOCKED
*/

--SELECT *
--FROM DBA_USERS;
/*
SYS	0		OPEN		23/02/06	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	5		OPEN		23/02/06	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	9		EXPIRED & LOCKED	22/08/10	22/08/10	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	42		EXPIRED & LOCKED	14/05/29	22/08/10	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	32		EXPIRED & LOCKED	22/08/10	22/08/10	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	

TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
HR	43		EXPIRED & LOCKED	22/08/10	22/08/10	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
*/

/*
�ۼ� ���� ���� �߻�
    SELECT DEFAULT_TABLESPACE, USERNAME
    FROM DUAL;
*/

-->��DBA_���� �����ϴ� Oracle Data Dictionary View��
--  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--  ���� ������ ��ųʸ� ������ ���� ���ص� �������.

--�� ��HR�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� �ٽ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
        :
HR	EXPIRED & LOCKED
        :
*/


--�� ��HR�� ����� ������ �н����带 lion���� ����
ALTER USER HR IDENTIFIED BY lion;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ��HR�� ����� ������ ����� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

SELECT USER
FROM DUAL;
--==>> SYS


--�� ��HR�� ����� ������ �ٽ� ���
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

--�� ��HR�� ����� ������ ����� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.

-------------------------------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--> ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--  ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA          -- �����ϰڴ�. ���̺����̽���... TBS_EDUA��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA.DBF' -- ������ ������ ���� ��� �� �̸�
SIZE 4M                             -- ������(�뷮) 4�ް�
EXTENT MANAGEMENT LOCAL             -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;      -- ���׸�Ʈ ���� ������ ����Ŭ ������ �˾Ƽ� ����

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �ش� ����� �������� ���͸� ���� �ʿ�

--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.


--�� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES;
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING
*/

--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES
WHERE FILE_NAME LIKE '%TBS_EDUA%';
--==>>C:\TESTDATA\TBS_EDUA.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE

--�� ����Ŭ ����� ���� ����
CREATE USER janghyunsung IDENTIFIED BY java002$
DEFAULT TABLESPACE TBS_EDUA;
--> janghyunsung �̶�� ����� ������ �����ϰڴ�. (����ڴ�.)
--  �� ����� ������ �н������ java002$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ��ü��(���׸�Ʈ��)
--  �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ���(�����������)
--  �����ϰڴ�.
--==>> User JANGHYUNSUNG��(��) �����Ǿ����ϴ�.


--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)�� ���� ���� �õ�
--   �� ���� �Ұ�(����)
--   ��create session�� ������ ���� ������ ���� �Ұ�.


--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)��
--   ����Ŭ ���� ������ ������ �� �ֵ��� create session ���� �ο�
GRANT CREATE SESSION TO JANGHYUNSUNG;
--==>> Grant��(��) �����߽��ϴ�.



--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)��
--   ���̺� ������ ������ �� �ֵ��� CREATE TABLE ���� �ο�

GRANT CREATE TABLE TO JANGHYUNSUNG;
--==>> Grant��(��) �����߽��ϴ�.

--�� ������ ����Ŭ ����� ����(���� ������ �̸� ����)��
--   ���̺����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����
ALTER USER JANGHYUNSUNG
QUOTA UNLIMITED ON TBS_EDUA;
----- --------- -------------
--�Ҵ緮  3M    ���̺����̽�

--==>> User JANGHYUNSUNG��(��) ����Ǿ����ϴ�. 

--------------------------------------------------------------------------------
-- SCOTT ������ Ȱ���� �� �ִ� ����
--�� ����� ���� ����(SCOTT / TIGER)
create user scott
identified by tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

--�� ����� ������ ����(��) �ο�
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.

--�� SCOTT ����� �����Ǳ⺻ ���̺����̽��� USERS�� ����(����)
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.

--�� SCOTT ����� ������ �ӽ� ���̺����̽��� TEMP�� ����(����)
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.



