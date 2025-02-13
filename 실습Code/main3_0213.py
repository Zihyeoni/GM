import mysql.connector
import pandas as pd

# 1. MariaDB 연결 설정
db_config = {
    "host": "localhost",      # MariaDB 서버 주소
    "user": "hj",             # 사용자 이름
    "password": "1234",       # 비밀번호
    "database": "backend"     # 사용할 데이터베이스
}

# MariaDB 연결
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# 2. 기존 테이블 삭제 후 새로 생성
cursor.execute("DROP TABLE IF EXISTS growth_marketing;")
cursor.execute("""
CREATE TABLE growth_marketing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(100),
    date DATE,
    impressions INT,
    clicks INT,
    conversions INT,
    cost DECIMAL(10,2),
    revenue DECIMAL(10,2)
);
""")

# 3. 샘플 데이터 생성 (pandas DataFrame 활용)
data = {
    "campaign_name": ["Google Ads", "Facebook Ads", "Instagram Ads", "YouTube Ads", "LinkedIn Ads"],
    "date": ["2025-02-01", "2025-02-02", "2025-02-03", "2025-02-04", "2025-02-05"],
    "impressions": [10000, 15000, 12000, 18000, 11000],
    "clicks": [500, 750, 600, 900, 550],
    "conversions": [50, 70, 60, 80, 55],
    "cost": [100000, 150000, 120000, 180000, 110000],
    "revenue": [500000, 750000, 600000, 900000, 550000]
}

df = pd.DataFrame(data)

# 4. 데이터 삽입
insert_query = """
INSERT INTO growth_marketing (campaign_name, date, impressions, clicks, conversions, cost, revenue)
VALUES (%s, %s, %s, %s, %s, %s, %s)
"""
values = [tuple(row) for row in df.to_numpy()] #2차원 배열로 변환하고 각행을 순차적으로 가져온 후 각행(row)을 튜플로 변환
cursor.executemany(insert_query, values)
conn.commit()

print("데이터 삽입 완료")

# 5. 데이터 조회 및 지표 계산
cursor.execute("SELECT * FROM growth_marketing")
rows = cursor.fetchall()

# 컬럼명 가져오기
column_names = [desc[0] for desc in cursor.description]
df_result = pd.DataFrame(rows, columns=column_names)

# 6. 그로스 마케팅 지표 계산 (CTR, CVR, ROAS)
df_result["CTR (%)"] = (df_result["clicks"] / df_result["impressions"]) * 100
df_result["CVR (%)"] = (df_result["conversions"] / df_result["clicks"]) * 100
df_result["ROAS (%)"] = (df_result["revenue"] / df_result["cost"]) * 100

# 7. 결과 출력 (pandas 기본 출력)
print("\n=== Growth Marketing Performance Metrics ===")
print(df_result[["campaign_name", "date", "CTR (%)", "CVR (%)", "ROAS (%)"]].to_string(index=False))

# CSV로 저장 (필요한 경우)
df_result.to_csv("growth_marketing_metrics.csv", index=False, encoding="utf-8")
print("지표 데이터를 'growth_marketing_metrics.csv' 파일로 저장하였습니다.")

# 연결 종료
cursor.close()
conn.close()