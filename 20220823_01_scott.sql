SELECT USER
FROM DUAL;
--==>> SCOTT

--※ UNION 은 항상 결과물의 첫 번째 컬럼을 기준으로
--   오름차순 정렬을 수행한다. (정렬기능)
--   반면, UNION ALL 은 결합된 순서(구문에서 테이블을 명시한 순서)대로
--   조회한 결과를 있는 그대로 반환한다. (정렬 없음)
--   이로 인해 UNION 이 부하가 더 크다. (리소스 소모가 더 크다.)
--   또한, UNION 은 결과물에 중복된 레코드(행)가 존재할 경우
--   중복을 제거하고 1개 행만 조회된 결과를 반환하게 된다.


--○ 지금까지 주문받은 데이터를 통해
--   제품 별 총 주문량을 조회할 수 있는 쿼리문을 구성한다.

SELECT T.제품명, SUM(T.주문량)"총 주문량"
FROM
(
    SELECT JECODE"제품명", JUSU"주문량"
    FROM TBL_JUMUN
    UNION ALL
    SELECT JECODE"제품명", JUSU"주문량"
    FROM TBL_JUMUNBACKUP
) T
GROUP BY T.제품명
ORDER BY 1;





------------■■■ 선생님
SELECT T.JECODE "제품코드", SUM(T.JUSU)"주문수량"
FROM
(
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT JECODE, JUSU
FROM TBL_JUMUN
) T
GROUP BY T.JECODE;
--==>>
/*
꼬북칩	30
꼬깔콘	20
치토스	20
맛동산	70
새우깡	10
웨하스	20
에이스	40
포카칩	20
스윙칩	20
오감자	30
사또밥	20
빼빼로	110
오레오	30
감자깡	40
홈런볼	40
다이제	10
죠리퐁	10
포스틱	40
*/


--○ INTERSECT / MINUS (교집합과 차집합)

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
-- 제품코드와 주문수량의 값이 똑같은 행만 추출하고자 한다.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
감자깡	20
맛동산	30
홈런볼	10
*/


SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
꼬깔콘	20
꼬북칩	20
다이제	10
빼빼로	10
사또밥	20
새우깡	10
스윙칩	20
오감자	20
오레오	10
죠리퐁	10
치토스	20
포스틱	10
포스틱	20
포카칩	20
*/


--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문량, 주문일자




--JOIN
    
SELECT T.JUNO"주문번호",T.JECODE"제품코드", T.JUSU"주문량", T.JUDAY"주문일자"
FROM
    (
        SELECT JUNO, JUSU, JECODE, JUDAY
        FROM TBL_JUMUNBACKUP
        UNION ALL
        SELECT JUNO, JUSU, JECODE, JUDAY
        FROM TBL_JUMUN
    ) T
    JOIN
    (
        SELECT JUSU, JECODE
        FROM TBL_JUMUNBACKUP
        INTERSECT
        SELECT JUSU, JECODE
        FROM TBL_JUMUN
    ) S
ON T.JECODE = S.JECODE
AND T.JUSU = S.JUSU
ORDER BY 1;



SELECT T.JUNO"주문번호",T.JECODE"제품코드", T.JUSU"주문량", T.JUDAY"주문일자"
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
) T
WHERE T.JECODE ||;




--------------------------------------------------------------------------------
SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	    치토스	20	2001-11-01
2	    빼빼로	10	2001-11-01
3	    맛동산	30	2001-11-01
4	    오레오	10	2001-11-02
5	    포카칩	20	2001-11-02
6	    죠리퐁	10	2001-11-03
7	    감자깡	20	2001-11-03
8	    사또밥	20	2001-11-04
9	    새우깡	10	2001-11-05
10	    스윙칩	20	2001-11-05
11	    홈런볼	10	2001-11-05
12	    홈런볼	10	2001-11-05
13	    꼬북칩	20	2001-11-06
14	    다이제	10	2001-11-07
15	    꼬깔콘	20	2001-11-08
16	    포스틱	10	2001-11-09
17	    오감자	20	2001-11-10
18	    홈런볼	10	2001-11-11
19	    포스틱	10	2001-11-12
20	    포스틱	20	2001-11-13
98764	꼬북칩	10	2022-08-22
98765	빼빼로	30	2022-08-22
98766	빼빼로	20	2022-08-22
98767	에이스	40	2022-08-22
98768	홈런볼	10	2022-08-22
98769	감자깡	20	2022-08-22
98770	맛동산	10	2022-08-22
98771	웨하스	20	2022-08-22
98772	맛동산	30	2022-08-22
98773	오레오	20	2022-08-22
98774	빼빼로	50	2022-08-22
98775	오감자	10	2022-08-22
*/

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
감자깡	20
맛동산	30
홈런볼	10
*/


