SELECT * FROM tbl_common_code;
SELECT * FROM tbl_common_group;

SELECT * FROM tbl_pickup_history;
SELECT * FROM tbl_user;

INSERT INTO `tbl_user` (`user_id`, `user_pw`, `user_nm`, `user_phnum`, `user_email`, `user_birth`, `user_gen`, `crtn_dt`, `mdfc_dt`) VALUES
('user011', 'hashed_pw_011', '김나라', '010-5679-8912', 'kimnara@example.com', '1999-10-18', 'F', NOW(), NULL);

/*
김나라씨의 픽업요청
*/
INSERT INTO `tbl_pickup_history` (`pickup_addr`, `shipping_addr`, `request_dt`, `allotment_dt`, `complet_dt`, `user_code`, `region_code`, `driver_code`, `category_code`, `product_code`, `pay_code`, `stat_code`) VALUES
('서울시 서초구 서초동 185호', '서울 영등포구 여의도동 125호', CURDATE() - INTERVAL 4 DAY, NULL, NULL, 11, 10, 10, 1,5,13,8);

/*
김나라씨의 픽업날짜 수정요청
*/
UPDATE tbl_pickup_history history
JOIN
    tbl_user user ON history.user_code = user.user_code
SET
    history.request_dt = '2025-12-02'
WHERE
    user.user_id = 'user011'
AND
    stat_code = 8;

SELECT * FROM tbl_pickup_history WHERE pickup_code = 11;

