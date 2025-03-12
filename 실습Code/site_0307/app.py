from flask import Flask, request, render_template, jsonify
import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score, classification_report

app = Flask(__name__)

# 고객 데이터 (그로스 마케팅 성과지표)
data = pd.DataFrame([
    [5, 1000, 2, 0.05, 0, 1],   # VIP 고객
    [3, 700, 7, 0.02, 1, 2],    # 일반 고객
    [1, 100, 30, 0.01, 2, 3],   # 이탈 위험 고객
    [4, 900, 3, 0.04, 0, 1],    # VIP 고객
    [2, 300, 15, 0.03, 1, 2],   # 일반 고객
    [1, 50, 40, 0.005, 3, 3],   # 이탈 위험 고객
    [5, 1200, 1, 0.06, 0, 1],   # VIP 고객
    [3, 600, 10, 0.025, 1, 2],  # 일반 고객
    [2, 200, 20, 0.015, 2, 3],  # 이탈 위험 고객
    [4, 800, 5, 0.045, 0, 1],   # VIP 고객
    [3, 650, 8, 0.022, 1, 2],   # 일반 고객
    [1, 120, 35, 0.008, 3, 3],  # 이탈 위험 고객
    [5, 1300, 1, 0.065, 0, 1],  # VIP 고객
    [2, 250, 22, 0.018, 2, 3],  # 이탈 위험 고객
    [3, 750, 6, 0.03, 1, 2],    # 일반 고객
    [4, 850, 4, 0.04, 0, 1],    # VIP 고객
    [1, 90, 38, 0.007, 3, 3],   # 이탈 위험 고객
    [2, 280, 17, 0.02, 2, 2],   # 일반 고객
    [5, 1400, 2, 0.07, 0, 1],   # VIP 고객
    [3, 720, 9, 0.025, 1, 2]    # 일반 고객
], columns=["방문 빈도", "구매 금액", "최근 구매일", "CTR", "반품 횟수", "고객 세그먼트"])

# 입력(X) / 출력(y) 데이터 설정
X = data.drop(columns=["고객 세그먼트"])
y = data["고객 세그먼트"]

# 데이터 표준화
scaler = StandardScaler()
X_scaled = pd.DataFrame(scaler.fit_transform(X), columns=X.columns)

# 학습 & 테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.3, random_state=42, stratify=y)

# 로지스틱 회귀 모델 학습
model = LogisticRegression(solver='lbfgs', max_iter=500)
model.fit(X_train, y_train)

# 고객 세그먼트 매핑
segment_labels = {1: "VIP 고객", 2: "일반 고객", 3: "이탈 위험 고객"}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # 클라이언트에서 JSON 데이터 받기
        data = request.json
        input_data = np.array([[data['visit'], data['purchase'], data['recency'], data['ctr'], data['returns']]])

        # 표준화
        input_scaled = scaler.transform(input_data)

        # 예측
        prediction = model.predict(input_scaled)[0]
        prediction_label = segment_labels[prediction]

        return jsonify({'prediction': prediction_label})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
