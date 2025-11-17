DROP TABLE IF EXISTS `tbl_performance_data`;
DROP TABLE IF EXISTS `tbl_pickup_stat`;
DROP TABLE IF EXISTS `tbl_inquiry_ans`;
DROP TABLE IF EXISTS `tbl_essential_terms`;
DROP TABLE IF EXISTS `tbl_review_files`;
DROP TABLE IF EXISTS `tbl_month_settle`;
DROP TABLE IF EXISTS `tbl_refund`;
DROP TABLE IF EXISTS `tbl_review`;
DROP TABLE IF EXISTS `tbl_inquiry`;
DROP TABLE IF EXISTS `tbl_pickup_cancellation_code`;
DROP TABLE IF EXISTS `tbl_notice`;
DROP TABLE IF EXISTS `tbl_payment`;
DROP TABLE IF EXISTS `tbl_fuel_cost_mng`;
DROP TABLE IF EXISTS `tbl_driver_sch`;
DROP TABLE IF EXISTS `tbl_driver_report`;
DROP TABLE IF EXISTS `tbl_notification_code`;
DROP TABLE IF EXISTS `tbl_address`;
DROP TABLE IF EXISTS `tbl_terms_version`;
DROP TABLE IF EXISTS `tbl_pickup_history`;
DROP TABLE IF EXISTS `tbl_driver`;
DROP TABLE IF EXISTS `tbl_report`;
DROP TABLE IF EXISTS `tbl_user`;
DROP TABLE IF EXISTS `tbl_admin`;
DROP TABLE IF EXISTS `tbl_serv_reg`;
DROP TABLE IF EXISTS `tbl_admin_auth`;
DROP TABLE IF EXISTS `tbl_terms`;
DROP TABLE IF EXISTS `tbl_common_code`;
DROP TABLE IF EXISTS `tbl_common_group`;
DROP TABLE IF EXISTS `tbl_report_type`;


-- 1. 코어 마스터 테이블 (참조가 거의 없는 테이블)
CREATE TABLE `tbl_user` (
	`user_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '회원 코드',
	`user_id`	VARCHAR(100)	NOT NULL	COMMENT '중복되지 않는 아이디',
	`user_pw`	VARCHAR(255)	NOT NULL	COMMENT '비밀번호 암호화',
	`user_nm`	VARCHAR(50)	NOT NULL	COMMENT '사용자의 이름, 성 이름으로 표현 (홍길동)',
	`user_phnum`	VARCHAR(50)	NOT NULL	COMMENT '"010-1234-5678"형식으로 저장',
	`user_email`	VARCHAR(50)	NOT NULL	COMMENT '사용자의 이메일 주소',
	`user_birth`	DATE	NOT NULL	COMMENT '사용자 생년월일(DATE형식으로)',
	`user_gen`	CHAR(1)	NOT NULL	COMMENT '성별(M,F) + CHECK',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '정보가 생성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '정보가 수정된 날짜, 초기에는 빈 값'
);

CREATE TABLE `tbl_serv_reg` (
	`region_code`	INT AUTO_INCREMENT PRIMARY KEY NOT NULL	COMMENT '지역 코드',
	`region_nm`	VARCHAR(200)	NOT NULL	COMMENT '큰 그룹의 지역명',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '지역명이 생성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '지역명이 수정된 날짜'
);

CREATE TABLE `tbl_terms` (
	`terms_code`	INT PRIMARY KEY AUTO_INCREMENT NOT NULL	COMMENT '약관 코드',
	`terms_title`	VARCHAR(255)	NOT NULL	COMMENT '약관명',
	`terms_content`	VARCHAR(10000)	NOT NULL	COMMENT '약관 내용 전체',
	`is_required`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '필수 여부',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '약관 사항 생성한 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '기존에 있던 약관 사항 수정한 날짜'
);

CREATE TABLE `tbl_report_type` (
	`type_code`	INT PRIMARY KEY AUTO_INCREMENT	NULL	COMMENT '신고 유형 코드',
	`name`	VARCHAR(100)	NULL	COMMENT '픽업서비스 관련 신고
웹,앱 관련 신고'
);

CREATE TABLE `tbl_pickup_cancellation_code` (
	`cancellation_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '취소 요청 식별자 코드',
	`requested_date`	DATETIME	NOT NULL	COMMENT '고객이 취소를 요청한 날짜',
	`approved_date`	DATETIME	NULL	COMMENT '관리자가 취소를 승인한 날짜',
	`cancellation_detail`	VARCHAR(10000)	NULL	COMMENT '취소 사유 상세 설명',
	`is_refunded`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '결제 환불 처리 여부',
	`is_payment_canceled`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '결제된 주문인지 여부'
);

