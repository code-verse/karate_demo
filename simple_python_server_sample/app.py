from flask import Flask, request, abort
from user import User
from authentication import Authentication
from uuid import uuid4

app = Flask(__name__)
tokens = []


@app.route('/')
def index():
    return 'Server Up!'


@app.route('/user/<int:user_id>')
def show_user(user_id):
    auth_token = request.headers.get('x-token')
    print(auth_token)
    print(tokens)
    if auth_token not in tokens:
        abort(401)

    user_data = User(user_id, 'Mr. X', 'mr.x@email.com')
    return user_data.to_json()


@app.route('/auth', methods=['POST'])
def auth():
    data = request.get_json()
    token = uuid4()
    status = 'SUCCESS'
    if data.get('username') != 'user_01':
        status = 'FAILED'

    auth_result = Authentication(token, status)
    tokens.append(str(token))
    return auth_result.to_json()
