-- [예제 1]
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- 자동 증가하는 기본 키
    name VARCHAR(100) NOT NULL,         -- 이름 (필수 입력)
    position VARCHAR(50) NOT NULL,      -- 직급
    salary DECIMAL(10,2) NOT NULL,      -- 급여 (소수점 2자리)
    hire_date DATE DEFAULT (CURRENT_DATE) -- 입사일 (기본값: 현재 날짜)
);

INSERT INTO employees (name, position, salary)
VALUES ('홍길동', '개발자', 5000000);

INSERT INTO employees (name, position, salary)
VALUES
('김철수', '디자이너', 4500000),
('이영희', '마케팅', 4800000),
('박민수', '개발자', 5200000),
('최수영', 'HR 매니저', 4700000);

SELECT * FROM employees;

SELECT * FROM employees WHERE position = '개발자';

UPDATE employees
SET salary = 5500000
WHERE name = '홍길동';

UPDATE employees
SET position = '시니어 개발자', salary = 6000000
WHERE name = '박민수';

UPDATE employees
SET salary = salary * 1.1  -- 모든 직원의 급여를 10% 인상
WHERE position = '디자이너';

DELETE FROM employees
WHERE name = '김철수';

DELETE FROM employees
WHERE position = '마케팅';

TRUNCATE TABLE employees;

DROP TABLE employees;

-- [예제 2. 직원정보 관리 시스템]
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

INSERT INTO employees (name, department, position, salary, hire_date, email, phone) VALUES
('김철수', '개발팀', '백엔드 개발자', 6000000, '2021-03-01', 'chulsoo@example.com', '010-1234-5678'),
('이영희', '디자인팀', 'UI/UX 디자이너', 5200000, '2022-07-15', 'younghee@example.com', '010-2233-4455'),
('박민수', '마케팅팀', '마케팅 매니저', 5800000, '2020-10-10', 'minsoo@example.com', '010-3344-5566'),
('최지훈', '개발팀', '프론트엔드 개발자', 5700000, '2019-06-20', 'jihoon@example.com', '010-4455-6677'),
('정수진', '인사팀', 'HR 매니저', 5100000, '2023-01-05', 'sujin@example.com', '010-5566-7788'),
('한지민', '개발팀', '데이터 엔지니어', 6300000, '2021-11-12', 'jimin@example.com', '010-6677-8899'),
('오세훈', '마케팅팀', '콘텐츠 마케터', 5000000, '2022-03-15', 'sehoon@example.com', '010-7788-9900'),
('김서연', '디자인팀', '그래픽 디자이너', 4900000, '2023-05-22', 'seoyeon@example.com', '010-8899-0011'),
('류지혁', '개발팀', 'AI 엔지니어', 7200000, '2018-09-30', 'jihyuk@example.com', '010-9900-1122'),
('배윤아', '운영팀', '총무', 4500000, '2023-08-07', 'yoonah@example.com', '010-1122-2233');

SELECT * FROM employees;

SELECT * FROM employees WHERE department = '개발팀';

SELECT * FROM employees WHERE hire_date >= '2021-01-01';

SELECT * FROM employees WHERE salary >= 5500000;

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC
LIMIT 1;

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

SELECT * FROM employees ORDER BY hire_date ASC;

SELECT * FROM employees WHERE email LIKE '%@example.com';

SELECT SUM(salary) AS total_salary
FROM employees
WHERE department = '개발팀';

UPDATE employees
SET salary = 6500000
WHERE name = '김철수';

UPDATE employees
SET salary = salary * 1.05
WHERE department = '마케팅팀';

DELETE FROM employees
WHERE name = '배윤아';

TRUNCATE TABLE employees;

DROP TABLE employees;

-- [예제 3. 그로스마케팅]
CREATE TABLE marketing_campaigns (
    id INT AUTO_INCREMENT PRIMARY KEY,       -- 캠페인 ID (기본 키)
    campaign_name VARCHAR(100) NOT NULL,     -- 캠페인명
    channel VARCHAR(50) NOT NULL,            -- 마케팅 채널 (SNS, 이메일, 광고 등)
    budget DECIMAL(10,2) NOT NULL,           -- 예산 (단위: 원)
    impressions INT NOT NULL,                -- 노출 수
    clicks INT NOT NULL,                     -- 클릭 수
    conversions INT NOT NULL,                 -- 전환 수 (회원가입, 구매 등)
    start_date DATE NOT NULL,                -- 시작일
    end_date DATE NOT NULL                   -- 종료일
);

