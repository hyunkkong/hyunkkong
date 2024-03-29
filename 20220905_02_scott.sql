SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
--※ DML 작업에 대한 이벤트 기록

--○ 실습 테이블 생성(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID        NUMBER
, NAME      VARCHAR2(30)
, TEL       VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

---○ 실습 테이블 생성(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.
DROP TABLE TBL_EVENTLOG;

--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음


--○ 생성한 TRIGGER 작동여부 확인
--   → TBL_TEST1 테이블을 대상으로 INSERT, UPDATE, DELETE 수행
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '민찬우', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다
UPDATE TBL_TEST1
SET NAME = '민달팽이'
WHERE ID = 1;
--==>> 1 행 이(가) 업데이트되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '최나윤', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다
UPDATE TBL_TEST1
SET NAME = '최달팽이'
WHERE ID = 2;
--==>> 1 행 이(가) 업데이트되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '엄달팽이', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '장달팽이', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '조달팽이', '010-5555-5555');
--==>> 1 행 이(가) 삽입되었습니다
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(6, '정달팽이', '010-6666-6666');
--==>> 1 행 이(가) 삽입되었습니다
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(7, '박달팽이', '010-7777-7777');
--==>> 1 행 이(가) 삽입되었습니다
SELECT *
FROM TBL_TEST1;

DELETE
FROM TBL_TEST1;
--==>> 7개 행 이(가) 삭제되었습니다.

-- ○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

--○ 커밋
COMMIT;
--==>> 커밋 완료.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:03
UPDATE 쿼리가 실행되었습니다.	2022-09-05 10:15:05
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:07
UPDATE 쿼리가 실행되었습니다.	2022-09-05 10:15:09
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:11
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:13
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:14
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:16
INSERT 쿼리가 실행되었습니다.	2022-09-05 10:15:18
DELETE 쿼리가 실행되었습니다.	2022-09-05 10:16:02
*/




INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(8, '김보경', '010-8888-8888');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '김달팽이'
WHERE ID = 8;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 8;
--==>> 1 행 이(가) 삭제되었습니다.


--※ 시간대 변경 (→ 오전 7시 40분)
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(9, '고연수', '010-9999-9999');
--==>> ORA-20003, 작업은 08:00 ~ 18:00 까지만 가능합니다.

-- 현재 테스트 불가
-- 현재 상황(노트북)에서의 시간 변경은 서버쪽 시간을 변경이 아닌 클라이언트 시간을 변경하는 것
-- 오라클 서버가 강의실 PC를 원격지로 되어있어 날짜를 바꾼다고 확인이 안된다.
-- 현재 테스트 확인으로 1 행 이(가) 삽입되었습니다.



--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■--
--※ 참조 관계가 설정된 데이터

--○ 실습을 위한 테이블 생성(TBL_TEST2)
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

--○ 실습을 위한 테이블 생성(TBL_TEST3)
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
                REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

--○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '텔레비전');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	텔레비전
2	냉장고
3	세탁기
4	건조기
*/
COMMIT;
--==>> 커밋 완료.


--○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 4, 20);


INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(13, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(14, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(15, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(16, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(17, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(18, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(19, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(20, 4, 20);
--==>> 1 행 이(가) 삽입되었습니다. * 20

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	2	20
3	3	30
4	4	20
5	1	30
6	2	20
7	3	30
8	4	20
9	1	30
10	2	20
11	3	30
12	4	20
13	1	30
14	2	20
15	3	30
16	4	20
17	1	30
18	2	20
19	3	30
20	4	20
*/
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST2;
SELECT *
FROM TBL_TEST3;

--○ TBL_TEST2(부모) 테이블의 데이터 삭제 시도
DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--> 건조기 삭제 시도
--==>> 에러 발생
--      (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found) 


--○ 트리거 생성 이후 TBL_TEST2(부모) 테이블의 데이터 삭제 시도
DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--> 건조기 삭제 시도
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
/*
1	텔레비전
2	냉장고
3	세탁기
*/

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	2	20
3	3	30
5	1	30
6	2	20
7	3	30
9	1	30
10	2	20
11	3	30
13	1	30
14	2	20
15	3	30
17	1	30
18	2	20
19	3	30
*/

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--> 세탁기 삭제 시도
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--> 냉장고 삭제 시도
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
5	1	30
9	1	30
13	1	30
17	1	30
*/

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST2;
--==>> 
/*
1	텔레비전
*/

SELECT *
FROM TBL_상품;
--==>>
/*
C001	구구콘	1500	20
C002	월드콘	1500	0
C003	브라보콘	1300	0
C004	누가콘	1800	0
C005	슈퍼콘	1900	0
H001	스크류바	1000	100
H002	캔디바	300	70
H003	쌍쌍바	500	0
H004	돼지바	600	0
H005	메로나	500	0
E001	찰떡아이스	2500	0
E002	붕어싸만코	2000	0
E003	빵또아	2300	0
E004	거북알	2300	0
E005	쿠키오	2400	0
E006	국화빵	2000	0
E007	투게더	3000	0
E008	엑셀런트	3000	0
E009	셀렉션	3000	0
*/

SELECT *
FROM TBL_입고;
--==>>
/*
1	C001	2022-09-02 11:17:31	30	1200
3	H001	2022-09-02 11:17:42	50	800
4	H002	2022-09-02 11:17:43	50	200
5	H001	2022-09-02 11:18:04	50	800
6	H002	2022-09-02 11:18:05	20	200
*/

INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
VALUES(7,'C003', 70, 2000);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
--==>>
/*
1	C001	2022-09-02 11:17:31	30	1200
7	C003	2022-09-05 11:51:56	70	2000
3	H001	2022-09-02 11:17:42	50	800
4	H002	2022-09-02 11:17:43	50	200
5	H001	2022-09-02 11:18:04	50	800
6	H002	2022-09-02 11:18:05	20	200
*/




--○ 패키지 활용 실습
SELECT INSA_PACK.FN_GENDER('751212-1234567') "함수호출결과"
FROM DUAL;
--==>> 남자

SELECT NAME, SSN, INSA_PACK.FN_GENDER(SSN) "함수호출결과"
FROM TBL_INSA;
--==>>
/*
홍길동	771212-1022432	남자
이순신	801007-1544236	남자
이순애	770922-2312547	여자
김정훈	790304-1788896	남자
한석봉	811112-1566789	남자
이기자	780505-2978541	여자
장인철	780506-1625148	남자
김영년	821011-2362514	여자
나윤균	810810-1552147	남자
김종서	751010-1122233	남자
유관순	801010-2987897	여자
정한국	760909-1333333	남자
조미숙	790102-2777777	여자
황진이	810707-2574812	여자
이현숙	800606-2954687	여자
이상헌	781010-1666678	남자
엄용수	820507-1452365	남자
이성길	801028-1849534	남자
박문수	780710-1985632	남자
유영희	800304-2741258	여자
홍길남	801010-1111111	남자
이영숙	800501-2312456	여자
김인수	731211-1214576	남자
김말자	830225-2633334	여자
우재옥	801103-1654442	남자
김숙남	810907-2015457	여자
김영길	801216-1898752	남자
이남신	810101-1010101	남자
김말숙	800301-2020202	여자
정정해	790210-2101010	여자
지재환	771115-1687988	남자
심심해	810206-2222222	여자
김미나	780505-2999999	여자
이정석	820505-1325468	남자
정영희	831010-2153252	여자
이재영	701126-2852147	여자
최석규	770129-1456987	남자
손인수	791009-2321456	여자
고순정	800504-2000032	여자
박세열	790509-1635214	남자
문길수	721217-1951357	남자
채정희	810709-2000054	여자
양미옥	830504-2471523	여자
지수환	820305-1475286	남자
홍원신	690906-1985214	남자
허경운	760105-1458752	남자
산마루	780505-1234567	남자
이기상	790604-1415141	남자
이미성	830908-2456548	여자
이미인	810403-2828287	여자
권영미	790303-2155554	여자
권옥경	820406-2000456	여자
김싱식	800715-1313131	남자
정상호	810705-1212141	남자
정한나	820506-2425153	여자
전용재	800605-1456987	남자
이미경	780406-2003214	여자
김신제	800709-1321456	남자
임수봉	810809-2121244	여자
김신애	810809-2111111	여자
조현하	970124-2234567	여자
*/