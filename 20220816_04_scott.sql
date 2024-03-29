SELECT USER
FROM DUAL;
--==>>SCOTT

--○ TBL_EMP 테이블에서 입사일이 1981년 4월 2일 부터
--   1981년 9월 28일 사이에 입사한 직원들의
--   사원명, 직종명, 입사일 항목을 조회한다. (해당일 포함)

--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 4월 2일 부터 1981년 9월 28일 사이;

SELECT ENAME"사원명", JOB"직종명", HIREDATE"입사일"
FROM TBL_EMP
WHERE HIREDATE 1981년 4월 2일 부터
      AND HIREDATE 1981년 9월 28일 사이;

SELECT ENAME"사원명", JOB"직종명", HIREDATE"입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02','YYYY-MM-DD') 
  AND HIREDATE <= TO_DATE('1981-09-28','YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/

--○ BETWEEN ⓐ AND ⓑ
SELECT ENAME"사원명", JOB"직종명", HIREDATE"입사일"
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02','YYYY-MM-DD') 
                   AND TO_DATE('1981-09-28','YYYY-MM-DD');
--==>>
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/


--○ TBL_EMP 테이블에서 급여(SAL)가 2450 에서 3000 사이의 직원들을 모두 조회한다.
SELECT *
FROM TBL_EMP
WHERE SAL BETWEEN 2450 AND 3000;
--==>>
/*
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		20
7902	FORD	ANALYST	7566	1981-12-03	3000		20
*/

--○ TBL_EMP 테이블에서 직원들의 이름이
--   'C'로 시작하는 이름부터 'S'로 시작하는 이름인 경우
--   모든 항목을 조회한다.
SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S';        -- 사전식 배열 기준
                                        -- S도 포함하고 있음
                                        
--==>>
/*
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--※ 『BETWEEN ⓐ AND ⓑ』 는 날짜형, 숫자형, 문자형 데이터 모두에 적용된다.
--   단, 문자형일 경우 아스키코드 순서를 따르기 때문에 (사전식 배열)
--   대문자가 앞쪽에 위치하고 소문자가 뒤쪽에 위치한다.
--   또한, 『BETWEEN ⓐ AND ⓑ』는 해당 구문이 수행되는 시점에서
--   오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산 처리된다.



SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 's';
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--○ ASCII()
--   매개변수로, 넘겨받은 해당 문자의 아스키 코드 갑을 반환한다.
SELECT ASCII('A'), ASCII('B'), ASCII('a'), ASCII('b')
FROM DUAL;
--==>> 65	66	97	98

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
   OR JOB = 'CLERK';
--==>>
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
영주니	SALESMAN	
나유니	SALESMAN	
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN ('SALESMAN','CLERK');
--==>>
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
영주니	SALESMAN	
나유니	SALESMAN	
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB =ANY ('SALESMAN','CLERK');
--==>>
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
영주니	SALESMAN	
나유니	SALESMAN	
*/

--※ 위의 3가지 유형의 쿼리문은 모두 같은 결과를 반환한다.
--   하지만, 맨 위의 쿼리문(OR)이 가장 빠르게 처리된다. (정말 얼마 안되지만...)
--   물론 메모리에 대한 내용이 아니라 CPU 처리에 대한 내용이므로
--   이 부분까지 감안하여 쿼리문을 구성하게 되는 경우는 많지 않다.
--   → 『IN』 과 『= ANY』는 같은 연산자효과를 가진다
--      이들 모두는 내부적으로 『OR』구조로 변경되어 연산 처리된다.  

--------------------------------------------------------------------------------

DROP TABLE TBL_SAWON;
--==>> Table TBL_SAWON이(가) 삭제되었습니다.


DROP TABLE TBL_SAWON PURGE;
-- 휴지통을 거치지 않고 삭제(쓰지 않는 것이 좋음, 위험함)

PURGE RECYCLEBIN;
--==>> RECYCLEBIN이(가) 비워졌습니다.



--○ 추가 실습 테이블 구성(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO      NUMBER(4)
, SANAME    VARCHAR2(30)
, JUBUN     CHAR(13)
, HIREDATE  DATE            DEFAULT SYSDATE
, SAL       NUMBER(10)
);
--==>> Table TBL_SAWON이(가) 생성되었습니다.

SELECT *
FROM TBL_SAWON;
--==>> 조회결과 없음

DESC TBL_SAWON;
/*
이름       널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/

--○ 생성된 테이블에 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '고연수','9409252234567', TO_DATE('2005-01-03','YYYY-MM-DD'),3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '김보경','9809022234567', TO_DATE('1999-11-23','YYYY-MM-DD'),2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '정미경','9810092234567', TO_DATE('2006-08-10','YYYY-MM-DD'),4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '김인교','9307131234567', TO_DATE('1998-05-13','YYYY-MM-DD'),2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '이정재','7008161234567', TO_DATE('1998-05-13','YYYY-MM-DD'),1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '아이유','9309302234567', TO_DATE('1999-10-10','YYYY-MM-DD'),3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '이하이','0302064234567', TO_DATE('2010-10-23','YYYY-MM-DD'),4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '인순이','6807102234567', TO_DATE('1998-03-20','YYYY-MM-DD'),1500);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '선동렬','6710261234567', TO_DATE('1998-03-20','YYYY-MM-DD'),1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '선우용녀','6511022234567', TO_DATE('1998-12-20','YYYY-MM-DD'),2600);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '선우선','0506174234567', TO_DATE('2011-10-10','YYYY-MM-DD'),1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '남궁민','0102033234567', TO_DATE('2010-10-10','YYYY-MM-DD'),2400);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '남진','0210303234567', TO_DATE('2011-10-10','YYYY-MM-DD'),2800);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '반보영','9903142234567', TO_DATE('2012-11-11','YYYY-MM-DD'),5200);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '한은영','9907292234567', TO_DATE('2012-11-11','YYYY-MM-DD'),5200);

--==>> 1 행 이(가) 삽입되었습니다. * 15
COMMIT;
--==>>커밋 완료.

SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	고연수	    9409252234567	2005-01-03	3000
1002	김보경	    9809022234567	1999-11-23	2000
1003	정미경	    9810092234567	2006-08-10	4000
1004	김인교	    9307131234567	1998-05-13	2000
1005	이정재	    7008161234567	1998-05-13	1000
1006	아이유	    9309302234567	1999-10-10	3000
1007	이하이	    0302064234567	2010-10-23	4000
1008	인순이	    6807102234567	1998-03-20	1500
1009	선동렬	    6710261234567	1998-03-20	1300
1010	선우용녀	    6511022234567	1998-12-20	2600
1011	선우선	    0506174234567	2011-10-10	1300
1012	남궁민	    0102033234567	2010-10-10	2400
1013	남진	    0210303234567	2011-10-10	2800
1014	반보영	    9903142234567	2012-11-11	5200
1015	한은영	    9907292234567	2012-11-11	5200
*/

--○ TBL_SAWON 테이블에서 '고연수' 사원의 데이터를 조회한다.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '고연수';
--==>> 1001	고연수	9409252234567	2005-01-03	3000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '고연수';
--==>> 1001	고연수	9409252234567	2005-01-03	3000

--※ LIKE : 동사 → 좋아하다(X)
--          부사 → ~와 같이, ~처럼

--※ WILD CARD(CHARACTER) → 『%』
--   『LIKE』와 함께 사용되는 『%』는 모든 글자를 의미하고
--   『LIKE』와 함께 사용되는 『_』는 아무 글자 한 개를 의미한다.

--※ TBL_SAWON 테이블에서 성씨가 『고』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT 사원명, 주민번호, 급여
FROM TBL_SAWON
WHERE 성씨가 '고';

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '고';
--==>> 조회 결과 없음

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '고__';
--==>> 조회 결과 없음

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '고__';
--==>> 고연수	9409252234567	3000

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '고%';
--==>> 고연수	9409252234567	3000


--○ TBL_SAWON 테이블에서 성씨가 『이』 씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT 사원명,주민번호,급여
FROM TBL_SAWON
WHERE 성씨가 '이';

SELECT SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '이%';
--==>>
/*
이정재	7008161234567	1000
이하이	0302064234567	4000
*/


--○ TBL_SAWON 테이블에서 사원의 이름이 『영』으로 끝나는 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT 사원명, 주민번호, 급여
FROM TBL_SAWON
WHERE 사원의 이름이 '영'으로 끝나는 사원;

SELECT SANAME"사원명", JUBUN"주민번호", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%영';
--==>>
/*
반보영	9903142234567	5200
한은영	9907292234567	5200
*/

SELECT SANAME"사원명", JUBUN"주민번호", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '__영';
--==>>
/*
반보영	9903142234567	5200
한은영	9907292234567	5200
*/

--○ 추가 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '이이경', '0605063234567',TO_DATE('2015-01-20','YYYY-MM-DD'), 1500);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_SAWON;
--==>>
/*
1001	고연수	9409252234567	2005-01-03	3000
1002	김보경	9809022234567	1999-11-23	2000
1003	정미경	9810092234567	2006-08-10	4000
1004	김인교	9307131234567	1998-05-13	2000
1005	이정재	7008161234567	1998-05-13	1000
1006	아이유	9309302234567	1999-10-10	3000
1007	이하이	0302064234567	2010-10-23	4000
1008	인순이	6807102234567	1998-03-20	1500
1009	선동렬	6710261234567	1998-03-20	1300
1010	선우용녀	6511022234567	1998-12-20	2600
1011	선우선	0506174234567	2011-10-10	1300
1012	남궁민	0102033234567	2010-10-10	2400
1013	남진	0210303234567	2011-10-10	2800
1014	반보영	9903142234567	2012-11-11	5200
1015	한은영	9907292234567	2012-11-11	5200
1016	이이경	0605063234567	2015-01-20	1500
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   하나라도 포함되어 있다면 그 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT 사원번호, 사원명, 급여
FROM TBL_SAWON
WHERE 사원의 이름에 『이』라는 글자가 하나라도 포함되어 있다면;

SELECT SANO"사원번호", SANAME"사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%';
--==>>
/*
1005	이정재	1000
1006	아이유	3000
1007	이하이	4000
1008	인순이	1500
1016	이이경	1500
*/

