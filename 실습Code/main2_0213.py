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

# 2. 테이블 생성 (이미 존재하면 삭제 후 생성)
cursor.execute("DROP TABLE IF EXISTS growth_marketing;")
cursor.execute("""
CREATE TABLE growth_marketing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    channel VARCHAR(50),
    budget INT,
    impressions INT,
    clicks INT,
    conversions INT,
    start_date DATE DEFAULT CURRENT_DATE
);
""")

# 3. 샘플 데이터 생성 (pandas DataFrame 활용)
data = {
    "channel": ["Google Ads", "Facebook Ads", "Instagram Ads"],
    "budget": [8000000, 7000000, 6500000],
    "impressions": [300000, 250000, 230000],
    "clicks": [20000, 18000, 17000],
    "conversions": [4000, 3500, 3400],
    "start_date": ["2024-06-01", "2024-07-01", "2024-08-01"]
}

df = pd.DataFrame(data)

# 4. 데이터 삽입
insert_query = "INSERT INTO growth_marketing (channel, budget, impressions, clicks, conversions, start_date) VALUES (%s, %s, %s, %s, %s, %s)"
values = [tuple(row) for row in df.to_numpy()]

cursor.executemany(insert_query, values)
conn.commit()

print("데이터 삽입 완료")

# 5. 데이터 조회 및 pandas DataFrame으로 변환
cursor.execute("SELECT * FROM growth_marketing")
rows = cursor.fetchall()

# 컬럼명 가져오기
column_names = [desc[0] for desc in cursor.description]
df_result = pd.DataFrame(rows, columns=column_names)

# 6. 결과 출력 (pandas 기본 출력 방식 사용)
print("\n=== Growth Marketing Table Data ===")
print(df_result.to_string(index=False))  # 인덱스 없이 출력

# CSV로 저장 (필요한 경우)
df_result.to_csv("growth_marketing_data.csv", index=False, encoding="utf-8")
print("데이터를 'growth_marketing_data.csv' 파일로 저장하였습니다.")

# 연결 종료
cursor.close()
conn.close()