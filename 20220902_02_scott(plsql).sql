SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_�԰� ���̺� ���԰��̺�Ʈ �߻� ��...
--   ���� ���̺� ����Ǿ�� �ϴ� ����

-- �� INSERT �� TBL_�԰�

-- �� UPDATE �� TBL_��ǰ


--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_�԰� ���̺��� ������ �Է� �� �ƴ϶�
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�.
--   TBL_�԰� ���̺� ���� �÷� - ����
--   : �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--   ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

DESC TBL_��ǰ;
DESC TBL_�԰�;

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�          IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����          IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�          IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ          TBL_�԰�.�԰��ȣ%TYPE;
    
BEGIN
    SELECT (NVL(MAX(�԰��ȣ),0)) + 1 INTO V_�԰��ȣ 
    FROM TBL_�԰�;    
    --�԰� ���̺��� �������Է�
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�) VALUES (V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ� );
    --��ǰ ���̺� ������ UPDATE
    UPDATE TBL_��ǰ   
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

DROP PROCEDURE PRC_�԰�_INSERT;

COMMIT;


--������

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�            IN TBL_�԰�.��ǰ�ڵ�%TYPE -- IN TBL_��ǰ.��ǰ�ڵ�%TYPE (����)
, V_�԰����            IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�            IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ          TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    -- �Ʒ� �������� �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(�԰��ȣ),0)+1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    /*
    SELECT NVL(MAX(�԰��ȣ),0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    */
    --INSERT ������ ����
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�,  �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ� );
    /*
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�,  �԰����, �԰�ܰ�)
    VALUES((V_�԰��ȣ+1), V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ� )
    */
    --UPDATE ������ ����
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- �̿ܿ� �ٸ���Ȳ�� �߻��ϸ� ROLLBACK�ض�...
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

--���� ���ν��� �������� ���� ó�� ����--

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '���', '����' �� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
--   (��, �Է��� �õ��ϴ� ���)
--   ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν��� �� : PRC_MEMBER_INSERT()
/*
���� ��)
EXEC PRC_MEMBER_INSERT('�ӽÿ�','010-1111-1111','����');
--==>> ������ �Է� ��

EXEC PRC_MEMBER_INSERT('�躸��','010-2222-1111','�λ�');
--==>> ������ �Է� X

*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME                IN TBL_MEMBER.NAME%TYPE
, V_TEL                 IN TBL_MEMBER.TEL%TYPE
, V_CITY                IN TBL_MEMBER.CITY%TYPE
)
IS
    -- ���� ������ ������ ���������� �ʿ��� ���� �߰� ����
    V_NUM               TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK~!!!
    --������ ������Ÿ��;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    -- �ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    
    --IF(������ ���� ��� ��õ�� �ƴ϶��)
    IF (V_CITY NOT IN ('����','���','����'))
    --    THEN ���ܸ� �߻���Ű�ڴ�.  --JAVA�� ���ε�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- INSERT �������� �����ϱ⿡ �ռ�
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- ������ ���� �� INSERT
    INSERT INTO TBL_MEMBER(NUM,NAME,TEL,CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    --���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,���,������ �Է��� �����մϴ�.'); --�Լ�(������ȣ,'����') ������ȣ�� 20000�������� ��ü������ ����Ŭ�� ���
        WHEN OTHERS 
            THEN ROLLBACK;
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� ��� ������ �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ���� ó���Ѵ�.
--   ����, ��� ������ ��� �������� ���� ���...
--   ��� �׼� ó�� ��ü�� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���...)
--   ���ν��� �� : PRC_���_INSERT()
/*
���� ��)
EXEC PRC_���_INSERT ('H001', 50, 1000);

*/
DESC TBL_���;

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�            IN TBL_���.��ǰ�ڵ�%TYPE
, V_������            IN TBL_���.������%TYPE
, V_���ܰ�            IN TBL_���.���ܰ�%TYPE
)
IS
        V_����ȣ               TBL_���.����ȣ%TYPE;
        V_������               TBL_��ǰ.������%TYPE;
        
        USER_DEFINE_ERROR   EXCEPTION;
BEGIN
        
        SELECT NVL(MAX(����ȣ),0) + 1 INTO V_����ȣ
        FROM TBL_���;
        
        SELECT ������ INTO V_������
        FROM TBL_��ǰ
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        IF (V_������ > V_������)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
         
        --��� INSERT
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES(V_����ȣ,V_��ǰ�ڵ�,V_������,V_���ܰ�);
        
        --������Ʈ
        UPDATE TBL_��ǰ
        SET ������ = V_������ - V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        --���� ó��
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'�������� ���������� �����ϴ�.');
            WHEN OTHERS
                THEN ROLLBACK;
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.
DROP PROCEDURE PRC_���_INSERT;


-- ������ Ǯ��
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�            IN TBL_���.��ǰ�ڵ�%TYPE
, V_������            IN TBL_���.������%TYPE
, V_���ܰ�            IN TBL_���.���ܰ�%TYPE
)
IS
        -- ������ ������ ���� �߰� ���� ����
        V_����ȣ  TBL_���.����ȣ%TYPE;
        V_������  TBL_��ǰ.������%TYPE; -- ������Ÿ�� ����
        
        -- ����� ���� ���� ����
        USER_DEFINE_ERROR   EXCEPTION;
