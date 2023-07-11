SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL)"급여합" -- DEPTNO 숫자타입, '모든부서' 문자열
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	 8700
모든부서	37725
*/

SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL)"급여합" -- DEPTNO 숫자타입, '모든부서' 문자열
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
모든부서	 8700
모든부서	37725
*/


-- GROUPING()
SELECT GROUPING(DEPTNO)"GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
GROUPTIN  부서번호      급여합
--------- -------- ----------
        0	    10	     8750
        0	    20	    10875
        0	    30	     9400
        0	(null)	     8700
        1	(null)	    37725
*/


SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	 8750
20	10875
30	 9400
	 8700
	37725
*/

--○ 위에서 조회한 해당 내용을
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/
--이와 같이 조회되도록 쿼리문을 구성한다.

--※ 참고
SELECT GROUPING(DEPTNO)"GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
GROUPTIN  부서번호      급여합
--------- -------- ----------
        0	    10	     8750
        0	    20	    10875
        0	    30	     9400
        0	(null)	     8700
        1	(null)	    37725
*/

--※ 힌트
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '단일부서' ELSE '모든부서' END "부서번호"
     , SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
단일부서	 8750
단일부서	10875
단일부서	 9400
단일부서	 8700
모든부서	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
       ELSE'모든부서' 
       END"부서번호"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL2(DEPTNO,TO_CHAR(DEPTNO),'인턴') 
       ELSE'모든부서' 
       END"부서번호"
       ,SUM(SAL)"급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/

--------------------------------------------------------------------------------
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO 
       ELSE'모든부서' 
       END "부서번호"
       ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 에러 발생
--      (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO) 
       ELSE'모든부서' 
       END "부서번호"
       ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)	     8700
모든부서	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
       ELSE'모든부서' 
       END "부서번호"
       ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	     8700
모든부서	37725
*/



--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
----------- ----------------
    성별          급여합
----------- ----------------
    남            XXXX               -- 0
    여           XXXXX               -- 0
  모든사원      XXXXXX               -- 1
----------- ----------------
*/
SELECT *
FROM TBL_SAWON;

SELECT CASE GROUPING(T.성별) 
       WHEN 0 
       THEN T.성별 
       ELSE '모든사원' 
       END"성별"
       , SUM(T.급여)"급여합" -- SUM(SAL) (X)
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4')
            THEN '여'
            ELSE '성별확인불가' 
            END"성별"
            , SAL"급여"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        11000
여	        31800
모든사원	42800
*/


-------------------------■■■선생님 풀이
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') 
            THEN '여'
            ELSE '성별확인불가'
            END "성별"
        , SAL "급여"
FROM TBL_SAWON;
--==>>
/*
여	3000
여	2000
여	4000
남	2000
남	1000
여	3000
여	4000
여	1500
남	1300
여	2600
여	1300
남	2400
남	2800
여	5200
여	5200
남	1500
*/

SELECT T.성별 "성별"
       , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') 
            THEN '여'
            ELSE '성별확인불가'
            END "성별"
        , SAL "급여"
FROM TBL_SAWON
)T
GROUP BY T.성별;
--==>>
/*
여	31800
남	11000
*/

SELECT T.성별 "성별"
       , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') 
            THEN '여'
            ELSE '성별확인불가'
            END "성별"
        , SAL "급여"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	    11000
여	    31800
(null)	42800
*/



SELECT NVL(T.성별, '모든사원') "성별"
       , SUM(T.급여) "급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') 
            THEN '여'
            ELSE '성별확인불가'
            END "성별"
        , SAL "급여"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        11000
여	        31800
모든사원	42800
*/

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별 
            ELSE '모든사원' 
       END"성별"
       , SUM(T.급여)"급여합"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') 
            THEN '남'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4')
            THEN '여'
            ELSE '성별확인불가' 
            END"성별"
            , SAL"급여"         
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
성별       급여합
-------- --------
남	        11000
여	        31800
모든사원	42800
*/










