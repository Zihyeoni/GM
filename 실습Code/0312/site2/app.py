from flask import Flask, request, jsonify, render_template
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression

app = Flask(__name__)

# 가상의 고객 데이터 생성
data = {
    'age': [22, 45, 25, 33, 50, 41, 29, 39, 48, 23, 31, 36, 27, 40, 53, 44, 26, 38, 51, 30],
    'monthly_purchases': [1, 5, 2, 3, 6, 4, 2, 3, 5, 1, 3, 4, 2, 4, 6, 5, 2, 3, 5, 2],
    'monthly_spending': [50, 300, 80, 200, 400, 250, 100, 220, 380, 60, 180, 240, 90, 270, 420, 320, 75, 230, 390, 110],
    'customer_support_calls': [3, 1, 4, 2, 0, 1, 3, 2, 0, 4, 2, 1, 3, 1, 0, 1, 4, 2, 0, 3],
    'loyalty_level': [0, 2, 0, 1, 2, 1, 0, 1, 2, 0, 1, 1, 0, 1, 2, 1, 0, 1, 2, 0]  # 0=낮음, 1=중간, 2=높음
}

df = pd.DataFrame(data)

# 데이터 분할
X = df[['age', 'monthly_purchases', 'monthly_spending', 'customer_support_calls']]
y = df['loyalty_level']

# 학습 및 테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

# 데이터 정규화
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# 로지스틱 회귀 모델 학습
model = LogisticRegression(multi_class='multinomial', solver='lbfgs', max_iter=200)
model.fit(X_train, y_train)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # 폼에서 받은 데이터
        age = float(request.form['age'])
        monthly_purchases = float(request.form['monthly_purchases'])
        monthly_spending = float(request.form['monthly_spending'])
        customer_support_calls = float(request.form['customer_support_calls'])

        # 입력 데이터 변환 및 예측
        input_data = np.array([[age, monthly_purchases, monthly_spending, customer_support_calls]])
        input_scaled = scaler.transform(input_data)
        predicted_class = model.predict(input_scaled)[0]
        predicted_proba = model.predict_proba(input_scaled)[0]

        loyalty_labels = {0: "낮음", 1: "중간", 2: "높음"}
        result = {
            "predicted_class": loyalty_labels[predicted_class],
            "probabilities": {
                "낮음": round(predicted_proba[0], 2),
                "중간": round(predicted_proba[1], 2),
                "높음": round(predicted_proba[2], 2)
            }
        }

        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)