--○ TBL_SAWON 테이블에서 사원의 이름에 『이』 라는 글자가 두 번 들어있는 사원의
--   사원번호, 사원명 급여 항목을 조회한다.
SELECT 사원번호, 사원명, 급여
FROM TBL_SAWON
WHERE 사원의 이름에 '이'라는 글자가 두 번 포함;

SELECT SANO"사원번호", SANAME"사원명", SAL"급여"
FROM TBL_SAWON
WHERE 사원의 이름에 '이'라는 글자가 두 번 포함;


SELECT SANO"사원번호", SANAME"사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%이%';
--==>> 
/*
1007	이하이	4000
1016	이이경	1500
*/


--○ TBL_SAWON 테이블에서 사원의 이름에 『이』라는 글자가
--   연속으로 두 번 들어있는 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.

SELECT SANO"사원번호",SANAME"사원명",SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이이%';
--==>> 1016	이이경	1500

--○ TBL_SAWON 테이블에서 사원의 이름의 두 번째 글자가 『보』인 사원의
--   사원번호, 사원명, 급여 항목을 조회한다.
SELECT 사원번호, 사원명, 급여
FROM TBL_SAWON
WHERE 사원의 이름의 두 번째 글자가 『보』;

SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME의 이름의 두 번째 글자가 『보』;

