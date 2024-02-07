import findspark 
findspark.init()

import pyspark 
from pyspark.sql import SparkSession
from flask import Flask, jsonify 

spark = SparkSession.builder.appName("GoldenLine Pyspark").getOrCreate()

app = Flask(__name__)

@app.route('/data')
def pyspark_app():
    data = [("Hello",)]
    df = spark.createDataFrame(data, ["message"])
    df.show()
    json_data = df.toJSON().collect()
    return jsonify(json_data)


@app.route('/')
def index():
    return "hello"

if __name__ == '__main__':
    app.run(debug=True, host='172.17.0.2', port=5000)
