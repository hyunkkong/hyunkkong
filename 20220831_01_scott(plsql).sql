SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    GRADE CHAR;
BEGIN
    -- �����
    GRADE := 'A';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>> EXCELLENT


DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'B';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>> GOOD


-- �� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮1;
    WHEN ��2 THEN ���๮2; 
    ELSE ���๮N+1;
END CASE;
*/

-- ����1 ����2 �Է��ϼ���
-- 1
-- �����Դϴ�.

-- ����1 ����2 �Է��ϼ���
-- 2
-- �����Դϴ�.


ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- ����� �� �ֿ� ���� ����
    SEL    NUMBER := &NUM;
    RESULT VARCHAR2(10) :='����';
BEGIN
    -- �����
    -- �׽�Ʈ
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    /*
    CASE SEL
        WHEN 1 
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        WHEN 2 
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    */
    CASE SEL
        WHEN 1
        THEN RESULT := '����';
        WHEN 2
        THEN RESULT := '����';
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || '�Դϴ�.');
END;

--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
--  ��&�ܺκ����� ���·� �����ϰ� �ȴ�.




--�� ���� �� ���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

-- ���� �ۼ��� ����
ACCEPT NUM1 PROMPT 'ù��° ������ �Է��ϼ���';
ACCEPT NUM2 PROMPT '�ι�° ������ �Է��ϼ���';

DECLARE
    --�����
    NUM1    NUMBER := &NUM1;
    NUM2    NUMBER := &NUM2;
BEGIN
    --�����
    DBMS_OUTPUT.PUT_LINE(NUM1+NUM2);
END;

-- �������� �ۼ��� ����
ACCEPT N1 PROMPT 'ù��° ������ �Է��ϼ���';
ACCEPT N2 PROMPT '�ι�° ������ �Է��ϼ���';

DECLARE
    -- �ֿ� ���� ����
    NUM1    NUMBER := &N1;
    NUM2    NUMBER := &N2;
    TOTAL   NUMBER := 0;
BEGIN
    -- �׽�Ʈ
    -- DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM1);
    -- DBMS_OUTPUT.PUT_LINE('NUM1 : ' || NUM2);
    TOTAL := NUM1 + NUM2;
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || TOTAL);
END;
--==>> 23 + 47 = 70


--�� ����ڷκ��� �Է¹��� �ݾ��� ȭ�� ������ �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.


