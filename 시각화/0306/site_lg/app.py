from flask import Flask, render_template, jsonify
from textData import text_data

app = Flask(__name__)

@app.route('/')
def index():
    # 텍스트 데이터와 그래프 데이터를 전달
    return render_template('index.html', text_data=text_data)

@app.route('/data')
def get_data():
    # 그래프 데이터를 JSON으로 반환
    return jsonify(text_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)