SELECT USER
FROM DUAL;
--==>> SCOTT

--�� TBL_INSA ���̺� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻��*12)+���硻 ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)

-- ������ �ۼ� FN_PAY ����
CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER, V_SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT    NUMBER;
BEGIN
    V_RESULT := (NVL(V_BASICPAY,0) * 12) + NVL(V_SUDANG, 0);
    
    RETURN V_RESULT;
    
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.


--�� TBL_INSA ���̺��� �Ի����� ��������
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)

CREATE OR REPLACE FUNCTION FN_WORKYEAR (V_IBSADATE DATE)
RETURN NUMBER
IS
    --����� (�ֿ� ���� ����)
    V_RESULT        NUMBER;
BEGIN
    --�����
    V_RESULT := TRUNC(((SYSDATE-V_IBSADATE)/365),1);
    
    RETURN V_RESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


DROP FUNCTION FN_WORKYEAR;

--������ Ǯ��
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12) || '��' ||
     , TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'),12)) ||'����'
FROM DUAL;

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '2002-02-11')/12) || '��' ||
     , TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, '2002-02-11'),12)) ||'����'
FROM DUAL;

--3
SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)"�ٹ��Ⱓ"
FROM DUAL;

CREATE OR REPLACE FUNTION FN_WORKYEAR(V_IBSADATE DATE)
RETURN VARHAR2
IS
    V_RESULT    VARCHAR2(20);
BEGIN
    V_RESULT := TRUNC(MONTHS_BEWEEN(SYSDATE, V_IBSADATE)/12)||'��'
                TRUNC(MOD(MONTHS_BEWEEN(SYSDATE, V_IBSADATE),12))||'����'
                
                RETURN V_RESULT;
END;

--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML (Data Manipulation Language) ����
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)   -- ������ ����, ������ ����, ������ ����
--==>> DDL(Data Definition Language) ����
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language) ����


/*
INSERT
INSERT
UPDATE
UPDATE

SELECT

CREATE

ROLLBACK
CREATE�� �����ϸ� �ڵ����� COMMIT �Ǳ� ������ ROLLBACK�� �����ص� ���� �� ����. 
*/

--------------------------------------------------------------------------------


--���� PROCEDURE(���ν���) ����--


-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [-- �ֿ� ���� ����]
BEGIN
    -- ���౸��;
    ...
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

-- �� FUNCTION �� ������ ��
--    ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--    ��RETURN�� �� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű�������
--    IN, OUT, INOUT ���� ���еȴ�.


-- 3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/


-- ���ν��� ���� �ǽ� ������ ����
-- 20220901_02_cott.sql ���Ͽ�
-- ���̺� ���� �� ������ �Է� ����



--�� ���ν��� ����
-- ���ν��� �� : PRC_STUDENTS_INSERT(���̵�, �н�����, �̸�, ��ȭ, �ּ�)

-- ���ν��� �⺻ Ʋ
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
(���̵�, �н�����, �̸�, ��ȭ, �ּ�
)
IS
BEGIN
END;


CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID          IN TBL_IDPW.ID%TYPE
, V_PW          IN TBL_IDPW.PW%TYPE
, V_NAME        IN TBL_STUDENTS.NAME%TYPE
, V_TEL         IN TBL_STUDENTS.TEL%TYPE
, V_ADDR        IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
END;