-- ���� ��)
/*
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� : 990

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/


-- ��Ǯ�� ���
-- ��
ACCEPT P PROMPT '�ݾ� �Է� : ';

DECLARE
    MONEY       NUMBER := &P;
    MONEY500    NUMBER;
    MONEY100    NUMBER;
    MONEY50     NUMBER;
    MONEY10     NUMBER;
    TOTAL       NUMBER := &P;
BEGIN
    MONEY500 := TRUNC(MONEY/500);
    MONEY := MONEY - MONEY500*500;
    MONEY100 := TRUNC(MONEY/100);
    MONEY := MONEY - MONEY100*100;
    MONEY50 := TRUNC(MONEY/50);
    MONEY := MONEY - MONEY50*50;
    MONEY10 := TRUNC(MONEY/10);
    
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || TOTAL);
    DBMS_OUTPUT.PUT_LINE('ȭ�� ���� : ����� '|| MONEY500 ||', ��� '||MONEY100||', ���ʿ� '|| MONEY50||', �ʿ� '|| MONEY10);
END;
--==>>
/*
�Է¹��� �ݾ� �Ѿ� : 990
ȭ�� ���� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/
SELECT TRUNC(990/500)
FROM DUAL;
--==>> 1
SELECT TRUNC(MOD(990,500)/100)
FROM DUAL;
--==>> 4
SELECT TRUNC(MOD(MOD(990,500),100)/50)
FROM DUAL;
--==>> 1
SELECT TRUNC(MOD(MOD(MOD(990,500),100),50)/10)
FROM DUAL;
--==>> 4



-- ��
ACCEPT P PROMPT '�ݾ� �Է� : ';

DECLARE
    MONEY       NUMBER := &P;
    MONEY500    NUMBER;
    MONEY100    NUMBER;
    MONEY50     NUMBER;
    MONEY10     NUMBER;
    TOTAL       NUMBER := &P;
BEGIN
    MONEY500 := TRUNC(MONEY/500);
    MONEY100 := TRUNC(MOD(MONEY,500)/100);
    MONEY50 := TRUNC(MOD(MOD(MONEY,500),100)/50);
    MONEY10 := TRUNC(MOD(MOD(MOD(MONEY,500),100),50)/10);
    
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || TOTAL);
    DBMS_OUTPUT.PUT_LINE('ȭ�� ���� : ����� '|| MONEY500 ||', ��� '||MONEY100||', ���ʿ� '|| MONEY50||', �ʿ� '|| MONEY10);
END;
--==>>
/*
�Է¹��� �ݾ� �Ѿ� : 990
ȭ�� ���� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/


--------------------------------------------------------------------------------
-- ������ Ǯ��
ACCEPT INPUT PROMPT '�ݾ� �Է� : ';

DECLARE
    --�ֿ� ���� ����
    MONEY   NUMBER := &INPUT;   -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2  NUMBER := &INPUT;   -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                -- (MONEY ������ ���� �������� ���� ���ϱ� ������...)
    M500    NUMBER;             -- 500�� ¥�� ������ ��Ƶ� ����
    M100    NUMBER;             -- 100�� ¥�� ������ ��Ƶ� ����
    M50     NUMBER;             --  50�� ¥�� ������ ��Ƶ� ����
    M10     NUMBER;             --  10�� ¥�� ������ ��Ƶ� ����
BEGIN
    -- ���� ��  ó��
    -- MONEY �� 500���� ������ ���� ���ϰ� �������� ������. �� 500���� ����
    M500 := TRUNC(MONEY / 500);
    
    -- MONEY �� 500���� ������ ���� ������ �������� ���Ѵ�. �� 500���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���.
    MONEY := MOD(MONEY, 500);
    
    -- MONEY �� 100���� ������ ���� ���ϰ� �������� ������. �� 100���� ����
    M100 := TRUNC(MONEY / 100);
    
    -- MONEY �� 100���� ������ ���� ������ �������� ���Ѵ�. �� 100���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���.
    MONEY := MOD(MONEY, 100);
    
    -- MONEY �� 50���� ������ ���� ���ϰ� �������� ������. �� 50���� ����
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY �� 50���� ������ ���� ������ �������� ���Ѵ�. �� 50���� ���� Ȯ���ϰ� ���� �ݾ�
    -- �� ����� �ٽ� MONEY �� ��Ƴ���.
    MONEY := MOD(MONEY, 50);
    
    -- MONEY �� 10���� ������ ���� ���ϰ� �������� ������. �� 10���� ����
    M10 := TRUNC(MONEY / 10);
    
    -- ��� ���
    -- ���յ� ���(ȭ�� ������ ����)�� ���Ŀ� �°� ���� ����Ѵ�.
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : ' || MONEY2 || '��');
    DBMS_OUTPUT.PUT_LINE('ȭ�� ���� : ����� '|| M500 ||', ��� '||M100||
                                    ', ���ʿ� '|| M50||', �ʿ� '|| M10);
END;
--==>>
/*
�Է¹��� �ݾ� �Ѿ� : 990��
ȭ�� ���� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/

--�� �⺻ �ݺ���
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    EXIT WHEN ����;           --������ ���� ��� �ݺ����� ����������.
END LOOP;
*/

--�� 1 ���� 10 ������ �� ���(LOOP �� Ȱ��)
DECLARE
    NUM NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        EXIT WHEN NUM >= 10;
        NUM := NUM + 1;
    END LOOP;
END;


--������
DECLARE
    N       NUMBER;
BEGIN
    N := 1;
    LOOP
            DBMS_OUTPUT.PUT_LINE(N);
            EXIT WHEN N >= 10;
            N:=N+1;             -- N++;     N+=1;
    END LOOP;
END;


--�� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--    WHILE LOOP ������ ����Ѵ�.
--    ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--    LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--    LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2. ���� �� ����
/*
WHILE ���� LOOP       -- ������ ���� ��� �ݺ� ����
    -- ���๮;
END LOOP;
*/

--�� 1 ���� 10 ������ �� ���(WHILE LOOP �� Ȱ��)
DECLARE
    N       NUMBER;
BEGIN
    N := 1;
    WHILE N<=10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
    END LOOP;
END;


