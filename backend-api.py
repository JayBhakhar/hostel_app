from flask import Flask, jsonify, request
from flask_pymongo import MongoClient, PyMongo
import jwt
import datetime
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps

MongoURL = "mongodb+srv://JayBhakhar:jay456789@hostel.rwz7a.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"
app = Flask(__name__)
app.config["MONGO_URI"] = MongoURL
mongo = PyMongo(app)
users = MongoClient(MongoURL).datadase.users
app.config['SECRET_KEY'] = 'secret'


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']

        if not token:
            return jsonify({'message': 'Token is missing!'}), 401

        try:
            data = jwt.decode(
                token,
                app.config['SECRET_KEY'],
                algorithms="HS256"
            )
            current_user = users.find_one({'_id': data['_id']})
        except:
            return jsonify({'message': 'Token is invalid!'}), 401

        return f(current_user, *args, **kwargs)

    return decorated

@app.route('/users', methods=['GET'])
@token_required
def home(current_user):
    output = []
    for user in users.find({'email':current_user['email']}):
        output.append(
            {
            'name': user['name'],
            'surename': user['surename'],
            'fatherName': user['father_name'],
            'faculty': user['faculty'],
            'course': user['course'],
            'group': user['group'],
            'phoneNo': user['phone_no'],
            'email': user['email'],
            'hostelNo': user['hostel_no'],
            'roomNo': user['room_no'],
            'position': user['position']
            }
        )
    return jsonify({'user': output})



@app.route('/all_users', methods=['GET'])
def all_users():
    output = []
    for user in users.find():
        output.append(
            {
                'name': user['name'],
                'surename': user['surename'],
                'fatherName': user['father_name'],
                'faculty': user['faculty'],
                'course': user['course'],
                'group': user['group'],
                'phoneNo': user['phone_no'],
                'email': user['email'],
                'hostelNo': user['hostel_no'],
                'roomNo': user['room_no'],
                'position': user['position']
            }
        )
    return jsonify({'users': output})


@app.route('/registration', methods=['POST'])
def create_user():
    data = request.get_json()

    # {
    #     name: 'jay',
    #     surename: 'jaybhakhar@gmail.com',
    #     fatherName: '123456'
    #     faculty: Филологический факультет,
    #     course: первый,
    #     group: 'ap-31',
    #     phoneNo: 9961011395,
    #     email: 'jaybhakhar@gmail.com',
    #     password: '123465',
    #     confirmPassword: '123456', #while not ready forget password
    #     hostelNo: первый,
    #     roomNo: 12,
    #     position: admin
    # }
    hashed_password = generate_password_hash(data['password'], method='sha256')

    users.insert_one({
        '_id': str(uuid.uuid4()),
        'name': str(data['name']),
        'surename': str(data['surename']),
        'father_name': str(data['fatherName']),
        'phone_no': int(data['phoneNo']),
        'email': str(data['email']),
        'password': hashed_password,
        'confirm_passsword': str(data['confirmPassword']),
        'faculty': str(data['faculty']),
        'course': str(data['course']),
        'group': str(data['group']),
        'hostel_no': str(data['hostelNo']),
        'room_no': int(data['roomNo']),
        'position': str(data['position']),
    })
    return jsonify({'message': 'User is successfully registered'})


@app.route('/login', methods=['POST'])
def login():
    user = request.get_json()
    # {
    #     "email": "jaybhakhar@gmail.com",
    #     "password": "123456"
    # }
    for data in users.find({'email': user['email']}):
        if check_password_hash(data['password'], user['password']):
            token = jwt.encode(
                {
                '_id': data['_id'],
                'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=30)
                },
                app.config['SECRET_KEY'],
                algorithm="HS256")
            return jsonify({'token': token})
    return make_response('Could not verify', 401, {'WWW-Authenticate': 'Basic realm="Login required!"'})


if __name__ == '__main__':
    app.run(debug=1, host='192.168.137.1')
    # app.run(debug=1, port=8000)