INSERT INTO marketing_campaigns (campaign_name, channel, budget, impressions, clicks, conversions, start_date, end_date) VALUES
('봄 세일 프로모션', 'Facebook Ads', 5000000, 200000, 15000, 2000, '2024-03-01', '2024-03-31'),
('신제품 출시 캠페인', 'Google Ads', 8000000, 500000, 32000, 4500, '2024-04-01', '2024-04-30'),
('여름 할인 이벤트', 'Instagram Ads', 7000000, 300000, 22000, 3500, '2024-06-01', '2024-06-30'),
('이메일 마케팅 테스트', 'Email Marketing', 1000000, 50000, 4000, 800, '2024-05-10', '2024-05-20'),
('인플루언서 협업 캠페인', 'YouTube Sponsorship', 9000000, 450000, 27000, 6000, '2024-07-01', '2024-07-31'),
('겨울 시즌 프로모션', 'Google Ads', 6000000, 250000, 18000, 3200, '2024-11-01', '2024-11-30'),
('회원가입 프로모션', 'TikTok Ads', 5000000, 280000, 21000, 5000, '2024-02-01', '2024-02-28'),
('앱 다운로드 캠페인', 'Instagram Ads', 5500000, 320000, 26000, 7000, '2024-08-01', '2024-08-31'),
('블랙프라이데이 이벤트', 'Facebook Ads', 10000000, 700000, 45000, 9000, '2024-11-20', '2024-11-30'),
('연말 감사 이벤트', 'Email Marketing', 2000000, 100000, 8000, 1500, '2024-12-01', '2024-12-10');

SELECT * FROM marketing_campaigns;

SELECT campaign_name, channel, (conversions / clicks) * 100 AS conversion_rate
FROM marketing_campaigns
ORDER BY conversion_rate DESC
LIMIT 1;

SELECT channel, AVG((clicks / impressions) * 100) AS avg_ctr
FROM marketing_campaigns
GROUP BY channel;

SELECT campaign_name, channel, conversions
FROM marketing_campaigns
WHERE conversions >= 5000;

SELECT campaign_name, channel, (budget / clicks) AS cpc
FROM marketing_campaigns
ORDER BY cpc ASC;

SELECT * FROM marketing_campaigns
WHERE start_date BETWEEN '2024-06-01' AND '2024-08-31';

SELECT campaign_name, channel, budget
FROM marketing_campaigns
ORDER BY budget DESC
LIMIT 1;

SELECT channel, SUM(conversions) AS total_conversions, AVG((conversions / clicks) * 100) AS avg_conversion_rate
FROM marketing_campaigns
WHERE channel = 'Google Ads'
GROUP BY channel;

SELECT campaign_name, channel, ((conversions * 50000 - budget) / budget) * 100 AS ROI
FROM marketing_campaigns
ORDER BY ROI DESC;

SELECT channel, SUM(budget) / SUM(conversions) AS avg_cpa
FROM marketing_campaigns
GROUP BY channel
ORDER BY avg_cpa ASC
LIMIT 1;

-- [예제 4. 사용자 행동 분석]
CREATE TABLE user_behavior1 (
    user_id INT AUTO_INCREMENT PRIMARY KEY,   -- 사용자 ID (기본 키)
    session_id VARCHAR(50) NOT NULL,         -- 세션 ID
    page_viewed VARCHAR(100) NOT NULL,       -- 방문한 페이지
    time_spent INT NOT NULL,                 -- 페이지에서 머문 시간 (초)
    device VARCHAR(50) NOT NULL,             -- 사용 기기 (모바일, 데스크탑 등)
    referrer VARCHAR(100) NOT NULL,          -- 유입 경로 (검색, SNS 등)
    purchase INT NOT NULL DEFAULT 0,         -- 구매 여부 (0: 미구매, 1: 구매)
    visit_date DATETIME NOT NULL             -- 방문 시간
);

