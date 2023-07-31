-- 사용중인 테이블 리스트 
-- 1. tMstUser
-- 2. tMstMovingDriver
-- 3. tProEstimationMng
-- 4. tProMovingMng
-- 5. tProReviewMng
-- 6. tProUsingHistoryMng


-- 1. 테이블 이름 :  tMstUser
-- 2. 성격 : 사용자용 앱 이용자들의 정보 보관 및 갱신
-- 3. 데이터 보존 기간 : 영구
-- 4. 변경이력
--   1) 2022.07.18  By 조채영 최초생성
--   2) 2022.07.20  By 조채영 u_address 데이터 타입 수정
--   3) 2022.07.21  By 조채영 u_phone_number 오타 수정 
--   4) 2022.07.29  By 조채영 u_id, u_password, u_name, u_phone_number, user_address 속성명 user_id, user_pw, user_name, user_phone_number, user_address로 변경 
--                           ,모든 속성에 코멘트 추가, user_id 데이터 크기 20에서 15로 수정
--   5) 2022.08.09  By 조채영 u_phone_number -> u_phone으로 속성명 변경 

CREATE TABLE IF NOT EXISTS tMstUser
(	
    user_id VARCHAR(15) NOT NULL,                                   -- 사용자의 아이디
    user_pw VARCHAR(20) NOT NULL,                                   -- 사용자의 비밀번호
    user_name VARCHAR(15) NOT NULL,                                 -- 사용자의 이름
    user_phone VARCHAR(11) NOT NULL,                                -- 사용자의 전화번호 
    user_address VARCHAR(50) NOT NULL,                              -- 사용자의 주소 
    PRIMARY KEY(user_id)                                            -- MstUser의 기본키 = user_id
);


-- 1. tMstMovingDriver       
-- 2. 성격 : 업체(기사)의 정보 관리 
-- 3. 데이터 보존 기간 : 영구
-- 4. 변경이력
--    1) 2022.07.18 By 조채영 최초생성 
--    2) 2022.07.20 By 조채영 staff_address 데이터 타입 수정
--    3) 2022.07.21 By 조채영 테이블명 수정
--    4) 2022.07.25 By 조채영 company_name 속성 추가 
--    5) 2022.07.29 By 조채영 코멘트 추가, staff_id 데이터 크기 20에서 15로 수정, 모든 속성에 코멘트 추가
--    6) 2022.08.05 By 신소희 테이블명 변경 (tMstMovingDriver <- tMstStaff)
--    7) 2022.08.08 By 조채영 staff_id -> MovingDriver_id, staff_name -> MovingDrivr_name, staff_pw -> MovingDriver_pw, staff_phone_number -> MovingDriver_phone, 
--                           staff_address -> MovingDriver_address, staff_avg_rating -> MovingDriver_avg_rating, company_name -> MovingComapany로 속성명 변경 
--    8) 2022.08.22 By 조채영 MovingDriver_id, name, pw, phone, address, avg_rating -> movingdriver_id, name, pw, phone, avg_rating로 속성명 변경, 
--                           MovingCompany -> movingcompany로 속성명 변경, PK에 대한 주석 삭제 

CREATE TABLE IF NOT EXISTS tMstMovingDriver
(
    movingdriver_id VARCHAR(15) NOT NULL,                            -- 기사(업체)의 아이디 
    movingdriver_name VARCHAR(15) NOT NULL,                          -- 기사의 이름
    movingdriver_pw VARCHAR(20) NOT NULL,                            -- 기사(업체)의 비밀번호
    movingdriver_phone VARCHAR(11) NOT NULL,                         -- 기사(업체)의 전화번호
    movingdriver_address VARCHAR(50) NOT NULL,                       -- 기사(업체)의 주소 
    movingdriver_avg_rating FLOAT(3) NOT NULL,                       -- 기사(업체)의 평균 평점
    movingcompany VARCHAR(20) NOT NULL,                              -- 업체의 이름(개인기사의 경우에는 이름으로 작성)
    PRIMARY KEY(movingdriver_id)                                    
);
        