SELECT *
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT *
FROM TBL_JUMUN;
--==>> 조회 결과 없음

-- 방법 1.



SELECT T2.JUNO "주문번호", T1.JECODE "제품코드"
     , T1.JUSU "주문수량", T2.JUDAY "주문일자"
FROM
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN    
) T1
JOIN
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU;

--==>>
/*
    3	맛동산	30	2001-11-01
    7	감자깡	20	2001-11-03
   11	홈런볼	10	2001-11-05
   12	홈런볼	10	2001-11-05
   18	홈런볼	10	2001-11-11
98768	홈런볼	10	2022-08-22
98769	감자깡	20	2022-08-22
98772	맛동산	30	2022-08-22
*/

-- 방법 2.
SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN ('감자깡','맛동산','홈런볼')
  AND T.JUSU IN (20, 30, 10);
--==>>
/*
    3	30	맛동산	2001-11-01
    7	20	감자깡	2001-11-03
   11	10	홈런볼	2001-11-05
   12	10	홈런볼	2001-11-05
   18	10	홈런볼	2001-11-11
98768	10	홈런볼	2022-08-22
98769	20	감자깡	2022-08-22
98770	10	맛동산	2022-08-22
98772	30	맛동산	2022-08-22
*/


SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE와 T.JUSU의 결합 결과가 '감자깡20', '맛동산30', '홈런볼10';


SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ('감자깡20', '맛동산30', '홈런볼10');
--==>>
/*
    3	30	맛동산	2001-11-01
    7	20	감자깡	2001-11-03
   11	10	홈런볼	2001-11-05
   12	10	홈런볼	2001-11-05
   18	10	홈런볼	2001-11-11
98768	10	홈런볼	2022-08-22
98769	20	감자깡	2022-08-22
98772	30	맛동산	2022-08-22
*/

SELECT T.*
FROM
(
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JUSU, JECODE, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE, T.JUSU) IN ( SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUNBACKUP
                                    INTERSECT
                                    SELECT CONCAT(JECODE, JUSU)
                                    FROM TBL_JUMUN);
--==>>
/*
    3	30	맛동산	2001-11-01
    7	20	감자깡	2001-11-03
   11	10	홈런볼	2001-11-05
   12	10	홈런볼	2001-11-05
   18	10	홈런볼	2001-11-11
98768	10	홈런볼	2022-08-22
98769	20	감자깡	2022-08-22
98772	30	맛동산	2022-08-22
*/


--------------------------------------------------------------------------------
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
--==>> 에러 발생


SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/
--데이터가 많지 않거나, 데이터 공개구문 정도로 


SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D
USING(DEPTNO);
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600    
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/


--------------------------------------------------------------------------------



--○ TBL_EMP 테이블에서 급여가 가장 많은 사원의 
--   사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 구성한다.

SELECT *
FROM TBL_EMP
ORDER BY SAL DESC;

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여"
FROM TBL_EMP
WHERE 급여가 가장 많은 사원의 ;

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여"
FROM TBL_EMP
WHERE SAL > = ( SELECT MAX(SAL)
                FROM TBL_EMP);
 
                   
                   
                   
-- 급여를 가장 많이 받는 사원의 급여
SELECT MAX(SAL)
FROM TBL_EMP;
--==>> 5000

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여"
FROM TBL_EMP
WHERE 급여가 가장 많은 사원;
                
SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여"
FROM TBL_EMP
WHERE SAL = ( 급여가 가장 많은 사원); 


SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여"
FROM TBL_EMP
WHERE SAL = ( SELECT MAX(SAL)
                FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000

-- 『=ANY』

-- 『=ALL』
-- ~이기도 하면서, ~이기도 하면서 ... (모든 조건에 충족해야함)

SELECT SAL
FROM TBL_EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
1500
2000
1700
2500
1000
*/
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL =ANY (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7788	SCOTT	ANALYST	    3000
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7902    	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300
8001    	김태민	CLERK	    1500
8002	    조현하	CLERK	    2000
8003	    김보경	SALESMAN	1700
8004	    유동현	SALESMAN	2500
8005	    장현성	SALESMAN	1000
*/
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ANY (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>>
/*
7369	SMITH	CLERK	     800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7788	SCOTT	ANALYST	    3000
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7876	ADAMS	CLERK	    1100
7900	    JAMES	CLERK	     950
7902    	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300
8001    	김태민	CLERK	    1500
8002	    조현하	CLERK	    2000
8003	    김보경	SALESMAN	1700
8004	    유동현	SALESMAN	2500
8005	    장현성	SALESMAN	1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ALL (800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 1100, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 7839	KING	PRESIDENT	5000

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >=ALL (SELECT SAL
                 FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000

--○ TBL_EMP 테이블에서 20번 부서에 근무하는 사원들 중
--   급여가 가장 많은 사원의
--   사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 구성한다.

SELECT *
FROM TBL_EMP;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE 20번 부서에 근무하는 사원들 중 급여가 가장 많은 사원;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20
  AND SAL >= ALL (SELECT SAL
                 FROM TBL_EMP);
--==>> 조회 결과 없음
                 

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM TBL_EMP
             WHERE DEPTNO = 20)
  AND DEPTNO = 20;
--==>>
/*
7788	SCOTT	ANALYST	3000
7902	FORD	ANALYST	3000
*/
 
 SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL (SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20)
  AND DEPTNO = 20;  
--==>>
/*
7902	    FORD	ANALYST	3000
7788	SCOTT	ANALYST	3000
*/

--○ TBL_EMP 테이블에서 수당(커미션, COMM)이 가장 많은 사원의
--   사원번호, 사원명, 부서번호, 직종명, 커미션 항목을 조회한다.
SELECT 사원번호, 사원명, 부서번호, 직종명, 커미션
FROM TBL_EMP
WHERE COMM이 가장 많은 사원;

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM이 가장 많은 사원;


SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM = (모든 직원들 중 최고 커미션);

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
              FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT COMM
                    FROM TBL_EMP);
--==>> 조회 결과 없음

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( NULL, 300, 500, NULL, 1400, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 10, 10, NULL, NULL, NULL);
--==>> 조회 결과 없음

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT NVL(COMM,0)
                      FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,COMM
FROM TBL_EMP
WHERE COMM >= ALL ( SELECT COMM
                    FROM TBL_EMP
                    WHERE COMM IS NOT NULL);
--==>> 7654	MARTIN	30	SALESMAN	1400


-- 내 풀이
--------------------------------------------------------------------------------
SELECT EMPNO,ENAME,DEPTNO,JOB,NVL(COMM,0)
FROM TBL_EMP
WHERE NVL(COMM,0) >= ALL (SELECT NVL(COMM,0)
                          FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO,ENAME,DEPTNO,JOB,NVL(COMM,0)
FROM TBL_EMP
WHERE NVL(COMM,0) = (SELECT MAX(NVL(COMM,0))
                       FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT MAX(NVL(COMM,0))
FROM TBL_EMP;

SELECT ENAME,NVL(COMM,0)
FROM TBL_EMP;
--------------------------------------------------------------------------------


--○ DISTINCT() 중복 행(레코드)을 제거하는 함수

-- TBL_EMP 테이블에서 관리자로 등록된 사원의
-- 사원번호, 사원명, 직종명을 조회한다.

SELECT *
FROM TBL_EMP;

SELECT 사원번호, 사원명, 직종명
FROM TBL_EMP
WHERE 관리자로 등록된 사원;

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE 사원번호 = (관리자(MGR)로 등록된 사원);

SELECT EMPNO, ENAME, JOB, MGR
FROM TBL_EMP
WHERE 사원번호 = (7902,7698,7698,7839,7698,7839,7839,7566,NULL,7698,7788,7698,7566,7782,7566,7566,7698,7698,7698);

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);
                
SELECT DISTINCT(MGR)
FROM TBL_EMP;
--==>>
/*
7839

7782
7698
7902
7566
7788
*/

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN( SELECT DISTINCT(MGR)
                FROM TBL_EMP );
--==>>
/*
7902    	FORD	ANALYST
7698	BLAKE	MANAGER
7839	KING	PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782	CLARK	MANAGER
*/

SELECT JOB
FROM TBL_EMP;

SELECT DISTINCT(JOB)
FROM TBL_EMP;
--==>>
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/

SELECT DEPTNO
FROM TBL_EMP;

SELECT DISTINCT(DEPTNO)
FROM TBL_EMP;
--==>>
/*
30

20
10
*/



--------------------------------------------------------------------------------

SELECT *
FROM TBL_SAWON;



--○ TBL_SAWON 테이블 백업(데이터 위주) → 각 테이블 간의 관계나 제약조건 등은 제외한 상태
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP이(가) 생성되었습니다.
-- TBL_SAWON 테이블의 데이터들만 백업을 수행
-- 즉, 다른 이름의 테이블 형태로 저장해 둔 상황


--○ 데이터 수정
UPDATE TBL_SAWON
SET SANAME = '똘똘이'
WHERE SANO = 1005;

UPDATE TBL_SAWON
SET SANAME = '똘똘이';
COMMIT;     -- 아직 안누름

SELECT *
FROM TBL_SAWNO;

ROLLBACK;

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME = '똘똘이';
--==>> 16개 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> 커밋 완료.