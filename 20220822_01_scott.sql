SELECT USER
FROM DUAL;


--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의 
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.
/*
------------------ ----------
입사년월            인원수
------------------ ----------
 1981-02                2
 1981-09                2
 1987-07                2
------------------ ---------- 
*/

SELECT 
(
SELECT TO_CHAR(HIREDATE,'YYYY-MM')
FROM EMP "입사년월"
)T
G;

SELECT ENAME, HIREDATE
FROM EMP
ORDER BY 2;

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*) "인원수"
FROM EMP;

SELECT T1.입사년월, T1.인원수
FROM
(
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP 
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
) T1
    WHERE T1.인원수 = (
        SELECT MAX(T2.인원수)
        FROM
        (
        SELECT TO_CHAR(HIREDATE, 'YYYY-MM')"입사년월"
             , COUNT(*) "인원수"
        FROM EMP
        GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
        )T2
    )
ORDER BY 1;

--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--------------------------------------------------------------------------------

--■■■ ROW_NUMBER ■■■--

SELECT ENAME "사원명", SAL"급여", HIREDATE "입사일"
FROM EMP;


SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트" 
    , ENAME "사원명", SAL"급여", HIREDATE "입사일"
FROM EMP;
--==>>
/*
1	KING	5000	81/11/17
2	FORD	3000	81/12/03
3	SCOTT	3000	87/07/13
4	JONES	2975	81/04/02
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
7	ALLEN	1600	81/02/20
8	TURNER	1500	81/09/08
9	MILLER	1300	82/01/23
10	WARD	1250	81/02/22
11	MARTIN	1250	81/09/28
12	ADAMS	1100	87/07/13
13	JAMES	 950	81/12/03
14	SMITH	 800	80/12/17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트" 
    , ENAME "사원명", SAL"급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
--==>>
/*
12	ADAMS	1100	87/07/13
7	ALLEN	1600	81/02/20
5	BLAKE	2850	81/05/01
6	CLARK	2450	81/06/09
2	FORD	3000	81/12/03
13	JAMES	 950	81/12/03
4	JONES	2975	81/04/02
1	KING	5000	81/11/17
11	MARTIN	1250	81/09/28
9	MILLER	1300	82/01/23
3	SCOTT	3000	87/07/13
14	SMITH	 800	80/12/17
8	TURNER	1500	81/09/08
10	WARD	1250	81/02/22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트" 
    , ENAME "사원명", SAL"급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	87/07/13
2	ALLEN	1600	81/02/20
3	BLAKE	2850	81/05/01
4	CLARK	2450	81/06/09
5	FORD	3000	81/12/03
6	JAMES	 950	81/12/03
7	JONES	2975	81/04/02
8	KING	5000	81/11/17
9	MARTIN	1250	81/09/28
10	MILLER	1300	82/01/23
11	SCOTT	3000	87/07/13
12	SMITH	 800	80/12/17
13	TURNER	1500	81/09/08
14	WARD	1250	81/02/22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트" 
    , ENAME "사원명", SAL"급여", HIREDATE "입사일"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;



--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우... 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는... 보안성 측면이나... 미관상... 바람직하지 않은 상태일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY 를 사용하지만,
--   단순히 게시물을 목록화 하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 바람직 할 수 있다.

--   오라클 개념(SEQUENCE), SLQ(IDENTITY)

--○ SEQUENCE(시퀀스:주문번호)
-- → 사전적인 의미 :1.(일련의) 연속적인 사건들, 2. (사건, 행동 등의) 순서

CREATE SEQUENCE SEQ_BOARD       -- 기본적인 시퀀스 생성 구문
START WITH 1                    -- 1부터 시작 (시작값)
INCREMENT BY 1                 -- 1씩 증가(증가값)
NOMAXVALUE                      -- 최대값(일반적으론 사용하지 않음)
NOCACHE;                        -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.


--○ 실습 테이블 생성
CREATE TABLE TBL_BOARD                  -- TBL_BOARD 테이블 새엇ㅇ 구문 → 게시판 테이블
( NO            NUMBER                  -- 게시물 번호       작성자 직접 입력 X
, TITLE         VARCHAR2(50)            -- 게시물 제목                        ○
, CONTENTS      VARCHAR2(1000)          -- 게시물 내용                        ○
, NAME          VARCHAR2(20)            -- 게시물 작성자                      △
, PW            VARCHAR2(20)            -- 게시물 패스워드                    △
, CREATED       DATE DEFAULT SYSDATE    -- 게시물 작성일                      X
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.

--○ 데이터 입력 → 게시판에 게시물을 작성한 액션
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~자고싶다', '10분만 자고 올께요','장현성', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~웃겨', '현성군 완전 재미있어요','엄소연', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '보고싶다', '원석이가 너무 보고싶어요','조영관', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '배고파요', '아침인데 배고파요', '유동현', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '너무멀어요', '집에서 교육원까지 너무 멀어요', '김태민', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '모자라요', '아직 잠이 모자라요', '장현성', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저두요', '저두 잠이 많이 모자라요', '유동현', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '비온대요', '오늘밤부터 비온대요', '박원석', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_BOARD;
--==>>
/*
1	아~자고싶다	10분만 자고 올께요	            장현성	java002$	2022-08-22 10:25:08
2	아~웃겨	    현성군 완전 재미있어요	        엄소연	java002$	2022-08-22 10:25:08
3	보고싶다	    원석이가 너무 보고싶어요	        조영관	java002$	2022-08-22 10:25:08
4	배고파요	아침인데 배고파요	            유동현	java002$	2022-08-22 10:25:08
5	너무멀어요	집에서 교육원까지 너무 멀어요	김태민	java002$	2022-08-22 10:25:08
6	모자라요    	아직 잠이 모자라요	            장현성	java002$	2022-08-22 10:25:08
7	저두요	    저두 잠이 많이 모자라요	        유동현	java002$	2022-08-22 10:25:08
8	비온대요    	오늘밤부터 비온대요	            박원석	java002$	2022-08-22 10:25:08
*/
DROP SEQUENCE SEQ_BOARD;
DROP TABLE TBL_BOARD;
PURGE RECYCLEBIN;

