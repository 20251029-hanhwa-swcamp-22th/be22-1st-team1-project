-- 델리미터 설정
DELIMITER //

CREATE PROCEDURE SP_ProcessRefund (
    IN p_refund_code INT -- 처리할 환불 코드
)
BEGIN
    DECLARE v_rollback BOOL DEFAULT FALSE;

    -- 에러 발생 시 v_rollback 변수를 TRUE로 설정 (오류 핸들러)
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET v_rollback = TRUE;

    START TRANSACTION;

    -- 1. tbl_refund 승인 상태 업데이트
    UPDATE tbl_refund
    SET
        is_refund_completed = 1,
        refund_completed_date = NOW()
    WHERE refund_code = p_refund_code;

    -- 2. 관련 취소 내역 상태 동기화 (JOIN을 사용하여 효율적으로 UPDATE)
    UPDATE tbl_pickup_cancellation_code tpc
    JOIN tbl_refund tr ON(tpc.cancellation_code = tr.cancellation_code)
    SET tpc.is_refunded = 1
    WHERE tr.refund_code = p_refund_code;

    -- 트랜잭션 처리
    IF v_rollback THEN
        ROLLBACK;
        -- 오류 메시지 로깅 등을 추가할 수 있음
        SELECT 'Refund processing failed and rolled back.' AS Result;
    ELSE
        COMMIT;
        SELECT CONCAT('Refund code', p_refund_code, 'processing successfully.') AS Result;
    END IF;

END //

-- 델리미터 복원
DELIMITER ;


-- 1. 초기 상태 확인 (환불 코드 8번 상태와 관련 취소 코드의 상태)
-- (환불 8번이 취소 코드 8번과 연결되어 있다고 가정)
SELECT
    tr.is_refund_completed,
    tpc.is_refunded
FROM tbl_refund tr
JOIN tbl_pickup_cancellation_code tpc
    ON(tr.cancellation_code = tpc.cancellation_code)
WHERE tr.refund_code = 8;
-- 예상 결과: 0, 0

-- 2. 프로시저 호출
CALL SP_ProcessRefund(8);
-- 예상 결과: 'Refund processing completed successfully.'

-- 3. 최종 상태 확인 (두 테이블 모두 업데이트 확인)
SELECT
    tr.is_refund_completed,
    tpc.is_refunded
FROM tbl_refund tr
JOIN tbl_pickup_cancellation_code tpc
    ON(tr.cancellation_code = tpc.cancellation_code)
WHERE tr.refund_code = 8;
-- 예상 결과: 1, 1