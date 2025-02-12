-- [FOREIGN KEY]
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO customers (name, email, phone) VALUES
('김철수', 'chulsoo@example.com', '010-1234-5678'),
('이영희', 'younghee@example.com', '010-2233-4455'),
('박민수', 'minsoo@example.com', '010-3344-5566'),
('김현우', 'hyunwoo@example.com', '010-4455-6677'), -- 주문 없음
('정수진', 'soojin@example.com', '010-5566-7788'); -- 주문 없음

INSERT INTO orders (customer_id, product, price, order_date) VALUES
(1, '노트북', 1500000, '2024-01-10'),
(2, '스마트폰', 800000, '2024-02-15'),
(1, '무선 이어폰', 200000, '2024-03-01'),
(3, '태블릿', 600000, '2024-03-10'),
(2, '스마트워치', 350000, '2024-04-05');

-- [INNER JOIN]
SELECT 
    customers.name,    -- 고객 이름 (customers 테이블에서 가져옴)
    customers.email,   -- 고객 이메일 (customers 테이블에서 가져옴)
    orders.product,    -- 주문한 제품명 (orders 테이블에서 가져옴)
    orders.price,      -- 주문한 제품 가격 (orders 테이블에서 가져옴)
    orders.order_date  -- 주문 날짜 (orders 테이블에서 가져옴)
FROM customers  -- 고객 정보를 포함하는 테이블
INNER JOIN orders  -- 고객과 주문 데이터를 결합
ON customers.id = orders.customer_id;  -- 고객 ID를 기준으로 두 테이블을 연결 (조인 조건)

-- [LEFT JOIN]
SELECT customers.name, customers.email, orders.product, orders.price, orders.order_date
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

-- [RIGHT JOIN]
SELECT customers.name, customers.email, orders.product, orders.price, orders.order_date
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- [UNION (FULL OUTER JOIN 대체)]
SELECT customers.name, customers.email, orders.product, orders.price, orders.order_date
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
UNION
SELECT customers.name, customers.email, orders.product, orders.price, orders.order_date
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- 연습 문제
CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(5) NOT NULL,
    grade VARCHAR(5) NOT NULL,
    class_id INT
);

INSERT INTO student (name, grade, class_id) VALUES
('김민수', '1학년', 1),
('이지은', '2학년', 2),
('박철수', '3학년', 1),
('최영희', '1학년', 3),
('정우성', '2학년', NULL);

CREATE TABLE class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    subject VARCHAR(5) NOT NULL,
    teacher VARCHAR(5) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES student(student_id) ON DELETE CASCADE
);

INSERT INTO class (class_id, subject, teacher) VALUES
(1, '수학', '이승기'),
(2, '과학', '한지민'),
(3, '영어', '김태희');

SELECT student.student_id, student.name, student.grade, class.subject, class.teacher
FROM student
INNER JOIN class ON student.class_id = class.class_id;

SELECT student.student_id, student.name, student.grade, class.subject, class.teacher
FROM student
LEFT JOIN class ON student.class_id = class.class_id;

INSERT INTO class (class_id, subject, teacher) VALUES (4, '음악', '유재석');

SELECT student.student_id, student.name, student.grade, class.subject, class.teacher
FROM student
LEFT JOIN class ON student.class_id = class.class_id
UNION
SELECT student.student_id, student.name, student.grade, class.subject, class.teacher
FROM student
RIGHT JOIN class ON student.class_id = class.class_id;

SELECT student.student_id, student.name, student.grade, class.subject, class.teacher
FROM student
RIGHT JOIN class ON student.class_id = class.class_id;

-- [집계 함수]
SELECT COUNT(*) AS total_orders FROM orders;

SELECT customers.name, COUNT(orders.id) AS order_count
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

SELECT customers.name, SUM(orders.price) AS total_spent
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

SELECT product, MAX(price) AS highest_price FROM orders;

SELECT customers.name, COUNT(orders.id) AS order_count
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name
ORDER BY order_count DESC
LIMIT 1;

SELECT SUM(price) AS total_sales
FROM orders
WHERE order_date BETWEEN '2024-03-01' AND '2024-04-30';

