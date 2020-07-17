-- 여기는 user1 화면입니다. 

SELECT * FROM tbl_dept;

-- projection, selection
-- DB 공학에서 논리적인 차원 DB 관련용에서 실무에서는 별로 사용하지 않는 단어이기도 함
  
-- projection한다
SELECT d_code, d_name, d_prof
FROM tbl_dept;

-- 레코드를 제한하는 selection
SELECT * 
FROM tbl_dept
WHERE d_name ='관광학';

-- 현재 학과테이블의 학과명 중에 관광학 학과를 관광정보학으로 변경하고자 할 때 
-- 1. 내가 변경하고자 하는 조건에 맞는 데이터가 있는지 확인하는 과정 필요
SELECT * FROM tbl_dept WHERE d_name ='관광학';

-- 2. selection한 결과가 1개의 레코드만 나타나고 있지만 d_name은 PK가 아님
--    여기에서 보여주는 데이터는 리스트이다. 
--    update할 때 d_name ='관광학' 조건으로 update를 실행하면 안된다는 얘기임
--    UPDATE tbl_dept SET d_name = '관광정보학' WHERE d_name ='관광학'; 처럼 명령 수행하면 안된다!!!!!

-- 3. 조회된 결과에서 PK값이 무엇인지를 파악해야 한다. 
-- 4. PK를 조건으로 데이터를 update 수행해야 한다. 

UPDATE tbl_dept
SET d_name = '관광정보학'
WHERE d_code ='D001';

SELECT * FROM tbl_dept;


INSERT INTO tbl_dept(d_code, d_name, d_prof)
VALUES ('D006','무역학','장길산');
COMMIT;
-- DELETE 
-- DBMS의 스키마에 포함된 Table 중에 여러 업무를 수행하는 데 필요한 Table을 보통
-- Master data table이라고 한다. 학생정보, 학과정보 등..마스터 테이블이라고 함
-- Master data는 초기에 insert가 수행된 후에 업무가 진행되는 동안 가급적 데이터를 변경하거나
-- 삭제하는 일이 최소화 되어야 하는 데이터이다. 
-- Master data와 relation 하여 생성되는 여러 데이터들의 무결성을 위해서 
-- 마스터 데이터는 변경을 최소화 하면서 유지 해야 한다. 

-- DBMS의 스키마에 포함된 테이블 중에 수시로 데이터가 추가, 변경, 삭제 필요한 데이블을
-- 보통 work data table이라고 한다. 예를 들면 성적정보 테이블
-- work data는 수시로 데이터가 추가되고 여러가지 연산을 수행하여 통계, 집계 등 보고서를 작성하는 기본 데이터가 된다.
-- 보고서 작성 후 데이터를 검증하였을 때 이상이 있으면 데이터를 수정, 삭제 수행하여 정정과정이 이루어짐
-- 워크 데이터는 마스텅테이블과 relation을 잘 연동하여 데이터를 insert하는 단계부터 
-- 잘못된 데이터가 추가되는 것을 막아줄 필요가 있다.
-- 이때 설정하는 조건중에 외래키 연관 조건이 있다.



SELECT * FROM tbl_score;

UPDATE tbl_score --변경할 테이블
SET sc_kor =90 -- 변경할 대상=값
WHERE sc_num ='20015'; -- 조건(update에서 where는 선택사항이나, 실무에서는 필수사항으로 인식)

UPDATE tbl_score
SET sc_kor =90, sc_math =90 -- 다수의 칼럼 값을 변경하고자 할 때 칼럼 =값, 칼럼= 값 형식으로 작성한다.
WHERE sc_num ='20015';

SELECT * FROM tbl_score;
SELECT * FROM tbl_score WHERE sc_num = '20015';

UPDATE tbl_score
SET sc_kor =100;

SELECT * FROM tbl_score;

-- SQL문으로 CUD(insert, update, delete)를 수행하고 난 직후에는 테이블의 변경된 데이터가
-- 물리적(스토리지)으로 반영이 되지 않은 상태이다. 
-- 스토리지에 데이터 변경반영이 되기 전에 롤백 명령을 수행하면 변경내용이 모두 취소된다. 
-- rollback 명령을 잘못 수행하면 정상적으로 변경(CUD)이 필요한 데이터 마저 변경이 취소되어
-- 문제를 일으킬 수 있다.

-- insert를 수행하고 난 직후에는 데이터의 변경이 물리적으로 반영될 수 있도록 
-- commit명령을 수행해 주는 것이 좋다. 
-- update나 delete는 수행한 직후 반드시 select를 수행하여 원하는 결과가 잘 수행되었는지 
-- 확인하는 것이 좋다. 

ROLLBACK;
SELECT * FROM tbl_score;

-- 20020 학번의 학생이 시험날 결석하여 시험응시를 하지 못했는데도 성적이 입력되었다.
-- 이 학생의 성적데이터는 삭제되어야 한다. 
-- 20020 학생이 정말 시험날 결석한 학생인지 확인하는 절차가 필요하다 
-- 20020 학생의 학생정보를 확인하고 만약 이 학생의 성적정보가 등록되어 있다면 삭제수행하자

