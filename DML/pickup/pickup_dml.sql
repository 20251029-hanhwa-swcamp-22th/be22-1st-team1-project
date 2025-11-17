/*
김나라씨의 아르마니 코트 픽업 요청
*/
SELECT * FROM tbl_pickup_history;

INSERT INTO `tbl_pickup_history` (`product_nm`,`pickup_addr`, `shipping_addr`, `request_dt`, `allotment_dt`, `complet_dt`, `user_code`, `region_code`, `driver_code`, `category_code`, `product_code`, `pay_code`, `stat_code`) VALUES
('아르마니 코트','서울시 서초구 서초동 185호', '서울 영등포구 여의도동 125호', CURDATE() - INTERVAL 4 DAY, NULL, NULL, 11, 10, 10, 1,5,13,8);

SELECT * FROM tbl_pickup_history WHERE pickup_code = 14;

/*
김나라씨의 아르마니 코트 픽업 요청 날짜 변경
*/
SELECT * FROM tbl_pickup_history;

UPDATE tbl_pickup_history ph
JOIN
    tbl_user u ON(ph.user_code = u.user_code)
SET
    ph.request_dt = '2025-12-02'
WHERE
    u.user_id = 'user011'
AND
    pickup_code = 14
AND
    stat_code = 8;

SELECT * FROM tbl_pickup_history WHERE pickup_code = 14;

/*
김나라씨의 픽업 요청 내역 결제 완료
*/
SELECT * FROM tbl_payment;

INSERT INTO `tbl_payment` (`amount`, `payment_method`, `is_paid`, `pay_date`, `pickup_code`) VALUES
(10000, '카카오페이', 1, NOW(), 14);

SELECT * FROM tbl_payment WHERE pickup_code = 14;

/*
김나라씨의 아르마니 코트 픽업 요청 취소
*/
SELECT * FROM tbl_pickup_cancellation_code;

INSERT INTO `tbl_pickup_cancellation_code` (`requested_date`, `approved_date`, `cancellation_detail`, `is_refunded`, `is_payment_canceled`) VALUES
(DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), '개인 사정으로 인한 픽업 취소', 1, 1);

SELECT * FROM tbl_pickup_cancellation_code WHERE cancellation_code = 11;

/*
김나라씨의 픽업 요청 내역 환불 신청
*/
SELECT * FROM tbl_refund;

INSERT INTO `tbl_refund` (`is_refund_completed`, `refund_completed_date`, `cancellation_code`, `paymn_code`) VALUES
(1, NOW() - INTERVAL 2 DAY, 11, 11);

SELECT * FROM tbl_refund WHERE paymn_code = 11;


/*
박나라씨의 이전 픽업 내역 조회
*/
SELECT * FROM tbl_pickup_history;

SELECT
    *
FROM
    tbl_pickup_history
WHERE
    complet_dt < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

/*
이영희씨의 픽업 내역 상세 조회
*/
SELECT
    ph.pickup_code,
    ph.product_nm,
    ph.pickup_addr,
    ph.shipping_addr,
    IFNULL(ph.request_dt,' - '),
    IFNULL(ph.allotment_dt,' - '),
    u.user_nm,
    cate.detail_codename,
    pro.detail_codename,
    pay.detail_codename,
    stat.detail_codename
FROM
    tbl_pickup_history ph
JOIN
    tbl_user u ON(ph.user_code = u.user_code)
JOIN
    tbl_common_code cate ON(ph.category_code = cate.detail_code)
JOIN
    tbl_common_code pay ON(ph.pay_code = pay.detail_code)
JOIN
    tbl_common_code pro ON(ph.product_code = pro.detail_code)
JOIN
    tbl_common_code stat ON(ph.stat_code = stat.detail_code)
WHERE
    u.user_id = 'user002';

