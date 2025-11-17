INSERT INTO `tbl_user` (`user_id`, `user_pw`, `user_nm`, `user_phnum`, `user_email`, `user_birth`, `user_gen`, `crtn_dt`, `mdfc_dt`) VALUES
('user001', 'hashed_pw_001', '김철수', '010-1111-2222', 'kimcs@example.com', '1990-05-15', 'M', NOW(), NULL),
('user002', 'hashed_pw_002', '이영희', '010-3333-4444', 'leeyh@example.com', '1995-11-20', 'F', NOW(), NULL),
('user003', 'hashed_pw_003', '박민수', '010-5555-6666', 'parkms@example.com', '1988-01-01', 'M', NOW(), NULL),
('user004', 'hashed_pw_004', '정은지', '010-7777-8888', 'jungej@example.com', '2000-07-25', 'F', NOW(), NULL),
('user005', 'hashed_pw_005', '최현우', '010-9999-0000', 'choihw@example.com', '1985-03-10', 'M', NOW(), NULL),
('user006', 'hashed_pw_006', '강수진', '010-1234-5678', 'kangsi@example.com', '1992-09-12', 'F', NOW(), NULL),
('user007', 'hashed_pw_007', '윤도현', '010-2345-6789', 'yundh@example.com', '1975-04-22', 'M', NOW(), NULL),
('user008', 'hashed_pw_008', '한지민', '010-3456-7890', 'hanjm@example.com', '1998-12-05', 'F', NOW(), NULL),
('user009', 'hashed_pw_009', '신동엽', '010-4567-8901', 'shindy@example.com', '1980-06-30', 'M', NOW(), NULL),
('user010', 'hashed_pw_010', '오나라', '010-5678-9012', 'onara@example.com', '1993-10-18', 'F', NOW(), NULL);



INSERT INTO `tbl_report_type` (`name`) VALUES
('기사 불친절/태도 문제'),
('기사 운전 미숙/난폭 운전'),
('픽업 지연/약속 불이행'),
('서비스 품질 불만'),
('웹/앱 오류 발생'),
('결제 및 환불 관련 문의'),
('개인정보 유출 의심'),
('불법 광고/스팸 신고'),
('기타 서비스 관련 문의'),
('물품 파손/분실');


INSERT INTO `tbl_serv_reg` (`region_nm`, `crtn_dt`, `mdfc_dt`) VALUES
('서울 강남구', NOW(), NULL),
('서울 마포구', NOW(), NULL),
('경기 성남시', NOW(), NULL),
('인천 연수구', NOW(), NULL),
('부산 해운대구', NOW(), NULL),
('대구 수성구', NOW(), NULL),
('대전 유성구', NOW(), NULL),
('광주 서구', NOW(), NULL),
('울산 남구', NOW(), NULL),
('세종시 전체', NOW(), NULL);


INSERT INTO `tbl_terms` (`terms_title`, `terms_content`, `is_required`, `crtn_dt`, `mdfc_dt`) VALUES
('서비스 이용약관', '서비스 이용에 관한 필수적인 약관 내용입니다.', 1, NOW(), NULL),
('개인정보 수집 및 이용 동의', '개인정보 수집에 대한 필수 동의 내용입니다.', 1, NOW(), NULL),
('위치기반 서비스 이용약관', '위치정보 이용에 대한 선택적 동의 내용입니다.', 0, NOW(), NULL),
('마케팅 정보 수신 동의', '이벤트 및 프로모션 정보 수신에 대한 선택적 동의 내용입니다.', 0, NOW(), NULL),
('환불 정책', '서비스 이용료 환불에 대한 안내 내용입니다.', 1, NOW(), NULL),
('차량 이용 수칙', '픽업 차량 이용 시 준수 사항입니다.', 1, NOW(), NULL),
('제3자 정보 제공 동의', '서비스 제공을 위한 제3자 정보 제공 동의 내용입니다.', 0, NOW(), NULL),
('청소년 보호 정책', '청소년 보호를 위한 정책 및 가이드라인입니다.', 1, NOW(), NULL),
('계정 복구 약관', '계정 분실 시 복구 절차에 대한 약관입니다.', 1, NOW(), NULL),
('운영 정책 및 가이드라인', '서비스 운영 전반에 대한 상세 정책입니다.', 1, NOW(), NULL);


INSERT INTO `tbl_report_type` (`name`) VALUES
('기사 불친절/태도 문제'),
('기사 운전 미숙/난폭 운전'),
('픽업 지연/약속 불이행'),
('서비스 품질 불만'),
('웹/앱 오류 발생'),
('결제 및 환불 관련 문의'),
('개인정보 유출 의심'),
('불법 광고/스팸 신고'),
('기타 서비스 관련 문의'),
('물품 파손/분실');