SELECT * FROM tbl_student WHERE st_num ='20020';

-- 아래 Query문을 실행했을 때 학생정보는 보이나, 성적정보 칼럼 값들이 "모두" NULL로 나타나면
-- 이 학생의 성적정보는 등록되지 않을 것
-- 따라서 삭제하는 과정이 필요하지 않다. 
-- 학생정보와 함께 성적정보 칼럼의 값들이 1개라도 null이 아닌 것으로 나타나면 
-- 이 학생의 성적정보는 등록된 것이다. 
-- 따라서 학생의 성적정보를 삭제해야 한다. 
 
SELECT * FROM tbl_student ST 
    LEFT JOIN tbl_score SC
        ON ST.st_num = SC.sc_num 
WHERE ST.st_num = '20020';

-- sc_num 데이터에 없는 조건을 부여하면 delete를 수행하지 않을 뿐 오류가 나거나 하지는 않다
DELETE FROM tbl_score
WHERE sc_num='20020';
ROLLBACK;


-- 성적데이터의 국어점수가 가장 높은 값과 가장 낮은 값은 무엇인가??
SELECT MAX(sc_kor), MIN(sc_eng)
FROM tbl_score;


-- 최고점수는 100점, 최저점수는 50점이다
-- 이 점수를 받은 학생은 누구인가?
SELECT MAX(sc_kor), MIN(sc_kor)
FROM tbl_score;

SELECT MAX(sc_kor), MIN(sc_kor)
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON SC.sc_num = ST.st_name;

INSERT INTO tbl_score(sc_num, sc_kor) VALUES('20101',49);

SELECT SC.sc_num, ST.st_name, SC.sc_kor --원하는 칼럼만 보여줌
FROM tbl_score SC --성적정보에서
    LEFT JOIN tbl_student ST --학생정보 조인
ON SC.sc_num = ST.st_num 
WHERE sc_kor =100 OR sc_kor =50;


-----------------------------------------------
-- WHERE 절에서 subquery 사용하기 
-----------------------------------------------
-- 두번 이상 select 수행해서 결과를 만들어야 하는 경우 한번의 select 결과를
-- 두번 째 select에 주입하여 동시에 두번 이상의 select를 수행하는 방법
-- sub query는 join으로 모두 구현이 가능하다.
-- 하지만 간단한 동작을 요구할 때는 subquery를 사용하는 것이 쉬운방법이기도 하다.
-- 또한 오라클 관련 정보들(구글링) 중에 join보다는 sub query를 사용한 예제들이 많아서 
-- 코딩에 다소 유리한 면도 있다. 

-- sub query를 사용하게 되면 select문이 여러번 실행되기 때문에 
-- 약간만 코딩이 변경되어도 상당히 느린 실행결과를 낳게 된다. 


-- where절에서 서브쿼리 사용
-- WHERE 처음에 칼럼명이 오고 오른쪽에 괄호 포함한 select쿼리가 나와야 한다.
-- sub query로 작동되는 select문은 기본적으로 1개의 결과만 나와야 한다. 
-- sub-query에 의해 연산된 결과의 값을 기준으로 칼럼에 조건문을 부여하는 방식!

-- sub-query는 method, 함수를 호출하는 것과 같이 sub query가 return해주는 값을 
-- 칼럼과 비교하여 최종 결과물을 낸다.
SELECT SC.sc_num, ST.st_name, SC.sc_kor --원하는 칼럼만 보여줌
FROM tbl_score SC --성적정보에서
    LEFT JOIN tbl_student ST --학생정보 조인
        ON SC.sc_num = ST.st_num 
WHERE sc_kor =
(
    SELECT MAX(sc_kor) FROM tbl_score --괄호로 묶어!
)
OR SC.sc_kor =
(
    SELECT MIN(sc_kor) FROM tbl_score
);

-- 국어점수의 평균을 구하고 평균점수보다 높은 점수를 얻은 학생들의 리스트를 구하고 싶다. 

--평균 먼저 구하기, test 먼저!
SELECT AVG(sc_kor) FROM tbl_score;

SELECT *
FROM tbl_score
WHERE sc_kor >= 73.47;

-- 두쿼리를 하나로 묶기
SELECT *
FROM tbl_score
WHERE sc_kor >=
(
    SELECT AVG(sc_kor) FROM tbl_score
);

-- 각 학생의 점수 평균을 구하고 
-- 전체학생의 평균을 구하여 
-- 각 학생의 평균 점수가 전체학생 평균보다 높은 리스트를 조회해라
DELETE FROM tbl_score WHERE sc_num ='20101';