SELECT MONTH(order_date) AS order_month, COUNT(*) AS order_count
FROM orders
GROUP BY order_month
ORDER BY order_month ASC;

-- 국가별 마케팅 성과 테이블
CREATE TABLE marketing_korea (
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

CREATE TABLE marketing_usa (
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

CREATE TABLE marketing_europe (
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

-- 이메일 및 SNS 캠페인 반응 데이터 테이블
CREATE TABLE email_campaign (
    customer_id INT,
    campaign_name VARCHAR(100),
    clicks INT
);

CREATE TABLE sns_campaign (
    customer_id INT,
    campaign_name VARCHAR(100),
    clicks INT
);

-- 1) 한국 마케팅 캠페인 성과 데이터 삽입
INSERT INTO marketing_korea VALUES
('Korea', '겨울 할인 이벤트', 500000),
('Korea', '신규 회원 웰컴 이벤트', 300000),
('Korea', '특가 프로모션', 700000),
('Korea', '봄맞이 할인', 400000),
('Korea', '회원 전용 세일', 550000);

-- 2) 미국 마케팅 캠페인 성과 데이터 삽입
INSERT INTO marketing_usa VALUES
('USA', 'Winter Sale', 600000),
('USA', 'New Member Promo', 350000),
('USA', 'Exclusive Deal', 800000),
('USA', 'Spring Discount', 450000),
('USA', 'VIP Members Only', 600000);

-- 3) 유럽 마케팅 캠페인 성과 데이터 삽입
INSERT INTO marketing_europe VALUES
('Europe', 'Winter Discount', 550000),
('Europe', 'Signup Bonus', 320000),
('Europe', 'Limited Offer', 750000),
('Europe', 'Easter Sale', 430000),
('Europe', 'Members-Only Discount', 570000);

-- 4) 이메일 캠페인 데이터 삽입
INSERT INTO email_campaign VALUES
(1, '겨울 할인 이벤트', 8),
(2, '신규 회원 웰컴 이벤트', 5),
(3, '특가 프로모션', 12),
(4, '봄맞이 할인', 3),
(5, '회원 전용 세일', 7),
(6, '여름 한정 할인', 2),
(7, '연말 특별 세일', 10),
(8, 'VIP 고객 특별 혜택', 15),
(9, '신상품 출시 기념', 6),
(10, '한정판 할인', 9);

-- 5) SNS 캠페인 데이터 삽입
INSERT INTO sns_campaign VALUES
(1, '인스타그램 광고', 20),
(2, '페이스북 광고', 15),
(3, '틱톡 바이럴', 25),
(4, '유튜브 리뷰', 10),
(5, '트위터 프로모션', 18),
(6, '카카오톡 친구 추가 이벤트', 5),
(7, '네이버 블로그 후기', 8),
(8, '네이버 쇼핑 라이브', 30),
(9, '유튜브 숏츠 광고', 22),
(10, '페이스북 리타겟팅 광고', 12);

SELECT region, campaign_name, revenue FROM marketing_korea
UNION
SELECT region, campaign_name, revenue FROM marketing_usa
UNION
SELECT region, campaign_name, revenue FROM marketing_europe;

SELECT customer_id, campaign_name, clicks, 'Email' AS channel
FROM email_campaign
UNION
SELECT customer_id, campaign_name, clicks 'SNS' AS channel
FROM sns_campaign;

SELECT region, campaign_name, revenue FROM marketing_korea
UNION ALL
SELECT region, campaign_name, revenue FROM marketing_usa
UNION ALL
SELECT region, campaign_name, revenue FROM marketing_europe;

SELECT region, campaign_name, revenue FROM marketing_korea
UNION
SELECT region, campaign_name, revenue FROM marketing_usa
UNION
SELECT region, campaign_name, revenue FROM marketing_europe
ORDER BY revenue DESC;

SELECT customer_id, campaign_name, clicks, 'A' AS test_group
FROM email_campaign
UNION
SELECT customer_id, campaign_name, clicks, 'B' AS test_group
FROM sns_campaign;

-- [JOIN 활용한 그로스 마케팅]
-- [1. 고객 정보와 구매 데이터 JOIN하여 VIP 고객 분석]
-- 고객 테이블
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- 구매 테이블
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    purchase_date DATE
);

