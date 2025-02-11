CREATE TABLE ad_performance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id INT NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ad_performance (campaign_id, impressions, clicks, conversions, cost, revenue, created_at)
VALUES
    (101, 50000, 1200, 150, 500.00, 1500.00, '2025-02-09 12:00:00'),
    (102, 30000, 800, 90, 300.00, 1000.00, '2025-02-09 12:10:00'),
    (103, 60000, 1500, 200, 600.00, 1800.00, '2025-02-09 12:20:00');

CREATE TABLE customer_behavior (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    visit_page VARCHAR(10) NOT NULL,
    duration_time INT NOT NULL,
    clicks INT NOT NULL,
    is_conversion VARCHAR(5) NOT NULL,
    visited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customer_behavior (user_id, visit_page, duration_time, clicks, is_conversion, visited_at)
VALUES
    (1001, '홈 페이지', 120, 3, 'X', '2025-02-09 10:00:00'),
    (1002, '제품 상세', 90, 5, 'O', '2025-02-09 10:15:00'),
    (1003, '결제 페이지', 60, 2, 'O', '2025-02-09 10:30:00');

CREATE TABLE email_marketing (
    id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_id INT NOT NULL,
    email VARCHAR(50),
    is_open VARCHAR(5),
    is_click VARCHAR(5),
    is_conversion VARCHAR(5),
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO email_marketing (campaign_id, email, is_open, is_click, is_conversion, sent_at)
VALUES
    (201, 'user1@email.com', 'O', 'O', 'O', '2025-02-08 09:00:00'),
    (202, 'user2@email.com', 'O', 'X', 'X', '2025-02-08 09:15:00'),
    (203, 'user3@email.com', 'X', 'X', 'X', '2025-02-08 09:30:00');

CREATE TABLE social_media_ads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    platform VARCHAR(30),
    campaign VARCHAR(30),
    impressions INT,
    clicks INT,
    engagements INT,
    conversions INT,
    ads_cost DECIMAL(10,2)
);

INSERT INTO social_media_ads (platform, campaign, impressions, clicks, engagements, conversions, ads_cost)
VALUES
    ('Facebook', '프로모션 A', 20000, 500, 150, 40, 300.00),
    ('Instagram', '할인 이벤트', 15000, 400, 120, 30, 250.00),
    ('TikTok', '챌린지 캠페인', 50000, 2000, 500, 100, 600.00);

CREATE TABLE lead_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lead_source VARCHAR(10),
    name VARCHAR(10),
    email VARCHAR(50),
    phone_num VARCHAR(13),
    product VARCHAR(5),
    is_conversion ENUM('O', 'X'),
    regist_at DATE
);

INSERT INTO lead_data (lead_source, name, email, phone_num, product, is_conversion, regist_at)
VALUES
    ('랜딩 페이지', '홍길동', 'user1@email.com', '010-1234-5678', 'A 제품', 'O', '2025-02-07'),
    ('광고 클릭', '김영희', 'user2@email.com', '010-9876-5432', 'B 제품', 'X', '2025-02-07'),
    ('뉴스레터', '박철수', 'user3@email.com', '010-5678-1234', 'C 제품', 'O', '2025-02-07');