--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
----------- -------------
연령대        인원수
----------- -------------
    10            X
    20            X
    30            X
    50            X
   전체          16
----------- -------------
*/

SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999),-1)
            ELSE -1 
            END"연령대"
FROM TBL_SAWON;
--==>>
/*
20
20
20
30
50
30
20
50
50
50
10
20
20
20
20
10
*/
SELECT T.연령대 "연령대"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999),-1)
            ELSE -1 
            END"연령대"
FROM TBL_SAWON
)T
GROUP BY (T.연령대);
--==>>
/*
30
20
50
10
*/
SELECT T.연령대 "연령대"
        , COUNT(*)"인원수"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999),-1)
            ELSE -1 
            END"연령대"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
10	2
20	8
30	2
50	4
(null)	16
*/

SELECT NVL(TO_CHAR(T.연령대),'전체') "연령대"
        , COUNT(*)"인원수"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899),-1)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN TRUNC((EXTRACT(YEAR FROM SYSDATE)) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999),-1)
            ELSE -1 
            END"연령대"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
10	     2
20	     8
30	     2
50	     4
전체	16
*/
SELECT NVL(TO_CHAR(T2.연령대),'전체')"연령대"
     , COUNT(*)
FROM
(
SELECT CASE WHEN T1.나이 >= 50 THEN 50
            WHEN T1.나이 >= 40 THEN 40
            WHEN T1.나이 >= 30 THEN 30
            WHEN T1.나이 >= 20 THEN 20
            WHEN T1.나이 >= 10 THEN 10
            ELSE -1
            END "연령대"
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')
            THEN EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2) + 1999)
            ELSE -1
            END "나이"
FROM TBL_SAWON
)T1
)T2
GROUP BY ROLLUP(T2.연령대);



--------------------------------------------------------------------------------
--■■■동현이형 방법 1.■■■--
SELECT NVL(T.연령대,'전체') "연령대", COUNT(*) "인원수"
FROM
(
    SELECT CASE WHEN S.현재나이>=50 THEN '50'
                WHEN S.현재나이>=30 THEN '30'
                WHEN S.현재나이>=20 THEN '20'
                WHEN S.현재나이>=10 THEN '10'
                ELSE '모름'
           END "연령대"
    FROM
    (
        SELECT  CASE WHEN  SUBSTR(JUBUN,7,1) = ANY('1','2') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1899)
                     WHEN  SUBSTR(JUBUN,7,1) = ANY('3','4') THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1999)
                     ELSE -1         
                END "현재나이"
        FROM TBL_SAWON
    )S
)T
GROUP BY ROLLUP(T.연령대);
--------------------------------------------------------------------------------
--■■■동현이형 방법 2.■■■--

SELECT NVL(T.연령대,'전체') "연령대", COUNT(*) "인원수"
FROM
(
    SELECT  CASE WHEN  SUBSTR(JUBUN,7,1) = ANY('1','2') 
                    THEN SUBSTR(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1899),1,1) || '0'
            WHEN  SUBSTR(JUBUN,7,1) = ANY('3','4') 
                    THEN SUBSTR(EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) +1999),1,1) || '0'
            ELSE '몰라'
            END  "연령대"                                 
    FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.연령대);
-- SUBSTR 로 앞부분만 추출하여 파이프||를 통해 문자타입의 0을 붙여 연령대로 만든다.
--------------------------------------------------------------------------------


--■■■선생님 방법■■■--
-- 방법 1. → INLINE VIEW 를 두 번 중첩

SELECT NVL(TO_CHAR(T2.연령대),'전체') "연령대"
        , COUNT(*) "인원수"
