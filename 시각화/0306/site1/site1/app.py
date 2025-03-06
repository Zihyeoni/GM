from flask import Flask, render_template, url_for

app = Flask(__name__, static_folder="static")  # 정적 파일 폴더 지정

@app.route("/")
def home():
    return render_template("index.html")  # templates 폴더 내 index.html 렌더링

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5001)

