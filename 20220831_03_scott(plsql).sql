SELECT USER
FROM DUAL;
--==>> SCOTT

SET SERVEROUTPUT ON;

--○ TBL_INSA 테이블의 여러 명의 데이터 여러개를 변수에 저장
--   (반복문 활용)

DECLARE
        V_INSA      TBL_INSA%ROWTYPE;
        V_NUM       TBL_INSA.NUM%TYPE  := 1001;

BEGIN
        LOOP
                -- 조회
                SELECT NAME, TEL, BUSEO
                       INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
                FROM TBL_INSA
                WHERE NUM = V_NUM;          -- 1001
                
                -- 출력
                DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - ' || V_INSA.BUSEO);
                
                -- 증감식
                V_NUM := V_NUM + 1;
                
                EXIT WHEN V_NUM > 1060;
        END LOOP;
END;


--------------------------------------------------------------------------------

--■■■ FUNCTION(함수) ■■■--
-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXCUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 매개변수명1 자료형
   매개변수명2 자료형
)]
RETURN 데이터타입 (실행문에 있는 RETURN 값의 데이터타입)
IS
            -- 주요 변수 선언
BEGIN
            -- 실행문;
            ...
            RETURN (값);
            
            [EXCEPTION]
                    -- 예외 처리 구문;
END;
*/


--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.

--○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNN'

DESC TBL_INSA;
--==>>
/*
SSN → VARCHAR2(14) 
*/

--CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2(14) )      -- 매개변수   : 자릿수(길이) 지정 안함
CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
--RETURN VARCHAR2(24)                                             -- 반환자료형 : 자릿수(길이) 지정 안함
RETURN VARCHAR2
IS -- DECLARE 가 IS로 바뀜
        -- 선언부 → 주요 변수 선언
        V_RESULT        VARCHAR2(24);
BEGIN
        -- 실행부 → 연산 및 처리
        
        -- 결과값 반환 CHECK~!!!
END;






CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
RETURN VARCHAR2
IS 
        -- 선언부 → 주요 변수 선언
        V_RESULT        VARCHAR2(24);
BEGIN
        -- 실행부 → 연산 및 처리
        IF (주민번호 8번째 자리 1개가 '2' 또는 '4')
                THEN 결과변수에 '여자' 담아내기
        ELSIF (주민번호 8번째 자리 1개가 '1' 또는 '3')
                THEN 결과변수에 '남자' 담아내기
        ELSE
                결과변수에 '성별확인불가' 담아내기
        END IF;
        
        -- 결과값 반환 CHECK~!!!
        RETURN V_RESULT;
END;






CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )
RETURN VARCHAR2
IS 
        -- 선언부 → 주요 변수 선언
        V_RESULT        VARCHAR2(24);
BEGIN
        -- 실행부 → 연산 및 처리
        IF (SUBSTR(V_SSN,8,1) IN('2','4'))
                THEN V_RESULT := '여자';
        ELSIF (SUBSTR(V_SSN,8,1) IN('1','3'))
                THEN V_RESULT := '남자';
        ELSE
                V_RESULT := '성별확인불가';
        END IF;
        
        -- 결과값 반환 CHECK~!!!
        RETURN V_RESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.

--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 → (A,B)
--   A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
-- 함수명 : FN_POW()
-- 사용 예)
/*
SELECT FN_POW (10, 3)
FROM DUAL;
--==>> 1000
*/

/*
FN_POW(1O,3) → 1000
        1 * 10 * 10 * 10 = 1000
        0 * 10 * 10 * 10 = 0
*/



CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
        -- 선언부 → 주요 변수 선언
        V_RESULT    NUMBER := 1;
        V_NUM       NUMBER;
BEGIN
        -- 실행부 → 연산 및 처리
        FOR V_NUM IN 1 .. B LOOP
            V_RESULT := V_RESULT * A;
        END LOOP;
        
        RETURN V_RESULT;
END;
--==>>Function FN_POW이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블 급여 계산 전용 함수를 정의한다.
--   급여는 『(기본급*12)+수당』 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)

CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER ,SUDANG NUMBER)
RETURN NUMBER
IS
    --선언부
    V_RESULT        NUMBER :=0;
BEGIN
    --실행부
    V_RESULT := (BASICPAY*12) + SUDANG;
    
    RETURN V_RESULT;
END;




