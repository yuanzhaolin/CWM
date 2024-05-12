# app.py
from flask import Flask, jsonify

app = Flask(__name__) # 创建flask应用

# 默认为get请求
@app.route('/hello')
def hello():
    return 'hello world' # 返回text/html类型响应，是一个html文件，<body>hello world</body>

# 错误处理
@app.errorhandler(Exception)
def error_handler(e):
    return jsonify({'error': repr(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)
