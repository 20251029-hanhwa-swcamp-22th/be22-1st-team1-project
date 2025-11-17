/*기사(driver)가 회사에서 부여받은 전용 코드(driver_code)로 로그인할 때
해당 기사의 정보를 조회*/
SELECT
    *
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
  ON(p.region_code = r.region_code)
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
-- 과거 일정(완료)
select * from tbl_driver_sch;
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

-- 미래 일정(예정)
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

/*배송 상세 정보 (사용자의 이름/사용자의 연락처/픽업/배송지)*/

SELECT
    p.pickup_stat,
    p.delivery_stat,
    u.user_nm
FROM
    tbl_pickup_stat p
LEFT JOIN
        tbl_user u ON(p.stat_code = u.user_code)
WHERE p.stat_code = 1;