-- 1. tProEstimationMng
-- 2. 성격 : 이삿짐 견적 정보 관리 
-- 3. 데이터 보존 기간 : 3년
-- 4. 변경이력
--    1) 2022.07.18 By 조채영 최초생성 
--    2) 2022.07.20 By 조채영 arrival_address, departure_address, est_number, using_truck_quantity 데이터 타입 수정
--    3) 2022.07.21 By 조채영 테이블명, 데이터 보존기간, est_number 데이터 타입, estimation 데이터 타입 수정 
--    4) 2022.07.29 By 조채영 모든 속성에 코멘트 추가
--    5) 2022.08.05 By 조채영 FK 내용 추가 
--    6) 2022.08.08 By 조채영 FK 참조 테이블명(tMststaff -> tMstMovingDriver), 키 값(staff_id -> MovingDriver_id) 수정 
--    7) 2022.08.08 By 조채영 staff_id -> MovingDriver-id, staff_name -> MovingDriver_name, staff_phone_number -> MovingDriver_phone, departure_address -> From_address,
--                           arrival_address -> To_address로 속성명 변경 
--    8) 2022.08.08 By 조채영 tProEstMng -> tProEstimationMng 로 테이블명 변경
--    9) 2022.08.22 By 조채영 From_address-> from_address, To_address -> to_address, MovingDriver_name,id,phone -> movingdriver_name, id, phone으로 속성명 변경,
--                           PK, FK에 대한 주석 삭제 

CREATE TABLE IF NOT EXISTS  tProEstimationMng
(
    est_number INT(11) NOT NULL AUTO_INCREMENT,                      -- 견적 정보 번호(자동생성, PK)
    baggage_name VARCHAR(20) NOT NULL,                               -- 짐 정보 이름(ex.텔레비전, 냉장고..)
    baggage_quantity INT(10) NOT NULL,                               -- 해당 짐의 수량
    from_address VARCHAR(50) NOT NULL,                               -- 출발 주소지 
    to_address VARCHAR(50) NOT NULL,                                 -- 도착 주소지
    box_type VARCHAR(5) NOT NULL,                                    -- 박스 타입(2호,3호,4호,5호,6호)
    box_quantity INT(10) NOT NULL,                                   -- 해당 박스의 개수
    using_ladder_truck INT(5) NOT NULL,                              -- 이용할 사다리차의 수 
    using_truck_type VARCHAR(5) NOT NULL,                            -- 사용 트럭 종류(1톤, 2.5톤, 3.5톤...)
    using_truck_quantity INT(5) NOT NULL,                            -- 이용할 트럭의 수
    using_staff INT(20) NOT NULL,                                    -- 이용할 직원의 수 
    order_number VARCHAR(20) NOT NULL,                               -- 주문번호(FK)
    movingdriver_name VARCHAR(15) NOT NULL,                          -- 기사(업체)의 이름 
    movingdriver_id VARCHAR(15) NOT NULL,                            -- 기사(업체)의 아이디(FK)
    movingdriver_phone VARCHAR(11) NOT NULL,                         -- 기사(업체)의 전화번호 
    estimation INT(11) NOT NULL,                                     -- 기사(업체)가 제안한 견적
    est_state TINYINT(1) NOT NULL,                                   -- 해당 견적의 상태(선택/미선택)
    user_id VARCHAR(20) NOT NULL,                                    -- 사용자의 아이디(FK)
    PRIMARY KEY(est_number),                                         
    FOREIGN KEY(user_id) REFERENCES tMstUser(user_id),             
    FOREIGN KEY(movingdriver_id) REFERENCES tMstMovingDriver(movingdriver_id),
    FOREIGN KEY(order_number) REFERENCES tProMvMng(order_number)
 );
        
        
-- 1. tProMvMng
-- 2. 성격 : 확정된 이사 정보의 관리
-- 3. 데이터 보존 기간 : 3년
-- 4. 변경이력
--    1) 2022.07.18 By 조채영 최초생성 
--    2) 2022.07.20 By 조채영 departure_address, arrival_address 데이터 타입 수정 및 box_type, box_quantity 추가
--    3) 2022.07.21 By 조채영 테이블명, 데이터 보존 기간, order_number 데이터 타입, determined_estimation 데이터 타입 수정
--    4) 2022.07.22 By 조채영 컬럼에 requirement 추가 
--    5) 2022.07.29 By 조채영 u_id를 user_id로 수정
--    6) 2022.08.05 By 조채영 FK 내용 추가 
--    6) 2022.08.08 By 조채영 FK 참조 테이블명(tMststaff -> tMstMovingDriver), 키 값(staff_id -> MovingDriver_id) 수정 
--    7) 2022.08.08 By 조채영 staff_id -> MovingDriver_id, company_name -> MovingCompany, departure_address -> From_address, arrival_address -> To_address로 속성명 변경
--    8) 2022.08.22 By 조채영 From_address -> from_address, TO_address -> to_address, MovingDriver_id -> movingdriver_id, MovingCompany - > movingcompany로 속성명 변경
--                           , PK, FK에 대한 주석 삭제 