-- 고객 데이터 삽입
INSERT INTO customers VALUES
(1, '김영희', 'younghee@email.com'),
(2, '이철수', 'cheolsu@email.com'),
(3, '박지수', 'jisu@email.com'),
(4, '최민수', 'minsu@email.com'),
(5, '한지혜', 'jihye@email.com');

-- 구매 데이터 삽입
INSERT INTO purchases VALUES
(101, 1, 50000, '2024-02-01'),
(102, 1, 60000, '2024-02-02'), -- 김영희 총 110,000
(103, 2, 40000, '2024-02-03'),
(104, 2, 30000, '2024-02-04'), -- 이철수 총 70,000
(105, 3, 150000, '2024-02-05'), -- 박지수 총 150,000 (VIP)
(106, 4, 90000, '2024-02-06'),
(107, 4, 50000, '2024-02-07'), -- 최민수 총 140,000 (VIP)
(108, 5, 25000, '2024-02-08');

SELECT c.customer_id, c.name, c.email, p.total_spent
FROM customers c
JOIN (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM purchases
    GROUP BY customer_id
) p ON c.customer_id = p.customer_id
WHERE p.total_spent > 100000;

-- [2. 이메일 캠페인 반응과 구매 데이터 연결]
-- 1) 고객 테이블
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- 2) 이메일 캠페인 반응 테이블
CREATE TABLE email_campaign (
    campaign_id INT PRIMARY KEY,
    customer_id INT,
    campaign_name VARCHAR(100),
    clicks INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3) 구매 테이블
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2),
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 1) 고객 데이터 삽입
INSERT INTO customers VALUES
(1, '김영희', 'younghee@email.com'),
(2, '이철수', 'cheolsu@email.com'),
(3, '박지수', 'jisu@email.com'),
(4, '최민수', 'minsu@email.com'),
(5, '한지혜', 'jihye@email.com');

-- 2) 이메일 캠페인 데이터 삽입
INSERT INTO email_campaign VALUES
(101, 1, '겨울 할인 이벤트', 8),  -- 클릭 수 8 (조건 충족)
(102, 2, '신규 회원 웰컴 이벤트', 5), -- 클릭 수 5 (조건 미충족)
(103, 3, '특가 프로모션', 12), -- 클릭 수 12 (조건 충족)
(104, 4, '봄맞이 할인', 3), -- 클릭 수 3 (조건 미충족)
(105, 5, 'VIP 고객 혜택', 10); -- 클릭 수 10 (조건 충족)

-- 3) 구매 데이터 삽입
INSERT INTO purchases VALUES
(201, 1, 50000, '2024-02-01'),
(202, 3, 120000, '2024-02-02'),
(203, 5, 80000, '2024-02-03');

SELECT c.email, e.campaign_name, e.clicks, p.purchase_amount, p.purchase_date
FROM email_campaign e
JOIN customers c ON e.customer_id = c.customer_id
LEFT JOIN purchases p ON c.customer_id = p.customer_id
WHERE e.clicks >= 10;

-- [3. 유입 채널별 전환율 분석]
-- 1) 방문자 트래킹 테이블 (유입 채널 데이터)
CREATE TABLE user_tracking (
    tracking_id INT PRIMARY KEY,
    user_id INT,
    channel VARCHAR(50),
    visit_date DATE
);

-- 2) 구매 테이블 (고객 구매 데이터)
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2),
    purchase_date DATE
);

-- 1) 방문자 데이터 삽입 (유입 채널별 방문자 ID 포함)
INSERT INTO user_tracking VALUES
(1, 101, 'Google Ads', '2024-02-01'),
(2, 102, 'Google Ads', '2024-02-01'),
(3, 103, 'Facebook Ads', '2024-02-02'),
(4, 104, 'Facebook Ads', '2024-02-02'),
(5, 105, 'Instagram Ads', '2024-02-03'),
(6, 106, 'Instagram Ads', '2024-02-03'),
(7, 107, 'Instagram Ads', '2024-02-03'),
(8, 108, 'YouTube Ads', '2024-02-04'),
(9, 109, 'YouTube Ads', '2024-02-04'),
(10, 110, 'YouTube Ads', '2024-02-04'),
(11, 111, 'YouTube Ads', '2024-02-04');