CREATE TABLE `tbl_common_group` (
	`group_code`	INT	PRIMARY KEY AUTO_INCREMENT NOT NULL	COMMENT '공통코드 그룹 식별자',
	`group_description`	VARCHAR(100)	NOT NULL	COMMENT '공통코드 그룹에 대한 설명',
	`group_name`	VARCHAR(255)	NOT NULL	COMMENT '공통코드 그룹명'
);

CREATE TABLE `tbl_admin_auth` (
	`athr_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '권한 코드',
	`read`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '읽기 권한 부여',
	`edit`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '편집 권한 부여',
	`del`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '삭제 권한 부여',
	`create`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '생성 권한 부여'
);


-- 2. 초기 참조 테이블 (레벨 1 의존성)
CREATE TABLE `tbl_driver` (
	`driver_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '기사 코드',
	`driver_nm`	VARCHAR(50)	NOT NULL	COMMENT '기사의 이름, 성 이름으로 표현 (홍길동)',
	`driver_gen`	CHAR(1)	NOT NULL	COMMENT '성별(M,F) + CHECK',
	`driver_age`	INT	NOT NULL	COMMENT '기사의 나이 정보',
	`driver_phnum`	VARCHAR(50)	NOT NULL	COMMENT '"010-1234-5678"형식으로 저장',
	`driver_license_typ`	CHAR(10)	NOT NULL	COMMENT '1종 보통, 1종 대형,  2종 자동, 2종 수동 등등',
	`entry_dt`	DATE	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '입사한 날짜(기본 값은 오늘 날짜)',
	`resig_dt`	DATE	NULL	COMMENT '퇴사한 날짜(기본 값은 오늘 날짜)',
	`salary`	INT	NOT NULL	COMMENT '기사의 급여 정보',
	`region_code`	INT	NOT NULL	COMMENT '지역 코드(AUTO_INCREMENT)',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '기사의 정보가 생성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '기사의 정보가 수정된 날짜',
	FOREIGN KEY (region_code)
				REFERENCES tbl_serv_reg(region_code)
);

CREATE TABLE `tbl_admin` (
	`admin_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '관리자 코드',
	`admin_id`	VARCHAR(100)	NOT NULL	COMMENT '중복되지 않는 아이디',
	`admin_pw`	VARCHAR(255)	NOT NULL	COMMENT '비밀번호 암호화',
	`admin_nm`	VARCHAR(50)	NOT NULL	COMMENT '관리자의 이름, 성 이름으로 표현 (홍길동)',
	`admin_phnum`	VARCHAR(50)	NOT NULL	COMMENT '"010-1234-5678"형식으로 저장',
	`admin_email`	VARCHAR(50)	NOT NULL	COMMENT '관리자의 이메일 주소',
	`admin_birth`	DATE	NOT NULL	COMMENT '관리자의 생년월일(DATE형식으로)',
	`admin_gen`	CHAR(1)	NOT NULL	COMMENT '성별(M,F) + CHECK',
	`athr_code`	INT	NOT NULL	COMMENT '권한 코드(참조)',
	`crtn_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '관리자 정보가 생성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '관리자 정보가 수정된 날짜',
	FOREIGN KEY (athr_code)
				REFERENCES tbl_admin_auth(athr_code)
);

