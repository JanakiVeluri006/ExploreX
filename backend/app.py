from flask import Flask
from flask_cors import CORS
from routes.trip_routes import trip_bp
<<<<<<< HEAD
from routes.user_routes import user_bp
from routes.favorite_routes import favorite_bp
from routes.planned_routes import planned_bp
=======
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
from routes.journal_routes import journal_bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(trip_bp)
<<<<<<< HEAD
app.register_blueprint(user_bp)
app.register_blueprint(favorite_bp)
app.register_blueprint(planned_bp)
=======
>>>>>>> ac294aacf9a6a94ec24cc4fcc3b4354a449115d9
app.register_blueprint(journal_bp)

@app.route('/')
def home():
    return {"message": "ExploreX backend running"}

if __name__ == '__main__':
    app.run(debug=True)