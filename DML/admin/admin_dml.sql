/*************************************************************************************************
 [관리자] 1. 사용자 관리
*************************************************************************************************/

-- 1-1. 조건에 맞는 사용자 조회 (남성, 2025-10-01 이후 가입)
SELECT user_nm, user_id, user_phnum, crtn_dt
FROM tbl_user
WHERE user_gen = 'M'
  AND crtn_dt >= '2025-10-01';


/*************************************************************************************************
 [관리자] 2. 기사 관리
*************************************************************************************************/

-- 2-1. 기사 상세 정보 및 스케줄 조회
SELECT
    d.driver_nm,
    d.driver_license_typ,
    s.work_date,
    s.start_time,
    s.end_time
FROM tbl_driver d
JOIN tbl_driver_sch s ON(d.driver_code = s.driver_code)
WHERE d.driver_code = 3
  AND s.work_date = '2025-12-10';

-- 2-2. 특정 지역(울산 남구:9), 1종 보통 면허 기사 급여 조회
SELECT driver_nm, driver_phnum, salary
FROM tbl_driver
WHERE region_code = 9
  AND driver_license_typ = '1종 보통'
ORDER BY salary DESC;


/*************************************************************************************************
 [관리자] 3. 픽업 및 배송 관리
*************************************************************************************************/

-- 현재 '픽업 대기' 중인 건들의 상태 조회
SELECT p.pickup_code, p.pickup_addr, s.pickup_stat
FROM tbl_pickup_history p
JOIN tbl_pickup_stat s ON(p.driver_code = s.driver_code)
WHERE s.pickup_stat = '픽업 대기';


/*************************************************************************************************
 [관리자] 4. 리뷰 및 신고 관리
*************************************************************************************************/

-- 4-1. 부적절한 리뷰 삭제
SELECT * FROM tbl_review_files;
SELECT * FROM tbl_review;

DELETE FROM tbl_review_files WHERE review_code = 8;
DELETE FROM tbl_review       WHERE review_code = 8;

-- 4-2. 2025년 11월 신고 내역 조회
SELECT
    r.report_code,
    r.crtn_dt,
    r.content,
    u.user_nm AS 신고자
FROM tbl_report r
JOIN tbl_user u ON(r.user_code = u.user_code)
WHERE r.crtn_dt BETWEEN '2025-11-01' AND '2025-11-11'
ORDER BY r.crtn_dt DESC;


/*************************************************************************************************
 [관리자] 5. 공지사항 관리
*************************************************************************************************/

-- 5-1. 공지사항 등록
SELECT * FROM tbl_notice;

INSERT INTO tbl_notice (title, content, is_pin, admin_code, crtn_dt)
VALUES ('서비스 점검 안내', '새벽 2시부터 점검이 있습니다.', 0, 1, NOW());

-- 5-2. 공지사항 수정 (고정 설정)
UPDATE tbl_notice
SET title = '[필독] 폭설 대비 안내', is_pin = 1, mdfc_dt = NOW()
WHERE notice_code = 4;

-- 5-3. 공지사항 삭제
DELETE FROM tbl_notice WHERE notice_code = 2;


/*************************************************************************************************
 [관리자] 6. 결제 및 환불 관리
*************************************************************************************************/

-- 6-1. 2025년 11월 결제 내역 조회 (테이블 하나만 봐도 충분한 경우)
SELECT paymn_code, amount, payment_method, pay_date
FROM tbl_payment
WHERE pay_date LIKE '2025-11%';

-- 6-2. 환불 요청 승인 처리
SELECT * FROM tbl_refund;

UPDATE tbl_refund
SET is_refund_completed = 1, refund_completed_date = NOW()
WHERE refund_code = 7;


/*************************************************************************************************
 [관리자] 7. 문의 답변
*************************************************************************************************/

-- 7-1. 문의 답변 등록
SELECT * FROM tbl_inquiry_ans;

INSERT INTO tbl_inquiry_ans (content, inquiry_code, admin_code, crtn_dt)
VALUES ('검토 후 연락드리겠습니다.', 11, 9, NOW());