SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;

--�� TBL_INSA ���̺��� ���� ���� ������ �������� ������ ����
--   (�ݺ��� Ȱ��)

DECLARE
        V_INSA      TBL_INSA%ROWTYPE;
        V_NUM       TBL_INSA.NUM%TYPE  := 1001;

BEGIN
        LOOP
                -- ��ȸ
                SELECT NAME, TEL, BUSEO
                       INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
                FROM TBL_INSA
                WHERE NUM = V_NUM;          -- 1001
                
                -- ���
                DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - ' || V_INSA.BUSEO);
                
                -- ������
                V_NUM := V_NUM + 1;
                
                EXIT WHEN V_NUM > 1060;
        END LOOP;
END;


--------------------------------------------------------------------------------

--���� FUNCTION(�Լ�) ����--
-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ�ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXCUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[( �Ű�������1 �ڷ���
   �Ű�������2 �ڷ���
)]
RETURN ������Ÿ�� (���๮�� �ִ� RETURN ���� ������Ÿ��)
IS
            -- �ֿ� ���� ����
BEGIN
            -- ���๮;
            ...
            RETURN (��);
            
            [EXCEPTION]
                    -- ���� ó�� ����;
END;
*/


--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNN'

DESC TBL_INSA;
--==>>
/*
SSN �� VARCHAR2(14) 
*/

--CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2(14) )      -- �Ű�����   : �ڸ���(����) ���� ����
CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
--RETURN VARCHAR2(24)                                             -- ��ȯ�ڷ��� : �ڸ���(����) ���� ����
RETURN VARCHAR2
IS -- DECLARE �� IS�� �ٲ�
        -- ����� �� �ֿ� ���� ����
        V_RESULT        VARCHAR2(24);
BEGIN
        -- ����� �� ���� �� ó��
        
        -- ����� ��ȯ CHECK~!!!
END;






CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
RETURN VARCHAR2
IS 
        -- ����� �� �ֿ� ���� ����
        V_RESULT        VARCHAR2(24);
BEGIN
        -- ����� �� ���� �� ó��
        IF (�ֹι�ȣ 8��° �ڸ� 1���� '2' �Ǵ� '4')
                THEN ��������� '����' ��Ƴ���
        ELSIF (�ֹι�ȣ 8��° �ڸ� 1���� '1' �Ǵ� '3')
                THEN ��������� '����' ��Ƴ���
        ELSE
                ��������� '����Ȯ�κҰ�' ��Ƴ���
        END IF;
        
        -- ����� ��ȯ CHECK~!!!
        RETURN V_RESULT;
END;






CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
RETURN VARCHAR2
IS 
        -- ����� �� �ֿ� ���� ����
        V_RESULT        VARCHAR2(24);
BEGIN
        -- ����� �� ���� �� ó��
        IF (SUBSTR(V_SSN,8,1) IN('2','4'))
                THEN V_RESULT := '����';
        ELSIF (SUBSTR(V_SSN,8,1) IN('1','3'))
                THEN V_RESULT := '����';
        ELSE
                V_RESULT := '����Ȯ�κҰ�';
        END IF;
        
        -- ����� ��ȯ CHECK~!!!
        RETURN V_RESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.

--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A,B)
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
-- �Լ��� : FN_POW()
-- ��� ��)
/*
SELECT FN_POW (10, 3)
FROM DUAL;
--==>> 1000
*/

/*
FN_POW(1O,3) �� 1000
        1 * 10 * 10 * 10 = 1000
        0 * 10 * 10 * 10 = 0
*/



CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
        -- ����� �� �ֿ� ���� ����
        V_RESULT    NUMBER := 1;
        V_NUM       NUMBER;
BEGIN
        -- ����� �� ���� �� ó��
        FOR V_NUM IN 1 .. B LOOP
            V_RESULT := V_RESULT * A;
        END LOOP;
        
        RETURN V_RESULT;
END;
--==>>Function FN_POW��(��) �����ϵǾ����ϴ�.


--�� TBL_INSA ���̺� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻��*12)+���硻 ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)

CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER ,SUDANG NUMBER)
RETURN NUMBER
IS
    --�����
    V_RESULT        NUMBER :=0;
BEGIN
    --�����
    V_RESULT := (BASICPAY*12) + SUDANG;
    
    RETURN V_RESULT;
END;




