SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 정의한 함수 정상 작동여부 확인
--   함수명 : FN_PAY()

SELECT NUM,NAME,BASICPAY,SUDANG
     , FN_PAY(BASICPAY,SUDANG)
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;


--○ 정의한 함수 정상 작동여부 확인
--   함수명 : FN_WORKYEAR()

SELECT NAME, IBSADATE, FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;
--==>>
/*
홍길동	1998-10-11	23.9
이순신	2000-11-29	21.7
이순애	1999-02-25	23.5
김정훈	2000-10-01	21.9
한석봉	2004-08-13	18
이기자	2002-02-11	20.5
장인철	1998-03-16	24.4
김영년	2002-04-30	20.3
나윤균	2003-10-10	18.9
김종서	1997-08-08	25
유관순	2000-07-07	22.1
정한국	1999-10-16	22.8
조미숙	1998-06-07	24.2
황진이	2002-02-15	20.5
이현숙	1999-07-26	23.1
이상헌	2001-11-29	20.7
엄용수	2000-08-28	22
이성길	2004-08-08	18
박문수	1999-12-10	22.7
유영희	2003-10-10	18.9
홍길남	2001-09-07	20.9
이영숙	2003-02-25	19.5
김인수	1995-02-23	27.5
김말자	1999-08-28	23
우재옥	2000-10-01	21.9
김숙남	2002-08-28	20
김영길	2000-10-18	21.8
이남신	2001-09-07	20.9
김말숙	2000-09-08	21.9
정정해	1999-10-17	22.8
지재환	2001-01-21	21.6
심심해	2000-05-05	22.3
김미나	1998-06-07	24.2
이정석	2005-09-26	16.9
정영희	2002-05-16	20.3
이재영	2003-08-10	19
최석규	1998-10-15	23.8
손인수	1999-11-15	22.8
고순정	2003-12-28	18.6
박세열	2000-09-10	21.9
문길수	2001-12-10	20.7
채정희	2003-10-17	18.8
양미옥	2003-09-24	18.9
지수환	2004-01-21	18.6
홍원신	2003-03-16	19.4
허경운	1999-05-04	23.3
산마루	2001-07-15	21.1
이기상	2001-06-07	21.2
이미성	2000-04-07	22.4
이미인	2003-06-07	19.2
권영미	2000-06-04	22.2
권옥경	2000-10-10	21.9
김싱식	1999-12-12	22.7
정상호	1999-10-16	22.8
정한나	2004-06-07	18.2
전용재	2004-08-13	18
이미경	1998-02-11	24.5
김신제	2003-08-08	19
임수봉	2001-10-10	20.9
김신애	2001-10-10	20.9
*/


--------------------------------------------------------------------------------


-- 프로시저 관련 실습 진행

-- 실습 테이블 생성
CREATE TABLE TBL_STUDENTS
( ID    VARCHAR2(10)
, NAME  VARCHAR2(40)
, TEL   VARCHAR2(30)
, ADDR  VARCHAR2(100)
);
--==>> Table TBL_STUDENTS이(가) 생성되었습니다.

-- 실습 테이블 생성
CREATE TABLE TBL_IDPW
( ID        VARCHAR2(10)
, PW        VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW이(가) 생성되었습니다.


-- 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '최동현', '010-1111-1111', '제주도 서귀포시');
INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java002$');
--==>> 1 행 이(가) 삽입되었습니다. * 2

-- 확인
SELECT *
FROM TBL_STUDENTS;
--==>> superman	최동현	010-1111-1111	제주도 서귀포시

SELECT *
FROM TBL_IDPW;
--==>> superman	java002$

-- 커밋
COMMIT;
--==>> 커밋 완료.


-- 위의 업무를 수행하는 프로시저(INSERT 프로시저, 입력 프로시저)를 생성하게 되면
-- EXECUTE PRC_STUDENTS_INSERT('batman','java002$','김태민','010-2222-2222','서울 마포구');
-- EXEC PRC_STUDENTS_INSERT('batman','java002$','김태민','010-2222-2222','서울 마포구');
-- 이와 같은 구문 한 줄로 양쪽 테이블에 모두 제대로 입력할 수 있다.


--※ 프로시저 생성 구문은
--   20220901_01_scott(plsql).sql 파일 참조~!!!

--○ 프로시저 호출을 통한 확인
EXECUTE PRC_STUDENTS_INSERT('batman','java002$','김태민','010-2222-2222','서울 마포구');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--○ 프로시저 호출 이후 다시 확인
SELECT *
FROM TBL_STUDENTS;
--==>>
/*
superman	최동현	010-1111-1111	제주도 서귀포시
batman	김태민	010-2222-2222	서울 마포구
*/
SELECT *
FROM TBL_IDPW;
--==>>
/*
superman	java002$
batman	java002$
*/


--○ 실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN        NUMBER
, NAME          VARCHAR2(40)
, KOR           NUMBER(3)
, ENG           NUMBER(3)
, MAT           NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK이(가) 생성되었습니다.


--○ 생성된 테이블에 컬럼 추가
--   (총점 → TOT, 평균 → AVG, 등급 → GRADE)
ALTER TABLE TBL_SUNGJUK
ADD (TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR);
--==>> Table TBL_SUNGJUK이(가) 변경되었습니다.

--※ 여기서 추가한 컬럼에 대한 항목은
--   프로시저 실습을 위해 추가한 것일 뿐
--   실제 테이블 구조에 적합하지도, 바람직하지도 않은 내용이다.

