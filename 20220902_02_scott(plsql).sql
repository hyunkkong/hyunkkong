SELECT USER
FROM DUAL;
--==>> SCOTT


--※ TBL_입고 테이블에 『입고』이벤트 발생 시...
--   관련 테이블에 수행되어야 하는 내용

-- ① INSERT → TBL_입고

-- ② UPDATE → TBL_상품


--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_입고 테이블의 데이터 입력 뿐 아니라
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다.
--   TBL_입고 테이블 구성 컬럼 - 구조
--   : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

DESC TBL_상품;
DESC TBL_입고;

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드          IN TBL_입고.상품코드%TYPE
, V_입고수량          IN TBL_입고.입고수량%TYPE
, V_입고단가          IN TBL_입고.입고단가%TYPE
)
IS
    V_입고번호          TBL_입고.입고번호%TYPE;
    
BEGIN
    SELECT (NVL(MAX(입고번호),0)) + 1 INTO V_입고번호 
    FROM TBL_입고;    
    --입고 테이블의 데이터입력
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가) VALUES (V_입고번호, V_상품코드, V_입고수량, V_입고단가 );
    --상품 테이블 재고수량 UPDATE
    UPDATE TBL_상품   
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;

END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

DROP PROCEDURE PRC_입고_INSERT;

COMMIT;


--선생님

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드            IN TBL_입고.상품코드%TYPE -- IN TBL_상품.상품코드%TYPE (가능)
, V_입고수량            IN TBL_입고.입고수량%TYPE
, V_입고단가            IN TBL_입고.입고단가%TYPE
)
IS
    -- 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호          TBL_입고.입고번호%TYPE;
BEGIN
    -- 아래 쿼리문을 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(입고번호),0)+1 INTO V_입고번호
    FROM TBL_입고;
    /*
    SELECT NVL(MAX(입고번호),0) INTO V_입고번호
    FROM TBL_입고;
    */
    --INSERT 쿼리문 수행
    INSERT INTO TBL_입고(입고번호, 상품코드,  입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, V_입고수량, V_입고단가 );
    /*
    INSERT INTO TBL_입고(입고번호, 상품코드,  입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, V_입고수량, V_입고단가 )
    */
    --UPDATE 쿼리문 수행
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; -- 이외에 다른상황이 발생하면 ROLLBACK해라...
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목 '서울', '경기', '대전' 만 입력이 가능하도록 구성한다.
--   이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--   (즉, 입력을 시도하는 경우)
--   예외에 대한 처리를 하려고 한다.
--   프로시저 명 : PRC_MEMBER_INSERT()
/*
실행 예)
EXEC PRC_MEMBER_INSERT('임시연','010-1111-1111','서울');
--==>> 데이터 입력 ○

EXEC PRC_MEMBER_INSERT('김보경','010-2222-1111','부산');
--==>> 데이터 입력 X

*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME                IN TBL_MEMBER.NAME%TYPE
, V_TEL                 IN TBL_MEMBER.TEL%TYPE
, V_CITY                IN TBL_MEMBER.CITY%TYPE
)
IS
    -- 실행 영역의 쿼리문 수행을위해 필요한 변수 추가 선언
    V_NUM               TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK~!!!
    --변수명 데이터타입;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지
    -- 아닌지의 여부를 가장 먼저 확인할 수 있도록 코드 구성
    
    --IF(지역이 서울 경기 인천이 아니라면)
    IF (V_CITY NOT IN ('서울','경기','대전'))
    --    THEN 예외를 발생시키겠다.  --JAVA의 스로드
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    
    -- INSERT 쿼리문을 수행하기에 앞서
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM),0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- 쿼리문 구성 → INSERT
    INSERT INTO TBL_MEMBER(NUM,NAME,TEL,CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    --예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,경기,대전만 입력이 가능합니다.'); --함수(에러번호,'내용') 에러번호는 20000번까지는 자체적으로 오라클이 사용
        WHEN OTHERS 
            THEN ROLLBACK;
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------


--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고 수량이 변동되는 프로시저를 작성한다.
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가 처리한다.
--   또한, 출고 수량이 재고 수량보다 많은 경우...
--   출고 액션 처리 자체를 취소할 수 있도록 처리한다. (출고가 이루어지지 않도록...)
--   프로시저 명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT ('H001', 50, 1000);

*/
DESC TBL_출고;

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드            IN TBL_출고.상품코드%TYPE
, V_출고수량            IN TBL_출고.출고수량%TYPE
, V_출고단가            IN TBL_출고.출고단가%TYPE
)
IS
        V_출고번호               TBL_출고.출고번호%TYPE;
        V_재고수량               TBL_상품.재고수량%TYPE;
        
        USER_DEFINE_ERROR   EXCEPTION;
BEGIN
        
        SELECT NVL(MAX(출고번호),0) + 1 INTO V_출고번호
        FROM TBL_출고;
        
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = V_상품코드;
        
        IF (V_출고수량 > V_재고수량)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
         
        --출고 INSERT
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES(V_출고번호,V_상품코드,V_출고수량,V_출고단가);
        
        --업데이트
        UPDATE TBL_상품
        SET 재고수량 = V_재고수량 - V_출고수량
        WHERE 상품코드 = V_상품코드;
        
        --예외 처리
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'출고수량이 재고수량보다 많습니다.');
            WHEN OTHERS
                THEN ROLLBACK;
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.
DROP PROCEDURE PRC_출고_INSERT;


