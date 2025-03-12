from flask import Flask, render_template, jsonify
import mysql.connector

app = Flask(__name__)

# MariaDB 연결 설정
db_config = {
    "host": "localhost",
    "user": "hj",
    "password": "1234",
    "database": "backend"
}

# 데이터베이스 연결 함수
def get_db_connection():
    return mysql.connector.connect(**db_config)

# API: 모든 마케팅 데이터 조회
@app.route('/growth-marketing', methods=['GET'])
def get_growth_marketing_data():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM growth_marketing")
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(data)

# 웹 페이지 렌더링
@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)