INSERT INTO user_behavior1 (session_id, page_viewed, time_spent, device, referrer, purchase, visit_date) VALUES
('S001', '홈페이지', 120, '모바일', 'Google Search', 0, '2024-01-01 10:30:00'),
('S002', '상품 상세', 300, '데스크탑', 'Facebook', 1, '2024-01-02 14:20:00'),
('S003', '결제 페이지', 60, '모바일', 'Email Campaign', 1, '2024-01-03 09:45:00'),
('S004', '홈페이지', 80, '태블릿', 'Direct', 0, '2024-01-03 18:00:00'),
('S005', '상품 상세', 240, '모바일', 'Google Search', 1, '2024-01-04 11:15:00');

SELECT user_id, AVG(time_spent) AS avg_time_spent
FROM user_behavior1
GROUP BY user_id;

SELECT device,
       (SUM(purchase) / COUNT(*)) * 100 AS conversion_rate
FROM user_behavior1
GROUP BY device
ORDER BY conversion_rate DESC;

SELECT user_id, page_viewed, MAX(time_spent) AS max_time_spent
FROM user_behavior1
GROUP BY user_id, page_viewed
ORDER BY max_time_spent DESC
LIMIT 1;

SELECT referrer, AVG(time_spent) AS avg_session_duration
FROM user_behavior1
GROUP BY referrer
ORDER BY avg_session_duration DESC;

-- [예제 5. 이메일 캠페인 성과 분석]
CREATE TABLE email_campaigns1 (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(150) NOT NULL,      -- 이메일 제목
    sent INT NOT NULL,                  -- 발송 수
    opened INT NOT NULL,                 -- 열람 수
    clicked INT NOT NULL,                -- 클릭 수
    conversions INT NOT NULL,            -- 전환 수
    send_date DATE NOT NULL
);

INSERT INTO email_campaigns1 (subject, sent, opened, clicked, conversions, send_date) VALUES
('봄맞이 할인 이벤트', 10000, 4500, 1200, 300, '2024-03-01'),
('VIP 전용 한정 할인', 8000, 5000, 1800, 700, '2024-04-10'),
('신제품 런칭 특별 이벤트', 12000, 7000, 2500, 900, '2024-05-15'),
('무료 샘플 신청', 9000, 6200, 1900, 850, '2024-06-01'),
('회원 감사 쿠폰 증정', 7500, 5200, 1600, 600, '2024-07-20');

SELECT subject,
       (opened / sent) * 100 AS open_rate,
       (clicked / sent) * 100 AS click_rate,
       (conversions / sent) * 100 AS conversion_rate
FROM email_campaigns1
ORDER BY conversion_rate DESC;

SELECT subject, conversions
FROM email_campaigns1
ORDER BY conversions DESC
LIMIT 1;

SELECT * FROM email_campaigns1
WHERE send_date >= DATE_SUB('2024-08-01', INTERVAL 6 MONTH);

-- [예제 6. 광고 ROI 분석]
CREATE TABLE ad_performance1 (
    ad_id INT AUTO_INCREMENT PRIMARY KEY,
    platform VARCHAR(50) NOT NULL,        -- 광고 플랫폼 (Google, Facebook 등)
    budget DECIMAL(10,2) NOT NULL,        -- 광고 예산
    impressions INT NOT NULL,             -- 노출 수
    clicks INT NOT NULL,                  -- 클릭 수
    conversions INT NOT NULL,             -- 전환 수
    revenue DECIMAL(11,2) NOT NULL,       -- 매출액
    start_date DATE NOT NULL
);

INSERT INTO ad_performance1 (platform, budget, impressions, clicks, conversions, revenue, start_date) VALUES
('Google Ads', 5000000, 200000, 15000, 3000, 150000000, '2024-01-01'),
('Facebook Ads', 6000000, 250000, 18000, 4000, 180000000, '2024-02-01'),
('Instagram Ads', 5500000, 220000, 17000, 3500, 140000000, '2024-03-01'),
('YouTube Ads', 7000000, 300000, 22000, 5000, 200000000, '2024-04-01'),
('TikTok Ads', 4000000, 180000, 14000, 2800, 120000000, '2024-05-01');

