-- 여기는 grade화면

----------------------------------------------
-- 성적일람표 출력
----------------------------------------------
-- 성적정보 테이블(tbl_score) 에는 학번과 각 과목별 점수가 저장되어 있다.
-- 학생정보 테이블(tbl_student) 에는 학번과 이름 등 학생정보가 저장되어 있다.
-- 성적 일람표를 보고 싶은데, 학생의 학번과 이름이 포함된 리스트를 보고싶은경우
-- 두개의 테이블(student와 score) 을 연동하여 리스트를 조회해야 한다.
-- 이러한 기법을 JOIN이라고 한다. 

SELECT * 
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';

-- 완전 JOIN
-- sc_score table에 있는 학번의 정보는 반드시 st_student에 있다 라는 전제 하에
-- 결과가 원하는 대로 나온다.
-- FROM 다음에 join할 테이블을 나열하고, WHERE 절에 두 테이블의 연결점 칼럼을 설정해 주면된다.
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE
--sc_num BETWEEN '20001' AND '20010' AND
sc_num = st_num;

-- OUTER JOIN (외부조인)
-- 성적테이블에는 1~100까지의 데이터가 있고, 학생테이블에는 1~50까지의 데이터만 있다.
-- 이러한 상황에서 성적리스트를 확인하면서 학생정보와 연동하여 보고싶을 때
-- EQ JOIN을 사용하게 되면 실제 데이터가 1~50까지만 나타나게 된다.
-- 이런상황에서 성적 테이블의 데이터는 모두 확인하면서 
-- 학생테이블에 있는 정보만 연결해 보여주는 방식의 조인이다.

DELETE FROM tbl_student
WHERE st_num > '20050';

SELECT * FROM tbl_student;

-- EQ JOIN 1안 (권장)
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

-- EQ JOIN 2안
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score
    INNER JOIN tbl_student
        ON sc_num = st_num;
-- LEFT JOIN 중요!!!
-- outter join의 대표적으로 많이 사용하는 조인 query 이다
-- 1. join 키워드 왼쪽(score 테이블)에는 리스트를 모~두 올릴 테이블을 위치 시키고
-- 2. 이 테이블과 연동하여 정보를 보조적으로 가져올 테이블을 join 다음에 위치한다(student테이블)
-- 3. 두 테이블의 연결점(key 여기서는 num)을 on 키워드 다음에 작성해 준다.

-- join 왼쪽테이블의 데이터를 모두 보여주고, 키값으로 오른쪽 테이블에서 값을 찾은 후
-- 키가 있으면 프로젝션에 나열된 컬럼위치에 값을 표시하고 
-- 만약 없으면 (null)이라고 표시한다. 

-- 왼쪽 테이블의 데이터가 잘 입력되었나 검증하는 용도로 많이 사용되고
-- 아직 FK설정이 되지 않은 테이블 간에 정보를 리스트업하는 용도로 사용된다.

SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score LEFT JOIN tbl_student
        ON sc_num =st_num;