FROM
(
    -- 연령대
    SELECT CASE WHEN T1.나이 >= 50 THEN 50 
                WHEN T1.나이 >= 40 THEN 40
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0
            END "연령대"
    FROM
    (
        --나이
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                END"나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);
/*
----------- -------------
연령대        인원수
----------- -------------
10	                    2
20	                    8
30	                    2
50	                    4
전체	               16
*/
SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR(T2.연령대)
            ELSE '전체'
        END "연령대"
        , COUNT(*) "인원수"
FROM
(
    -- 연령대
    SELECT CASE WHEN T1.나이 >= 50 THEN 50 
                WHEN T1.나이 >= 40 THEN 40
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0
            END "연령대"
    FROM
    (
        --나이
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                END"나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);
/*
----------- -------------
연령대        인원수
----------- -------------
10	                    2
20	                    8
30	                    2
50	                    4
전체	               16
*/




--■■■선생님 방법■■■--
-- 방법 2. → INLINE VIEW 를 한 번 사용
SELECT CASE GROUPING (T.연령대) WHEN 0 THEN TO_CHAR(T.연령대) ELSE '전체' END "연령대"
     , COUNT(*) "인원수"
FROM
(
    -- 연령대 
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                ELSE -1
            END, -1) "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--------------------------------------------------------------------------------



SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300        -- 10번 부서 CLERK 직종의 급여합
10	    MANAGER	     2450        -- 10번 부서 MANAGER 직종의 급여합
10	    PRESIDENT	 5000        -- 10번 부서 PRESIDENT 직종의 급여합
10	    (null)	     8750        -- 10번 부서 모든 직종의 급여합
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20	    (null)  	10875        -- 20번 부서 모든 직종의 급여합  
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30	    (null)  	 9400        -- 30번 부서 모든 직종의 급여합
(null)	(null)	    29025        -- 모든 부서 모든 직종의 급여합
*/


--○ CUBE() → ROLLUP() 보다 

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	    CLERK	     1300
10	    MANAGER	     2450
10	    PRESIDENT	 5000
10		(null)       8750
20	    ANALYST	     6000
20	    CLERK	     1900
20	    MANAGER	     2975
20		(null)      10875
30	    CLERK	      950
30	    MANAGER	     2850
30	    SALESMAN	 5600
30		(null)       9400
(null)	ANALYST	     6000       -- 모든 부서 ANALYST 직종의 급여합        --추가
(null)	CLERK	     4150       -- 모든 부서 CLERK 직종의 급여합          --추가
(null)	MANAGER	     8275       -- 모든 부서 MANAGER 직종의 급여합        --추가
(null)	PRESIDENT	 5000       -- 모든 부서 PRESIDENT 직종의 급여합      --추가
(null)	SALESMAN	 5600       -- 모든 부서 SALESMAN 직종의 급여합       --추가
(null)  (null)		29025
*/


--※ ROLLUP() 과 CUBE() 는
--   그룹을 묶어주는 방식이 다르다. (차이)

-- EX.

-- ROLLUP(A, B, C)
-- →(A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- →(A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()


--==>> 위의 과정은(ROLLUP()) 묶음 방식이 다소 모자랄 때가 있고
--     아래 과정은(CUBE()) 묵음 방식이 다소 지나칠 때가 잇기 때문에
--     다음과 같은 방식의 쿼리를 더 많이 사용하게 된다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만
--     『GROUPING SETS』 를 이용하여 묶어주는 방식이다.
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
            ELSE '전체부서'
        END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
        END "직종"
     ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	             1300
10	        MANAGER	             2450
10	        PRESIDENT	         5000
10	        전체직종	             8750

20	        ANALYST	             6000
20	        CLERK	             1900
20	        MANAGER	             2975
20	        전체직종	            10875

30	        CLERK	              950
30	        MANAGER	             2850
30	        SALESMAN	         5600
30	        전체직종	             9400

인턴	    CLERK	             3500
인턴	    SALESMAN	         5200
인턴	    전체직종         	 8700
전체부서	전체직종	            37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
            ELSE '전체부서'
        END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
        END "직종"
     ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종	     8750
20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	    10875
30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종     9400
인턴	    CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	     8700
전체부서	ANALYST	     6000
전체부서	CLERK	     7650
전체부서	MANAGER	     8275
전체부서	PRESIDENT	 5000
전체부서	SALESMAN	10800
전체부서	전체직종    	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
            ELSE '전체부서'
        END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
        END "직종"
     ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE() 를 사용한 결과와 같은 조회 결과 반환


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
            ELSE '전체부서'
        END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
        END "직종"
     ,SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB),(DEPTNO), ())
ORDER BY 1, 2;
--==>> ROLLUP() 을 사용한 결과와 같은 조회 결과 반환




--------------------------------------------------------------------------------

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

--○ TBL_EMP 테이블을 대상으로
--   입사년도별 인원수를 조회한다.


SELECT NVL(TO_CHAR(T.입사년도),'전체')"입사년도"
    , COUNT(*)"인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.입사년도);
/*
1980	1
1981	10
1982	1
1987	2
2022    	5
전체	19
*/

SELECT ENAME,HIREDATE
FROM TBL_EMP;

SELECT NVL(TO_CHAR(T.입사년도),'전체')"입사년도"
    , COUNT(*)"인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    FROM TBL_EMP
) T
GROUP BY CUBE(T.입사년도);






SELECT ? "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY 입사년도;


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE);
--==>>
/*
1982	1
2022    	5
1987	2
1980	    1
1981	10
*/

SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;



SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00979: not a GROUP BY expression)


SELECT SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00979: not a GROUP BY expression)

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE)  
            ELSE '전체' 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)

SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE)  
            ELSE '전체' 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)



SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY')  
            ELSE '전체' 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00979: not a GROUP BY expression)


SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY')  
            ELSE '전체' 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--      (ORA-00979: not a GROUP BY expression)


SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE, 'YYYY')  
            ELSE '전체' 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 
/*
1980	1
1981	10
1982	1
1987	2
2022	    5
전체	19
*/

SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0 
            THEN EXTRACT(YEAR FROM HIREDATE)  
            ELSE -1 
        END "입사년도"
      , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
-1	    19
1980	    1
1981	10
1982	1
1987	2
2022	    5
*/

--------------------------------------------------------------------------------


--■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE 부서번호가 20, 30
GROUP BY 부서번호;

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)        -- OR
GROUP BY DEPTNO;
--==>>
/*
30	 9400
20	10875
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)        -- OR    
 AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 에러 발생
--      (ORA-00934: group function is not allowed here)

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)        -- OR    
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400
--(↑ 더 바람직한 코드)

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
   AND DEPTNO IN (20, 30);
--==>> 30	9400


--------------------------------------------------------------------------------


--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- 그룹 함수는 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- MSSQL 은 이마저도 불가능하다.
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875



-- RANK() / DENSC_RANK()
--> ORACLE 9i 부터 적용... MSSQL 2005 부터 적용...

--> 하위 버전에서는 RANK() 나 DENSC_RANK() 를 사용할 수 없기 때문에
--  예를 들어... 급여 순위를 구하고자 한다면...
--  해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
--  확인한 숫자에 +1 을 추가 연산해주면...
--  그 값이 곧 해당 사원의 등수가 된다.

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;        -- SMITH 의 급여
--==>> 14               -- SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;        -- SMITH 의 급여
--==>> 14               -- SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800         -- SMITH 의 급여
  AND DEPTNO = 20;      -- SMITH 의 부서번호
--==>> 5                -- SMITH 의 급여 등수

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;       -- ALLEN 의 급여
--==>> 7                -- ALLEN 의 급여 등수


--※ 서브 상관 쿼리(상관 서브 쿼리)
--   메인 쿼리가 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리(상관 서브 쿼리)라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (1) "급여등수"
FROM EMP;

SELECT ENAME "사원명", SAL "급여", (SELECT COUNT(*) + 1
                                    FROM EMP
                                    WHERE SAL > 800) "급여등수"
FROM EMP;


SELECT E.ENAME "사원명", E.SAL "급여", (SELECT COUNT(*) + 1
                                        FROM EMP
                                        WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3;
--==>>
/*
KING	5000	     1
FORD	3000	     2
SCOTT	3000	     2
JONES	2975	 4
BLAKE	2850     5
CLARK	2450	     6
ALLEN	1600	     7
TURNER	1500	     8
MILLER	1300	     9
WARD	1250	    10
MARTIN	1250	    10
ADAMS	1100    	12
JAMES	 950	    13
SMITH	 800	    14
*/