INSERT INTO `tbl_pickup_cancellation_code` (`requested_date`, `approved_date`, `cancellation_detail`, `is_refunded`, `is_payment_canceled`) VALUES
(DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), '개인 사정으로 인한 픽업 취소', 1, 1),
(DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY), '시간 착오로 인한 요청', 1, 1),
(DATE_SUB(NOW(), INTERVAL 1 DAY), NULL, '기사 배정 지연으로 인한 취소 요청', 0, 0),
(DATE_SUB(NOW(), INTERVAL 10 HOUR), DATE_SUB(NOW(), INTERVAL 8 HOUR), '주소 오기입으로 인한 취소', 1, 1),
(DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), '물품 준비 미완료', 1, 1),
(DATE_SUB(NOW(), INTERVAL 1 WEEK), DATE_SUB(NOW(), INTERVAL 6 DAY), '고객 요청으로 인한 긴급 취소', 1, 1),
(DATE_SUB(NOW(), INTERVAL 12 HOUR), NULL, '기사-고객 간 소통 오류', 0, 0),
(DATE_SUB(NOW(), INTERVAL 5 HOUR), DATE_SUB(NOW(), INTERVAL 4 HOUR), '다른 운송 수단 이용 결정', 1, 1),
(DATE_SUB(NOW(), INTERVAL 3 WEEK), DATE_SUB(NOW(), INTERVAL 2 WEEK), '날짜 변경 필요', 1, 1),
(DATE_SUB(NOW(), INTERVAL 7 HOUR), NULL, '결제 오류로 인한 취소 후 재요청', 0, 0);


INSERT INTO `tbl_common_group` (`group_description`, `group_name`) VALUES
('픽업 요청 시 물품의 종류를 분류합니다.', '물품 카테고리'),
('픽업 서비스 상태를 구분합니다.', '서비스 상태'),
('알림 메시지의 유형을 분류합니다.', '알림 유형'),
('결제 수단을 분류합니다.', '결제 수단'),
('배송 완료 후의 상태를 분류합니다.', '배송 후 상태'),
('기사 휴무 사유를 분류합니다.', '휴무 사유'),
('관리자 시스템 로그 유형', '시스템 로그'),
('할인 및 프로모션 코드 유형', '프로모션 유형'),
('앱 버전 및 업데이트 상태', '앱 버전'),
('고객 문의 유형 분류', '문의 분류');


INSERT INTO `tbl_admin_auth` (`read`, `edit`, `del`, `create`) VALUES
(1, 0, 0, 0), -- 뷰어(읽기 전용)
(1, 1, 0, 0), -- 일반 운영팀(읽기, 편집)
(1, 1, 1, 1), -- 슈퍼 관리자(모든 권한)
(1, 0, 0, 1), -- 콘텐츠 생성자(읽기, 생성)
(0, 0, 1, 0), -- 삭제 전용
(1, 1, 0, 1), -- 개발/기술팀
(1, 1, 1, 0), -- 데이터 관리팀
(0, 0, 0, 0), -- 비활성 계정
(1, 0, 1, 0), -- 감사팀(읽기, 삭제)
(1, 1, 1, 1); -- 시스템 관리자(최고 권한)






INSERT INTO `tbl_driver` (`driver_nm`, `driver_gen`, `driver_age`, `driver_phnum`, `driver_license_typ`, `entry_dt`, `salary`, `region_code`, `crtn_dt`, `mdfc_dt`) VALUES
('홍길동', 'M', 35, '010-1000-1000', '1종 보통', '2020-03-01', 40000000, 1, NOW(), NULL),
('김민지', 'F', 28, '010-2000-2000', '2종 자동', '2021-08-15', 38000000, 2, NOW(), NULL),
('박서준', 'M', 42, '010-3000-3000', '1종 대형', '2019-01-20', 45000000, 3, NOW(), NULL),
('이하늘', 'F', 31, '010-4000-4000', '2종 자동', '2022-05-10', 39000000, 4, NOW(), NULL),
('최강민', 'M', 50, '010-5000-5000', '1종 보통', '2018-11-25', 48000000, 5, NOW(), NULL),
('정유미', 'F', 26, '010-6000-6000', '2종 자동', '2023-02-01', 37000000, 6, NOW(), NULL),
('강호동', 'M', 45, '010-7000-7000', '1종 대형', '2017-06-12', 46000000, 7, NOW(), NULL),
('윤아름', 'F', 33, '010-8000-8000', '2종 자동', '2020-10-01', 41000000, 8, NOW(), NULL),
('신동우', 'M', 38, '010-9000-9000', '1종 보통', '2021-04-05', 42000000, 9, NOW(), NULL),
('오영주', 'F', 29, '010-0000-0000', '2종 자동', '2023-11-01', 36000000, 10, NOW(), NULL);