SELECT SANO"사원번호", SANAME"사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '_보';             -- 이름이 두글자인 사람만
--==>> 조회 결과 없음

SELECT SANO"사원번호", SANAME"사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '_보%';
--==>>
/*
1002	김보경	2000
1014	반보영	5200
*/

--○ TBL_SAWON 테이블에서 성씨가 『선』씨인 사원의
--   사원명, 주민번호, 급여 항목을 조회한다.
SELECT 사원명, 주민번호, 급여
FROM TBL_SAWON
WHERE 성씨가 『선』;

SELECT SANAME"사원명", JUBUN"주민번호", SAL"급여"
FROM TBL_SAWON
WHERE SANAME 『선』;

SELECT SANAME"사원명", JUBUN"주민번호", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '선%';
--==>>
/*
선동렬	    6710261234567	1300
선우용녀	    6511022234567	2600
선우선	    0506174234567	1300
*/

--※ 데이터베이스 설계 과정에서
--   성과 이름을 분리하여 처리할 업무 계획이 있다면
--   (지금 당장은 아니더라도...)
--   테이블에서 성 컬럼과 이름 컬럼을 분리하여 구성해야 한다.

--  『선우』용녀,『선우』선 과 같이 성이 『선우』인 경우와 『선』인 경우 구분하지 못한다.