-- 각학생의 점수 평균 먼저 구하기
SELECT sc_num, AVG(sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 AS 평균 FROM tbl_score
GROUP BY sc_num;

-- 전체 학생의 평균 74.452
SELECT AVG((sc_kor+sc_eng+sc_math+sc_music+sc_art)/5) AS 전체평균 FROM tbl_score;

-- select query문이 실행되는 순서
-- 1. FROM 절이 실행되어 tbl_score 테이블의 정보(칼럼정보)를 가져오기
-- 2. WHERE 절이 실행되어서 실제로 가져올 데이터를 선별하기 
-- 2-2. group by 절이 있으면 실행되어 중복된 데이터를 묶어서 하나로 만드는 과정 필요
-- 3. SELECT 에 나열된 칼럼에 값을 채워넣고 
-- 4. SELECT 에 정의된 수식을 연산, 결과를 보일 준비
-- 5. ORDER BY는 모든 쿼리가 실행되고 가장 마지막에 연산이 수행되어 정렬을 하게된다.

-- WHERE 절과 group by 절에서는 alias로 설정된 칼럼 이름을 사용할 수 없다. 
-- order by에서는 alias로 설정된 칼럼 이름 사용할 수 있다.
SELECT sc_num, (sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 AS 평균
FROM tbl_score
WHERE  (sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 >=
(
    SELECT AVG(sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 FROM tbl_score
);

-- 위의 Query를 활용 하여 평균을 구하는 조건은 유지하고
-- 학번이 20020 이전의 학생들만 추출하라

SELECT sc_num, (sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 AS 평균
FROM tbl_score
WHERE  (sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 >=
(
    SELECT AVG(sc_kor+sc_eng+sc_math+sc_music+sc_art)/5 
    FROM tbl_score
)AND sc_num < '20020';
 


-- 성적테이블에서 학번의 문자열을 자르기 수행하여
-- 반 명칭만 추출한 것
SELECT SUBSTR(sc_num,1,4) AS 반
FROM tbl_score
GROUP BY SUBSTR(sc_num,1,4)
ORDER BY 반;


-- 추출된 반 명칭이 '2006' 보다 작은 값을 갖는 반만 추출
-- HAVING : 성질이 WHERE 와 매우 비슷하다. 하는 일이 group by로 묶이거나 통계함수로
--          생성된 값을 대상으로 WHERE연산을 수행하는 키워드 이다. 
SELECT SUBSTR(sc_num,1,4) AS 반
FROM tbl_score
GROUP BY SUBSTR(sc_num,1,4) --그룹으로 묶어서
HAVING SUBSTR(sc_num,1,4) > '2006'
ORDER BY 반;

-- 각 반의 평균 구하는 코드
SELECT SUBSTR(sc_num,1,4) AS 반, ROUND(AVG((sc_kor+sc_eng+sc_math)/3)) AS 반평균
FROM tbl_score
GROUP BY SUBSTR(sc_num,1,4) --그룹으로 묶어서
HAVING ROUND(AVG((sc_kor+sc_eng+sc_math)/3)) >=
(
    SELECT ROUND(AVG((sc_kor+sc_eng+sc_math)/3)) FROM tbl_score
)
ORDER BY 반;


-- 2000~2005까지는 A그룹, 2006~2010까지 B그룹일 때- 
-- 반 명이 '2005' 이하, A 그룹의 반들 평균 구하기
SELECT SUBSTR(sc_num,1,4) AS 반, ROUND(AVG((sc_kor+sc_eng+sc_math)/3)) AS 반평균
FROM tbl_score
GROUP BY SUBSTR(sc_num,1,4) --그룹으로 묶어서
HAVING SUBSTR(sc_num,1,4) <= '2005' --having만 집어 넣어줌
ORDER BY 반;


-- Having과 Where
-- 두가지 모두 결과를 selection 하는 조건문을 설정하는 방식이다. 
-- having은 그룹으로 묶이거나 통계함수로 연산된 결과를 조건으로 설정하는 방식이고 
-- Where는 아무런 연산이 수행되기 전에 원본 데이터를 조건으로 제한하는 방식이다. 
-- 어쩔 수 없이 통계결과를 제한할 때는 Having을 써야 한다. 
-- Where절에 조건을 설정하여 데이터를 제한한 후 연산을 수행할 수 있다면 항상 그 방법을 우선조건으로 설정하자
-- Having은 Where조건이 없으면 전체 데이터를 상대로 상당한 연산을 수행한 후 조건을 설정하므로
-- 상대적으로 Where조건을 설정하는 것 보다 느리다. 

SELECT SUBSTR(sc_num,1,4) AS 반, ROUND(AVG((sc_kor+sc_eng+sc_math)/3)) AS 반평균 --내가 원하는 정보 출력할 것 만들고
FROM tbl_score -- 어디 데이터에서???
WHERE SUBSTR(sc_num,1,4) <= '2005' --where절이 먼저 실행됨
GROUP BY SUBSTR(sc_num,1,4) --where절에서 실행된 것만 그룹으로 묶음
ORDER BY 반; -- 모든연산이 끝나고 정렬해라 제일늦게 실행됨






















