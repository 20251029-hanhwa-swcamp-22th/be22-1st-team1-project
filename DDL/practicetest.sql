/*기사(driver)가 회사에서 부여받은 전용 코드(driver_code)로 로그인할 때
해당 기사의 정보를 조회*/

SELECT
    driver_code
FROM tbl_driver
WHERE driver_code = 1;

/*기사 근무 내역 조회 (상태: 완료 / 예정 / 취소)*/

SELECT
    pickup_code,
    pickup_addr,
    shipping_addr,
    request_dt,
    allotment_dt,
    complet_dt,
    CASE
      WHEN complet_dt IS NOT NULL THEN '완료'
      WHEN allotment_dt IS NOT NULL AND complet_dt IS NULL THEN '예정'
      ELSE '취소/미배정'
    END AS status
FROM tbl_pickup_history
WHERE driver_code = 1
  AND request_dt BETWEEN '2025-11-01' AND '2025-11-30'
ORDER BY request_dt DESC;

/*배정된 근무일·시간·지역 조회 (스케줄 + 지역)*/

SELECT
    s.work_date AS assign_date,
    s.start_time,
    s.end_time,
    GROUP_CONCAT(DISTINCT r.region_nm SEPARATOR ', ') AS delivery_regions
FROM tbl_driver_sch s
LEFT JOIN tbl_pickup_history p
  ON p.driver_code = s.driver_code
  AND DATE(p.allotment_dt) = s.work_date
LEFT JOIN tbl_serv_reg r
  ON p.region_code = r.region_code
WHERE s.driver_code = 2
  AND s.work_date BETWEEN '2025-11-17' AND '2025-11-20'
GROUP BY s.work_date, s.start_time, s.end_time
ORDER BY s.work_date;

/*평점·리뷰·월별 완료 건수 통계*/

SELECT
    driver_code,
    ROUND(AVG(review_grade), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM tbl_review
WHERE driver_code = 1;

/*과거 일정(완료) / 미래 일정(예정) 조회*/

SELECT
    sch_code,
    work_date,
    start_time,
    end_time,
    is_off
FROM tbl_driver_sch
WHERE driver_code = 1
  AND work_date < CURRENT_DATE
  AND is_off = 0
ORDER BY work_date DESC;

SELECT
    sch_code,
    work_date,
    start_time,
    end_time,
    is_off
FROM tbl_driver_sch
WHERE driver_code = 1
  AND work_date >= CURRENT_DATE
  AND is_off = 0
ORDER BY work_date ASC;

/*배송 상세 정보 (구매자/판매자/물품/픽업/배송지)*/

SELECT
    p.pickup_code,
    p.pickup_addr,
    p.shipping_addr,
    p.request_dt,
    p.allotment_dt,
    p.complet_dt,
    u.user_code AS requester_user_code,
    u.user_nm   AS requester_name,
    u.user_phnum,
    r.region_nm,
    pay.amount AS payment_amount,
    pay.payment_method,
    rv.review_grade,
    rv.review_detail
FROM tbl_pickup_history p
LEFT JOIN tbl_user u
  ON p.user_code = u.user_code
LEFT JOIN tbl_serv_reg r
  ON p.region_code = r.region_code
LEFT JOIN tbl_payment pay
  ON pay.pickup_code = p.pickup_code
LEFT JOIN tbl_review rv
  ON rv.pickup_code = p.pickup_code
WHERE p.pickup_code = 1;

/*픽업 → 전달 완료까지 상태 알림*/

DELIMITER //

DELIMITER $$

CREATE TRIGGER trg_pickup_on_completion
AFTER UPDATE ON tbl_pickup_history
FOR EACH ROW
BEGIN
    -- 완료 처리된 경우
    IF OLD.complet_dt IS NULL AND NEW.complet_dt IS NOT NULL THEN
        INSERT INTO tbl_notification_code (
            notification_content,
            send_time,
            is_checked,
            receiver_type,
            receiver_code,
            pickup_code
        ) VALUES (
            CONCAT('픽업 및 배송이 완료되었습니다. 완료일: ', DATE_FORMAT(NEW.complet_dt, '%Y-%m-%d %H:%i:%s')),
            NOW(),
            0,
            'USER',
            CAST(NEW.user_code AS CHAR),
            NEW.pickup_code
        );

        -- 관리자용 알림 (예: 운영팀 확인 필요 시)
        INSERT INTO tbl_notification_code (
            notification_content,
            send_time,
            is_checked,
            receiver_type,
            receiver_code,
            pickup_code
        ) VALUES (
            CONCAT('픽업코드 ', NEW.pickup_code, '의 배송이 완료되었습니다.'),
            NOW(),
            0,
            'ADMIN',
            'SYSTEM', -- 관리자 코드는 별도 논의 필요(여기선 문자열 'SYSTEM' 사용)
            NEW.pickup_code
        );
    END IF;
END;

DELIMITER ;

/*새로운 픽업 배정 시 자동 알림*/

DELIMITER $$

CREATE TRIGGER trg_new_pickup_notify_driver
AFTER INSERT ON tbl_pickup_history
FOR EACH ROW
BEGIN
    -- 드라이버가 지정된 경우에만 알림을 생성
    IF NEW.driver_code IS NOT NULL THEN
        INSERT INTO tbl_notification_code (
            notification_content,
            send_time,
            is_checked,
            receiver_type,
            receiver_code,
            pickup_code
        ) VALUES (
            CONCAT('새로운 픽업이 배정되었습니다. 픽업코드: ', NEW.pickup_code, ' / 픽업주소: ', NEW.pickup_addr),
            NOW(),
            0,
            'DRIVER',
            CAST(NEW.driver_code AS CHAR),
            NEW.pickup_code
        );
    END IF;
END$$

DELIMITER ;

-- 박지민