--○ TBL_SAWON 테이블에서 여직원들의
--   사원명, 주민번호, 급여 항목을 조회한다.

DESC TBL_SAWON;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/

SELECT 사원명, 주민번호, 급여
FROM TBL_SAWON
WHERE 성별이 여성인;

SELECT SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE 주민번호 7번째 자리 1개가 2
      주민번호 7번째 자리 1개가 4;
      
SELECT SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE JUBUN 7번째 자리 1개가 2
      JUBUN 7번째 자리 1개가 4;

SELECT SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______' 
   OR JUBUN LIKE '______4______';
--==>>
/*
고연수	    9409252234567	3000
김보경	    9809022234567	2000
정미경	    9810092234567	4000
아이유	    9309302234567	3000
이하이	    0302064234567	4000
인순이	    6807102234567	1500
선우용녀	    6511022234567	2600
선우선	    0506174234567	1300
반보영	    9903142234567	5200
한은영	    9907292234567	5200
*/


--○ 실습 테이블 생성(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME    VARCHAR2(20)
, BIGO          VARCHAR2(100)
);
--==>> Table TBL_WATCH이(가) 생성되었습니다.

-- 데이터 입력(TBL_WARCH)
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('금시계','순금 99.99% 함유된 최고급 시계');

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('은시계','고객 만족도 99.99점을 획득한 최고의 시계');

--==>> 1 행 이(가) 삽입되었습니다. * 2

--○ 확인
SELECT *
FROM TBL_WATCH;
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 최고의 시계
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ TBL_WATCH 테이블의 BIGO(비고) 컬럼에
--   『99.99%』라는 글자가 포함된(들어있는) 행(레코드)의
--   데이터를 조회한다.

SELECT *
FROM TBL_WATCH
WHERE 비고 컬럼에 '99.99%' 라는 글자 포함;

SELECT *
FROM TBL_WATCH
WHERE BIGO 에 '99.99%' 라는 글자 포함;

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';
--==>> 조회 결과 없음
-- BIGO 컬럼의 문자열이 99.99로 시작하는...

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 최고의 시계
*/
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 최고의 시계
*/


-- ESCAPE
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99$%%' ESCAPE '$';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99@%%' ESCAPE '@';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

--※ ESCAPE 로 정한 문자의 다음 한 글자를 와일드 카드에서 탈출시켜라...
--   일반적으로 사용 빈도가 낮은 특수문자(특수기호)를 사용한다.




--------------------------------------------------------------------------------


--■■■ COMMIT / ROLLBACK ■■■--

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/



--○ 데이터 입력
INSERT INTO TBL_DEPT VALUES(50,'개발부','서울');
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/

-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는
-- 하드디스크상에 물리적으로 적용되어 저장된 것이 아니다.
-- 메모리(RAM) 상에 입력된 것이다.


--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 다시 확인
SELECT *
FROM TBL_DEPT;
--==>> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--> 50번 개발부 서울... 에 대한 데이터가 소실되었음을 확인(존재하지 않음)


--○ 다시 데이터 입력
INSERT INTO TBL_DEPT VALUES(50,'개발부','서울');
--==>> 1 행 이(가) 삽입되었습니다.

--○ 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	서울
*/



-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는 하드디스크상에 저장된 것이 아니라
-- 메모리(RAM) 상에 입력된 것이다.
-- 이를... 실제 하드디스크상에 물리적으로 저장된 상황을 확정하기 위해서는
-- COMMIT 을 수행해야 한다.

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 커밋 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/


