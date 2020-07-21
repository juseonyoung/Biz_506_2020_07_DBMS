-- 여기는 grade화면입니다


--------------------------------------------------------
-- 집계, 통계함수
-- SQL에서는 기본적인 명령어, 연산자 등과 함께 많이 사용되는 집계함수가 있다.
-- SUM():합계, COUNT():개수, AVG():평균, MAX():최대값, MIN():최소값
-- 일반적으로 숫자형으로 되어있는 칼럼에 저장된 값을 추출하여 집계, 통계를 수행하는 함수
-- SELECT 칼럼을 감싸는 형태로 사용한다. 

-- tbl_student에 저장된 전체 레코드가 몇개인가?
SELECT COUNT(*) FROM tbl_student; --100
SELECT COUNT(st_num) FROM tbl_student; --100
SELECT COUNT(st_name) FROM tbl_student; --100

-- tbl_student의 칼럼중에 st_grade와 st_age는 숫자형 칼럼인데,
-- 이 칼럼에 저장된 값의 합계를 한번 구해보자!
SELECT st_grade FROM tbl_student;
SELECT SUM(st_grade) FROM tbl_student;
SELECT SUM(st_grade),SUM(st_age) FROM tbl_student;

-- tbl_student의 칼럼중에 st_grade 칼럼에 저장된 값들의 평균을 구하고 싶다
SELECT AVG(st_grade), AVG(st_age) FROM tbl_student;


-- tbl_student의 st_grade 칼럼에 저장된 값 중에서 최대값과 최소값을 보여달라
SELECT MAX(st_grade), MIN(st_grade) FROM tbl_student;

----------------------------------------------------
-- 데이터를 조건별로 묶어서 보고싶은 경우
----------------------------------------------------
-- tbl_student 데이터 중에서 어떠한 학과가 있는지 알고싶은 경우??
-- 학과이름이 같은 경우들이 다수 존재하는데 이들 이름을 한개씩만 추출하여 
-- 리스트로 보여준다면 어떠한 학과가 있는지 알기 쉽다.
-- st_dept 칼럼에 저장된 값들을 같은 값끼리 그룹지어라
-- 그 그룹들의 이름을 한개씩만 나열해달라
SELECT st_dept FROM tbl_student
GROUP BY st_dept;

SELECT st_grade FROM tbl_student
GROUP BY st_grade; 

-- st_name 칼럼에 저장된 값들이 중복된 값이 없어서 Group by가 의미없는 경우도 있다.
SELECT st_name FROM tbl_student
GROUP BY st_name; 


-- 데이터를 학과이름으로 그룹짓고 각 학과에 소속된 학생들이 몇명씩인가를 알고싶은경우
-- st_dept 칼럼으로 그룹 만들고, 그 그룹에 속하는 레코드가 몇개인가를 count하여 보여줌
SELECT st_dept, COUNT(*) FROM tbl_student
GROUP BY st_dept;

-- 학년별로 소속된 학생이 몇명인가 알고싶은 경우
-- st_grade칼럼으로 그룹 만들고, 그 그룹에 속하는 레코드가 몇개인가를 count하여 보여줌
SELECT st_grade, COUNT(*) FROM tbl_student
GROUP BY st_grade;

-- count() *쓰는 대신 특정 칼럼을 사용하여도 된다
SELECT st_grade, COUNT(st_num), COUNT(st_name)FROM tbl_student
GROUP BY st_grade;

-- count(칼럼명) 문법에서 칼럼명은 중요하지 않다
SELECT st_grade, COUNT(st_grade) FROM tbl_student
GROUP BY st_grade;

-- 각 학과별로 소속된 학생들의 총 나이를 합산한 것
SELECT st_dept, SUM(st_age) FROM tbl_student
GROUP BY st_dept;

-- 각 학과별로 소속된 학생들의 평균나이
SELECT st_dept, AVG(st_age) FROM tbl_student
GROUP BY st_dept;

-- 학과별로 가장 나이가 많은 학생과 나이가 적은 학생 보여달라
-- 단, 나이가 많은 학생이름, 적은학생이름을 찾는것은 이 SQL로는 어렵다!!
SELECT st_dept, MAX(st_age),MIN(st_age) FROM tbl_student
GROUP BY st_dept;

-- SQL 명령문 : Query 문이라고 한다.(질의어)














