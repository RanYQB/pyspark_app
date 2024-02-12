import findspark 
findspark.init()

import pyspark 
from pyspark.sql import SparkSession
from flask import Flask, jsonify, redirect, url_for 

spark = SparkSession.builder \
    .appName("GoldenLine Pyspark") \
    .config("spark.ui.enable", "true") \
    .getOrCreate()

app = Flask(__name__)

@app.route('/data')
def pyspark_app():
    data = [("Hello",)]
    df = spark.createDataFrame(data, ["message"])
    df.show()
    json_data = df.toJSON().collect()
    return jsonify(json_data)

@app.route('/spark-ui')
def display_web_ui():
    return redirect('http://127.0.0.1:4041')

@app.route('/')
def index():
    return "hello"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