CREATE TABLE `tbl_address` (
	`addr_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '주소 코드',
	`detail_addr`	VARCHAR(300)	NOT NULL	COMMENT '시,구,동 등 상세 주소 입력',
	`postal_code`	VARCHAR(10)	NOT NULL	COMMENT '전체 상세 주소의 우편번호',
	`addr_alias`	VARCHAR(50)	NOT NULL	COMMENT '주소 별 쉽게 찾을 수 있는 별칭',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(AUTO_INCREMENT)',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code)
);

CREATE TABLE `tbl_inquiry` (
	`inquiry_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '문의 코드',
	`inquiry_title`	VARCHAR(50)	NOT NULL	COMMENT '사용자가 작성한 문의의 제목',
	`inquiry_detail`	VARCHAR(500)	NULL	COMMENT '사용자가 작성한 문의의 내용',
	`inquiry_stat`	VARCHAR(50)	NOT NULL	COMMENT '문의 등록 또는 답변 완료',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(AUTO_INCREMENT)',
	`crtn_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '문의가 생성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '문의가 주정된 날짜',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code)
);

CREATE TABLE `tbl_common_code` (
	`detail_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '공통코드 상세값',
	`detail_codename`	VARCHAR(255)	NOT NULL	COMMENT '상세 코드명',
	`group_code`	INT	NOT NULL	COMMENT '공통코드 그룹 식별자(참조)',
	FOREIGN KEY (group_code)
				REFERENCES tbl_common_group(group_code)
);

