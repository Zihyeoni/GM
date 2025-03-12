from flask import Flask, jsonify, request
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

# API: 특정 마케팅 채널 데이터 조회
@app.route('/growth-marketing/<channel>', methods=['GET'])
def get_marketing_by_channel(channel):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM growth_marketing WHERE channel = %s", (channel,))
    data = cursor.fetchall()

    cursor.close()
    conn.close()

    if not data:
        return jsonify({"error": "해당 마케팅 채널의 데이터가 없습니다."}), 404

    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
