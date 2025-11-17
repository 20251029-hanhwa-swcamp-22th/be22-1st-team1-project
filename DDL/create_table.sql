

/**********************************************************************************************************
사용자 정보 테이블 생성
**********************************************************************************************************/


DROP TABLE IF EXISTS tbl_user;

CREATE TABLE `tbl_user` (
	`user_code`	    INT PRIMARY KEY AUTO_INCREMENT	        NOT NULL	                COMMENT '회원 코드',
	`user_id`	    VARCHAR(100)	                        NOT NULL	                COMMENT '중복되지 않는 아이디',
	`user_pw`	    VARCHAR(255)	                        NOT NULL	                COMMENT '비밀번호 암호화',
	`user_nm`	    VARCHAR(50)	                            NOT NULL	                COMMENT '사용자의 이름, 성 이름으로 표현 (홍길동)',
	`user_phnum`	VARCHAR(50)	                            NOT NULL	                COMMENT '"010-1234-5678"형식으로 저장',
	`user_email`	VARCHAR(50)	                            NOT NULL	                COMMENT '사용자의 이메일 주소',
	`user_birth`	DATE	                                NOT NULL	                COMMENT '사용자 생년월일(DATE형식으로)',
	`user_gen`	    CHAR(1)	                                NOT NULL	                COMMENT '성별(M,F) + CHECK',
	`crtn_dt`	    DATETIME	                            NOT NULL	                COMMENT '정보가 생성된 날짜',
	`mdfc_dt`	    DATETIME	                            NULL	                    COMMENT '정보가 수정된 날짜, 초기에는 빈 값'
);

SELECT * FROM tbl_user;