CREATE TABLE `tbl_terms_version` (
	`version_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '약관 버전 코드',
	`version_number`	VARCHAR(50)	NOT NULL	COMMENT '약관 버전 번호',
	`change_description`	VARCHAR(10000)	NULL	COMMENT '변경 상세 내용',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '약관 버전 생성일',
	`mdfc_dt`	DATETIME	NULL	COMMENT '약관 업데이트 일자',
	`terms_code`	INT	NOT NULL	COMMENT '약관 코드(참조)',
	FOREIGN KEY (terms_code)
				REFERENCES tbl_terms(terms_code)
);

CREATE TABLE `tbl_essential_terms` (
	`cnsn_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '동의코드',
	`consent_stat`	CHAR(1)	NOT NULL	DEFAULT 'Y'	COMMENT '동의 여부(\'Y\' OR \'N\')',
	`consent_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '필수 약관에 동의한 날짜',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(참조)',
	`terms_code`	INT	NOT NULL	COMMENT '약관 코드(참조)',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code),
	FOREIGN KEY (terms_code)
				REFERENCES tbl_terms(terms_code)
);


-- 3. 중간 참조 테이블 (레벨 2 의존성)
CREATE TABLE `tbl_notice` (
	`notice_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '공지사항 코드',
	`title`	VARCHAR(200)	NOT NULL	COMMENT '관리자가 작성한 공지사항의 제목',
	`content`	VARCHAR(10000)	NOT NULL	COMMENT '관리자가 작성한 공지사항의 내용',
	`is_pin`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '상단에 고정할지 여부',
	`admin_code`	INT	NOT NULL	COMMENT '관리자 코드(AUTO_INCREMENT)',
	`crtn_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '관리자가 공지사항을 작성한 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '관리자가 공지사항을 수정한 날짜',
	FOREIGN KEY (admin_code)
				REFERENCES tbl_admin(admin_code)
);

CREATE TABLE `tbl_performance_data` (
	`perform_code`	INT PRIMARY KEY	AUTO_INCREMENT NOT NULL	COMMENT '실적 코드',
	`avrg_rating`	INT	NULL	COMMENT '리뷰의 평점이 추가되면 업데이트',
	`pickup_comp_num`	INT	NULL	COMMENT '픽업 완료가 되면 건당 업데이트',
	`mdfc_dt`	DATETIME	NULL	COMMENT '평점이나 픽업 완료가 업데이트 될 때의 수정일',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(AUTO_INCREMENT)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_month_settle` (
	`mnth_sttl_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '월별정산코드',
	`salary`	INT	NOT NULL	COMMENT '기사에게 지급된 기본 급여',
	`meal_allow`	INT	NOT NULL	COMMENT '기사에게 지급 된 식대',
	`natl_pension`	INT	NOT NULL	COMMENT '기사의 4대 보험',
	`helth_ins`	INT	NOT NULL	COMMENT '기사의 4대 보험',
	`emp_ins`	INT	NOT NULL	COMMENT '기사의 4대 보험',
	`ind_ins`	INT	NOT NULL	COMMENT '기사의 4대 보험',
	`bonus`	INT	NULL	COMMENT '지급 된 보너스',
	`sttl_mnt`	DATE	NOT NULL	COMMENT '급여가 정산 된 달',
	`paymn_dt`	DATE	NOT NULL	COMMENT '급여가 지급 된 일',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_driver_sch` (
	`sch_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '스케줄 코드',
	`work_date`	DATE	NOT NULL	COMMENT '기사의 근무 날짜',
	`start_time`	TIME	NOT NULL	COMMENT '기사의 근무 시작 시간',
	`end_time`	TIME	NOT NULL	COMMENT '기사의 근무 종료 시간',
	`is_off`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '기사의 휴무 여부',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_fuel_cost_mng` (
	`mng_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '관리 코드',
	`distance`	INT	NOT NULL	COMMENT '총 이동 거리',
	`date`	DATE	NOT NULL	COMMENT '주유를 한 날짜',
	`cost`	INT	NOT NULL	COMMENT '주유하는데 소비된 비용',
	`note`	VARCHAR(255)	NULL	COMMENT '특이사항',
	`receipt_url`	VARCHAR(2048)	NOT NULL	COMMENT '주유 영수증 url',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_pickup_stat` (
	`stat_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '픽업 상태 코드',
	`pickup_stat`	VARCHAR(50)	NOT NULL	COMMENT '현재 픽업 상태',
	`delivery_stat`	VARCHAR(50)	NOT NULL	COMMENT '현재 배송 상태',
	`note`	VARCHAR(255)	NULL	COMMENT '픽업과 배송 중 특이사항',
	`updated_at`	DATETIME	NOT NULL	COMMENT '픽업과 배송의 상태가 변할 때 일시',
	`addr_code`	INT	NOT NULL	COMMENT '주소 코드(참조)',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	FOREIGN KEY (addr_code)
				REFERENCES tbl_address(addr_code),
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_inquiry_ans` (
	`ans_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '답변 코드',
	`content`	VARCHAR(10000)	NOT NULL	COMMENT '사용자가 작성한 문의에 대한 답변 내용',
	`inquiry_code`	INT	NOT NULL	COMMENT '문의 코드(참조)',
	`admin_code`	INT	NOT NULL	COMMENT '관리자 코드(참조)',
	`crtn_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '답변이 작성된 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '답변이 수정된 날짜',
	FOREIGN KEY (inquiry_code)
				REFERENCES tbl_inquiry(inquiry_code),
	FOREIGN KEY (admin_code)
				REFERENCES tbl_admin(admin_code)
);

CREATE TABLE `tbl_report` (
	`report_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '신고 코드',
	`content`	VARCHAR(10000)	NOT NULL	COMMENT '사용자가 서비스나 기사에 대해 신고할 내용',
	`type_code`	INT	NULL	COMMENT '신고 유형 코드(참조)',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(참조)',
	`admin_code`	INT	NOT NULL	COMMENT '관리자 코드(참조)',
	`crtn_dt`	DATETIME	NOT NULL	DEFAULT CURRENT_DATE	COMMENT '신고를 작성한 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '신고가 수정된 날짜',
	FOREIGN KEY (type_code)
				REFERENCES tbl_report_type(type_code),
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code),
	FOREIGN KEY (admin_code)
				REFERENCES tbl_admin(admin_code)
);


-- 4. 핵심 트랜잭션 및 최종 테이블 (레벨 3+ 의존성)
CREATE TABLE `tbl_pickup_history` (
	`pickup_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '픽업 코드',
    `product_nm` VARCHAR(50) NOT NULL   COMMENT '물품의 이름',
	`pickup_addr`	VARCHAR(200)	NOT NULL	COMMENT '판매자가 물품을 전달 할 주소',
	`shipping_addr`	VARCHAR(200)	NOT NULL	COMMENT '구매자가 물품을 전달 받을 주소',
	`request_dt`	DATE	NOT NULL	COMMENT '픽업을 요청한 일시',
	`allotment_dt`	DATE	NULL	COMMENT '픽업 기사가 배정된 일시',
	`complet_dt`	DATE	NULL	COMMENT '기사가 픽업 후 배송까지 완료한 일시',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(참조)',
	`region_code`	INT	NOT NULL	COMMENT '지역 코드(참조)',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	`category_code`	INT	NOT NULL	COMMENT '공통코드 상세 - 카테고리코드',
    `product_code` INT NOT NULL     COMMENT '공통코드 상세 - 상품정보코드',
    `pay_code` INT NOT NULL     COMMENT '공통코드 상세 - 결제방식코드',
    `stat_code` INT NOT NULL    COMMENT '공통코드 상세 - 픽업상태코드',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code),
	FOREIGN KEY (region_code)
				REFERENCES tbl_serv_reg(region_code),
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code),
	FOREIGN KEY (category_code)
				REFERENCES tbl_common_code(detail_code),
    FOREIGN KEY (product_code)
				REFERENCES tbl_common_code(detail_code),
    FOREIGN KEY (pay_code)
				REFERENCES tbl_common_code(detail_code),
    FOREIGN KEY (stat_code)
				REFERENCES tbl_common_code(detail_code)

);

/*
alter table tbl_pickup_history add column product_nm varchar(50);
*/

CREATE TABLE `tbl_driver_report` (
	`report_code`	INT	NOT NULL	COMMENT '신고 코드(참조)',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	FOREIGN KEY (report_code)
				REFERENCES tbl_report(report_code),
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);

CREATE TABLE `tbl_notification_code` (
	`notification_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '알림 고유 식별자',
	`notification_content`	VARCHAR(10000)	NOT NULL	COMMENT '사용자에게 표시되는 알림 메시지',
	`send_time`	DATETIME	NOT NULL	COMMENT '알림이 발송된 실제 시각',
	`is_checked`	TINYINT	NULL	DEFAULT 0	COMMENT '알림문자 발송이 정상적으로 발송됐는지 확인여부',
	`receiver_type`	VARCHAR(200)	NOT NULL	COMMENT '알림 수신자 유형 1: 사용자 2: 기사',
	`receiver_code`	VARCHAR(200)	NOT NULL	COMMENT '회원 코드 or 기사 코드',
	`pickup_code`	INT	NOT NULL	COMMENT '관련 픽업 요청 코드',
	FOREIGN KEY (pickup_code)
				REFERENCES tbl_pickup_history(pickup_code)
);

CREATE TABLE `tbl_payment` (
	`paymn_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '결제 코드',
	`amount`	INT	NOT NULL	COMMENT '최종 결제된 금액',
	`payment_method`	VARCHAR(50)	NOT NULL	COMMENT '카드/무통장입금 등 결제 방식',
	`is_paid`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '결제 승인 완료 여부',
	`pay_date`	DATETIME	NOT NULL	COMMENT '결제가 완료된 시간',
	`pickup_code`	INT	NOT NULL	COMMENT '픽업 코드(AUTO_INCREMENT)',
	FOREIGN KEY (pickup_code)
				REFERENCES tbl_pickup_history(pickup_code)
);

CREATE TABLE `tbl_review` (
	`review_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '리뷰 코드',
	`review_grade`	INT	NOT NULL	COMMENT '사용자가 평가한 기사의 펑점',
	`review_detail`	VARCHAR(500)	NULL	COMMENT '서비스와 기사에 대한 리뷰',
	`crtn_dt`	DATETIME	NOT NULL	COMMENT '리뷰를 작성한 날짜',
	`mdfc_dt`	DATETIME	NULL	COMMENT '리뷰를 수정한 날짜',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(참조)',
	`user_code`	INT	NOT NULL	COMMENT '회원 코드(참조)',
	`pickup_code`	INT	NOT NULL	COMMENT '픽업 코드(참조)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code),
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code),
	FOREIGN KEY (pickup_code)
				REFERENCES tbl_pickup_history(pickup_code)
);

CREATE TABLE `tbl_refund` (
	`refund_code`	INT PRIMARY KEY AUTO_INCREMENT NOT NULL	COMMENT '환불 코드',
	`is_refund_completed`	TINYINT	NOT NULL	DEFAULT 0	COMMENT '환불 완료에 대한 Y/N',
	`refund_completed_date`	DATETIME	NULL	COMMENT '환불 완료 후 날짜',
	`cancellation_code`	INT	NOT NULL	COMMENT '환불 관련된 취소 코드',
	`paymn_code`	INT	NOT NULL	COMMENT '결제 코드(참조)',
	FOREIGN KEY (cancellation_code)
				REFERENCES tbl_pickup_cancellation_code(cancellation_code),
	FOREIGN KEY (paymn_code)
				REFERENCES tbl_payment(paymn_code)
);

CREATE TABLE `tbl_review_files` (
	`photo_code`	INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	COMMENT '사진 고유 식별자',
	`file_path`	VARCHAR(255)	NOT NULL	COMMENT '사진 파일 저장 경로',
	`review_code`	INT	NOT NULL	COMMENT '리뷰 코드(참조)',
	FOREIGN KEY (review_code)
				REFERENCES tbl_review(review_code)
);