--○ 롤백
ROLLBACK;
--==>> 롤백 완료.

--○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	    서울
*/
--> 롤백(ROLLBACK)을 수행했음에도 불구하고
--  50번 개발부 서울... 의 행 데이터는 소실되지 않앗음을 확인

--※ COMMIT 을 실행한 이후로 DML 구문(INSERT, UPDATE, DELETE)을 통해
--   변경된 데이터를 취소할 수 있는 것일 뿐... 
--   DML 명령을 사용한 후 COMMIT 을 수행하고 나서 ROLLBACK 을 실행해봐야
--   아무런 소용이 없다.

--○ 데이터 수정(UPDATE → TBL_DEPT)
UPDATE TBL_DEPT                             --②
SET DNAME = '연구부', LOC = '경기'          --③
WHERE DEPTNO = 50;                          --①    생략 시 모든 구문 변경하겠다
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    경기
*/


ROLLBACK;
--==>> 롤백 완료.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	개발부	서울
*/

UPDATE TBL_DEPT
SET DNAME = '연구부',LOC='인천'
WHERE DEPTNO=50;
--==>>  1 행 이(가) 업데이트되었습니다.


SELECT *
FROM TBL_DEPT;
--==>> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    인천
*/

COMMIT;
--==>>커밋 완료.

ROLLBACK;
ROLLBACK;
ROLLBACK;

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	연구부	    인천
*/


--○ 데이터 삭제(DELETE → TBL_DEPT)
/*
DELETE TBL_DEPT
WHERE DEPTNO=50;
*/

SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;

DELETE
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_DEPT;

ROLLBACK;

COMMIT;

--------------------------------------------------------------------------------

--■■■ ORDER BY 절 ■■■■--
SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP;
--==>>
/*
SMITH	20	CLERK	    800	    9600
ALLEN	30	SALESMAN	1600	19500
WARD	30	SALESMAN	1250	15500
JONES	20	MANAGER	    2975	35700
MARTIN	30	SALESMAN	1250	16400
BLAKE	30	MANAGER	    2850	34200
CLARK	10	MANAGER	    2450	29400
SCOTT	20	ANALYST	    3000	36000
KING	10	PRESIDENT	5000	60000
TURNER	30	SALESMAN	1500	18000
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	    11400
FORD	20	ANALYST	    3000	36000
MILLER	10	CLERK	    1300	15600
*/

SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO ASC;        -- DEPTNO → 정렬 기준 : 부서번호
                            -- ASC    → 정렬 유형 : 오름차순
--==>>
/*
CLARK	10	MANAGER	    2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	    9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	    950	    11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO;                -- ASC      → 정렬 유형 : 오름차순 → 생략 가능~!!!
--==>>
/*
CLARK	10	MANAGER	    2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	    9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	    950	    11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO DESC;           -- DESC     → 정렬 유형 : 내림차순 → 생략 가능~!!!
--==>>
/*
BLAKE	30	MANAGER	    2850	34200
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
MARTIN	30	SALESMAN	1250	16400
WARD	30	SALESMAN	1250	15500
JAMES	30	CLERK	    950	    11400
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975	35700
SMITH	20	CLERK	    800	    9600
ADAMS	20	CLERK	    1100	13200
FORD	20	ANALYST	    3000	36000
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
CLARK	10	MANAGER	    2450	29400
*/

SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 연봉 DESC;
-- 파싱 순서에 의해
/*
KING	10	PRESIDENT	5000	60000
FORD	20	ANALYST	    3000	36000
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975	35700
BLAKE	30	MANAGER	    2850	34200
CLARK	10	MANAGER	    2450	29400
ALLEN	30	SALESMAN	1600	19500
TURNER	30	SALESMAN	1500	18000
MARTIN	30	SALESMAN	1250	16400
MILLER	10	CLERK	    1300	15600
WARD	30	SALESMAN	1250	15500
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	     950	11400
SMITH	20	CLERK	     800	 9600
*/
SELECT *
FROM EMP;