/**********************************************************************************************************
서비스 지역 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_serv_reg;

CREATE TABLE `tbl_serv_reg` (
	`region_code`	INT AUTO_INCREMENT PRIMARY KEY          NOT NULL	                COMMENT '지역 코드',
	`region_nm`	    VARCHAR(200)	                        NOT NULL	                COMMENT '큰 그룹의 지역명',
	`crtn_dt`	    DATETIME	                            NOT NULL	                COMMENT '지역명이 생성된 날짜',
	`mdfc_dt`	    DATETIME	                            NULL	                    COMMENT '지역명이 수정된 날짜'
);

/**********************************************************************************************************
약관정보 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_terms;

CREATE TABLE `tbl_terms` (
	`terms_code`	INT PRIMARY KEY AUTO_INCREMENT          NOT NULL	                COMMENT '약관 코드',
	`terms_title`	VARCHAR(255)	                        NOT NULL	                COMMENT '약관명',
	`terms_content`	VARCHAR(10000)	                        NOT NULL	                COMMENT '약관 내용 전체',
	`is_required`	TINYINT	NOT                             NULL	        DEFAULT 0	COMMENT '필수 여부',
	`crtn_dt`	    DATETIME	                            NOT NULL	                COMMENT '약관 사항 생성한 날짜',
	`mdfc_dt`	    DATETIME	                            NULL	                    COMMENT '기존에 있던 약관 사항 수정한 날짜'
);

/**********************************************************************************************************
신고유형 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_report_type;

CREATE TABLE `tbl_report_type` (
	`type_code`	INT PRIMARY KEY AUTO_INCREMENT	            NULL	                    COMMENT '신고 유형 코드',
	`name`	    VARCHAR(100)	                            NULL	                    COMMENT '픽업서비스 관련 신고
웹,앱 관련 신고'
);

/**********************************************************************************************************
픽업취소내역 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_pickup_cancellation_code;

CREATE TABLE `tbl_pickup_cancellation_code` (
	`cancellation_code`	    INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	                COMMENT '취소 요청 식별자 코드',
	`requested_date`	    DATETIME	                    NOT NULL	                COMMENT '고객이 취소를 요청한 날짜',
	`approved_date`	        DATETIME	                    NULL	                    COMMENT '관리자가 취소를 승인한 날짜',
	`cancellation_detail`	VARCHAR(10000)	                NULL	                    COMMENT '취소 사유 상세 설명',
	`is_refunded`	        TINYINT	                        NOT NULL	    DEFAULT 0	COMMENT '결제 환불 처리 여부',
	`is_payment_canceled`	TINYINT	                        NOT NULL	    DEFAULT 0	COMMENT '결제된 주문인지 여부'
);

/**********************************************************************************************************
공통코드그룹 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_common_group;

CREATE TABLE `tbl_common_group` (
	`group_code`	        INT	PRIMARY KEY AUTO_INCREMENT  NOT NULL	                COMMENT '공통코드 그룹 식별자',
	`group_description`	    VARCHAR(100)	                NOT NULL	                COMMENT '공통코드 그룹에 대한 설명',
	`group_name`	        VARCHAR(255)	                NOT NULL	                COMMENT '공통코드 그룹명'
);

/**********************************************************************************************************
관리자 권한 종류 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_admin_auth;

CREATE TABLE `tbl_admin_auth` (
	`athr_code`	        INT PRIMARY KEY AUTO_INCREMENT	    NOT NULL	                COMMENT '권한 코드',
	`read`	            TINYINT	                            NOT NULL	    DEFAULT 0	COMMENT '읽기 권한 부여',
	`edit`	            TINYINT	                            NOT NULL	    DEFAULT 0	COMMENT '편집 권한 부여',
	`del`	            TINYINT	                            NOT NULL	    DEFAULT 0	COMMENT '삭제 권한 부여',
	`create`	        TINYINT	                            NOT NULL	    DEFAULT 0	COMMENT '생성 권한 부여'
);

/**********************************************************************************************************
배달기사정보 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_driver;

CREATE TABLE `tbl_driver` (
	`driver_code`	        INT PRIMARY KEY AUTO_INCREMENT  NOT NULL	                COMMENT '기사 코드',
	`driver_nm`	            VARCHAR(50)	                    NOT NULL	                COMMENT '기사의 이름, 성 이름으로 표현 (홍길동)',
	`driver_gen`	        CHAR(1)	                        NOT NULL	                COMMENT '성별(M,F) + CHECK',
	`driver_age`	        INT	                            NOT NULL	                COMMENT '기사의 나이 정보',
	`driver_phnum`	        VARCHAR(50)	                    NOT NULL	                COMMENT '"010-1234-5678"형식으로 저장',
	`driver_license_typ`	CHAR(10)	                    NOT NULL	                COMMENT '1종 보통, 1종 대형,  2종 자동, 2종 수동 등등',
	`entry_dt`	            DATE	                        NOT NULL	    DEFAULT CURRENT_DATE	COMMENT '입사한 날짜(기본 값은 오늘 날짜)',
	`resig_dt`	            DATE	                        NULL	                    COMMENT '퇴사한 날짜(기본 값은 오늘 날짜)',
	`salary`	            INT	                            NOT NULL	                COMMENT '기사의 급여 정보',
	`region_code`	        INT	                            NOT NULL	                COMMENT '지역 코드(AUTO_INCREMENT)',
	`crtn_dt`	            DATETIME	                    NOT NULL	                COMMENT '기사의 정보가 생성된 날짜',
	`mdfc_dt`	            DATETIME	                    NULL	                    COMMENT '기사의 정보가 수정된 날짜',
	FOREIGN KEY (region_code)
				REFERENCES tbl_serv_reg(region_code)
);

select * from tbl_driver;

/**********************************************************************************************************
관리자정보 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_admin;

CREATE TABLE `tbl_admin` (
	`admin_code`	INT PRIMARY KEY AUTO_INCREMENT	        NOT NULL	                COMMENT '관리자 코드',
	`admin_id`	    VARCHAR(100)	                        NOT NULL	                COMMENT '중복되지 않는 아이디',
	`admin_pw`	    VARCHAR(255)	                        NOT NULL	                COMMENT '비밀번호 암호화',
	`admin_nm`	    VARCHAR(50)	                            NOT NULL	                COMMENT '관리자의 이름, 성 이름으로 표현 (홍길동)',
	`admin_phnum`	VARCHAR(50)	                            NOT NULL	                COMMENT '"010-1234-5678"형식으로 저장',
	`admin_email`	VARCHAR(50)	                            NOT NULL	                COMMENT '관리자의 이메일 주소',
	`admin_birth`	DATE	                                NOT NULL	                COMMENT '관리자의 생년월일(DATE형식으로)',
	`admin_gen`	    CHAR(1)	                                NOT NULL	                COMMENT '성별(M,F) + CHECK',
	`athr_code`	    INT	                                    NOT NULL	                COMMENT '권한 코드(참조)',
	`crtn_dt`	    DATETIME	                            NOT NULL	    DEFAULT CURRENT_DATE	COMMENT '관리자 정보가 생성된 날짜',
	`mdfc_dt`	    DATETIME	                            NULL	                    COMMENT '관리자 정보가 수정된 날짜',
	FOREIGN KEY (athr_code)
				REFERENCES tbl_admin_auth(athr_code)
);

/**********************************************************************************************************
주소록 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_address;

CREATE TABLE `tbl_address` (
	`addr_code`	    INT PRIMARY KEY AUTO_INCREMENT	        NOT NULL	                COMMENT '주소 코드',
	`detail_addr`	VARCHAR(300)	                        NOT NULL	                COMMENT '시,구,동 등 상세 주소 입력',
	`postal_code`	VARCHAR(10)	                            NOT NULL	                COMMENT '전체 상세 주소의 우편번호',
	`addr_alias`	VARCHAR(50)	                            NOT NULL	                COMMENT '주소 별 쉽게 찾을 수 있는 별칭',
	`user_code`	    INT	                                    NOT NULL	                COMMENT '회원 코드(AUTO_INCREMENT)',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code)
);

/**********************************************************************************************************
문의 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_inquiry;

CREATE TABLE `tbl_inquiry` (
	`inquiry_code`	    INT PRIMARY KEY AUTO_INCREMENT	    NOT NULL	                COMMENT '문의 코드',
	`inquiry_title`	    VARCHAR(50)	                        NOT NULL	                COMMENT '사용자가 작성한 문의의 제목',
	`inquiry_detail`	VARCHAR(500)	                    NULL	                    COMMENT '사용자가 작성한 문의의 내용',
	`inquiry_stat`	    VARCHAR(50)	                        NOT NULL	                COMMENT '문의 등록 또는 답변 완료',
	`user_code`	        INT	                                NOT NULL	                COMMENT '회원 코드(AUTO_INCREMENT)',
	`crtn_dt`	        DATETIME	                        NOT NULL	    DEFAULT CURRENT_DATE	COMMENT '문의가 생성된 날짜',
	`mdfc_dt`	        DATETIME	                        NULL	                    COMMENT '문의가 주정된 날짜',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code)
);

/**********************************************************************************************************
공통 코드 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_common_code;

CREATE TABLE `tbl_common_code` (
	`detail_code`	    INT PRIMARY KEY AUTO_INCREMENT	    NOT NULL	                COMMENT '공통코드 상세값',
	`detail_codename`	VARCHAR(255)	                    NOT NULL	                COMMENT '상세 코드명',
	`group_code`	    INT	                                NOT NULL	                COMMENT '공통코드 그룹 식별자(참조)',
	FOREIGN KEY (group_code)
				REFERENCES tbl_common_group(group_code)
);

/**********************************************************************************************************
약관 버전 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_terms_version;

CREATE TABLE `tbl_terms_version` (
	`version_code`	        INT PRIMARY KEY AUTO_INCREMENT	NOT NULL	                COMMENT '약관 버전 코드',
	`version_number`	    VARCHAR(50)	                    NOT NULL	                COMMENT '약관 버전 번호',
	`change_description`	VARCHAR(10000)	                NULL	                    COMMENT '변경 상세 내용',
	`crtn_dt`	            DATETIME	                    NOT NULL	                COMMENT '약관 버전 생성일',
	`mdfc_dt`	            DATETIME	                    NULL	                    COMMENT '약관 업데이트 일자',
	`terms_code`	        INT	                            NOT NULL	                COMMENT '약관 코드(참조)',
	FOREIGN KEY (terms_code)
				REFERENCES tbl_terms(terms_code)
);

/**********************************************************************************************************
필수 약관 동의 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_essential_terms;

CREATE TABLE `tbl_essential_terms` (
	`cnsn_code`	    INT PRIMARY KEY AUTO_INCREMENT	        NOT NULL	                COMMENT '동의코드',
	`consent_stat`	CHAR(1)	                                NOT NULL	    DEFAULT 'Y'	COMMENT '동의 여부(\'Y\' OR \'N\')',
	`consent_dt`	DATETIME	                            NOT NULL	    DEFAULT CURRENT_DATE	COMMENT '필수 약관에 동의한 날짜',
	`user_code`	    INT	                                    NOT NULL	                COMMENT '회원 코드(참조)',
	`terms_code`	INT	                                    NOT NULL	                COMMENT '약관 코드(참조)',
	FOREIGN KEY (user_code)
				REFERENCES tbl_user(user_code),
	FOREIGN KEY (terms_code)
				REFERENCES tbl_terms(terms_code)
);

/**********************************************************************************************************
공지사항 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_notice;

CREATE TABLE `tbl_notice` (
	`notice_code`	INT PRIMARY KEY AUTO_INCREMENT	        NOT NULL	                COMMENT '공지사항 코드',
	`title`	        VARCHAR(200)	                        NOT NULL	                COMMENT '관리자가 작성한 공지사항의 제목',
	`content`	    VARCHAR(10000)	                        NOT NULL	                COMMENT '관리자가 작성한 공지사항의 내용',
	`is_pin`	    TINYINT	                                NOT NULL	    DEFAULT 0	COMMENT '상단에 고정할지 여부',
	`admin_code`	INT	NOT                                 NULL	                    COMMENT '관리자 코드(AUTO_INCREMENT)',
	`crtn_dt`	    DATETIME	                            NOT NULL	    DEFAULT CURRENT_DATE	COMMENT '관리자가 공지사항을 작성한 날짜',
	`mdfc_dt`	    DATETIME	                            NULL	                    COMMENT '관리자가 공지사항을 수정한 날짜',
	FOREIGN KEY (admin_code)
				REFERENCES tbl_admin(admin_code)
);

/**********************************************************************************************************
공지사항 테이블 생성
**********************************************************************************************************/
DROP TABLE IF EXISTS tbl_performance_data;

CREATE TABLE `tbl_performance_data` (
	`perform_code`	INT PRIMARY KEY	AUTO_INCREMENT NOT NULL	COMMENT '실적 코드',
	`avrg_rating`	INT	NULL	COMMENT '리뷰의 평점이 추가되면 업데이트',
	`pickup_comp_num`	INT	NULL	COMMENT '픽업 완료가 되면 건당 업데이트',
	`mdfc_dt`	DATETIME	NULL	COMMENT '평점이나 픽업 완료가 업데이트 될 때의 수정일',
	`driver_code`	INT	NOT NULL	COMMENT '기사 코드(AUTO_INCREMENT)',
	FOREIGN KEY (driver_code)
				REFERENCES tbl_driver(driver_code)
);













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