-- 2) 구매 데이터 삽입 (일부 방문자가 실제로 구매한 데이터)
INSERT INTO purchases VALUES
(201, 101, 50000, '2024-02-02'), -- Google Ads 방문자 1명 구매
(202, 103, 75000, '2024-02-03'), -- Facebook Ads 방문자 1명 구매
(203, 105, 120000, '2024-02-04'), -- Instagram Ads 방문자 1명 구매
(204, 110, 90000, '2024-02-05'); -- YouTube Ads 방문자 1명 구매

SELECT u.channel, COUNT(DISTINCT u.user_id) AS visitors, 
    COUNT(DISTINCT p.customer_id) AS buyers, (COUNT(p.customer_id) / COUNT(u.user_id)) * 100 AS conversion_rate
FROM user_tracking u
LEFT JOIN purchases p ON u.user_id = p.customer_id
GROUP BY u.channel;

-- [4. 장바구니 이탈 고객 찾기]
-- 1) 고객 테이블
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- 2) 장바구니 아이템 테이블 (고객이 담은 상품 목록)
CREATE TABLE cart_items (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3) 구매 테이블 (구매한 고객 정보)
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2),
    purchase_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 1) 고객 데이터 삽입
INSERT INTO customers VALUES
(1, '김영희', 'younghee@email.com'),
(2, '이철수', 'cheolsu@email.com'),
(3, '박지수', 'jisu@email.com'),
(4, '최민수', 'minsu@email.com'),
(5, '한지혜', 'jihye@email.com');

-- 2) 장바구니 데이터 삽입 (상품을 담은 고객 정보)
INSERT INTO cart_items VALUES
(101, 1, '노트북', 1200000, 1),
(102, 2, '스마트폰', 800000, 1),
(103, 3, '태블릿', 600000, 1),
(104, 4, '무선 이어폰', 200000, 2),
(105, 5, '스마트워치', 350000, 1);

-- 3) 구매 데이터 삽입 (일부 고객만 구매)
INSERT INTO purchases VALUES
(201, 1, 1200000, '2024-02-02'), -- 김영희는 구매 완료
(202, 3, 600000, '2024-02-04'); -- 박지수는 구매 완료

SELECT c.customer_id, c.name, c.email, i.product_name, i.cart_total
FROM customers c
JOIN (
    SELECT customer_id, product_name, SUM(price * quantity) AS cart_total
    FROM cart_items
    GROUP BY customer_id
) i ON i.customer_id = c.customer_id
LEFT JOIN purchases p ON p.customer_id = c.customer_id;
WHERE p.customer_id IS NULL;

-- [5. 마케팅 비용 대비 매출 분석]
-- 1) 마케팅 비용 테이블 (광고 캠페인별 지출 데이터)
CREATE TABLE marketing_spend (
    campaign_id INT PRIMARY KEY,
    campaign_name VARCHAR(100),
    ad_spend DECIMAL(10,2) -- 마케팅 비용
);

-- 2) 구매 테이블 (구매 내역 데이터)
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    campaign_id INT,
    amount DECIMAL(10,2), -- 구매 금액
    purchase_date DATE,
    FOREIGN KEY (campaign_id) REFERENCES marketing_spend(campaign_id)
);

-- 1) 마케팅 비용 데이터 삽입
INSERT INTO marketing_spend VALUES
(1, 'Google Ads Campaign', 1000000),
(2, 'Facebook Ads Campaign', 800000),
(3, 'Instagram Ads Campaign', 600000),
(4, 'YouTube Ads Campaign', 1200000),
(5, 'TikTok Ads Campaign', 700000);

-- 2) 구매 데이터 삽입 (각 캠페인에서 발생한 매출 데이터)
INSERT INTO purchases VALUES
(101, 1, 300000, '2024-02-01'),
(102, 1, 400000, '2024-02-02'),
(103, 1, 500000, '2024-02-03'),
(104, 2, 250000, '2024-02-01'),
(105, 2, 350000, '2024-02-02'),
(106, 3, 700000, '2024-02-03'), -- 광고비보다 높은 매출
(107, 4, 800000, '2024-02-04'),
(108, 4, 600000, '2024-02-05'),
(109, 5, 500000, '2024-02-06');

