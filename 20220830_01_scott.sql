SELECT USER
FROM DUAL;
--==>> SCOTT

-- 제약조건 비활성화(일시정지)
ALTER TABLE 테이블명
DISABLE CONSTRAINT CONSTRAINT명;

-- 제약조건 활성화(일시정지 해제)
ALTER TABLE 테이블명
ENABLE CONSTRAINT CONSTRAINT명;



--------------------------------------------------------------------------------

--■■■ UPDATE ■■■--
-- 1. 테이블에서 기존 데이터를 수정(변경)하는 구문

-- 2. 형식 및 구조
-- UPDATE 테이블
-- SET 컬러명=변경할값[, 컬럼명 = 변경할값, ...]
-- [WHERE 조건절]

--○ TBL_SAWON 테이블에서 사원번호 1004번 사원의
--   주민번호를 『8805251234567』

UPDATE TBL_SAWON
SET JUBUN = '8805251234567'
WHERE SANO = 1004;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	고연수	9409252234567	05/01/03	3000
1002	김보경	9809022234567	99/11/23	2000
1003	정미경	9810092234567	06/08/10	4000
1004	김인교	8805251234567	98/05/13	2000
1005	이정재	7008161234567	98/05/13	1000
1006	아이유	9309302234567	99/10/10	3000
1007	이하이	0302064234567	10/10/23	4000
1008	인순이	6807102234567	98/03/20	1500
1009	선동렬	6710261234567	98/03/20	1300
1010	선우용녀	6511022234567	98/12/20	2600
1011	선우선	0506174234567	11/10/10	1300
1012	남궁민	0102033234567	10/10/10	2400
1013	남진	0210303234567	11/10/10	2800
1014	반보영	9903142234567	12/11/11	5200
1015	한은영	9907292234567	12/11/11	5200
1016	이이경	0605063234567	15/01/20	1500
*/

-- 실행 후 COMMIT 또는 ROLLBACK 을 반드시 선택적으로 실행
COMMIT;
--==>> 커밋 완료.


--○ TBL_SAWON 테이블에서 1005번 사원의 입사일과 급여를
--   각각 2020-04-01, 1200 으로 변경한다.

UPDATE TBL_SAWON
SET HIREDATE = TO_DATE('2020-04-01','YYYY-MM-DD'), SAL = 1200
WHERE SANO = 1005;
--==>> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> 커밋 완료.

-- ○ TBL_INSA 테이블 복사(데이터만...)
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>> Table TBL_INSABACKUP이(가) 생성되었습니다.


-- ○ TBL_INSABACKUP 테이블에서
--    직위가 과장과 부장만 수당 10% 인상
SELECT NAME "사원명", JIKWI "직위", SUDANG "수당"
     , SUDANG + (SUDANG*0.1) "10% 인상된 수당A"
     , SUDANG * 1.1 "10% 인상된 수당B"
FROM TBL_INSABACKUP
WHERE JIKWI IN ('과장','부장');


UPDATE TBL_INSABACKUP
SET SUDANG = SUDANG*1.1
WHERE JIKWI IN ('과장','부장');
--==>> 15개 행 이(가) 업데이트되었습니다.
COMMIT;

-- 확인
SELECT *
FROM TBL_INSABACKUP;


--○ TBL_INSABACKUP 테이블에서
--   전화번호가 016, 017, 018, 019 로 시작하는 전화번호인 경우
--   이름 모두 010으로 변경한다.

SELECT TEL "기존전화번호", 010|| TEL "변경전화번호"
FROM TBL_INSABACKUP
WHERE SUBSTR(TEL, 1, 3) IN ('016', '017', '018', '019');

SELECT TEL "기존전화번호", 010|| SUBSTR(TEL, 4) "변경전화번호"
FROM TBL_INSABACKUP
WHERE SUBSTR(TEL, 1, 3) IN ('016', '017', '018', '019');

UPDATE TBL_INSABACKUP
SET TEL = '010' || SUBSTR(TEL,4)
WHERE SUBSTR(TEL,1,3) IN ('016', '017', '018', '019');


--------------------------------------------------------------------------------
-- 내 풀이
SELECT TEL
FROM TBL_INSABACKUP
WHERE SUBSTR(TEL,1,3) IN ('016','017', '018', '019');

UPDATE TBL_INSABACKUP
SET TEL = '010' || SUBSTR(TEL,4)
WHERE SUBSTR(TEL,1,3) IN ('016', '017', '018', '019');
--==>> 24개 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_INSABACKUP;

COMMIT;
--==>> 커밋 완료.