BEGIN

        -- ������ ���� ���������� ���θ� Ȯ���ϴ� ��������
        -- ��� �ľ� �� ������ ��� Ȯ���ϴ� ������ ����Ǿ�� �Ѵ�.
        -- �׷���... ��� ������ �񱳰� �����ϱ� ������...
        SELECT ������ INTO V_������
        FROM TBL_��ǰ
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        
        -- ��� ���������� �������� �������� ���� ���� Ȯ��
        -- �ľ��� ���������� �������� ������ ���� �߻�
        IF (V_������ > V_������)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        
        -- ������ ������ �� ��Ƴ���
        SELECT NVL(MAX(����ȣ),0) INTO V_����ȣ
        FROM TBL_���;
        
        
        -- ������ ���� �� INSERT(TBL_���)
        --INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        --VALUES(?????,V_��ǰ�ڵ�,V_������,V_���ܰ�);
        INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES((V_����ȣ + 1),V_��ǰ�ڵ�,V_������,V_���ܰ�);
        
        -- ������ ���� �� UPDATE(TBL_��ǰ)
        UPDATE TBL_��ǰ
        SET ������ = ������ - V_������
        WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
        
        --���� ó��
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'��� ����~!!!');
                     ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.





--�� TBL_��� ���̺��� ��� ������ ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--   ���ν��� �� : PRC_���_UPDATE()
/*
���� ��)
CREATE PRC_���_UPDATE(����ȣ, �����Ҽ���);
*/
DESC TBL_���;

DROP PROCEDURE PRC_���_UPDATE;


CREATE OR REPLACE PROCEDURE PRC_���_UPDATE 
(
    -- �� �Ű����� ����
  V_����ȣ            IN TBL_���.����ȣ%TYPE
, V_������            IN TBL_���.������%TYPE     --���� ����
)
IS
    -- �� �ʿ��� ���� �߰� ����
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_����������    TBL_���.������%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
    
    -- �� ����
    USER_DEFINE_ERROR EXCEPTION;
BEGIN

    -- �� ������ ������ �� ��Ƴ���
    -- ��ǰ�ڵ�� ���������� �ľ�
    /*
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    SELECT ������ INTO V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    */

    SELECT ��ǰ�ڵ�, ������ INTO V_��ǰ�ڵ�, V_����������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- �� ������ �� ��ǰ�ڵ带 Ȱ���Ͽ� ������ �ľ�
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- �� ��� ���� ���࿩�� �Ǵ� �ʿ�
    --    ���� ������ ������ �� ������ ������ Ȯ��
    --IF (�ľ��� �������� ������ �������� ��ģ ���� ������ ���������� ������ ���ܸ� �߻���Ű�����Ѵ�.)
    --END IF;
    IF (V_������ + V_���������� < V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- �� ����� ������ üũ(UPDATE �� TBL_��� / UPDATE �� TBL_��ǰ)
    UPDATE TBL_���
    SET ������ = V_������
    WHERE ����ȣ = V_����ȣ;
    
    -- ��
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_���������� - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
     WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002,'��� ����~!!!');
             ROLLBACK;
     WHEN OTHERS
        THEN ROLLBACK;
    
    -- �� Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.

-- ����
/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����) ���_UPDATE�ߴ��� ó��
2. PRC_�԰�_DELETE(�԰��ȣ) 
3. PRC_���_DELETE(����ȣ) �԰�_INSERTó�� ���ڵ� ���� (����Ŵ�)
*/
--÷������, ���� ����
--�׽�Ʈ ĸ�Ļ��� 


--------------------------------------------------------------------------------

--���� Ŀ�� ����--

--1. ����Ŭ������ �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������
--   �۾� �������� SQL ���� �����ϰ� �� �������� �߻��� �����͸�
--   �����ϱ� ���� Ŀ��(CURSOR)�� ����ϸ�,
--   Ŀ������ �Ͻ����� Ŀ���� ������� Ŀ���� �ִ�.

--2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�
--   SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--   �׷��� SQL ���� ������ �����(RESULT SET)��
--   ���� ��(ROW)���� ������ ���
--   Ŀ��(CURSOR)�� ��������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�.

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '-' || V_TEL);
END;
--==>> ȫ�浿 -- 011-2356-4528

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '-' || V_TEL);
END;
--==>> ���� �߻�
--      ORA-01422: exact fetch returns more than requested number of rows

--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� �� - �ݺ��� Ȱ��)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || '-' || V_TEL);
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1602;
        
    END LOOP;
    
END;

--�� Ŀ�� �̿� �� ��Ȳ
DECLARE
    -- �����
    -- �ֿ� ���� ����
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
    /*
    ������ ������Ÿ��
    V_RESULT            NUMBER
    USER_DEFINE_ERROR   EXCEPTION;
    */
    
    /*
    ���̺� ����(����)
    ����� ����(����)
    �Լ� ����
    ���ν��� ����
    
    TABLE ���̺��
    INDEX �ε�����
    USER ������
    FUNCTION �Լ���
    PROCEDURE ���ν�����
    */
BEGIN
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� ���� �� ����� ������ �����͵� ó��
    LOOP
        -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        -- Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����
        -- ��, Ŀ�� ���ο��� �� �̻��� �����͸� ã�� �� ���� ����
        -- �� �׸�~~!!! �ݺ��� ����������
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
                    --Ŀ���̸�
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_INSA_SELECT;
    
END;
--------------------------------------------------------------------------------