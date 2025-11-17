-- 성별('M','F')로 1차 필터링 후, 가입 날짜로 범위 검색이 필요
CREATE INDEX idx_user_gen_crtn_dt ON tbl_user (user_gen, crtn_dt);

-- 김태형