SELECT platform,
       ((revenue - budget) / budget) * 100 AS ROI
FROM ad_performance1
ORDER BY ROI DESC;

SELECT platform, (budget / clicks) AS CPC
FROM ad_performance
ORDER BY CPC ASC;

SELECT platform, (budget / conversions) AS CPA
FROM ad_performance
ORDER BY CPA ASC
LIMIT 1;

-- [예제 7. 마케팅 시나리오]
-- 1) 광고 채널별 전환 최적화
CREATE TABLE ad_performance2 (
    ad_id INT AUTO_INCREMENT PRIMARY KEY,
    channel VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL,
    start_date DATE NOT NULL
);

INSERT INTO ad_performance2 (channel, budget, impressions, clicks, conversions, start_date) VALUES
('Google Ads', 5000000, 200000, 15000, 3000, '2024-01-01'),
('Facebook Ads', 6000000, 250000, 18000, 4000, '2024-02-01'),
('Instagram Ads', 5500000, 220000, 17000, 3500, '2024-03-01'),
('YouTube Ads', 7000000, 300000, 22000, 5000, '2024-04-01'),
('TikTok Ads', 4000000, 180000, 14000, 2800, '2024-05-01');

SELECT channel, (SUM(conversions) / SUM(clicks)) * 100 AS conversion_rate
FROM ad_performance2
GROUP BY channel
ORDER BY conversion_rate DESC;