SELECT ENAME "사원명", DEPTNO"부서명", JOB"직종", SAL"급여",
       SAL*12+NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 2;         -- 부서번호 오름차순
                    
--> EMP 테이블이 갖고 있는 테이블의 고유한 컬럼 순서(2 → ENAME)가 아니라
--  SELECT 처리 되는 두 번째 컬럼(2→DEPTNO, 부서번호)을 기준으로 정렬
--  ASC 는 생략된 상태 → 오름차순 정렬
--  오라클에서의 기본 인덱스는 자바와 달리 1부터 시작.
--  최종적으로.. 현재 『ORDER BY 2』 구문은 → 『ORDER BY DEPTNO ASC』 이다.
--==>>
/*
CLARK	10	MANAGER	    2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	35700
FORD	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	     800	9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	     950	11400
BLAKE	30	MANAGER	    2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 4;
-- ORDER BY EPTNO, SAL ASC;
-- 부서번호, 급여 기준 오름차순 정렬;
--   (1)        (2)
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SMITH	20	CLERK	     800
ADAMS	20	CLERK	    1100
JONES	20	MANAGER	    2975
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
JAMES	30	CLERK	     950
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
TURNER	30	SALESMAN	1500
ALLEN	30	SALESMAN	1600
BLAKE	30	MANAGER	    2850
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 3, 4 DESC;
-- ① 2 → DEPTNO(부서번호) 기준 오름차순 정렬
-- ② 3 → JOB(직종명) 기준 오름차순 정렬
-- ③ 4 DESC → SAL(급여) 기준 내림차순(DESC) 정렬
-- (3차 정렬 수행)
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	    3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	     800
JONES	20	MANAGER	    2975
JAMES	30	CLERK	     950
BLAKE	30	MANAGER	    2850
ALLEN	30	SALESMAN	1600
TURNER	30	SALESMAN	1500
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
*/


--------------------------------------------------------------------------------

--○ CONCAT()
SELECT ENAME || JOB "첫번째컬럼"
     , CONCAT(ENAME, JOB) "두번째컬럼"
FROM EMP;

-- 문자열 기반으로 데이터 결합을 수행하는 함수 CONCAT()
-- 오로지 2개의 문자열만 결합시킬 수 있다.

SELECT '우리는' || '기본을' || '지킨다' "첫번째컬럼"
      , CONCAT('우리는','기본을','지킨다') "두번째컬럼"
FROM DUAL;
--==>> 에러 발생
--     (ORA-00909: invalid number of arguments)

SELECT ENAME || JOB || DEPTNO "첫번째 컬럼"
     , CONCAT(CONCAT(ENAME, JOB), DEPTNO) "두번째 컬럼"
FROM EMP;
--==>>
/*
SMITHCLERK20	    SMITHCLERK20
ALLENSALESMAN30	    ALLENSALESMAN30
WARDSALESMAN30	    WARDSALESMAN30
JONESMANAGER20	    JONESMANAGER20
MARTINSALESMAN30	MARTINSALESMAN30
BLAKEMANAGER30	    BLAKEMANAGER30
CLARKMANAGER10	    CLARKMANAGER10
SCOTTANALYST20	    SCOTTANALYST20
KINGPRESIDENT10	    KINGPRESIDENT10
TURNERSALESMAN30	TURNERSALESMAN30
ADAMSCLERK20	    ADAMSCLERK20
JAMESCLERK30	    JAMESCLERK30
FORDANALYST20	    FORDANALYST20
MILLERCLERK10	    MILLERCLERK10
*/

--> 내부적인 형 변환이 일어나며 결합을 수행하게 된다.
--  CONCAT() 은 문자열을 결합시켜주는 함수이지만
--  내부적으로 숫자나 날짜를 문자로 바꾸어주는 과정이 포함되어 있다.

/*
obj.subString()
---
 |
문자열 → 문자열.subString(n, m);
                          ------
                          문자열의 n 부터 m-1 까지... (인덱스는 0부터)
*/

--○ SUBSTR() 갯수 기반 / SUBSTRB() 바이트 기반
--   바이트 기반으로 운용할 때 인코딩 고려 (가급적 쓰지 말 것) 

