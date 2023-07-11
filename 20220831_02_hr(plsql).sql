SELECT USER
FROM DUAL;
--==>> HR

SET SERVEROUTPUT ON;

--�� %TYPE

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� �ڷ���(������Ÿ��)�� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ���̺��, �÷���%TYPE [:= �ʱⰪ];

--�� HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
DESC EMPLOYEES;

-- �̸�(FIRST_NAME) �÷� Ȯ�� �� VARCHAR2(20)

DECLARE
        --V_NAME  VARCHAR2(20); -- FIRST_NAME�� �������� VARCHAR2(20)
        V_NAME  EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
        SELECT FIRST_NAME INTO V_NAME
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 103;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander



--�� EMPLOYEES ���̺��� ������� 108�� ���(Nancy)��
--   SALARY �� ������ ��� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

DECLARE
        V_SALARY    EMPLOYEES.SALARY%TYPE;
BEGIN
        SELECT SALARY INTO V_SALARY
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 108;
        
        DBMS_OUTPUT.PUT_LINE(V_SALARY);
END;
--==>> 12008 

--�� EMPLOYEES ���̺��� Ư�� ���ڵ� �׸� �������� ������ ����
--   103�� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���

DECLARE
        V_FIRST_NAME        EMPLOYEES.FIRST_NAME%TYPE;
        V_PHONE_NUMBER      EMPLOYEES.PHONE_NUMBER%TYPE;
        V_EMAIL             EMPLOYEES.EMAIL%TYPE;
BEGIN
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
               INTO V_FIRST_NAME, V_PHONE_NUMBER, V_EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 103;
        
        DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE(V_PHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE(V_EMAIL);
END;


--�� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;
DECLARE
        -- V_FIRST_NAME        EMPLOYEES.FIRST_NAME%TYPE;
        -- V_PHONE_NUMBER      EMPLOYEES.PHONE_NUMBER%TYPE;
        -- V_EMAIL             EMPLOYEES.EMAIL%TYPE;
        V_EMP           EMPLOYEES%ROWTYPE;
BEGIN
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
               INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 103;
        
        -- DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME || ', ' ||  V_PHONE_NUMBER || ', ' || V_EMAIL);
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' ||  V_EMP.PHONE_NUMBER || ', ' || V_EMP.EMAIL);
END;

--�� EMPLOYEES ���̺��� ��ü ���ڵ� �׸� �������� ������ ����
--   ��� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���

DECLARE
        V_EMP           EMPLOYEES%ROWTYPE;
BEGIN
        SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
          INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
        FROM EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' ||  V_EMP.PHONE_NUMBER || ', ' || V_EMP.EMAIL);
END;
--==>> exact fetch returns more than requested number of rows
--      ���� �߻�

--> ���� ���� ��(ROWS) ������ ���� �������� �ϸ�
--  ������ �����ϴ� �� ��ü�� �Ұ���������.

SELECT *
FROM EMPLOYEES;
