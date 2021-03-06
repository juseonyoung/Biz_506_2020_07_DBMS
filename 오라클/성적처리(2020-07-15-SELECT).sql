-- 여기는 grade 사용자 화면입니다. 
-- excel 파일에서 학생 데이터를 import한 후 select실습하기 

-- 모든 데이터를 다 보여달라
SELECT * FROM tbl_student;

-- SELECTION
-- 데이터중에서 조건을 부여하여 조건에 맞는 리스트만 보이기..
-- Recored의 제한 이라고 한다..(전체 데이터 개수> 조건에 맞는 데이터 개수)
-- WHERE 절에 조건을 설정하여 데이터를 조회한다.
-- PK, unique로 설정된 칼럼을 단일조건!으로 selection하는 경우 
-- 이 데이터는 1개의 객체로 취급한다(VO에 담는다)
SELECT * FROM tbl_student
WHERE st_num = '20001';

-- st_num에 저장된 값이 '20001'이상이고 (AND) '20010' 이하인 학번에 맞는 데이터리스트(레코드)만 보여달라
-- PK, unique로 설정된 칼럼을 복합(다중)조건절로 selection할 때는 레코드가 1개만 나타날 지라도
-- 이 데이터는 리스트로 취급한다.
SELECT * FROM tbl_student
WHERE st_num >= '20001' AND st_num <='20010';

-- st_name에 저장된 값이 독고예준인 리스트만 보여라
-- "PK, unique로 설정된 칼럼이 아닌 경우" selection 수행했을 때 나타나는 레코드가 1개일지라도
-- 이 데이터는 리스트로 취급한다.
-- "PK, unique로 설정된 칼럼은 반드시!! 리스트 아닌 VO로 취급" 조건에 맞는 값은 하나만 나온다(단일조건인 경우만)
SELECT * FROM tbl_student
WHERE st_name='독고예준';

--PROJECTION
-- selection된 레코드의 개수와 무관하게 특정칼럼만 리스트에 포함하는 조회
-- 레코드 개수와 관계없이 보이는 칼럼을 제한하는 조회이다.
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student;


-- selection & projection
-- WHERE 조건절을 사용하여 레코드를 제한하고 , 칼럼명을 나열하여 필요한 항목(필드)만 보고자 할 때 
-- 칼럼리스트를 제한하기!!
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_name ='남동예';


--비교연산자( < , > ,=)와 관계연산자(AND, OR)사용하여 selection 구현
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num >='20001' AND st_num <='20010';
-- '20001' <= st_num >='20010' sql에서는 이게 안됨

-- between 연산자 사용하여 범위제한하여 selection 구현
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num BETWEEN '20001' AND '20010';


-- 비교연산자(=)와 관계연산자 OR를 조합하여 selection구현하기 
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num = '20001' OR st_num='20003' OR st_num= '20006';

-- 한개의 칼럼에 다수의 OR 조건을 부여하여 
-- selection 수행할 때는 IN이라는 연산자를 사용하여 구현할 수 있다.
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num IN( '20001','20003' ,'20006');


-- 문자열(VARCHAR, nVARCHAR2) 칼럼일 경우
-- 문자열 전체가 아닌 부분만 일치하는 조건을 부여하여 셀렉션 구현하기 
-- LIKE 연산자 사용하여 부분문자열 검색하기
-- %기호 사용 : 문자열의 포함여부를 제한하는 기능을 한다.
--              '%찾기' : '찾기' 문자열로 끝나는 모든 데이터 레코드
--              '찾기%" : '찾기' 문자열로 시작하는 모든 데이터 레코드
--              '%찾기%" : '찾기' 문자열이 '포함되는' 모든 데이터 레코드
-- LIKE 연산자를 사용하여 조회(검색) 수행하면 DB에 설정된 모든 index를 무시하고
-- 무조건 처음부터 다 뒤지는 연산을 수행한다! 이러한 연산을 Full Text Search라고 한다
SELECT st_num, st_name, st_dept, st_grade
FROM tbl_student
WHERE st_num LIKE '%7'; --7로 끝나는 학번