SELECT m.campaign_id, m.campaign_name, m.ad_spend, SUM(p.amount) AS total_revenue,
    (SUM(p.amount) - m.ad_spend) AS profit
FROM marketing_spend m
JOIN purchases p ON p.campaign_id = m.campaign_id
GROUP BY m.campaign_id, m.ad_spend;

-- [UNION 활용한 그로스 마케팅]
-- [1. 이메일과 SNS 캠페인 반응 데이터 통합]
-- 1) 이메일 캠페인 반응 테이블
CREATE TABLE email_campaign (
    campaign_id INT PRIMARY KEY,
    customer_id INT,
    campaign_name VARCHAR(100),
    clicks INT
);

-- 2) SNS 캠페인 반응 테이블
CREATE TABLE sns_campaign (
    campaign_id INT PRIMARY KEY,
    customer_id INT,
    campaign_name VARCHAR(100),
    clicks INT
);

-- 1) 이메일 캠페인 데이터 삽입
INSERT INTO email_campaign VALUES
(101, 1, '겨울 할인 이벤트', 8),
(102, 2, '신규 회원 웰컴 이벤트', 5),
(103, 3, '특가 프로모션', 12),
(104, 4, '봄맞이 할인', 3),
(105, 5, 'VIP 고객 혜택', 10);

-- 2) SNS 캠페인 데이터 삽입
INSERT INTO sns_campaign VALUES
(201, 1, '인스타그램 광고', 20),
(202, 2, '페이스북 광고', 15),
(203, 3, '틱톡 바이럴', 25),
(204, 4, '유튜브 리뷰', 10),
(205, 5, '트위터 프로모션', 18);

SELECT customer_id, campaign_name, clicks, 'Email' AS channel
FROM email_campaign
UNION
SELECT customer_id, campaign_name, clicks, 'SNS' AS channel
FROM sns_campaign;

-- [2. 여러 국가에서의 마케팅 성과 통합]
-- 1) 한국 마케팅 성과 테이블
CREATE TABLE marketing_korea (
    campaign_id INT PRIMARY KEY,
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

-- 2) 미국 마케팅 성과 테이블
CREATE TABLE marketing_usa (
    campaign_id INT PRIMARY KEY,
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

-- 3) 유럽 마케팅 성과 테이블
CREATE TABLE marketing_europe (
    campaign_id INT PRIMARY KEY,
    region VARCHAR(50),
    campaign_name VARCHAR(100),
    revenue DECIMAL(10,2)
);

-- 1) 한국 마케팅 성과 데이터 삽입
INSERT INTO marketing_korea VALUES
(101, 'Korea', '겨울 할인 이벤트', 500000),
(102, 'Korea', '신규 회원 웰컴 이벤트', 300000),
(103, 'Korea', '특가 프로모션', 700000),
(104, 'Korea', '봄맞이 할인', 400000),
(105, 'Korea', '회원 전용 세일', 550000);

-- 2) 미국 마케팅 성과 데이터 삽입
INSERT INTO marketing_usa VALUES
(201, 'USA', 'Winter Sale', 600000),
(202, 'USA', 'New Member Promo', 350000),
(203, 'USA', 'Exclusive Deal', 800000),
(204, 'USA', 'Spring Discount', 450000),
(205, 'USA', 'VIP Members Only', 600000);

-- 3) 유럽 마케팅 성과 데이터 삽입
INSERT INTO marketing_europe VALUES
(301, 'Europe', 'Winter Discount', 550000),
(302, 'Europe', 'Signup Bonus', 320000),
(303, 'Europe', 'Limited Offer', 750000),
(304, 'Europe', 'Easter Sale', 430000),
(305, 'Europe', 'Members-Only Discount', 570000);

SELECT region, campaign_name, revenue FROM marketing_korea
UNION
SELECT region, campaign_name, revenue FROM marketing_usa
UNION
SELECT region, campaign_name, revenue FROM marketing_europe;

-- [3. 웹사이트, 모바일 앱, 오프라인 구매 데이터 통합]
-- 1) 웹사이트 구매 테이블
CREATE TABLE web_purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2)
);

