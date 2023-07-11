SELECT USER
FROM DUAL;
--==>> SCOTT

-- 과제
/*
1. PRC_입고_UPDATE(입고번호, 
2. PRC_입고_DELETE(입고번호) 
3. PRC_출고_DELETE(출고번호) 
*/

-- 1. PRC_입고_UPDATE(입고번호, 입고수량)
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( -- 매개변수 구성
  V_입고번호  IN TBL_입고.입고번호%TYPE
, V_입고수량  IN TBL_입고.입고수량%TYPE      
)
IS
    -- 필요한 변수 추가 선언
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_이전입고수량    TBL_입고.입고수량%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    
    -- 예외에 대한 변수 선언
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    -- 선언한 변수에 값 담기
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_이전입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량     INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 재고수량 - 이전입고수량 + 입고수량이 음수일 경우 예외 발생
    IF (V_재고수량 - V_이전입고수량 + V_입고수량 < 0)
        THEN RAISE USER_DEFINE_ERROR;     
    END IF;
    
    -- 수행될 쿼리문 체크(UPDATE → TBL_입고 / UPDATE → TBL_상품)
    UPDATE TBL_입고
    SET 입고수량 = V_입고수량
    WHERE 입고번호 = V_입고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_이전입고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고부족~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.



DROP  PROCEDURE PRC_입고_UPDATE;




-- 2. PRC_입고_DELETE(입고번호)

CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
( V_입고번호  IN TBL_입고.입고번호%TYPE )
IS
    -- 쿼리문 수행에 필요한 변수 선언
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_입고수량      TBL_입고.입고수량%TYPE;
    V_재고수량      TBL_상품.재고수량%TYPE;
    -- 예외에 대한 변수선언
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 선언한 변수에 값 담기
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_입고수량
    FROM TBL_입고     
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량          INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 입고 데이터를 DELETE 시 재고수량 - 입고수량
    -- 재고수량이 마이너스가 나오면 안되므로 0보다 작은 값이 나올 시 예외 발생
    IF (V_재고수량 - V_입고수량 < 0)
        THEN RAISE USER_DEFINE_ERROR;     
    END IF;
    
    
    -- 수행해야할 쿼리문 (DELETE → TBL_입고 / UPDATE → TBL_상품)
    -- 기존의 입력되었던 입고 데이터가 DELETE 되면 재고수량은 감소
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고부족~!!!');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.
DROP  PROCEDURE PRC_입고_DELETE;






-- 3. PRC_출고_DELETE(출고번호)

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
( V_출고번호         IN TBL_출고.출고번호%TYPE )
IS
    -- 실행 영역의 쿼리문 수행을 위한 변수 추가 선언
    V_출고수량      TBL_출고.출고수량%TYPE;
    V_상품코드      TBL_상품.상품코드%TYPE;
    
BEGIN
        SELECT 상품코드,출고수량 INTO V_상품코드,V_출고수량
        FROM TBL_출고
        WHERE 출고번호 = V_출고번호;
             
        -- 수행해야할 쿼리문 체크 (DELETE → TBL_출고) / (UPDATE → TBL_상품)
        DELETE 
        FROM TBL_출고
        WHERE 출고번호 = V_출고번호;
        
        -- TBL_상품 테이블 재고수량 UPDATE
        UPDATE TBL_상품
        SET 재고수량 = 재고수량 + V_출고수량
        WHERE 상품코드 = V_상품코드;
        
        --커밋
        COMMIT;
        
END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.



--기존 상품 내역
SELECT *
FROM TBL_상품;
--==>>
/*
C001	구구콘	    1500	30
C002	월드콘	    1500	30
C003	브라보콘    	1300	0
C004	누가콘	    1800	0
C005	슈퍼콘	    1900	0
H001	스크류바	    1000	0
H002	캔디바	    300	    100
H003	쌍쌍바	    500	    0
H004	돼지바	    600	    0
H005	메로나	    500	    0
E001	찰떡아이스	2500	0
E002	붕어싸만코	2000	0
E003	빵또아	    2300	0
E004	거북알	    2300	0
E005	쿠키오	    2400	0
E006	국화빵	    2000	0
E007	투게더	    3000	0
E008	엑셀런트	3000	0
E009	셀렉션	    3000	0
*/