-- 2) 고객 생애 가치(LTV) 예측
CREATE TABLE customer_purchases (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_value DECIMAL(10,2) NOT NULL,
    retention_period INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO customer_purchases (customer_id, order_value, retention_period, order_date) VALUES
(1, 50000, 12, '2024-01-10'),
(1, 70000, 12, '2024-02-15'),
(1, 60000, 12, '2024-03-20'),
(2, 150000, 8, '2024-01-05'),
(2, 120000, 8, '2024-03-12'),
(3, 30000, 10, '2024-04-01'),
(3, 45000, 10, '2024-04-15'),
(3, 35000, 10, '2024-05-10');

SELECT customer_id, AVG(order_value) * COUNT(DISTINCT order_id) * AVG(retention_period) AS LTV
FROM customer_purchases
GROUP BY customer_id
ORDER BY LTV DESC
LIMIT 1;

-- A/B 테스트 분석
CREATE TABLE ab_test_campaigns (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(50) NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL
);

INSERT INTO ab_test_campaigns (campaign_name, impressions, clicks) VALUES
('캠페인 A', 100000, 12000),
('캠페인 B', 100000, 15000);

SELECT campaign_name, (SUM(clicks) / SUM(impressions)) * 100 AS CTR
FROM ab_test_campaigns
WHERE campaign_name IN ('캠페인 A', '캠페인 B')
GROUP BY campaign_name
ORDER BY CTR DESC;

-- 퍼널 분석 (Funnel Analysis)
CREATE TABLE user_behavior (
    session_id VARCHAR(50) NOT NULL,
    page_viewed VARCHAR(100) NOT NULL,
    visit_date DATETIME NOT NULL
);

INSERT INTO user_behavior (session_id, page_viewed, visit_date) VALUES
('S001', '홈페이지', '2024-01-01 10:30:00'),
('S002', '상품 상세', '2024-01-02 14:20:00'),
('S003', '장바구니', '2024-01-03 09:45:00'),
('S004', '결제 완료', '2024-01-04 18:00:00');

SELECT funnel_stage,
       users,
       LAG(users) OVER (ORDER BY step_order) AS previous_stage_users,
       ((LAG(users) OVER (ORDER BY step_order) - users) / LAG(users) OVER (ORDER BY step_order)) * 100 AS drop_off_rate
FROM (
    SELECT '방문' AS funnel_stage, COUNT(DISTINCT session_id) AS users, 1 AS step_order FROM user_behavior
    UNION ALL
    SELECT '상품 상세', COUNT(DISTINCT session_id), 2 FROM user_behavior WHERE page_viewed = '상품 상세'
    UNION ALL
    SELECT '장바구니', COUNT(DISTINCT session_id), 3 FROM user_behavior WHERE page_viewed = '장바구니'
    UNION ALL
    SELECT '결제 완료', COUNT(DISTINCT session_id), 4 FROM user_behavior WHERE page_viewed = '결제 완료'
) AS funnel_data;

-- 마케팅 채널별 ROI 비교
CREATE TABLE marketing_roi (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    channel VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(10,2) NOT NULL
);

INSERT INTO marketing_roi (channel, budget, revenue) VALUES
('Google Ads', 5000000, 15000000),
('Facebook Ads', 6000000, 18000000),
('Instagram Ads', 5500000, 14000000);

SELECT channel, (SUM(revenue) - SUM(budget)) / SUM(budget) * 100 AS ROI
FROM marketing_roi
GROUP BY channel
ORDER BY ROI DESC;

-- 구독 서비스 유지율 분석
CREATE TABLE subscription_data (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    cohort_month DATE NOT NULL,
    months_active INT NOT NULL
);

INSERT INTO subscription_data (cohort_month, months_active) VALUES
('2024-01-01', 12),
('2024-02-01', 10),
('2024-03-01', 8),
('2024-04-01', 6);

SELECT cohort_month,
       COUNT(DISTINCT user_id) AS initial_subscribers,
       COUNT(DISTINCT CASE WHEN months_active >= 3 THEN user_id END) AS retained_users,
       (COUNT(DISTINCT CASE WHEN months_active >= 3 THEN user_id END) / COUNT(DISTINCT user_id)) * 100 AS retention_rate
FROM subscription_data
GROUP BY cohort_month;

-- 추천 시스템 최적화
CREATE TABLE product_interactions (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    interaction_count INT NOT NULL
);

INSERT INTO product_interactions (user_id, product_id, interaction_count) VALUES
(1, 101, 5),
(1, 102, 3),
(2, 101, 4),
(2, 103, 6),
(3, 102, 7);

SELECT a.user_id, b.product_id, COUNT(*) AS interaction_score
FROM user_behavior a
JOIN user_behavior b ON a.user_id != b.user_id AND a.page_viewed = b.page_viewed
GROUP BY a.user_id, b.product_id
ORDER BY interaction_score DESC
LIMIT 10;

-- 재구매율 분석
CREATE TABLE customer_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO customer_orders (customer_id, order_date) VALUES
(1, '2024-01-10'),
(1, '2024-02-15'),
(2, '2024-01-05'),
(3, '2024-04-01'),
(3, '2024-05-10');

SELECT (COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id)) * 100 AS repeat_purchase_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM customer_purchases
    GROUP BY customer_id
) AS purchase_data;

-- 광고 효율성 비교 (CPC, CPA 분석)
CREATE TABLE ad_cost_analysis (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL
);

INSERT INTO ad_cost_analysis (campaign_name, budget, clicks, conversions) VALUES
('Google Ads', 5000000, 15000, 3000),
('Facebook Ads', 6000000, 18000, 4000),
('Instagram Ads', 5500000, 17000, 3500);

SELECT campaign_name, SUM(budget) / SUM(clicks) AS CPC, SUM(budget) / SUM(conversions) AS CPA
FROM ad_cost_analysis
GROUP BY campaign_name
ORDER BY CPA ASC;

-- 고객 세그먼트별 매출 분석
CREATE TABLE customer_segments (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    total_orders INT NOT NULL,
    total_revenue DECIMAL(10,2) NOT NULL
);

INSERT INTO customer_segments (total_orders, total_revenue) VALUES
(12, 1000000),
(8, 600000),
(3, 200000);

SELECT customer_segment, SUM(order_value) AS total_revenue
FROM (
    SELECT customer_id, order_value,
           CASE
               WHEN total_orders > 10 THEN 'VIP'
               WHEN total_orders BETWEEN 3 AND 10 THEN '일반'
               ELSE '신규'
           END AS customer_segment
    FROM (SELECT customer_id, COUNT(order_id) AS total_orders, SUM(order_value) AS order_value FROM customer_purchases GROUP BY customer_id) AS grouped_data
) AS segmented_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;