-- 2) 모바일 앱 구매 테이블
CREATE TABLE app_purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2)
);

-- 3) 오프라인 구매 테이블
CREATE TABLE offline_purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_amount DECIMAL(10,2)
);

-- 1) 웹사이트 구매 데이터 삽입
INSERT INTO web_purchases VALUES
(101, 1, 75000),
(102, 2, 160000),
(103, 3, 220000),
(104, 4, 85000),
(105, 5, 135000);

-- 2) 모바일 앱 구매 데이터 삽입
INSERT INTO app_purchases VALUES
(201, 1, 70000),
(202, 2, 140000),
(203, 3, 190000),
(204, 4, 72000),
(205, 5, 120000);

-- 3) 오프라인 구매 데이터 삽입
INSERT INTO offline_purchases VALUES
(301, 1, 90000),
(302, 2, 180000),
(303, 3, 230000),
(304, 4, 95000),
(305, 5, 145000);

SELECT customer_id, 'Web' AS source, purchase_amount FROM web_purchases
UNION
SELECT customer_id, 'App' AS source, purchase_amount FROM app_purchases
UNION
SELECT customer_id, 'Offline' AS source, purchase_amount FROM offline_purchases;

-- [4. A/B 테스트 그룹별 성과 비교]
-- 1) A/B 테스트 그룹 A 테이블
CREATE TABLE ab_test_group_a (
    user_id INT PRIMARY KEY,
    conversion BOOLEAN
);

-- 2) A/B 테스트 그룹 B 테이블
CREATE TABLE ab_test_group_b (
    user_id INT PRIMARY KEY,
    conversion BOOLEAN
);

-- 1) A 그룹 테스트 데이터 삽입
INSERT INTO ab_test_group_a VALUES
(101, TRUE),
(102, FALSE),
(103, TRUE),
(104, FALSE),
(105, TRUE);

-- 2) B 그룹 테스트 데이터 삽입
INSERT INTO ab_test_group_b VALUES
(201, FALSE),
(202, TRUE),
(203, FALSE),
(204, TRUE),
(205, FALSE);

SELECT user_id, 'Group A' AS test_group, conversion FROM ab_test_group_a
UNION
SELECT user_id, 'Group B' AS test_group, conversion FROM ab_test_group_b;

-- [5. 여러 마케팅 채널별 ROI 통합]
-- 1) Google Ads 마케팅 성과 테이블
CREATE TABLE google_ads (
    channel VARCHAR(50),
    ad_spend DECIMAL(10,2),
    revenue DECIMAL(10,2)
);

-- 2) Facebook Ads 마케팅 성과 테이블
CREATE TABLE facebook_ads (
    channel VARCHAR(50),
    ad_spend DECIMAL(10,2),
    revenue DECIMAL(10,2)
);

-- 3) TikTok Ads 마케팅 성과 테이블
CREATE TABLE tiktok_ads (
    channel VARCHAR(50),
    ad_spend DECIMAL(10,2),
    revenue DECIMAL(10,2)
);

-- 1) Google Ads 성과 데이터 삽입
INSERT INTO google_ads VALUES
('Google Ads', 1500000, 4500000),
('Google Ads', 1000000, 3200000),
('Google Ads', 800000, 2500000);

-- 2) Facebook Ads 성과 데이터 삽입
INSERT INTO facebook_ads VALUES
('Facebook Ads', 1200000, 3800000),
('Facebook Ads', 900000, 2900000),
('Facebook Ads', 700000, 2000000);

-- 3) TikTok Ads 성과 데이터 삽입
INSERT INTO tiktok_ads VALUES
('TikTok Ads', 1100000, 3400000),
('TikTok Ads', 950000, 2800000),
('TikTok Ads', 600000, 1800000);

SELECT channel, ((revenue - ad_spend) / ad_spend) * 100 AS ROI FROM google_ads
UNION
SELECT channel, ((revenue - ad_spend) / ad_spend) * 100 AS ROI FROM facebook_ads
UNION
SELECT channel, ((revenue - ad_spend) / ad_spend) * 100 AS ROI FROM tiktok_ads;