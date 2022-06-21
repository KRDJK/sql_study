-- UNDO는 

-- DML : 데이터 조작어
-- SELECT(READ), INSERT(CREATE), UPDATE(U), DELETE(D)


INSERT INTO board
    (bno, title, content, writer, reg_date)
VALUES
    (1, '제목이야~', '랄랄라~~~', '둘리', SYSDATE + 1);
    

-- NN(NOT NULL) 제약조건 위반 - 삽입 실패
INSERT INTO board
    (bno, content, writer)
VALUES
    (2, '하하호호~~~', '마이콜');
    

-- PK의 UNIQUE 제약조건 위반
INSERT INTO board
    (bno, title, writer)
VALUES
    (1, '하하호호~~~', '마이콜');    
    
    
INSERT INTO board
    (bno, title, writer)
VALUES
    (2, '하하호호히히~~~', '짹짹잉');   
    
    
-- 컬럼명을 생략한 경우, 무조건 모든 컬럼들의 값을 넣어줘야 한다. 생성 순서대로!!    
INSERT INTO board
    
VALUES
    (3, '제목제목~@@~~~', '꽥꽥이', '내용내용!', SYSDATE + 30);      
    
    
    
-- 데이터 수정
UPDATE board
SET title = '수정된 제목이야~'
WHERE bno = 3;
    
UPDATE board
SET writer = '수정맨'
    , content = '메롱메롱메롱 fix'
WHERE bno = 2;

-- WHERE절 생략시 벌어지는 일.. 전체가 수정되어 버림..
UPDATE board
SET writer = '나쁜놈';
    
    
-- 데이터 삭제 : 한 행을 전부 지우는 것!
DELETE FROM board
WHERE bno = 1; -- 여기서도 where절 생략하면 전체 삭제가 된다.. truncate처럼!! 그치만 롤백 가능! TRUNCATE는 롤백 불가.. ㅠㅠ


-- 전체 데이터 삭제
-- 1. WHERE절을 생략한 DELETE절 (커밋만 안했다면 롤백 가능, 수동 커밋 가능, 로그 남기기 가능)
DELETE FROM board;   

-- 2. TRUNCATE TABLE 
-- (롤백 불가능, 자동 커밋, 로그를 남길 수 없음, 테이블 생성 초기상태로 복귀)
TRUNCATE TABLE board;
-- 주의! TRUNCATE TABLE을 하는 순간 그동안 커밋 안하고 있었던거 자동적으로 전부 다 커밋되어버림..


-- 3. DROP TABLE
-- (롤백 불가능, 자동 커밋, 로그를 남길 수 없음, 테이블 구조가 완전 삭제됨)
DROP TABLE board;
   
    
COMMIT;
ROLLBACK;

SELECT * FROM board;