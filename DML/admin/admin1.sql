/* 1. 사용자 정보 조회 (SELECT)
조건: 남성('M')이면서 2025년 10월 1일 이후에 가입한 사용자 조회. */
SELECT
    user_code,
    user_nm,
    user_phnum,
    user_email,
    user_gen,
    crtn_dt
FROM tbl_user
WHERE user_gen = 'M'
  AND crtn_dt >= '2025-10-01';


/* 2. 기사 정보 및 스케줄 조회 (SELECT, JOIN)
조건: 기사 코드 **3**번의 2025-12-10 스케줄 포함 정보 조회. */
-- S2: 기사 3번의 고유 스케줄

INSERT INTO `tbl_driver_sch` (`work_date`, `start_time`, `end_time`, `is_off`, `driver_code`) VALUES
('2025-12-10', '11:00:00', '20:00:00', 0, 3);

SELECT
    td.driver_nm,
    td.driver_gen,
    td.driver_age,
    td.driver_license_typ,
    tds.work_date,
    tds.start_time,
    tds.end_time,
    tds.is_off
FROM tbl_driver td
JOIN tbl_driver_sch tds
    ON (td.driver_code = tds.driver_code)
WHERE td.driver_code = 3
  AND tds.work_date = '2025-12-10'
ORDER BY tds.work_date;


/* 3. 운송 수단 할당을 위한 픽업 정보 수정 (UPDATE)
대상: 픽업 코드 **200**번 / 값: detail_code 2003 (대형차 배정)으로 수정. */
INSERT INTO `tbl_common_code` (`detail_code`, `detail_codename`, `group_code`) VALUES
(2003, '운송 수단: 대형차 배정', 2);

UPDATE tbl_user
SET
    user_phnum = '010-9876-5432', -- 새로운 고유 전화번호
    user_email = 'new_contact_info@unique.com', -- 새로운 고유 이메일
    mdfc_dt = NOW()
WHERE user_code = 11; -- 고유 사용자 코드 11번


/* 4. 진행 중인 픽업 상태 및 위치 확인 조회 (SELECT, JOIN)
조건: 현재 '픽업 대기' 상태인 모든 건 조회. */
SELECT
    tph.pickup_code,
    tph.pickup_addr,
    tph.shipping_addr,
    tps.pickup_stat AS current_pickup_status,
    tps.delivery_stat AS current_delivery_status,
    td.driver_nm
FROM tbl_pickup_history tph
JOIN tbl_driver td ON(tph.driver_code = td.driver_code)
JOIN tbl_pickup_stat tps ON(tph.driver_code = tps.driver_code)
WHERE tps.pickup_stat = '픽업 대기'
ORDER BY tps.updated_at DESC;


/* 5. 부적절하다고 판단된 리뷰 삭제 (DELETE)
대상: 리뷰 코드 **9**번 삭제. */
START TRANSACTION;

DELETE FROM tbl_review_files
WHERE review_code = 60;

DELETE FROM tbl_review
WHERE review_code = 60;

COMMIT;

SELECT * FROM tbl_review_files;


/* 6. 특정 기간 동안 접수된 신고 내역 상세 조회 (SELECT, JOIN)
조건: 2025년 9월 한 달 동안 접수된 신고 내역 조회. */
SELECT
    tr.report_code,
    tr.crtn_dt AS report_date,
    tr.content AS report_content,
    trt.name AS report_type,
    tu.user_nm AS reported_user_name,
    tdr.driver_code
FROM tbl_report tr
JOIN tbl_report_type trt ON(tr.type_code = trt.type_code)
JOIN tbl_user tu ON(tr.user_code = tu.user_code)
LEFT JOIN tbl_driver_report tdr ON(tr.report_code = tdr.report_code)
WHERE tr.crtn_dt BETWEEN '2025-09-01' AND '2025-09-30'
ORDER BY tr.crtn_dt DESC;