--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고 서브상관쿼리를 활용할 수 있도록 한다.

SELECT ENAME"사원명",SAL"급여",DEPTNO"부서번호","부서내급여등수"
FROM EMP;




SELECT E.ENAME "사원명",E.SAL "급여",E.DEPTNO "부서번호"
 , (SELECT COUNT(*) + 1
    FROM EMP
    WHERE SAL > E.SAL
    AND DEPTNO = E.DEPTNO) "부서내급여등수"
 , (SELECT COUNT(*) + 1
    FROM EMP
    WHERE SAL > E.SAL) "전체급여등수"
FROM EMP E;

/*
SELECT COUNT(*)+1
FROM EMP
WHERE SAL > 800
GROUP BY DEPTNO;

SELECT ENAME"사원명", SAL"급여", E.DEPTNO"부서번호"
     , (SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > 800
        AND DEPTNO = 20) "부서내급여등수"
     , (SELECT COUNT(*) + 1
       FROM EMP
       WHERE SAL > 800) "전체급여등수"
FROM EMP;
*/


--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
                                            -각 부서 내에서 입사일자별로 누적된 급여의 합
---------------------------------------------------------------------------
    사원명     부서번호        입사일         급여      부서내입사별급여누적
---------------------------------------------------------------------------
    SMITH       20          1980-12-17          800             800
    JONES       20          1981-04-02         2975            3775
    FORD        20          1981-12-03         3000            6775
    SCOTT       20          1987-07-13         3000              :
                                 :
                                                WHERE DEPTNO HIREDATE
    
*/

SELECT E.ENAME "사원명",E.DEPTNO"부서번호",E.HIREDATE"입사일",E.SAL "급여"
 , (SELECT SUM(SAL)
    FROM EMP
    WHERE 
    HIREDATE <= E.HIREDATE
    AND DEPTNO = E.DEPTNO) "부서내급여등수"
FROM EMP E
ORDER BY 2,3;





SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
     , (1) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2, 3;


SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2, 3;


SELECT E1.ENAME"사원명", E1.DEPTNO"부서번호", E1.HIREDATE"입사일", E1.SAL"급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM SCOTT.EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	     2450
KING	10	1981-11-17	5000	     7450
MILLER	10	1982-01-23	1300	     8750
SMITH	20	1980-12-17	 800    	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	     6775
SCOTT	20	1987-07-13	3000	    10875
ADAMS	20	1987-07-13	1100	    10875
ALLEN	30	1981-02-20	1600	     1600
WARD	30	1981-02-22	1250	     2850
BLAKE	30	1981-05-01	2850	     5700
TURNER	30	1981-09-08	1500	     7200
MARTIN	30	1981-09-28	1250	     8450
JAMES	30	1981-12-03	 950	     9400
*/



--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의 SUBSTR(HIREDATE,1,7) = SUBSTR(E.HIREDATE) AND MAX(COUNT(*))
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
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');



SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*) "인원수"
FROM EMP
WHERE COUNT(*) = 2
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 에러 발생
--  (ORA-00934: group function is not allowed here)

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (2);


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (입사년월 기준 최대 인원);


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
       , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
                   
                   
--==>>
/*
1981-12	2
1981-09	2
1981-02	2
1987-07	2
*/