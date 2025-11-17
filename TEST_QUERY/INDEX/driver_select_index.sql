-- 지역 코드와 면허 유형을 조합하여 기사 목록을 빠르게 찾기 위해 사용
CREATE INDEX idx_driver_region_license ON tbl_driver (region_code, driver_license_typ);

-- 김태형