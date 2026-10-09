import os
from flask import Flask, jsonify

app = Flask(__name__)

VERSION=os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT=os.getenv("APP_ENV" , "developement")


@app.get("/")
def home():
    return jsonify({
        "message":"Cloudforge webapp is running!!",
        "status" : "healthy",
        "version" :VERSION
    })


@app.get("/health")
def health():
    return jsonify({"status" : "healthy"}),200

@app.get("/api/health")
def api_health():
    return jsonify({
        "status":"healthy",
        "service":"CLOUDFORGE API",
        "version": VERSION,
        "environment" : ENVIRONMENT
    }),200

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000)