--○ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 1;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO = 8;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_BOARD;

--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '집중합시다.', '전 전혀 졸리지 않아요', '유동현', 'java002$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 게시물 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 7;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
2	아~웃겨	    현성군 완전 재미있어요	            엄소연	java002$	2022-08-22 10:25:08
3	보고싶다	    원석이가 너무 보고싶어요   	        조영관	java002$	2022-08-22 10:25:08
4	배고파요	아침인데 배고파요	                유동현	java002$	2022-08-22 10:25:08
5	너무멀어요	집에서 교육원까지 너무 멀어요	    김태민	java002$	2022-08-22 10:25:08
9	집중합시다.	전 전혀 졸리지 않아요	            유동현	java002$	2022-08-22 10:35:53
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시판의 게시물 리스트 조회
SELECT NO "글번호", TITLE"제목", NAME"작성자", CREATED "작성일"
FROM TBL_BOARD;
--==>>
/*
2	아~웃겨	엄소연	2022-08-22 10:25:08
3	보고싶다	조영관	2022-08-22 10:25:08
4	배고파요	유동현	2022-08-22 10:25:08
5	너무멀어요	김태민	2022-08-22 10:25:08
9	집중합시다.	유동현	2022-08-22 10:35:53
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE"제목", NAME"작성자", CREATED"작성일"
FROM TBL_BOARD
ORDER BY CREATED DESC;



--------------------------------------------------------------------------------

--■■■ JOIN(조인) ■■■--

-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(CATERSIAN PRODUCT)
--  두 테이블에서 결합한 모든 경우의 수


-- EQUI JOIN :서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;


SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY HIREDATE;

SELECT *
FROM EMP;

-- NON EQUI JOIN : 범위 안에 적합한 것들끼리 연결시키는 결합 방법
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S. HISAL;

-- EQUI JOIN 시 (+) 를 활용한 결합 방법
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14 건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5) 모두 누락
--  또한, 소속 사원을 갖지 못한 부서(1) 모두 누락


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> 총 19 건의 데이터가 결합되어 조회된 상황
--  소속 사원을 갖지 못한 부서(1) 누락 --------------------(+)
--  부서번호를 갖지 못한 사원들(5) 모두 조회


SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 15 건의 데이터가 결합되어 조회된 상황
--  부서번호를 갖지 못한 사원들(5) 모두 누락 --------------(+)
--  소속 사원을 갖지 못한 부서(1) 조회

--※ (+) 가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후              -- 기준
--   (+) 가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로  -- 추가(첨가)
--   JOIN 이 이루어진다.

--   이와 같은 이유로...
SELECT *
FROM TBL_EMP, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--   이런 형식의 JOIN은 존재하지 않는다.



-- 2. SQL 1999 CODE     → 『JOIN』 키워드 등장 → JOIN(결합)의 유형 명시
--                      → 『ON』 키워드 등장 → 결합 조건은 WHERE 대신 ON

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;
-- INNER JOIN 에서 INNER 는 생략 가능


-- OUTER JOIN
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- OUTER JOIN 에서 OUTER 는 생략 가능

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- LEFT RIGTH FULL 이 없으면 INNER JOIN


--------------------------------------------------------------------------------
-- 주의 사항
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> 이와 같은 방법으로 쿼리문을 구성해도
--  조회 결과를 얻는 과정에 문제는 없다.

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK';
--> 하지만, 이와 같이 구성하여
--  조회하는 것을 권장한다.

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO          -- 결합조건
WHERE E.JOB = 'CLERK';          -- 선택조건
-- 한 눈에 구분 가능 
--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.
SELECT D.DEPTNO"부서번호", ENAME"부서명",  ENAME"사원명", JOB "직종명", SAL"급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO                  --결합 조건
WHERE JOB IN ('MANAGER','CLERK');       --선택 조건

-- 부서번호, 부서명, 사원명, 직종명, 급여
-- DEPTNO    DNAME   ENAME   JOB     SAL
-- E, D      D       E       E       E

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
--      (ORA-00918: column ambiguously defined)
--      두 테이블 간 중복되는 컬럼에 대한
--      소속 테이블을 정해줘야(명시해줘야) 한다.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--※ 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 창조할 수 있도록 처리해야 한다.

SELECT *
FROM EMP;       -- 자식 테이블

SELECT *
FROM DEPT;      -- 부모 테이블

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL -- ORACLE의 경우 명시한 컬럼에서 확인하기때문에 양쪽(FROM) 컬럼을 확인할 필요가 없다.
FROM EMP E, DEPT D
WHERE E. DEPTNO = D.DEPTNO;

-- 두 테이블에 모두 포함되어 있는 중복된 컬럼이 아니더라도
-- 컬럼의 소속 테이블을 명시해 줄 수 있도록 권장한다.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;


--------------------------------------------------------------------------------

--○ SELF JOIN (자기 조인)

-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
--------------------------------------------------------------------------------
-- 사원번호  사원명  직종명  관리자번호  관리자명  관리자직종
--------------------------------------------------------------------------------
-- 7369      SMITH    CLERK     7902       FORD     ANALYST
-- ----------------------------------- E1
--                           -------------------------------- E2

SELECT E.EMPNO"사원번호" 
     , E.ENAME"사원명"
     , E.JOB"직종명"
     , E.MGR "관리자번호"
     , S.ENAME"관리자명"
     , S.JOB"관리자직종"
FROM EMP E, EMP S
WHERE E.MGR = S.EMPNO(+);


SELECT E.EMPNO"사원번호"
     , E.ENAME"사원명"
     , E.JOB"직종명"
     , E.MGR"관리자번호"
     , S.ENAME"관리자명"
     , S.JOB"관리자직종"
FROM EMP E LEFT JOIN EMP S
ON S.EMPNO = E.MGR;





SELECT EMPNO" 사원번호",ENAME"사원명", JOB"직종명", MGR "관리자번호", ENAME"관리자명", JOB "관리자직종명"
FROM EMP;

-- 1.
SELECT E1.EMPNO" 사원번호",E1.ENAME"사원명", E1.JOB"직종명"
     , E1.MGR "관리자번호", E2.ENAME"관리자명", E2.JOB "관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
-- 2.
SELECT E1.EMPNO" 사원번호",E1.ENAME"사원명", E1.JOB"직종명"
     , E2.EMPNO "관리자번호", E2.ENAME"관리자명", E2.JOB "관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;


SELECT E1.EMPNO" 사원번호",E1.ENAME"사원명", E1.JOB"직종명"
     , E2.EMPNO "관리자번호", E2.ENAME"관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;


SELECT E1.EMPNO" 사원번호",E1.ENAME"사원명", E1.JOB"직종명"
     , E2.EMPNO "관리자번호", E2.ENAME"관리자명", E2.JOB "관리자직종명"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);