-- 선생님 풀이
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드            IN TBL_출고.상품코드%TYPE
, V_출고수량            IN TBL_출고.출고수량%TYPE
, V_출고단가            IN TBL_출고.출고단가%TYPE
)
IS
        -- 쿼리문 수행을 위한 추가 변수 선언
        V_출고번호  TBL_출고.출고번호%TYPE;
        V_재고수량  TBL_상품.재고수량%TYPE; -- 데이터타입 참조
        
        -- 사용자 정의 예외 선언
        USER_DEFINE_ERROR   EXCEPTION;
BEGIN

        -- 쿼리문 수행 이전에수행 여부를 확인하는 과정에서
        -- 재고 파악 → 기존의 재고를 확인하는 과정이 선행되어야 한다.
        -- 그래야... 출고 수량과 비교가 가능하기 때문에...
        SELECT 재고수량 INTO V_재고수량
        FROM TBL_상품
        WHERE 상품코드 = V_상품코드;
        
        
        -- 출고를 정상적으로 진행해줄 것인지에 대한 여부 확인
        -- 파악한 재고수량보다 출고수량이 많으면 예외 발생
        IF (V_출고수량 > V_재고수량)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
        
        -- 선언한 변수에 값 담아내기
        SELECT NVL(MAX(출고번호),0) INTO V_출고번호
        FROM TBL_출고;
        
        
        -- 쿼리문 구성 → INSERT(TBL_출고)
        --INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        --VALUES(?????,V_상품코드,V_출고수량,V_출고단가);
        INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES((V_출고번호 + 1),V_상품코드,V_출고수량,V_출고단가);
        
        -- 쿼리문 구성 → UPDATE(TBL_상품)
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 - V_출고수량
        WHERE 상품코드 = V_상품코드;
        
        --예외 처리
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족~!!!');
                     ROLLBACK;
            WHEN OTHERS
                THEN ROLLBACK;
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.





--○ TBL_출고 테이블에서 출고 수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE()
/*
실행 예)
CREATE PRC_출고_UPDATE(출고번호, 변경할수량);
*/
DESC TBL_출고;

DROP PROCEDURE PRC_출고_UPDATE;


CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE 
(
    -- ① 매개변수 구성
  V_출고번호            IN TBL_출고.출고번호%TYPE
, V_출고수량            IN TBL_출고.출고수량%TYPE     --변경 수량
)
IS
    -- ③ 필요한 변수 추가 선언
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_이전출고수량    TBL_출고.출고수량%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    
    -- ⑦ 예외
    USER_DEFINE_ERROR EXCEPTION;
BEGIN

    -- ④ 선언한 변수에 값 담아내기
    -- 상품코드와 이전출고수량 파악
    /*
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    SELECT 출고수량 INTO V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    */

    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- ⑤ 위에서 얻어낸 상품코드를 활용하여 재고수량 파악
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑥ 출고 정상 수행여부 판단 필요
    --    변경 이전의 출고수량 및 현재의 재고수량 확인
    --IF (파악한 재고수량과 이전의 출고수량을 합친 값이 현재의 출고수량보다 작으면 예외를 발생시키도록한다.)
    --END IF;
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- ⑧
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
     WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족~!!!');
             ROLLBACK;
     WHEN OTHERS
        THEN ROLLBACK;
    
    -- ⑨ 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

-- 과제
/*
1. PRC_입고_UPDATE(입고번호, 입고수량) 출고_UPDATE했던것 처럼
2. PRC_입고_DELETE(입고번호) 
3. PRC_출고_DELETE(출고번호) 입고_INSERT처럼 레코드 제거 (쉬울거다)
*/
--첨부파일, 안의 내용
--테스트 캡쳐사진 


--------------------------------------------------------------------------------

--■■■ 커서 ■■■--

--1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--   작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 데이터를
--   저장하기 위해 커서(CURSOR)를 사용하며,
--   커서에는 암시적인 커서와 명시적인 커서가 있다.

--2. 암시적 커서는 모든 SQL 문에 존재하며
--   SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--   그러나 SQL 문을 실행한 결과물(RESULT SET)이
--   여러 행(ROW)으로 구성된 경우
--   커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.

--○ 커서 이용 전 상황(단일 행 접근 시)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '-' || V_TEL);
END;
--==>> 홍길동 -- 011-2356-4528

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '-' || V_TEL);
END;
--==>> 에러 발생
--      ORA-01422: exact fetch returns more than requested number of rows

--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문 활용)
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

--○ 커서 이용 후 상황
DECLARE
    -- 선언부
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 커서 이용을 위한 커서변수 선언(→ 커서 정의)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
    /*
    변수명 데이터타입
    V_RESULT            NUMBER
    USER_DEFINE_ERROR   EXCEPTION;
    */
    
    /*
    테이블 생성(정의)
    사용자 생성(정의)
    함수 정의
    프로시저 정의
    
    TABLE 테이블명
    INDEX 인덱스명
    USER 유저명
    FUNCTION 함수명
    PROCEDURE 프로시저명
    */
BEGIN
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈 시 쏟아져 나오는 데이터들 처리
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태
        -- 즉, 커서 내부에서 더 이상의 데이터를 찾을 수 없는 상태
        -- → 그만~~!!! 반복문 빠져나가기
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
                    --커서이름
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_INSA_SELECT;
    
END;
--------------------------------------------------------------------------------