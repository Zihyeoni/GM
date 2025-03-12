from flask import Flask, request, render_template
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

app = Flask(__name__)

# 데이터셋 로드
file_path = 'sales.csv'
df = pd.read_csv(file_path)

# 'PurchaseAmount (원)' 컬럼명을 'PurchaseAmount'로 변경
df.rename(columns={'PurchaseAmount (원)': 'PurchaseAmount'}, inplace=True)

# 필요한 데이터 전처리
X = df[['Age', 'Gender', 'ClothingCategory', 'Brand', 'PurchaseAmount']]  # 필요한 특성만 선택
y = df['Email']  # 타겟 변수 (Email)

# 범주형 데이터를 수치형으로 변환
X = pd.get_dummies(X)

# 데이터셋을 학습과 테스트 세트로 분할
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# K-NN 모델 학습
knn = KNeighborsClassifier(n_neighbors=3)
knn.fit(X_train, y_train)

# 드롭다운 옵션을 위한 고유 값 추출
gender_options = df['Gender'].unique().tolist()
clothing_category_options = df['ClothingCategory'].unique().tolist()
brand_options = df['Brand'].unique().tolist()

@app.route('/')
def index():
    return render_template('index.html', 
                           gender_options=gender_options, 
                           clothing_category_options=clothing_category_options, 
                           brand_options=brand_options)

@app.route('/predict', methods=['POST'])
def predict_customer():
    if request.method == 'POST':
        # 폼에서 입력된 데이터를 가져옴
        age = int(request.form['age'])
        gender = request.form['gender']
        clothing_category = request.form['clothing_category']
        brand = request.form['brand']
        purchase_amount = int(request.form['purchase_amount'])

        # 새로운 고객 데이터 프레임 생성
        new_customer = pd.DataFrame({
            'Age': [age],
            'Gender': [gender],
            'ClothingCategory': [clothing_category],
            'Brand': [brand],
            'PurchaseAmount': [purchase_amount]
        })

        # 새로운 고객 데이터에 대해 One-Hot Encoding 적용
        new_customer = pd.get_dummies(new_customer)
        new_customer = new_customer.reindex(columns=X.columns, fill_value=0)

        # 가장 유사한 고객의 Email 예측
        predicted_customer = knn.predict(new_customer)[0]

        # 유사한 고객의 구매 패턴 확인 및 추천
        similar_customers = df[df['Email'] == predicted_customer]
        if not similar_customers.empty:
            input_amount = new_customer['PurchaseAmount'].values[0]

            # 입력 금액과 가장 유사한 상품을 찾기 위해 오차를 계산
            df['AmountDifference'] = abs(df['PurchaseAmount'] - input_amount)

            # 오차가 작은 상품을 추천 (여기서는 상위 5개의 유사한 상품을 추천)
            recommended_products = df.nsmallest(5, 'AmountDifference')

            return render_template('result.html', 
                                   predicted_email=predicted_customer, 
                                   recommendations=recommended_products[['Brand', 'ClothingCategory', 'PurchaseAmount', 'PurchaseLocation']].to_html(index=False))
        else:
            return render_template('result.html', predicted_email=predicted_customer, recommendations=None)

    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