--������ Ǯ��
--�� 1 ���� 10 ������ �� ���(WHILE LOOP �� Ȱ��)
DECLARE
    N       NUMBER;
BEGIN
    N := 0;
    
    WHILE N<10 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;



--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �����ۼ������� 1�� �����Ͽ�
--    ������������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
    -- ���๮;
END LOOP
*/

--�� 1 ���� 10 ������ �� ���(WHILE LOOP �� Ȱ��)
DECLARE
    N       NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;

--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
-- ���� ��)
/*
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� : 2

2 * 1 = 2
2 * 2 = 4
    :
2 * 9 = 19
*/

-- �� Ǯ�� ���
-- 1. LOOP ��
ACCEPT DAN PROMPT "���� �Է��ϼ��� : ";
DECLARE
    DAN     NUMBER := &DAN;
    NUM     NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || NUM || ' = ' || DAN*NUM);
        EXIT WHEN NUM >= 9;
        NUM := NUM+1;
    END LOOP;
END;

-- 2. WHILE LOOP ��
ACCEPT DAN PROMPT "���� �Է��ϼ��� : ";
DECLARE
    DAN     NUMBER := &DAN;
    NUM     NUMBER := 1;
BEGIN
    WHILE NUM<=9 LOOP 
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || NUM || ' = ' || DAN*NUM);
        NUM := NUM+1;
    END LOOP;
END;

-- 3. FOR LOOP ��
ACCEPT DAN PROMPT "���� �Է��ϼ��� : ";
DECLARE
    DAN     NUMBER;
    NUM     NUMBER;
BEGIN
    DAN := &DAN;
    NUM := 1;
    FOR NUM IN 1 .. 9 LOOP
    DBMS_OUTPUT.PUT_LINE( DAN || ' * ' || NUM || ' = ' || DAN*NUM);
    END LOOP;
END;

--������ Ǯ�� ���
-- 1. LOOP ��
ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';

DECLARE
        DAN     NUMBER := &NUM;
        N       NUMBER;
BEGIN
        N := 1;
        
        LOOP
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || ' = ' || (DAN * N));
                EXIT WHEN N >= 9;
                N := N + 1;
        END LOOP;
END;

-- 2. WHILE LOOP ��
ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';
DECLARE
        DAN     NUMBER := &NUM;
        N       NUMBER;
BEGIN
        N := 0;
        
        WHILE N<9 LOOP
                N := N + 1;
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || ' = ' || (DAN * N));
        END LOOP;
END;

--3. FOR LOOP ��

ACCEPT NUM PROMPT '���� �Է��ϼ��� : ';

DECLARE
        DAN     NUMBER := &NUM;
        N       NUMBER;
BEGIN
        FOR N IN 1 .. 9 LOOP
                DBMS_OUTPUT.PUT_LINE(DAN || '*' || N || ' = ' || (DAN * N));
        END LOOP;
END;


--�� ������ ��ü(2�� ~ 9��)�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ���Ѵ�.

-- ���� ��)
/*
===[ 2��]===
2 * 1 = 2
2 * 2 = 4
    :
===[ 3��]===
    :
    :
===[ 9��]=== 
    :
9 * 9 = 81
*/
-- LOOP [�̿�]
DECLARE
    DAN NUMBER;
    N   NUMBER;
BEGIN
    DAN := 2;
    LOOP
        DBMS_OUTPUT.PUT_LINE('===[ ' || DAN || '��]===');
        
        LOOP
            N := 1;
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
            EXIT WHEN N <= 9
        END LOOP;
        
    END LOOP;
END;



-- WHILE LOOP
DECLARE
    DAN     NUMBER;
    N       NUMBER;
BEGIN
    DAN := 2;
    WHILE DAN <=9 LOOP
         DBMS_OUTPUT.PUT_LINE('===[ ' || DAN || '��]===');
          N := 1;
         WHILE N <= 9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
            N := N + 1;
         END LOOP;
         DAN := DAN +1;
    END LOOP; 
END;


-- FOR LOOP
DECLARE
    DAN     NUMBER;
    N       NUMBER;
BEGIN
    DAN := 2;
    N := 1;
    FOR DAN IN 2..9 LOOP
        DBMS_OUTPUT.PUT_LINE('===[ ' || DAN || '��]===');
        
        FOR N IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || (DAN * N));
        END LOOP;
        
    END LOOP;    
END;
