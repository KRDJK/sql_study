

CREATE TABLE 일자별매출_93 (
    일자 DATE,
    매출액 NUMBER(5)
);

INSERT INTO 일자별매출_93 VALUES ('2015-11-01', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-02', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-03', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-04', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-05', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-06', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-07', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-08', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-09', 1000);
INSERT INTO 일자별매출_93 VALUES ('2015-11-10', 1000);
COMMIT;

SELECT * FROM 일자별매출_93;

-- 보기 1번

SELECT A.일자, SUM(A.매출액) AS 누적매출액
FROM 일자별매출_93 A
GROUP BY A.일자
ORDER BY A.일자
;

-- 보기 2번
SELECT B.일자, SUM(B.매출액) AS 누적매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
GROUP BY B.일자
ORDER BY B.일자;

-- GROUP BY를 해보지 말자.
SELECT A.일자, A.매출액, B.일자, B.매출액
FROM 일자별매출_93 A
JOIN 일자별매출_93 B 
ON (A.일자 >= B.일자)
ORDER BY A.일자;



-- 86번
drop table 회원기본정보_86;
drop table 회원상세정보_86;
CREATE TABLE 회원기본정보_86 (
    user_id VARCHAR2(200) PRIMARY KEY
);

CREATE TABLE 회원상세정보_86 (
    user_id VARCHAR2(200)
    
);
ALTER TABLE 회원상세정보_86
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id)
references 회원기본정보_86 (user_id);


INSERT INTO 회원기본정보_86 VALUES ('abc01');
INSERT INTO 회원기본정보_86 VALUES ('abc02');
INSERT INTO 회원기본정보_86 VALUES ('abc03');
COMMIT;

INSERT INTO 회원상세정보_86 VALUES ('abc01');
INSERT INTO 회원상세정보_86 VALUES ('abc02');
INSERT INTO 회원상세정보_86 VALUES ('abc03');
INSERT INTO 회원상세정보_86 VALUES ('abc04');
COMMIT;



SELECT * FROM 회원기본정보_86;
SELECT * FROM 회원상세정보_86;

-- 보기 1
SELECT user_id FROM 회원기본정보_86
MINUS
SELECT user_id FROM 회원상세정보_86
;


-- 보기 2
SELECT user_id FROM 회원기본정보_86
UNION ALL
SELECT user_id FROM 회원상세정보_86
;


-- 보기 3
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT A.user_id 
FROM 회원기본정보_86 A 
JOIN 회원상세정보_86 B 
ON A.user_id = B.user_id
;

-- 보기 4
SELECT user_id FROM 회원기본정보_86
INTERSECT
SELECT user_id FROM 회원상세정보_86
;

SELECT user_id FROM 회원기본정보_86
UNION
SELECT user_id FROM 회원상세정보_86
;