INSERT INTO `tbl_admin` (`admin_id`, `admin_pw`, `admin_nm`, `admin_phnum`, `admin_email`, `admin_birth`, `admin_gen`, `athr_code`, `crtn_dt`, `mdfc_dt`) VALUES
('admin_root', 'admin_hash_01', '이재석', '010-1111-1111', 'root@carrotgo.com', '1980-01-01', 'M', 3, NOW(), NULL), -- 슈퍼 관리자
('op_manager', 'admin_hash_02', '최지수', '010-2222-2222', 'op@carrotgo.com', '1992-05-15', 'F', 2, NOW(), NULL), -- 일반 운영팀
('data_analyst', 'admin_hash_03', '김태형', '010-3333-3333', 'data@carrotgo.com', '1985-11-20', 'M', 7, NOW(), NULL), -- 데이터 관리팀
('content_writer', 'admin_hash_04', '박은영', '010-4444-4444', 'content@carrotgo.com', '1998-03-10', 'F', 4, NOW(), NULL), -- 콘텐츠 생성자
('viewer_01', 'admin_hash_05', '정준호', '010-5555-5555', 'view1@carrotgo.com', '1975-07-25', 'M', 1, NOW(), NULL), -- 뷰어
('dev_team', 'admin_hash_06', '한승연', '010-6666-6666', 'dev@carrotgo.com', '1993-09-12', 'F', 6, NOW(), NULL), -- 개발/기술팀
('auditor_01', 'admin_hash_07', '신민철', '010-7777-7777', 'audit@carrotgo.com', '1982-04-22', 'M', 9, NOW(), NULL), -- 감사팀
('op_staff_01', 'admin_hash_08', '배수지', '010-8888-8888', 'op_stf1@carrotgo.com', '1996-12-05', 'F', 2, NOW(), NULL), -- 일반 운영팀
('system_manager', 'admin_hash_09', '윤성현', '010-9999-9999', 'sys@carrotgo.com', '1988-06-30', 'M', 10, NOW(), NULL), -- 시스템 관리자
('inactive_acc', 'admin_hash_10', '황보라', '010-0000-0000', 'inactive@carrotgo.com', '1990-10-18', 'F', 8, NOW(), NULL); -- 비활성 계정


INSERT INTO `tbl_address` (`detail_addr`, `postal_code`, `addr_alias`, `user_code`) VALUES
('서울 강남구 테헤란로 123, 101호', '06130', '회사 주소', 1),
('서울 마포구 월드컵로 250, 502호', '03900', '집 주소', 2),
('경기 성남시 분당구 판교역로 10', '13494', '본가 주소', 3),
('인천 연수구 송도과학로 30', '21984', '대학교 기숙사', 4),
('부산 해운대구 센텀시티로 78, 201동 101호', '48058', '부산 별장', 5),
('대구 수성구 동대구로 99, 105동 503호', '42126', '친척 집', 6),
('대전 유성구 대덕대로 1200', '34141', '대전 거주지', 7),
('광주 서구 상무대로 500, 3층', '61947', '사무실 주소', 8),
('울산 남구 삼산로 10, 707호', '44604', '친구 집', 9),
('세종특별자치시 한누리대로 100, 202호', '30151', '세종 아파트', 10);