SELECT ENAME "COL1"
     , SUBSTR(ENAME, 1, 2) "COL2"
FROM EMP;
--> 문자열을 추출하는 기능을 가진 함수
--  첫 번째 파라미터 값은 대상 문자열(추출의 대상, TARGET)
--  두 번째 파라미터 값은 추출을 시작하는 위치(인덱스, START) → 인덱스는 1부터 시작
--  세 번째 파라미터 값은 추출할 문자열의 갯수(갯수, COUNT) → 생략 시... 문자열의 길이 끝까지...

SELECT ENAME "COL1"
     , SUBSTR(ENAME, 3, 2) "COL2"
     , SUBSTR(ENAME, 3, 5) "COL3"
     , SUBSTR(ENAME, 3) "COL4"
     , SUBSTR(ENAME, 6, 1) "COL5"
FROM EMP;
--==>>
/*
SMITH	IT	ITH	    ITH     (null)	
ALLEN	LE	LEN	    LEN	    (null)
WARD	RD	RD	     RD	    (null)
JONES	NE	NES	    NES	    (null)
MARTIN	RT	RTIN	RTIN	N
BLAKE	AK	AKE	     AKE	(null)
CLARK	AR	ARK	     ARK	(null)
SCOTT	OT	OTT	    OTT	    (null)
KING	NG	NG	     NG	    (null)
TURNER	RN	RNER	RNER	R
ADAMS	AM	AMS	     AMS	(null)
JAMES	ME	MES	     MES	(null)
FORD	RD	RD	     RD	    (null)
MILLER	LL	LLER	LLER	R
*/

-- ○ TBL_SAWON 테이블에서 성별이 남성인 사원만
--    사원번호, 사원명, 주민번호, 급여 항목을 조회한다.
--    단, SUBSTR() 함수를 활용하여 처리할 수 있도록 한다.

SELECT 사원번호, 사원명, 주민번호, 급여
FROM TBL_SAWON
WHERE 남성인 사원;

SELECT SANO"사원번호",SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE JUBUN 컬럼의 7번째 자리 1개가 '1'
   OR JUBUN 컬럼의 7번째 자리 1개가 '3';



SELECT SANO"사원번호",SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) = '1' 
   OR SUBSTR(JUBUN,7,1) = '3';
--==>>
/*
1004	김인교	9307131234567	2000
1005	이정재	7008161234567	1000
1009	선동렬	6710261234567	1300
1012	남궁민	0102033234567	2400
1013	남진	0210303234567	2800
1016	이이경	0605063234567	1500
*/

SELECT SANO"사원번호",SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) IN ('1','3');
--==>>
/*
1004	김인교	9307131234567	2000
1005	이정재	7008161234567	1000
1009	선동렬	6710261234567	1300
1012	남궁민	0102033234567	2400
1013	남진	0210303234567	2800
1016	이이경	0605063234567	1500
*/

SELECT SANO"사원번호",SANAME"사원명",JUBUN"주민번호",SAL"급여"
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) =ANY ('1','3');
--==>>
/*
1004	김인교	9307131234567	2000
1005	이정재	7008161234567	1000
1009	선동렬	6710261234567	1300
1012	남궁민	0102033234567	2400
1013	남진	0210303234567	2800
1016	이이경	0605063234567	1500
*/

--○ LENGTH() 글자 수 / LENGTHB() 바이트 수
SELECT ENAME "COL1"
     , LENGTH(ENAME) "COL2"
     , LENGTHB(ENAME) "COL3"
FROM EMP;
--==>>
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	4	4
MILLER	6	6
*/


--○ INSTR()
SELECT 'ORACLE ORAHOME BIORA' "COL1"
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"    -- 1
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"    -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"    -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"       -- 8
     , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"    -- 0
FROM DUAL;
--> 첫 번째 파라미터 값에 해당하는 문자열에서... (대상 문자열, TARGET)
--  두 번째 파라미터 값을 통해 넘겨준 문자열이 등장하는 위치를 찾아라~!!!
--  세 번째 파라미터 값은 찾기 시작하는(스캔을 시작하는) 위치
--  네 번째 파라미터 값은 몇 번째 등장하는 값을 찾을 것인지에 대한 설정(→ 1은 생략 가능)

