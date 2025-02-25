from flask import Flask, request, jsonify, render_template
import mysql.connector

app = Flask(__name__)

# MariaDB 연결 설정
db_config = {
    "host": "localhost",
    "user": "hj",
    "password": "1234",
    "database": "backend"
}

# 광고 클릭 시 클릭수 증가
@app.route("/click", methods=["POST"])
def click_ad():
    ad_id = request.json.get("ad_id")

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # 클릭 수 증가
    cursor.execute("UPDATE ads SET clicks = clicks + 1 WHERE id = %s", (ad_id,))
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({"message": "Click registered"}), 200

# 광고 노출 시 views 증가
@app.route("/view", methods=["POST"])
def view_ad():
    ad_id = request.json.get("ad_id")

    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # 노출 수 증가
    cursor.execute("UPDATE ads SET views = views + 1 WHERE id = %s", (ad_id,))
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({"message": "View registered"}), 200

# CTR 데이터 가져오기
@app.route("/ctr", methods=["GET"])
def get_ctr():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # CTR 계산 (CTR = 클릭수 / 노출수 * 100)
    cursor.execute("SELECT id, ad_name, views, clicks, (clicks / views) * 100 AS ctr FROM ads WHERE views > 0")
    ads_data = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify(ads_data)

# 웹페이지 렌더링
@app.route("/")
def index():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)