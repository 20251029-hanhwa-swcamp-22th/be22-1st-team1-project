DELIMITER //

CREATE PROCEDURE SP_InsertDummyUsers(IN num_rows INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    -- 더미 데이터에 사용할 값의 배열 (예시)
    DECLARE v_names VARCHAR(255) DEFAULT '김철수,이영희,박민준,최지우,정우성,고소영,유재석,강호동,송지효,하하';
    DECLARE v_domain VARCHAR(20) DEFAULT '@sample.com';
    DECLARE v_genders VARCHAR(3) DEFAULT 'M,F';

    DECLARE rand_name VARCHAR(20);
    DECLARE rand_gen CHAR(1);
    DECLARE rand_birth DATE;
    DECLARE rand_dt DATETIME;

    -- 대량 삽입 시 성능 최적화를 위해 트랜잭션 시작
    START TRANSACTION;

    -- 지정된 횟수만큼 반복
    WHILE i < num_rows DO
        -- 인덱스를 사용하기 위해 i를 1부터 시작
        SET i = i + 1;

        -- 무작위 데이터 생성
        SET rand_name = SUBSTRING_INDEX(SUBSTRING_INDEX(v_names, ',', (i MOD 10) + 1), ',', -1);
        SET rand_gen = SUBSTRING_INDEX(SUBSTRING_INDEX(v_genders, ',', (i MOD 2) + 1), ',', -1);

        -- 무작위 생년월일 (2000년 ~ 2030년)
        SET rand_birth = DATE_ADD('2000-01-01', INTERVAL FLOOR(RAND() * 365 * 30) DAY);

        -- 무작위 가입 날짜 (최근 3년 이내)
        SET rand_dt = NOW() - INTERVAL FLOOR(RAND() * 3 * 365) DAY - INTERVAL FLOOR(RAND() * 86400) SECOND;

        -- tbl_user 테이블에 데이터 삽입
        INSERT INTO tbl_user (
            user_id, user_pw, user_nm, user_phnum,
            user_email, user_birth, user_gen, crtn_dt
        ) VALUES (
            CONCAT('user', LPAD(i, 5, '0')),
            CONCAT('hashed_pw_', LPAD(i, 5, '0')),
            CONCAT(rand_name, i),
            CONCAT('010', LPAD(FLOOR(RAND() * 99999999), 8, '0')),
            CONCAT('user', i, v_domain),
            rand_birth,
            rand_gen,
            rand_dt
        );

    END WHILE;

    COMMIT;
END //

DELIMITER ;

-- 프로시저 실행 (10만 건 삽입)
CALL SP_InsertDummyUsers(100000);

-- 테이블 통계 갱신 (옵티마이저가 변경된 크기를 인식하도록 함)
ANALYZE TABLE tbl_user;


-- 성별('M','F')로 1차 필터링 후, 가입 날짜로 범위 검색이 필요
CREATE INDEX idx_user_gen_crtn_dt ON tbl_user (user_gen, crtn_dt);


-- EXPLAIN 실행 후 key 필드에 'idx_user_gen_crtn_dt'가 표시되는지 확인
EXPLAIN SELECT user_id, crtn_dt
FROM tbl_user
WHERE user_gen = 'M' AND crtn_dt BETWEEN '2025-05-01' AND '2025-11-30';


-- 인덱스 미사용
SELECT user_id
FROM tbl_user
WHERE crtn_dt BETWEEN '2025-05-01' AND '2025-11-30';


DROP PROCEDURE SP_InsertDummyUsers;
DROP INDEX IF EXISTS idx_user_gen_crtn_dt ON tbl_user;

-- 사용 쿼리
SELECT user_id
FROM tbl_user
WHERE user_gen = 'M' AND crtn_dt BETWEEN '2025-05-01' AND '2025-11-30';




SELECT * FROM tbl_user;




DELETE FROM tbl_user
WHERE user_code >= 11;