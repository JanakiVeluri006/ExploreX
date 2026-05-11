from flask import Flask
from flask_cors import CORS
from routes.trip_routes import trip_bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(trip_bp)

@app.route('/')
def home():
    return {"message": "ExploreX backend running"}

if __name__ == '__main__':
    app.run(debug=True)