SELECT '나의오라클 집으로오라 합니다.' "COL1"
     , INSTR('나의오라클 집으로오라 합니다.', '오라', 1) "COL2"    -- 3
     , INSTR('나의오라클 집으로오라 합니다.', '오라', 2) "COL3"    -- 3
     , INSTR('나의오라클 집으로오라 합니다.', '오라', 10) "COL4"   -- 10
     , INSTR('나의오라클 집으로오라 합니다.', '오라', 11) "COL5"   -- 0
FROM DUAL;
--> 마지막 파라미터 값을 생략한 형태로 사용 → 마지막 파라미터 → 1

--○ REVERSE()
SELECT 'ORACLE' "COL1"
      , REVERSE('ORACLE') "COL2"    --ELCARO
      , REVERSE('오라클') "COL3"    
FROM DUAL;
--==>> 	ORACLE	ELCARO	???
-- 대상 문자열을 거꾸로 반환한다. (단, 한글은 제외 - 사용불가)

--○ 실습 테이블 생성(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO        NUMBER(3)
, FILENAME      VARCHAR2(100)
);
--==>> Table TBL_FILES이(가) 생성되었습니다.

--○ 데이터 입력(TBL_FILES)
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'C:\SHARE\F\TEST\FLOWER.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE\20220816_01_SCOTT.SQL');

--==>> 1 행 이(가) 삽입되었습니다. * 7


--○ 확인
SELECT *
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XXLS
3	D:\RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
6	C:\SHARE\F\TEST\FLOWER.PNG
7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.
SELECT FILENO "파일번호"
      ,FILENAME "파일명"
FROM TBL_FILES;
--==>>
/*
--------- ----------------------------------------
 파일번호 파일명
--------- ----------------------------------------
        1	C:\AAA\BBB\CCC\SALES.DOC
        2	C:\AAA\PANMAE.XXLS
        3	D:\RESEARCH.PPT
        4	C:\DOCUMENTS\STUDY.HWP
        5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
        6	C:\SHARE\F\TEST\FLOWER.PNG
        7	E:\STUDY\ORACLE\20220816_01_SCOTT.SQL
--------- ----------------------------------------
*/

--○ TBL_FILES 테이블을 조회하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.
/*
--------- ----------------------------------------
 파일번호 파일명
--------- ----------------------------------------
        1	SALES.DOC
        2	PANMAE.XXLS
        3	RESEARCH.PPT
        4	STUDY.HWP
        5	SQL.TXT
        6	FLOWER.PNG
        7	20220816_01_SCOTT.SQL
--------- ----------------------------------------
*/
     
SELECT FILENO"파일번호"
      ,SUBSTR(FILENAME,INSTR(FILENAME,'\',-1)+1)"파일명"       --INSTR - 반대에서 시작
FROM TBL_FILES;

SELECT FILENO"파일번호"
      ,SUBSTR(FILENAME,)

FROM TBL_FILES;

--영준이 형 풀이방식
SELECT SUBSTR(FILENAME, (LENGTH(FILENAME)-INSTR(REVERSE(FILENAME),'\',1)+2))"파일명"
FROM TBL_FILES;
--동현이 형 풀이 방식
SELECT FILENO "파일번호"
      ,REVERSE(SUBSTR(REVERSE(FILENAME),1,INSTR(REVERSE(FILENAME),'\',1,1)-1))"파일명"
FROM TBL_FILES;
--내 방식
SELECT FILENO "파일번호"
     -- ,SUBSTR(REVERSE(FILENAME),'\',1,1)
      ,REVERSE(SUBSTR(REVERSE(FILENAME),1,INSTR(REVERSE(FILENAME),'\',1)-1))"파일명"
FROM TBL_FILES;

SELECT FILENO "파일번호" 
     , SUBSTR(FILENAME, (LENGTH(FILENAME)-INSTR(REVERSE(FILENAME),'\',1)+2))"파일명"
FROM TBL_FILES;