CREATE TABLE IF NOT EXISTS tProMvMng
(        
    order_number INT(11) NOT NULL AUTO_INCREMENT,                    -- 주문 번호(자동생성,PK)
    user_id VARCHAR(20) NOT NULL,                                    -- 사용자의 아이디(FK)
    moving_date DATETIME NOT NULL,                                   -- 이사 확정일 
    from_address VARCHAR(50) NOT NULL,                               -- 출발 주소지
    to_address VARCHAR(50) NOT NULL,                                 -- 도착 주소지
    baggage_name VARCHAR(20) NOT NULL,                               -- 짐 정보 이름(ex.텔레비전, 냉장고...)
    baggage_quantity INT(10) NOT NULL,                               -- 해당 짐의 수량
    box_type VARCHAR(5) NOT NULL,                                    -- 박스의 타입(2호,3호,4호,5호,6호)
    box_quantity INT(10) NOT NULL,                                   -- 해당 박스의 수량 
    movingdriver_id VARCHAR(20) NOT NULL,                            -- 이사를 진행할 업체 또는 기사의 아이디(FK)
    movingcompany VARCHAR(20) NOT NULL,                              -- 업체명(개인기사의 경우에는 이름으로 작성)
    requirement VARCHAR(50) NOT NULL,                                -- 요구사항(주소지 정보, 짐 정보 등의 정보 외에 업체에 요구하는 것)
    determined_estimation INT(11) NOT NULL,                          -- 확정된 견적 
    PRIMARY KEY(order_number),                                       
    FOREIGN KEY(user_id) REFERENCES tMstUser(user_id),               
    FOREIGN KEY(movingdriver_id) REFERENCES tMstMovingDriver(movingdriver_id)
);


-- 1. tProReviewMng
-- 2. 성격 : 사용자의 후기 데이터 관리 
-- 3. 데이터 보존 기간 : 3년
-- 4. 변경이력
--    1) 2022.07.18 By 조채영 최초생성 
--    2) 2022.07.20 By 조채영 테이블 내에 review_contents 추가 및 review_number 데이터 타입 수정
--    3) 2022.07.21 By 조채영 테이블명, 데이터 보존 기간, review_number 데이터 타입 수정 및 컬럼에 moving_date, order_number 추가 
--    4) 2022.07.29 By 조채영 u_id를 user_id로 속성명 수정, 코멘트 추가
--    5) 2022.08.05 By 조채영 FK 내용 추가 
--    6) 2022.08.08 By 조채영 FK 참조 테이블명(tMststaff -> tMstMovingDriver), 키 값(staff_id -> MovingDriver_id) 수정 
--    7) 2022.08.08 By 조채영 staff_id -> MovingDriver_id로 속성명 변경
--    8) 2022.08.09 By 조채영 tProRVMng -> tProReviewMng로 테이블명 변경 
--    9) 2022.08.22 By 조채영 MovingDriver_id -> movingdriver_id로 속성명 변경, PK,FK에 대한 주석 삭제 

 CREATE TABLE IF NOT EXISTS  tProReviewMng
(
     review_number INT(11)  NOT NULL AUTO_INCREMENT,                 -- 리뷰 번호(자동생성, PK)
     user_id  VARCHAR(20) NOT NULL,                                  -- 사용자의 아이디(FK)
     movingdriver_id VARCHAR(20) NOT NULL,                           -- 기사(업체)의 아이디(FK)
     review_created_date DATETIME NOT NULL,                          -- 리뷰가 작성된 날짜 
     review_rating FLOAT(3) NOT NULL,                                -- 이사 서비스에 대한 평점 
     review_contents VARCHAR(200) NULL,                              -- 이사 서비스에 대한 후기 
     moving_date DATETIME NOT NULL,                                  -- 이사 확정일
     order_number INT(11) NOT NULL,                                  -- 주문 번호(FK)
     PRIMARY KEY(review_number),                                     
     FOREIGN KEY(user_id) REFERENCES tMstUser(user_id),              
     FOREIGN KEY(movingdriver_id) REFERENCES tMstMovingDriver(movingdriver_id),
     FOREIGN KEY(order_number) REFERENCES tProMvMng(order_number) 
);


