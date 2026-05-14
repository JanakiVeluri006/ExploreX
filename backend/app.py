from flask import Flask
from flask_cors import CORS
from routes.trip_routes import trip_bp
from routes.user_routes import user_bp
from routes.favorite_routes import favorite_bp
from routes.planned_routes import planned_bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(trip_bp)
app.register_blueprint(user_bp)
app.register_blueprint(favorite_bp)
app.register_blueprint(planned_bp)
@app.route('/')
def home():
    return {"message": "ExploreX backend running"}

if __name__ == '__main__':
    app.run(debug=True)