INSERT INTO `tbl_inquiry` (`inquiry_title`, `inquiry_detail`, `inquiry_stat`, `user_code`, `crtn_dt`, `mdfc_dt`) VALUES
('픽업 서비스 시간 변경 문의', '다음 주 화요일 픽업 시간을 2시간 늦추고 싶습니다.', '답변 완료', 1, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY)),
('기사님 불친절 신고', '기사님이 물건을 던지듯 놓았습니다. 확인 부탁드립니다.', '문의 등록', 2, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL),
('결제 수단 변경 오류', '결제 수단을 바꾸려는데 계속 오류가 발생합니다.', '답변 완료', 3, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
('배송 지역 확대 요청', '현재 살고 있는 지역으로도 서비스를 확대해주세요.', '문의 등록', 4, DATE_SUB(NOW(), INTERVAL 2 DAY), NULL),
('회원 탈퇴 방법 문의', '계정을 비활성화하고 싶은데 방법을 알려주세요.', '답변 완료', 5, DATE_SUB(NOW(), INTERVAL 1 DAY), NOW()),
('파손 물품 보상 절차', '배송 중 물품이 파손되었습니다. 보상 절차를 알고 싶습니다.', '문의 등록', 6, NOW(), NULL),
('공지사항 확인 불가', '앱 내 공지사항 페이지가 로딩되지 않습니다.', '문의 등록', 7, NOW(), NULL),
('새로운 주소 등록 문제', '신규 주소를 등록하려는데 우편번호 검색이 안됩니다.', '문의 등록', 8, NOW(), NULL),
('서비스 이용료 문의', '픽업 서비스 이용료 책정 기준이 궁금합니다.', '답변 완료', 9, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
('장기 보관 서비스 요청', '물품을 1주일 정도 보관 후 배송하고 싶습니다.', '문의 등록', 10, NOW(), NULL);


INSERT INTO `tbl_common_code` (`detail_codename`, `group_code`) VALUES
('의류/잡화', 1), -- 물품 카테고리
('가전/디지털', 1), -- 물품 카테고리
('도서/문구', 1), -- 물품 카테고리
('요청 접수', 2), -- 서비스 상태
('픽업 진행 중', 2), -- 서비스 상태
('배송 완료', 2), -- 서비스 상태
('카드 결제', 4), -- 결제 수단
('무통장 입금', 4), -- 결제 수단
('카카오페이', 4), -- 결제 수단
('네이버페이', 4); -- 결제 수단


INSERT INTO `tbl_terms_version` (`version_number`, `change_description`, `crtn_dt`, `mdfc_dt`, `terms_code`) VALUES
('V1.0', '최초 서비스 이용약관 등록', '2020-01-01', NULL, 1), -- 서비스 이용약관
('V1.1', '개인정보 보호법 개정에 따른 내용 수정', '2022-03-15', NULL, 2), -- 개인정보 수집
('V1.0', '최초 위치기반 서비스 약관 등록', '2021-05-20', NULL, 3), -- 위치기반 서비스
('V2.0', '마케팅 정보 수신 범위 확대', '2023-01-01', NULL, 4), -- 마케팅 동의
('V1.2', '환불 수수료 정책 변경', '2023-11-01', NULL, 5), -- 환불 정책
('V1.0', '최초 차량 이용 수칙 등록', '2020-07-01', NULL, 6), -- 차량 이용 수칙
('V1.0', '최초 제3자 정보 제공 동의 약관 등록', '2022-09-01', NULL, 7), -- 제3자 정보 제공
('V1.0', '최초 청소년 보호 정책 등록', '2021-04-10', NULL, 8), -- 청소년 보호 정책
('V1.0', '최초 계정 복구 약관 등록', '2022-12-01', NULL, 9), -- 계정 복구 약관
('V2.1', '운영 정책 관련 고객 대응 절차 세분화', '2024-01-20', NULL, 10); -- 운영 정책


INSERT INTO `tbl_essential_terms` (`consent_stat`, `consent_dt`, `user_code`, `terms_code`) VALUES
('Y', NOW(), 1, 1), -- user 1, 서비스 이용약관 (필수)
('Y', NOW(), 1, 2), -- user 1, 개인정보 수집 (필수)
('Y', NOW(), 2, 1), -- user 2, 서비스 이용약관 (필수)
('Y', NOW(), 2, 2), -- user 2, 개인정보 수집 (필수)
('N', NOW(), 3, 3), -- user 3, 위치기반 서비스 (선택 - 동의 안 함)
('Y', NOW(), 4, 5), -- user 4, 환불 정책 (필수)
('Y', NOW(), 5, 6), -- user 5, 차량 이용 수칙 (필수)
('N', NOW(), 6, 4), -- user 6, 마케팅 동의 (선택 - 동의 안 함)
('Y', NOW(), 7, 8), -- user 7, 청소년 보호 정책 (필수)
('Y', NOW(), 8, 9); -- user 8, 계정 복구 약관 (필수)





INSERT INTO `tbl_notice` (`notice_code`,`title`, `content`, `is_pin`, `admin_code`, `crtn_dt`, `mdfc_dt`) VALUES
(11,'서비스 약관 개정 안내 (2025년 1월 1일 시행)', '서비스 이용약관이 개정되어 주요 변경 사항을 안내드립니다.', 1, 3, NOW(), NULL),
(12,'추석 연휴 픽업/배송 일정 안내', '추석 연휴 기간에는 픽업 및 배송 일정이 조정되오니 참고 바랍니다.', 1, 2, DATE_SUB(NOW(), INTERVAL 1 MONTH), NULL),
(13,'개인정보처리방침 변경 고지', '더 나은 서비스 제공을 위해 개인정보처리방침이 일부 변경됩니다.', 0, 1, DATE_SUB(NOW(), INTERVAL 2 WEEK), NULL),
(14,'앱 업데이트 (V2.1.0) 주요 변경사항', '앱 기능 개선 및 버그 수정 사항을 확인해주세요.', 0, 6, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL),
(15,'기사 안전 교육 의무화 안내', '모든 기사님은 분기별 안전 교육을 이수해야 합니다.', 1, 9, NOW(), NULL),
(16,'Carrot Go 신규 지역 서비스 오픈 (부산)', '부산 해운대구 지역에서 서비스를 시작합니다.', 0, 2, DATE_SUB(NOW(), INTERVAL 3 WEEK), NULL),
(17,'시스템 점검으로 인한 서비스 일시 중단 안내', '안정적인 서비스 제공을 위해 새벽 시간 점검을 실시합니다.', 0, 6, DATE_SUB(NOW(), INTERVAL 2 DAY), NULL),
(18,'겨울철 운행 주의사항 공지', '빙판길 및 폭설에 대비하여 안전 운전을 부탁드립니다.', 0, 1, DATE_SUB(NOW(), INTERVAL 4 MONTH), NULL),
(19,'고객센터 운영 시간 변경 안내', '평일 고객센터 운영 시간이 1시간 단축됩니다.', 0, 2, NOW(), NULL),
(20,'자주 묻는 질문(FAQ) 업데이트', '자주 묻는 질문 10개가 추가되었습니다.', 0, 3, DATE_SUB(NOW(), INTERVAL 1 WEEK), NULL);


INSERT INTO `tbl_performance_data` (`avrg_rating`, `pickup_comp_num`, `mdfc_dt`, `driver_code`) VALUES
(4, 150, NOW(), 1), -- 홍길동
(5, 80, NOW(), 2), -- 김민지
(4, 220, NOW(), 3), -- 박서준
(4, 95, NOW(), 4), -- 이하늘
(5, 300, NOW(), 5), -- 최강민
(3, 50, NOW(), 6), -- 정유미
(5, 180, NOW(), 7), -- 강호동
(4, 110, NOW(), 8), -- 윤아름
(4, 160, NOW(), 9), -- 신동우
(5, 75, NOW(), 10); -- 오영주


INSERT INTO `tbl_month_settle` (`salary`, `meal_allow`, `natl_pension`, `helth_ins`, `emp_ins`, `ind_ins`, `bonus`, `sttl_mnt`, `paymn_dt`, `driver_code`) VALUES
(4000000, 300000, 180000, 120000, 50000, 10000, 500000, '2025-10-01', '2025-10-25', 1),
(3800000, 300000, 170000, 110000, 45000, 9000, 300000, '2025-10-01', '2025-10-25', 2),
(4500000, 300000, 200000, 130000, 55000, 12000, 800000, '2025-10-01', '2025-10-25', 3),
(3900000, 300000, 175000, 115000, 48000, 9500, NULL, '2025-10-01', '2025-10-25', 4),
(4800000, 300000, 210000, 140000, 60000, 13000, 1000000, '2025-10-01', '2025-10-25', 5),
(3700000, 300000, 165000, 105000, 42000, 8500, NULL, '2025-10-01', '2025-10-25', 6),
(4600000, 300000, 205000, 135000, 57000, 12500, 900000, '2025-10-01', '2025-10-25', 7),
(4100000, 300000, 185000, 125000, 52000, 10500, 400000, '2025-10-01', '2025-10-25', 8),
(4200000, 300000, 190000, 128000, 53000, 10800, 600000, '2025-10-01', '2025-10-25', 9),
(3600000, 300000, 160000, 100000, 40000, 8000, NULL, '2025-10-01', '2025-10-25', 10);


INSERT INTO `tbl_driver_sch` (`work_date`, `start_time`, `end_time`, `is_off`, `driver_code`) VALUES
('2025-11-17', '09:00:00', '18:00:00', 0, 1),
('2025-11-17', '10:00:00', '19:00:00', 0, 2),
('2025-11-17', '12:00:00', '21:00:00', 0, 3),
('2025-11-18', '08:00:00', '17:00:00', 0, 4),
('2025-11-18', '09:00:00', '18:00:00', 0, 5),
('2025-11-18', '00:00:00', '00:00:00', 1, 6), -- 휴무
('2025-11-19', '11:00:00', '20:00:00', 0, 7),
('2025-11-19', '09:00:00', '18:00:00', 0, 8),
('2025-11-19', '00:00:00', '00:00:00', 1, 9), -- 휴무
('2025-11-20', '13:00:00', '22:00:00', 0, 10);


INSERT INTO `tbl_fuel_cost_mng` (`distance`, `date`, `cost`, `note`, `receipt_url`, `driver_code`) VALUES
(250, '2025-11-10', 55000, '고속도로 주행 많음', 'http://receipt.url/d1_f1', 1),
(180, '2025-11-12', 40000, NULL, 'http://receipt.url/d2_f2', 2),
(300, '2025-11-08', 65000, '경유차량', 'http://receipt.url/d3_f3', 3),
(150, '2025-11-15', 35000, '시내 주행 위주', 'http://receipt.url/d4_f4', 4),
(350, '2025-11-05', 70000, '장거리 운행', 'http://receipt.url/d5_f5', 5),
(100, '2025-11-13', 25000, '주유량 적음', 'http://receipt.url/d6_f6', 6),
(280, '2025-11-09', 60000, NULL, 'http://receipt.url/d7_f7', 7),
(190, '2025-11-14', 42000, '주말 주유', 'http://receipt.url/d8_f8', 8),
(210, '2025-11-07', 48000, NULL, 'http://receipt.url/d9_f9', 9),
(130, '2025-11-11', 32000, '출퇴근용', 'http://receipt.url/d10_f10', 10);


INSERT INTO `tbl_pickup_stat` (`pickup_stat`, `delivery_stat`, `note`, `updated_at`, `addr_code`, `driver_code`) VALUES
('픽업 완료', '배송 중', '물품 상태 양호', NOW(), 1, 1),
('픽업 대기', '배송 대기', NULL, DATE_SUB(NOW(), INTERVAL 1 HOUR), 2, 2),
('픽업 중', '배송 전', '교통 체증으로 10분 지연', DATE_SUB(NOW(), INTERVAL 30 MINUTE), 3, 3),
('픽업 완료', '배송 완료', '수령인 부재로 경비실 보관', DATE_SUB(NOW(), INTERVAL 2 DAY), 4, 4),
('픽업 완료', '배송 중', NULL, DATE_SUB(NOW(), INTERVAL 5 HOUR), 5, 5),
('픽업 실패', '배송 전', '고객 취소 요청', DATE_SUB(NOW(), INTERVAL 1 DAY), 6, 6),
('픽업 대기', '배송 대기', '판매자 연락 두절', DATE_SUB(NOW(), INTERVAL 2 HOUR), 7, 7),
('픽업 중', '배송 전', NULL, NOW(), 8, 8),
('픽업 완료', '배송 완료', '직접 전달 완료', DATE_SUB(NOW(), INTERVAL 3 DAY), 9, 9),
('픽업 대기', '배송 대기', '내일 픽업 예정', DATE_SUB(NOW(), INTERVAL 10 HOUR), 10, 10);


INSERT INTO `tbl_inquiry_ans` (`content`, `inquiry_code`, `admin_code`, `crtn_dt`, `mdfc_dt`) VALUES
('요청하신 픽업 시간 변경 처리 완료되었습니다.', 1, 2, DATE_SUB(NOW(), INTERVAL 6 DAY), NULL),
('기사님 불친절 신고 접수되었으며, 내부적으로 조치 후 피드백 드리겠습니다.', 2, 8, NOW(), NULL),
('결제 수단 변경 오류는 시스템 재부팅 후 해결되었습니다. 다시 시도해 주세요.', 3, 6, DATE_SUB(NOW(), INTERVAL 3 DAY), NULL),
('배송 지역 확대는 현재 검토 중에 있으며, 확정 시 공지하겠습니다.', 4, 2, NOW(), NULL),
('회원 탈퇴는 마이페이지 > 설정에서 진행하실 수 있습니다.', 5, 2, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL),
('파손 물품 보상 절차는 [링크]에서 확인하실 수 있으며, 담당 부서로 연결해드리겠습니다.', 6, 8, NOW(), NULL),
('공지사항 로딩 오류는 일시적인 현상으로 현재는 정상화되었습니다.', 7, 6, NOW(), NULL),
('신규 주소 등록 시 우편번호 검색 시스템을 확인하고 있습니다. 불편을 드려 죄송합니다.', 8, 3, NOW(), NULL),
('서비스 이용료는 거리에 따라 차등 적용되며, 상세 기준은 공지사항을 참고해 주세요.', 9, 2, DATE_SUB(NOW(), INTERVAL 8 DAY), NULL),
('장기 보관 서비스는 현재 제공하고 있지 않습니다. 양해 부탁드립니다.', 10, 8, NOW(), NULL);


INSERT INTO `tbl_report` (`content`, `type_code`, `user_code`, `admin_code`, `crtn_dt`, `mdfc_dt`) VALUES
('픽업 기사님이 통화 중 반말을 사용했습니다. 불쾌했습니다.', 1, 2, 2, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL),
('운행 중 급정거를 너무 많이 하여 불안했습니다.', 2, 4, 7, DATE_SUB(NOW(), INTERVAL 3 DAY), NULL),
('픽업 예정 시간보다 30분 늦게 도착했습니다. 사전 연락도 없었습니다.', 3, 1, 8, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL),
('배송된 물품의 포장이 뜯겨져 있었습니다.', 10, 6, 2, NOW(), NULL),
('앱을 실행하면 갑자기 종료되는 현상이 반복됩니다.', 5, 3, 6, NOW(), NULL),
('제 개인정보가 유출되었다는 스팸 문자를 받았습니다.', 7, 5, 3, DATE_SUB(NOW(), INTERVAL 2 WEEK), NULL),
('Carrot Go를 사칭하는 불법 광고를 발견했습니다.', 8, 7, 7, DATE_SUB(NOW(), INTERVAL 4 DAY), NULL),
('결제 금액이 청구서와 다르게 나왔습니다. 확인 부탁드립니다.', 6, 8, 8, NOW(), NULL),
('서비스 이용에 대한 전반적인 불만 사항입니다. 담당자 연락 바랍니다.', 4, 9, 2, DATE_SUB(NOW(), INTERVAL 1 WEEK), NULL),
('기타: 차량 내부가 청결하지 않았습니다.', 9, 10, 7, NOW(), NULL);


INSERT INTO `tbl_pickup_history` (`pickup_addr`, `shipping_addr`, `request_dt`, `allotment_dt`, `complet_dt`, `user_code`, `region_code`, `driver_code`, `category_code`, `product_code`, `pay_code`, `stat_code`) VALUES
('서울시 서초구 서초동 185호', '서울 영등포구 여의도동 125호', CURDATE() - INTERVAL 4 DAY, NULL, NULL, 11, 10, 10, 1,5,13,8);


INSERT INTO `tbl_driver_report` (`report_code`, `driver_code`) VALUES
(1, 1), -- 신고 1 (기사 불친절) -> 기사 1
(2, 3), -- 신고 2 (운전 미숙) -> 기사 3
(3, 10), -- 신고 3 (픽업 지연) -> 기사 10
(4, 5), -- 신고 4 (물품 파손) -> 기사 5
(9, 2), -- 신고 9 (서비스 불만) -> 기사 2
(1, 4), -- 신고 1 (기사 불친절) -> 기사 4
(2, 6), -- 신고 2 (운전 미숙) -> 기사 6
(3, 8), -- 신고 3 (픽업 지연) -> 기사 8
(4, 7), -- 신고 4 (물품 파손) -> 기사 7
(9, 9); -- 신고 9 (서비스 불만) -> 기사 9


INSERT INTO `tbl_notification_code` (`notification_content`, `send_time`, `is_checked`, `receiver_type`, `receiver_code`, `pickup_code`) VALUES
('픽업 요청이 성공적으로 접수되었습니다.', NOW() - INTERVAL 5 DAY, 1, 'USER', '1', 1),
('기사님 배정이 완료되었습니다. (담당: 김민지 기사님)', NOW() - INTERVAL 4 DAY, 1, 'USER', '2', 2),
('픽업 기사가 곧 도착합니다.', NOW() - INTERVAL 3 DAY, 0, 'DRIVER', '7', 3),
('픽업이 완료되었습니다. 배송을 시작합니다.', NOW() - INTERVAL 2 DAY, 1, 'USER', '4', 4),
('배송이 완료되었습니다. 확인해 주세요.', NOW() - INTERVAL 1 DAY, 1, 'USER', '5', 5),
('픽업 요청이 취소되었습니다. 상세 내용은 고객센터 문의 바랍니다.', NOW() - INTERVAL 10 DAY, 1, 'USER', '6', 6),
('오늘의 운행 스케줄을 확인해 주세요.', NOW() - INTERVAL 7 DAY, 1, 'DRIVER', '4', 7),
('배송 지역 변경이 필요합니다.', NOW() - INTERVAL 6 DAY, 0, 'DRIVER', '6', 8),
('결제가 성공적으로 승인되었습니다.', NOW() - INTERVAL 5 DAY, 1, 'USER', '9', 9),
('리뷰를 작성하고 포인트를 받아가세요!', NOW() - INTERVAL 4 DAY, 0, 'USER', '10', 10);


INSERT INTO `tbl_payment` (`amount`, `payment_method`, `is_paid`, `pay_date`, `pickup_code`) VALUES
(12000, '카드 결제', 1, NOW() - INTERVAL 3 DAY, 1),
(18500, '무통장 입금', 1, NOW() - INTERVAL 2 DAY, 2),
(15000, '카카오페이', 1, NOW() - INTERVAL 1 DAY, 3),
(9900, '네이버페이', 1, NOW(), 4),
(21000, '카드 결제', 1, NOW() - INTERVAL 10 HOUR, 5),
(13500, '무통장 입금', 0, NOW() - INTERVAL 5 DAY, 6), -- 결제 미완료 (또는 취소된 주문)
(10000, '카드 결제', 1, NOW() - INTERVAL 7 DAY, 7),
(17000, '카카오페이 5', 1, NOW() - INTERVAL 6 DAY, 8),
(25000, '네이버페이', 1, NOW() - INTERVAL 4 DAY, 9),
(11000, '카드 결제', 1, NOW() - INTERVAL 3 DAY, 10);


INSERT INTO `tbl_review` (`review_grade`, `review_detail`, `crtn_dt`, `mdfc_dt`, `driver_code`, `user_code`, `pickup_code`) VALUES
(5, '매우 친절하고 신속하게 픽업해주셨습니다.', NOW() - INTERVAL 2 DAY, NULL, 1, 1, 1),
(4, '물품을 안전하게 전달받았습니다. 감사합니다.', NOW() - INTERVAL 1 DAY, NULL, 5, 2, 2),
(5, '정확한 시간에 도착하셨고, 안내도 친절했습니다.', NOW() - INTERVAL 12 HOUR, NULL, 7, 3, 3),
(3, '픽업 시간이 15분 정도 지연되어 아쉬웠습니다.', NOW() - INTERVAL 5 HOUR, NULL, 9, 4, 4),
(5, '완벽한 서비스입니다. 기사님 최고!', NOW() - INTERVAL 20 HOUR, NULL, 2, 5, 5),
(1, '기사님이 운전 중 통화를 너무 오래 하셨습니다.', NOW() - INTERVAL 8 DAY, NULL, 3, 6, 6),
(5, '새벽 픽업이었는데도 빠르고 정확했습니다.', NOW() - INTERVAL 5 DAY, NULL, 4, 7, 7),
(4, '물품 포장이 조금 훼손되었지만, 배송은 빨랐습니다.', NOW() - INTERVAL 3 DAY, NULL, 6, 8, 8),
(5, '다음에 또 이용할 의사 있습니다. 만족합니다.', NOW() - INTERVAL 2 DAY, NULL, 8, 9, 9),
(4, '배송 상태는 좋았으나, 기사님이 급하게 가시는 듯했습니다.', NOW() - INTERVAL 1 DAY, NULL, 10, 10, 10);


INSERT INTO `tbl_refund` (`is_refund_completed`, `refund_completed_date`, `cancellation_code`, `paymn_code`) VALUES
(1, NOW() - INTERVAL 3 DAY, 1, 1), -- 취소 1, 결제 1에 대한 환불 완료
(1, NOW() - INTERVAL 2 DAY, 2, 2), -- 취소 2, 결제 2에 대한 환불 완료
(0, NULL, 3, 3), -- 취소 3 (아직 승인 전) -> 결제 3
(1, NOW(), 4, 4), -- 취소 4, 결제 4에 대한 환불 완료
(1, NOW() - INTERVAL 1 DAY, 5, 5), -- 취소 5, 결제 5에 대한 환불 완료
(1, NOW() - INTERVAL 6 DAY, 6, 7), -- 취소 6, 결제 7에 대한 환불 완료
(0, NULL, 7, 8), -- 취소 7 (아직 승인 전) -> 결제 8
(1, NOW() - INTERVAL 4 DAY, 8, 9), -- 취소 8, 결제 9에 대한 환불 완료
(1, NOW() - INTERVAL 10 DAY, 9, 10), -- 취소 9, 결제 10에 대한 환불 완료
(0, NULL, 10, 6); -- 취소 10 (아직 승인 전) -> 결제 6 (이 결제는 미완료였으므로 환불 처리 자체가 대기일 수 있음)


INSERT INTO `tbl_review_files` (`file_path`, `review_code`) VALUES
('http://files.carrotgo.com/review/1/photo_1.jpg', 1),
('http://files.carrotgo.com/review/2/photo_a.png', 2),
('http://files.carrotgo.com/review/3/photo_b.jpg', 3),
('http://files.carrotgo.com/review/4/photo_c.jpeg', 4),
('http://files.carrotgo.com/review/5/photo_d.jpg', 5),
('http://files.carrotgo.com/review/6/photo_e.png', 6),
('http://files.carrotgo.com/review/7/photo_f.jpg', 7),
('http://files.carrotgo.com/review/8/photo_g.jpg', 8),
('http://files.carrotgo.com/review/8/photo_h.jpg', 8), -- 리뷰 8은 사진 2장
('http://files.carrotgo.com/review/9/photo_i.jpg', 9);


select * from tbl_common_group;


/*************************************************************************************************
회원가입
*************************************************************************************************/

-- 1. 아이디가 중복값이 있는지 (select)
SELECT * FROM tbl_user WHERE user_id = 'qew032';

-- 2. 회원 가입 (insert)
INSERT INTO `tbl_user` (`user_id`, `user_pw`, `user_nm`, `user_phnum`, `user_email`, `user_birth`, `user_gen`, `crtn_dt`, `mdfc_dt`) VALUES
('qew032', 'apqktmfjqrp12!', '윤성원', '010-6669-7974', 'qew032@naver.com', '1992-03-14', 'M', NOW(), NULL);

-- 3. INSERT 확인
SELECT * FROM tbl_user;

/**********************************************************************************************************
로그인 SELECT 본인의 정보를 조회할 수 있다.
**********************************************************************************************************/
SELECT
    user_id AS '아이디',
    user_phnum AS '핸드폰번호',
    user_email AS '이메일',
    user_birth '생년월일',
    user_gen '성별'
FROM
    tbl_user
WHERE
    user_id = 'qew032'
AND
    user_pw = 'apqktmfjqrp12!';



/**********************************************************************************************************
이름과 이메일 또는 휴대폰 인증을 통해 아이디를 조회할 수 있다.
**********************************************************************************************************/
SELECT
    user_id,
    user_nm
FROM
    tbl_user
WHERE
    user_nm = '윤성원'
AND
    user_email = 'qew032@naver.com'
OR
    user_phnum = '010-6669-7974';

/**********************************************************************************************************
비밀번호 찾기
**********************************************************************************************************/
UPDATE
    tbl_user
SET
    user_pw = 'rnflapqk12!@'
WHERE
    user_id = 'qew032';

SELECT * FROM tbl_user;

/**********************************************************************************************************
신고 작성
**********************************************************************************************************/
INSERT INTO `tbl_report` (`content`, `type_code`, `user_code`, `admin_code`, `crtn_dt`, `mdfc_dt`) VALUES
('픽업 기사님이 통화 중 반말을 사용했습니다. 불쾌했습니다.', 1, 2, 2, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL),
('운행 중 급정거를 너무 많이 하여 불안했습니다.', 2, 4, 7, DATE_SUB(NOW(), INTERVAL 3 DAY), NULL),
('픽업 예정 시간보다 30분 늦게 도착했습니다. 사전 연락도 없었습니다.', 3, 1, 8, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL),
('배송된 물품의 포장이 뜯겨져 있었습니다.', 10, 6, 2, NOW(), NULL),
('앱을 실행하면 갑자기 종료되는 현상이 반복됩니다.', 5, 3, 6, NOW(), NULL),
('제 개인정보가 유출되었다는 스팸 문자를 받았습니다.', 7, 5, 3, DATE_SUB(NOW(), INTERVAL 2 WEEK), NULL),
('Carrot Go를 사칭하는 불법 광고를 발견했습니다.', 8, 7, 7, DATE_SUB(NOW(), INTERVAL 4 DAY), NULL),
('결제 금액이 청구서와 다르게 나왔습니다. 확인 부탁드립니다.', 6, 8, 8, NOW(), NULL),
('서비스 이용에 대한 전반적인 불만 사항입니다. 담당자 연락 바랍니다.', 4, 9, 2, DATE_SUB(NOW(), INTERVAL 1 WEEK), NULL),
('기타: 차량 내부가 청결하지 않았습니다.', 9, 10, 7, NOW(), NULL);

/**********************************************************************************************************
마이페이지 조회
*********************************************************************************************************/
SELECT
    *
FROM
    tbl_user u
JOIN
    tbl_address a ON (u.user_code = a.user_code)
JOIN
    tbl_inquiry i ON (u.user_code = i.user_code)
JOIN
    tbl_pickup_history p ON (u.user_code = p.user_code)
JOIN
    tbl_notification_code n ON (p.pickup_code = n.pickup_code);


/**********************************************************************************************************
마이페이지 수정
*********************************************************************************************************/
UPDATE
    tbl_address
SET
    detail_addr = '서울특별시 강남구 xxx대로'
WHERE
    addr_code = 7;

/**********************************************************************************************************
회원 탈퇴
*********************************************************************************************************/
DELETE FROM tbl_user WHERE user_id = 'qew032';

SELECT * FROM tbl_user;

/**********************************************************************************************************
문의 작성
*********************************************************************************************************/
INSERT INTO `tbl_inquiry` (`inquiry_title`, `inquiry_detail`, `inquiry_stat`, `user_code`, `crtn_dt`, `mdfc_dt`) VALUES
('예약 문의', '일주일 뒤 예약도 가능한지 궁금합니다.', '문의 등록', 10, NOW(), NOW());

/**********************************************************************************************************
리뷰 작성
**********************************************************************************************************/
INSERT INTO `tbl_review` (`review_grade`, `review_detail`, `crtn_dt`, `mdfc_dt`, `driver_code`, `user_code`, `pickup_code`) VALUES
(5, '전체적으로 너무 친절하고 좋았습니다.', NOW(), NULL, 6, 8, 10);

/**********************************************************************************************************
리뷰 조회
**********************************************************************************************************/
SELECT
    review_grade,
    review_detail
FROM
    tbl_review;

