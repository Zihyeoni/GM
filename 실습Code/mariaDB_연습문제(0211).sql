-- 1) 광고 채널별 전환 최적화
CREATE TABLE channel_conversion (
    ad_id INT AUTO_INCREMENT PRIMARY KEY,
    channel VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL,
    start_date DATE NOT NULL
);

INSERT INTO channel_conversion (channel, budget, impressions, clicks, conversions, start_date) VALUES
('Google Ads', 8000000, 300000, 20000, 4000, '2024-06-01'),
('Facebook Ads', 7000000, 250000, 18000, 3500, '2024-07-01'),
('Instagram Ads', 6500000, 230000, 17000, 3400, '2024-08-01');

SELECT channel, (conversions / clicks) * 100 AS conversion_rate
FROM channel_conversion
ORDER BY conversion_rate DESC;

-- 2) 고객 생애 가치(LTV) 예측
CREATE TABLE customer_purchases2 (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    order_value DECIMAL(10,2) NOT NULL,
    retention_period INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO customer_purchases2 (order_value, retention_period, order_date) VALUES
(70000, 12, '2024-06-10'),
(120000, 10, '2024-07-15'),
(50000, 8, '2024-08-20');

SELECT customer_id, SUM(order_value) AS total_purchase
FROM customer_purchases2
GROUP BY customer_id
ORDER BY total_purchase DESC;

-- A/B 테스트 분석
CREATE TABLE ab_test_campaigns2 (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(50) NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL
);

INSERT INTO ab_test_campaigns2 (campaign_name, impressions, clicks) VALUES
('캠페인 A', 120000, 15000),
('캠페인 B', 140000, 18000);

SELECT campaign_name, (clicks / impressions) * 100 AS CTR
FROM ab_test_campaigns2
WHERE campaign_name IN ('캠페인 A', '캠페인 B')
GROUP BY campaign_name
ORDER BY CTR DESC;

-- 퍼널 분석 (Funnel Analysis)
CREATE TABLE user_behavior2 (
    session_id VARCHAR(50) NOT NULL,
    page_viewed VARCHAR(100) NOT NULL,
    visit_date DATETIME NOT NULL
);

INSERT INTO user_behavior2 (session_id, page_viewed, visit_date) VALUES
('S101', '홈페이지', '2024-06-01 10:00:00'),
('S102', '상품 상세', '2024-06-02 14:30:00'),
('S103', '장바구니', '2024-06-03 09:50:00');

SELECT funnel_stage,
       users,
       LAG(users) OVER (ORDER BY step_order) AS previous_stage_users,
       ((LAG(users) OVER (ORDER BY step_order) - users) / LAG(users) OVER (ORDER BY step_order)) * 100 AS drop_off_rate
FROM (
    SELECT '방문' AS funnel_stage, COUNT(DISTINCT session_id) AS users, 1 AS step_order FROM user_behavior2
    UNION ALL
    SELECT '상품 상세', COUNT(DISTINCT session_id), 2 FROM user_behavior2 WHERE page_viewed = '상품 상세'
    UNION ALL
    SELECT '장바구니', COUNT(DISTINCT session_id), 3 FROM user_behavior2 WHERE page_viewed = '장바구니'
    UNION ALL
    SELECT '결제 완료', COUNT(DISTINCT session_id), 4 FROM user_behavior2 WHERE page_viewed = '결제 완료'
) AS funnel_data;

-- 마케팅 채널별 ROI 비교
CREATE TABLE marketing_roi2 (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    channel VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(10,2) NOT NULL
);

INSERT INTO marketing_roi2 (channel, budget, revenue) VALUES
('Google Ads', 8000000, 17000000),
('Facebook Ads', 7500000, 16000000),
('Instagram Ads', 6000000, 14000000),
('TikTok Ads', 5000000, 11000000),
('LinkedIn Ads', 5500000, 9000000),
('Twitter Ads', 4000000, 7200000),
('YouTube Ads', 10000000, 22000000),
('Bing Ads', 4500000, 8500000),
('Reddit Ads', 3000000, 5000000);

SELECT channel, ((revenue - budget) / budget) * 100 AS ROI
FROM marketing_roi2
GROUP BY channel
ORDER BY ROI DESC;

-- 구독 서비스 유지율 분석
CREATE TABLE subscription_data (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    cohort_month DATE NOT NULL,
    months_active INT NOT NULL
);

INSERT INTO subscription_data (cohort_month, months_active) VALUES
('2024-06-01', 14),
('2024-07-01', 12),
('2024-08-01', 16),
('2024-09-01', 10),
('2024-10-01', 15),
('2024-11-01', 18),
('2024-12-01', 12),
('2025-01-01', 14),
('2025-02-01', 17),
('2025-03-01', 16),
('2025-04-01', 15),
('2025-05-01', 19),
('2025-06-01', 14);

SELECT cohort_month,
       COUNT(DISTINCT user_id) AS initial_subscribers,
       COUNT(DISTINCT CASE WHEN months_active >= 3 THEN user_id END) AS retained_users,
       (COUNT(DISTINCT CASE WHEN months_active >= 3 THEN user_id END) / COUNT(DISTINCT user_id)) * 100 AS retention_rate
FROM subscription_data
GROUP BY cohort_month;

-- 광고 효율성 비교 (CPC, CPA 분석)
CREATE TABLE ad_cost_analysis2 (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(50) NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL
);

INSERT INTO ad_cost_analysis2 (campaign_name, budget, clicks, conversions) VALUES
('Google Ads', 8500000, 19000, 4200),
('Facebook Ads', 8000000, 18500, 3900),
('Instagram Ads', 7800000, 17000, 3800),
('TikTok Ads', 6000000, 14000, 3200),
('LinkedIn Ads', 5500000, 9000, 2000),
('Twitter Ads', 5000000, 11000, 2500),
('YouTube Ads', 12000000, 25000, 5000),
('Bing Ads', 4800000, 8000, 1800),
('Reddit Ads', 4000000, 7500, 1700);

SELECT campaign_name, SUM(budget) / SUM(clicks) AS CPC, SUM(budget) / SUM(conversions) AS CPA
FROM ad_cost_analysis2
GROUP BY campaign_name
ORDER BY CPC ASC;