--   쿼리문으로 구할 수 있는 값은 컬럼화 시키지 않는다.


-- ○ 변경된 테이블 구조 확인
DESC TBL_SUNGJUK;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)      
*/


--※ 프로시저 생성 구문은
--   20220901_01_scott(plsql).sql 파일 참조~!!!
SELECT *
FROM TBL_SUNGJUK;
--==>> 조회 결과 없음

EXEC PRC_SUNGJUK_INSERT(1,'엄소연',90,80,70);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_SUNGJUK;
--==>> 1	엄소연	90	80	70	240	80	B



EXEC PRC_SUNGJUK_INSERT(2,'정미경',80,70,60);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_SUNGJUK_INSERT(3,'임시연',80,70,60);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_SUNGJUK_INSERT(4,'유동현',54,63,72);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_SUNGJUK_INSERT(5,'장현성',44,33,22);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
--==>>
/*
1	엄소연	90	80	70	240	80	B
2	정미경	80	70	60	210	70	C
3	임시연	80	70	60	210	70	C
4	유동현	54	63	72	189	63	D
5	장현성	44	33	22	99	33	F
*/
EXEC PRC_SUNGJUK_UPDATE(1,50,50,50);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_SUNGJUK_UPDATE(3,82,71,60);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_SUNGJUK_UPDATE(5,100,99,98);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
--==>>
/*
1	엄소연	50	50	50	150	50	F
2	정미경	80	70	60	210	70	C
3	임시연	82	71	60	213	71	C
4	유동현	54	63	72	189	63	D
5	장현성	100	99	98	297	99	A
*/
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
SELECT *
FROM TBL_STUDENTS;





SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 2;
--==>> 조회 결과 없음

SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE DEPTNO = 20
  AND 1 = 1;
  --==>>
  /*
  7369	SMITH	CLERK	20
7566	JONES	MANAGER	20
7788	SCOTT	ANALYST	20
7876	ADAMS	CLERK	20
7902	FORD	ANALYST	20
  */
  



--○ 프로시저 호출을 통한 확인
EXEC PRC_STUDENTS_UPDATE('superman', 'java002', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_STUDENTS_UPDATE('superman', 'java002$', '010-9876-5432', '강원도 횡성');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
ON T1.ID = T2.ID;
--==>>
/*
superman	    java002$	010-9876-5432	강원도 횡성
batman	    java002$	010-2222-2222	서울 마포구
*/


EXEC PRC_STUDENTS_UPDATE('batman', '1234', '010-9999-8888', '서울 종로구');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
/*
superman	    java002$	010-9876-5432	강원도 횡성
batman	    java002$	010-2222-2222	서울 마포구
*/
EXEC PRC_STUDENTS_UPDATE('batman', 'java002$', '010-9999-8888', '서울 종로구');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
/*
superman	    java002$	010-9876-5432	강원도 횡성
batman	    java002$	010-9999-8888	서울 종로구
*/


--○ 프로시저 호출을 통한 확인
EXEC PRC_INSA_INSERT('조현하', '970124-2234567', SYSDATE, '서울', '010-7202-6306', '개발부', '대리', 2000000, 2000000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 프로시저 실행 구문은 무조건 한줄로 실행할 것




--○ 실습 테이블 생성(TBL_상품)
-- 실무에서는 절대 한글 이름으로 짓지말것
CREATE TABLE TBL_상품
( 상품코드              VARCHAR2(20)
, 상품명                VARCHAR2(100)
, 소비자가격            NUMBER
, 재고수량              NUMBER DEFAULT 0
, CONSTRAINT 상품_상품코드_PK PRIMARY KEY(상품코드)
);
--==>> Table TBL_상품이(가) 생성되었습니다.

--○ 실습 테이블 생성(TBL_입고)
CREATE TABLE TBL_입고
( 입고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 입고일자  DATE DEFAULT SYSDATE
, 입고수량  NUMBER
, 입고단가  NUMBER
, CONSTRAINT 입고_입고번호_PK PRIMARY KEY(입고번호)
, CONSTRAINT 입고_상품코드_FK FOREIGN KEY(상품코드)
              REFERENCES TBL_상품(상품코드)
);
--==>> Table TBL_입고(가) 생성되었습니다.

--○ TBL_상품 테이블에 상품 데이터 입력
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C001', '구구콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C002', '월드콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C003', '브라보콘', 1300);  
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C004', '누가콘', 1800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('C005', '슈퍼콘', 1900);
--==>> 1 행 이(가) 삽입되었습니다. * 5
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H001', '스크류바', 1000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H002', '캔디바', 300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H003', '쌍쌍바', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H004', '돼지바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('H005', '메로나', 500);
--==>> 1 행 이(가) 삽입되었습니다. * 5
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E001', '찰떡아이스', 2500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E002', '붕어싸만코', 2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E003', '빵또아', 2300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E004', '거북알', 2300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E005', '쿠키오', 2400);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E006', '국화빵', 2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E007', '투게더', 3000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E008', '엑셀런트', 3000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격) VALUES('E009', '셀렉션', 3000);
--==>> 1 행 이(가) 삽입되었습니다. * 9

--○ 확인
SELECT *
FROM TBL_상품;
--==>>
/*
C001	구구콘	    1500	0
C002	월드콘	    1500	0
C003	브라보콘    	1300	0
C004	누가콘	    1800	0
C005	슈퍼콘	    1900	0
H001	스크류바	    1000	0
H002	캔디바	    300	    0
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
--커밋
COMMIT;
--==>> 커밋 완료.