CREATE OR REPLACE PROCEDURE PRC_STUDENTS_
( V_ID          IN TBL_IDPW.ID%TYPE
, V_PW          IN TBL_IDPW.PW%TYPE
, V_NAME        IN TBL_STUDENTS.NAME%TYPE
, V_TEL         IN TBL_STUDENTS.TEL%TYPE
, V_ADDR        IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT��(��) �����ϵǾ����ϴ�.



--�� TBL_SUNGJUK ���̺� ������ �Է� ��
--   Ư�� �׸��� �����͸� �Է��ϸ�
--   ------------------
--   (�й�, �̸�, ��������, ��������, ��������)
--   ���������� ����, ���, ��� �׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '���ҿ�', 90, 80, 70);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 1   ���ҿ�    90          80          70       240    80     B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT         TBL_SUNGJUK.TOT%TYPE;
    V_AVG         TBL_SUNGJUK.AVG%TYPE;
    V_GRADE       TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := TRUNC(V_TOT/3);
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF(V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF(V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF(V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
   
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME,KOR,ENG,MAT,TOT,AVG,GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    COMMIT;
END;

DROP PROCEDURE PRC_SUNGJUK_INSERT;




-- �������� Ǯ��
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  
, V_NAME    
, V_KOR     
, V_ENG     
, V_MAT     
)
IS
BEGIN
END;



CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAMG%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
BEGIN
END;



CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAMG%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� ����
BEGIN

    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, ????, ????, ????);
END;




CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAMG%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- ���� ��
    -- INSERT �������� �����ϱ� ����
    -- ����ο��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    -- V_GRADE := ��Ȳ�� ���� �б� �ʿ�~!!!;
     IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF(V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF(V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF(V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    --Ŀ��
    COMMIT;
END;




--�� TBL_SUNGJUK ���̺��� Ư�� �л��� ���� ������ ���� ��
--   Ư�� �׸��� �����͸� �Է��ϸ�
--   ------------------
--   (�й�, ��������, ��������, ��������)
--    ���������� ����, ���, ��� �׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--    ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);

�� ���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 1   ���ҿ�    50          50          50       150    50     F
*/


CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HACBUN      IN TBL_SUNGJUK.HACBUN%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MOT%TYPE
)
IS
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := TRUNC(V_TOT / 3);
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF(V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF(V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF(V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE 
        THEN V_GRADE := 'F';
    END IF;
    
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG,MAT = V_MAT
    WHERE HACBUN = V_HACBUN;
END;



--��������
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
BEGIN
END;




CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- �����
    -- UPDATE ������ ������ ���� �ʿ��� �ֿ� ���� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
    
BEGIN
    -- �����
    -- UPDATE ������ ���࿡ �ռ� �߰��� ������ �ֿ� �����鿡 �� ��Ƴ���
    V_TOT := V_KOR + V_ENG +V_MAT;
    V_AVG := (TRUNC(V_TOT / 3));
    IF(V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF(V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF(V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF(V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE V_GRADE := 'F';
    END IF;
    -- UPDATE ������ ����
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ��
    COMMIT;
    
END;

DROP PROCEDURE PRC_SUNGJUK_UPDATE;









CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
  V_TOT     TBL_SUNGJUK.TOT%TYPE;
  V_AVG     TBL_SUNGJUK.AVG%TYPE;
  V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
  -- ���� �� ó��
  V_TOT := V_KOR + V_ENG + V_MAT;
  V_AVG := TRUNC(V_TOT/3);
  V_GRADE := (CASE (V_AVG/10) WHEN 9 THEN 'A'
                              WHEN 8 THEN 'B'
                              WHEN 7 THEN 'C'
                              WHEN 6 THEN 'D'
                              ELSE 'F'
                              END);

  -- TBL_SUNGJUK ������Ʈ ���� ���� ����
  UPDATE TBL_SUNGJUK
  SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, AVG = V_AVG, GRADE = V_GRADE
  WHERE HAKBUN = V_HAKBUN;
  
  -- Ŀ��
  COMMIT;

END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '������ Ⱦ��');
--> �н����� ��ġ���� ���� --==>> ������ ���� X

EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '������ Ⱦ��');
--> �н����� ��ġ�� --==>> ������ ���� ��

*/

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE        
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- �����
    UPDATE (SELECT I.ID, I.PW, S.TEL, S.ADDR
            FROM TBL_STUDENTS S JOIN TBL_IDPW I
            ON S.ID = I.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.






--�������� Ǯ��

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
(
)
IS
BEGIN
END;

--�� ���
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID              IN TBL_IDPW.ID%TYPE
, V_PW              IN TBL_IDPW.PW%TYPE
, V_TEL             IN TBL_STUDENTS.TEL%TYPE
, V_ADDR            IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE(SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
           FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
           ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL , T.ADDR = V_ADDR
    WHERE T.ID = V_ID
      AND T.PW = V_PW;
      
      COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.


--�� ���
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID              IN TBL_IDPW.ID%TYPE
, V_PW              IN TBL_IDPW.PW%TYPE
, V_TEL             IN TBL_STUDENTS.TEL%TYPE
, V_ADDR            IN TBL_STUDENTS.ADDR%TYPE
)
IS
    -- �ʿ��� ���� ����
    V_PW2           TBL_IDPW.PW%TYPE;
    V_FLAG          NUMBER := 0;
BEGIN
    -- �н����尡 �´��� Ȯ��
    -- (����ڰ� �Է��� V_PW �� ���� �н������ �������� Ȯ��)
    SELECT PW INTO V_PW2    --V_PW2�� ��ڴ�.
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    -- �н����� ��ġ ���ο� ���� �б�
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG := 2;
    END IF;
    
    -- UPDATE ������ ���� �� TBL_STUDENTS (�б� ���)
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�


--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   ���� ������ �÷� ��
--   NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--   �� ������ �Է� ��
--   NUM �÷�(�����ȣ)�� ����
--   ���� �ο��� ��� ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó���� �� �ִ�
--   ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_INSA_INSERT()
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970124-2234567', SYSDATE, '����', '010-7202-6306'
                   , '���ߺ�', '�븮', 2000000, 2000000);
�� ���ν��� ȣ��� ó���� ���
1061 ������ 970124-2234567, SYSDATE, ����, 010-7202-6306, ���ߺ�, �븮, 2000000, 2000000
�� �����Ͱ� �ű� �Էµ� ��Ȳ
*/
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NUM)+1 INTO V_NUM
    FROM TBL_INSA;
             
    INSERT INTO TBL_INSA(NUM,NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM,V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM       TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NUM)+1 INTO V_NUM -- V_NUM�� ��ڴ�.
    FROM TBL_INSA;
             
    INSERT INTO TBL_INSA(NUM,NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM,V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);

    --Ŀ��
    COMMIT;
END;





DROP PROCEDURE PRC_INSA_INSERT;

-- TBL_INSA���̺��� NUM�� �ִ밪
SELECT MAX(NUM)
FROM TBL_INSA;
--==>> 1060

SELECT MAX(NUM) + 1
FROM TBL_INSA;

-- MAX(NUM) + 1 ������ ���(������)
-- NUM := MAX(NUM) = 1;
-- V_NUM := 1;



--������ Ǯ��

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME        IN TBL_INSA.NAME%TYPE
, V_SSN         IN TBL_INSA.SSN%TYPE
, V_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, V_CITY        IN TBL_INSA.CITY%TYPE
, V_TEL         IN TBL_INSA.TEL%TYPE
, V_BUSEO       IN TBL_INSA.BUSEO%TYPE
, V_JIKWI       IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM       TBL_INSA.NUM%TYPE;      -- ����
BEGIN
    SELECT MAX(NVL(NUM,0))+1 INTO V_NUM -- V_NUM�� ��ڴ�.
    FROM TBL_INSA;
             
    INSERT INTO TBL_INSA(NUM,NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM,V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);

    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�. 