/* 7. 특정 지역/면허 유형 기사 목록 및 급여 조회 (SELECT, JOIN) - 변경됨
조건: 지역 코드 9(울산 남구)이면서 면허 유형이 '1종 보통'인 기사 조회. */
SELECT
    td.driver_nm,
    td.driver_phnum,
    td.driver_license_typ,
    tsr.region_nm,
    td.salary
FROM tbl_driver td
JOIN tbl_serv_reg tsr ON(td.region_code = tsr.region_code)
WHERE td.region_code = 9 -- 울산 남구 지역 코드
  AND td.driver_license_typ = '1종 보통'
ORDER BY td.salary DESC;

/* 8. 신규 공지사항 등록 (INSERT)
값: 관리자 코드 '5'번 (뷰어)이 실시간 위치 추적 기능 추가 공지 등록. */
INSERT INTO tbl_notice
(title, content, is_pin, admin_code, crtn_dt)
VALUES
('🚀 서비스 개선: 실시간 위치 추적 기능 추가',
 '금일 앱 업데이트를 통해 픽업부터 배송까지 실시간으로 물품 위치를 확인할 수 있는 기능이 추가되었습니다.',
 0, -- 상단 고정 해제
 5, -- 관리자 코드 5번
 NOW());

SELECT * FROM tbl_notice;

/* 9. 기존 공지사항 내용 및 고정 여부 수정 (UPDATE)
대상: 공지 코드 **4**번 / 값: 겨울철 폭설 대비 가이드라인으로 수정 후 고정 설정. */
UPDATE tbl_notice
SET
    title = '🔥 [필독] 겨울철 폭설 대비 운행 가이드라인 공지',
    content = '폭설/결빙 시 운행 기준 및 안전 조치 사항을 확인해주세요.',
    is_pin = 1, -- 고정 설정
    mdfc_dt = NOW()
WHERE notice_code = 4;

SELECT * FROM tbl_notice;

/* 10. 특정 공지사항 영구 삭제 (DELETE)
대상: 공지 코드 **2**번 삭제. */
DELETE FROM tbl_notice
WHERE notice_code = 2;

SELECT * FROM tbl_notice;

/* 11. 특정 연월의 전체 결제 내역 조회 (SELECT)
조건: 2025년 10월에 발생한 모든 결제 내역 조회. */
SELECT
    tp.paymn_code,
    tp.amount,
    tp.payment_method,
    tp.pay_date,
    tph.pickup_addr
FROM tbl_payment tp
JOIN tbl_pickup_history tph ON(tp.pickup_code = tph.pickup_code)
WHERE YEAR(tp.pay_date) = 2025
  AND MONTH(tp.pay_date) = 10
ORDER BY tp.pay_date DESC;

/* 12. 환불 요청 승인 (UPDATE)
대상: 환불 요청 코드 **8**번 승인. */
-- 1. 환불 승인 (tbl_refund 업데이트)
UPDATE tbl_refund
SET
    is_refund_completed = 1,
    refund_completed_date = NOW()
WHERE refund_code = 8;

-- 2. 관련 취소 내역 상태 동기화 (tbl_pickup_cancellation_code 업데이트)
UPDATE tbl_pickup_cancellation_code tpc
SET tpc.is_refunded = 1
WHERE tpc.cancellation_code = (
    SELECT cancellation_code FROM tbl_refund WHERE refund_code = 8
);

/* 13. 사용자 문의에 대한 답변 등록 (INSERT)
값: 문의 코드 **18**번에 대해 관리자 코드 **9**번 (시스템 관리자)이 답변 등록. */
INSERT INTO tbl_inquiry_ans
(content, inquiry_code, admin_code, crtn_dt)
VALUES
('문의하신 서비스 지역 확대 건은 2026년 상반기에 검토될 예정입니다. 참고 부탁드립니다.',
 18,
 9,
 NOW());

SELECT * FROM tbl_inquiry_ans;

-- 김태형