-- 1. tProUsingHistoryMng
-- 2. 성격 : 사용자의 이용내역 관리 테이블  
-- 3. 데이터 보존 기간 : 3년
-- 4. 변경이력
--    1) 2022.08.08 By 조채영 최초생성 
--    2) 2022.08.09 By 조채영 cleaning_address, fixing_address 필드 추가 작성 
--    3) 2022.08.22 By 조채영 테이블명 변경(tProUsingHistory -> tProUsingHistoryMng), 테이블 생성 문구 작성(CREATE TABLE IF NOT EXISTS tUsingHistoryMng),
--                           Using_order_number -> using_order_number, From_address -> from_address, To_address -> to_address, MovingDriver_id -> movingdriver_id.
--                           MovingCompany -> movingcompany, Moving_state -> moving_state로 속성명 변경, PK, FK에 대한 주석 삭제 

 CREATE TABLE IF NOT EXISTS  tProUsingHistoryMng
(
    using_order_number INT(11) NOT NULL AUTO_INCREMENT,              -- 사용 내역의 번호(PK, 자동생성)
    user_id VARCHAR(20) NOT NULL,                                    -- 사용자의 아이디
    cleaning_date DATETIME NOT NULL,                                 -- 청소 서비스 이용 날짜
    cleaning_address VARCHAR(50) NOT NULL,                           -- 청소 서비스 이용 주소 
    fixing_date DATETIME NOT NULL,                                   -- 설치 서비스 이용 날짜 
    fixing_address VARCHAR(50) NOT NULL,                             -- 설치 서비스 이용 주소 
    order_number INT(11) NOT NULL,                                   -- 이사 관리 서비스 주문번호(FK)
    moving_date DATETIME NOT NULL,                                   -- 이사 확정일 
    from_address VARCHAR(50) NOT NULL,                               -- 출발 주소지
    to_address VARCHAR(50) NOT NULL,                                 -- 도착 주소지
    movingdriver_id VARCHAR(20) NOT NULL,                            -- 이용한 기사의 아이디
    movingcompany VARCHAR(20) NOT NULL,                              -- 업체명(개인기사의 경우에는 이름으로 작성)
    baggage_name VARCHAR(20) NOT NULL,                               -- 짐 정보 이름(ex.텔레비전, 냉장고...)
    baggage_quantity INT(10) NOT NULL,                               -- 해당 짐의 수량
    box_type VARCHAR(5) NOT NULL,                                    -- 박스의 타입(2호,3호,4호,5호,6호)
    box_quantity INT(10) NOT NULL,                                   -- 해당 박스의 수량 
    requirement VARCHAR(50) NOT NULL,                                -- 요구사항(주소지 정보, 짐 정보 등의 정보 외에 업체에 요구하는 것)
    using_ladder_truck INT(5) NOT NULL,                              -- 이용한 사다리차의 수 
    using_truck_type VARCHAR(5) NOT NULL,                            -- 사용 트럭 종류(1톤, 2.5톤, 3.5톤...)
    using_truck_quantity INT(5) NOT NULL,                            -- 이용한 트럭의 수
    using_staff INT(20) NOT NULL,                                    -- 이용한 직원의 수 
    determined_estimation INT(11) NOT NULL,                          -- 확정된 견적 
    moving_state VARCHAR(5) NOT NULL,                                -- 이사 서비스 상태(접수완료,이사준비중, 이사완료)
    review_state TINYINT(1) NOT NULL,                                -- 리뷰 작성 여부 
    review_number INT(11)  NOT NULL,                                 -- 리뷰 번호(FK)
    PRIMARY KEY(using_order_number),                                 
    FOREIGN KEY(order_number) REFERENCES tMstMvMng(order_number),     
    FOREIGN KEY(review_number) REFERENCES tMstReviewMng(review_number)
);
