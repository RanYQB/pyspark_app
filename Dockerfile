FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y default-jre && \
    apt-get install -y scala && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m venv venv 

RUN . venv/bin/activate && \ 
    pip install --upgrade pip


RUN . venv/bin/activate && \ 
    pip install py4j

ARG APACHA_SPARK_VERSION=3.5.0
ARG HADOOP_VERSION=3

ADD http://archive.apache.org/dist/spark/spark-${APACHA_SPARK_VERSION}/spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz /app
RUN tar -zxvf spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /spark && \
    rm spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 

RUN . venv/bin/activate && \ 
    pip install findspark 

RUN . venv/bin/activate && \ 
pip install flask

ENV SPARK_HOME /spark
ENV PATH $SPARK_HOME/bin:$PATH

EXPOSE 5000

COPY . /app

CMD ["venv/bin/python", "app.py"]