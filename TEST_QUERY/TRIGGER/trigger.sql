-- 델리미터 설정 (트리거 정의 내에서 ; 사용을 위해)
DELIMITER //

CREATE TRIGGER trg_after_inquiry_ans_insert
AFTER INSERT ON tbl_inquiry_ans
FOR EACH ROW
BEGIN
    -- 새로 삽입된 (NEW) 답변 레코드의 inquiry_code를 참조하여
    -- tbl_inquiry 테이블의 상태(inquiry_stat)를 '답변 완료'로 업데이트
    UPDATE tbl_inquiry
    SET inquiry_stat = '답변 완료',
        mdfc_dt = NOW()
    WHERE inquiry_code = NEW.inquiry_code;
END //

-- 델리미터 복원
DELIMITER ;


-- 1. 초기 상태 확인 (문의 코드 18)
SELECT inquiry_stat, crtn_dt FROM tbl_inquiry WHERE inquiry_code = 18;
-- 예상 결과: '문의 등록'

-- 2. 답변 INSERT (트리거 실행)
INSERT INTO tbl_inquiry_ans
(content, inquiry_code, admin_code, crtn_dt)
VALUES
('문의하신 서비스 지역 확대 건은 2026년 상반기에 검토될 예정입니다.',
 18,
 9,
 NOW());

-- 3. 최종 상태 확인 (자동 업데이트 확인)
SELECT inquiry_stat, crtn_dt, mdfc_dt FROM tbl_inquiry WHERE inquiry_code = 18;
-- 예상 결과: '답변 완료'로 변경됨
-- 김태형