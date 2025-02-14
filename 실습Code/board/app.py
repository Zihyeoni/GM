from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename
import os
import mysql.connector

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16 MB

# Database connection configuration
DB_USER = 'hj'
DB_PASSWORD = '1234'
DB_HOST = 'localhost'
DB_DATABASE = 'backend'

# Database connection
def get_db_connection():
    conn = mysql.connector.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        database=DB_DATABASE
    )
    return conn

@app.route('/')
def index():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, title, author, created_at FROM posts")
    posts = cursor.fetchall()
    conn.close()
    return render_template('index.html', posts=posts)

@app.route('/write', methods=['GET', 'POST'])
def write():
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        author = '관리자'  
        file = request.files['image']
        filename = None
        if file:
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO posts (title, content, author, image) VALUES (%s, %s, %s, %s)",
                       (title, content, author, filename))
        conn.commit()
        conn.close()
        return redirect(url_for('index'))
    return render_template('write.html')

@app.route('/view/<int:post_id>')
def view(post_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT title, content, author, created_at, image FROM posts WHERE id=%s", (post_id,))
    post = cursor.fetchone()
    conn.close()
    return render_template('view.html', post=post)

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
