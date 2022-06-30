CREATE TABLE score ( -- Repository layer : 저장소                       
-- 객체?? model객체(or 도메인 객체 or 엔터티객체?) :: 어떤 특정 객체가 가져야할 값들을 가지고 있었다.
    stu_num NUMBER(10), -- 학생 일련번호(출석번호)
    stu_name VARCHAR2(20) NOT NULL, -- 학생 이름
    kor NUMBER(3) NOT NULL, -- 국어 성적 점수
    eng NUMBER(3) NOT NULL, -- 영어 점수
    math NUMBER(3) NOT NULL, -- 수학 점수
    total NUMBER(3), -- 총점
    average NUMBER(5,2), -- 평균
    CONSTRAINT pk_score PRIMARY KEY (stu_num)
);

-- 연속된 숫자 생성
CREATE SEQUENCE seq_score; -- [중복 없는!!] 일련번호를 만들고 싶을 때 사용한다!!
    -- 시퀀스 테이블이 생기고, ~~~

SELECT * FROM score;

INSERT INTO score VALUES (seq_score.nextval,  '홍길동', 90, 90, 90, 270, 90); -- 기본키 입력 부분에 시퀀스 활용
INSERT INTO score VALUES (seq_score.nextval,  '김철수', 80, 80, 80, 240, 80);
INSERT INTO score VALUES (seq_score.nextval,  '박영희', 100, 100, 100, 300, 100);
COMMIT;

SELECT AVG(average) AS avg_cls
FROM score;