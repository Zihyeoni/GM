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
cursor.execute("DROP TABLE IF EXISTS employees;")
cursor.execute("""
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);
""")

# 3. 샘플 데이터 생성 (pandas DataFrame 활용)
data = {
    "name": ["Alice", "Bob", "Charlie", "David", "Eve"],
    "age": [25, 30, 35, 28, 40],
    "department": ["HR", "IT", "Finance", "Marketing", "IT"],
    "salary": [50000, 70000, 80000, 60000, 90000]
}

df = pd.DataFrame(data)

# 4. 데이터 삽입
insert_query = "INSERT INTO employees (name, age, department, salary) VALUES (%s, %s, %s, %s)"
values = [tuple(row) for row in df.to_numpy()]

cursor.executemany(insert_query, values)
conn.commit()

print("데이터 삽입 완료")

# 5. 데이터 조회 및 pandas DataFrame으로 변환
cursor.execute("SELECT * FROM employees")
rows = cursor.fetchall()

# 컬럼명 가져오기
column_names = [desc[0] for desc in cursor.description]
df_result = pd.DataFrame(rows, columns=column_names)

# 6. 결과 출력 (pandas 기본 출력 방식 사용)
print("\n=== Employees Table Data ===")
print(df_result.to_string(index=False))  # 인덱스 없이 출력

# CSV로 저장 (필요한 경우)
df_result.to_csv("employees_data.csv", index=False, encoding="utf-8")
print("데이터를 'employees_data.csv' 파일로 저장하였습니다.")

# 연결 종료
cursor.close()
conn.close()