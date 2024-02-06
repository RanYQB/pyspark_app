FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install python3-pip && \
    apt-get install default-jre && \
    apt-get install scala && \
    pip3 install py4j

ENV APACHA_SPARK_VERSION 3.5.0
ENV HADOOP_VERSION 3

ADD http://archive.apache.org/dist/spark/spark-${APACHA_SPARK_VERSION}/spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz /app
RUN tar -zxvf spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /spark && \
    rm spark-${APACHA_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 

RUN pip3 install findspark 

ENV SPARK_HOME /spark
ENV PATH $SPARK_HOME/bin:$PATH

COPY . /app

CMD ["python", "app.py"]