--------------------------------------------------------------------------------
-- EXEC PRC_입고_UPDATE(입고번호, 입고수량) 프로시저 작동 확인
-- 현재 입고내역
SELECT *
FROM TBL_입고;
--==>>
/*
1	C001	2022-09-02	30	1200
2	C002	2022-09-02	30	1200
3	H001	2022-09-02	50	800
4	H002	2022-09-02	50	200
5	H001	2022-09-02	50	800
6	H002	2022-09-02	50	200     --캔디바
*/

EXEC PRC_입고_UPDATE(6,20);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
-- 입고 내역 변경 전 재고수량
-- H002	캔디바	    300	    100
-- 입고내역 변경 후 재고수량
-- H002	캔디바	    300	    70

-- 입고내역 (변경 전)
-- 6    H002	2022-09-02	50	200
-- 입고내역 (변경 후)
-- 6	H002	2022-09-02	20	200

EXEC PRC_출고_INSERT ('C001', 10, 1000);
-- C001	구구콘	1500	20

-- 예외 발생 테스트 (재고수량 - 이전입고수량 + 입고수량 이 음수일 경우)
EXEC PRC_입고_UPDATE(1,5);
-- 현재 재고수량 20개 이전입고수량 30개 입고수량 5개
--==>> 에러 발생
--      (ORA-20002: 재고부족~!!!)





--------------------------------------------------------------------------------
-- PRC_입고_DELETE(입고번호) 프로시저 작동 확인
-- 현재 출고내역
SELECT *
FROM TBL_입고;
--==>>
/*
1	C001	2022-09-02	30	1200
2	C002	2022-09-02	30	1200
3	H001	2022-09-02	50	800
4	H002	2022-09-02	50	200
5	H001	2022-09-02	50	800
6	H002	2022-09-02	20	200
*/

EXEC PRC_입고_DELETE(2);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 프로시저 입력 후 입고 내역
/*
1	C001	2022-09-02	30	1200
3	H001	2022-09-02	50	800
4	H002	2022-09-02	50	200
5	H001	2022-09-02	50	800
6	H002	2022-09-02	20	200
*/


SELECT *
FROM TBL_상품;
-- 기존의 재고 내역
-- C002	월드콘	1500	30
-- 프로시저 입력 후 재고 내역
-- C002	월드콘	1500	0


-- 예외 발생 테스트 (V_재고수량 - V_입고수량 < 0)
-- 입고 데이터를 DELETE 시 재고수량 - 입고수량
-- 재고수량이 마이너스가 나오면 안되므로 0보다 작은 값이 나올 시 예외 발생
SELECT *
FROM TBL_상품;
--==>> C001	구구콘	1500	20
SELECT *
FROM TBL_입고;   
 --==>> 1	C001	2022-09-02	30	1200   

-- 현재 구구콘 재고수량 20개 입고수량 30개 - 출고수량 10개 
EXEC PRC_입고_DELETE(1);
--==>> 에러 발생
--      (ORA-20002: 재고부족~!!!)
--------------------------------------------------------------------------------

-- PRC_출고_DELETE(출고번호) 프로시저 작동 확인
SELECT *
FROM TBL_출고; 
--==>>
/*
1	H001	2022-09-02	100	1000
2	C001	2022-09-04	10	1000    -- PRC_입고_UPDATE, 예외 발생 테스트를 위해 생성한 데이터
*/

EXEC PRC_출고_DELETE(1);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
/*
2	C001	2022-09-04	10	1000
*/

SELECT *
FROM TBL_상품; 
--==>>
/*
C001	구구콘	    1500	20
C002	월드콘	    1500	0
C003	브라보콘	    1300	0
C004	누가콘	    1800	0
C005	슈퍼콘	    1900	0
H001	스크류바	    1000	100
H002	캔디바	    300	    70
H003	쌍쌍바	    500	    0
H004	돼지바	    600	    0
H005	메로나	    500	    0
E001	찰떡아이스	2500	0
E002	붕어싸만코	2000	0
E003	빵또아	    2300	0
E004	거북알	    2300	0
E005	쿠키오	    2400	0
E006	국화빵	    2000	0
E007	투게더	    3000	0
E008	엑셀런트	3000	0
E009	셀렉션	    3000	0
*/
