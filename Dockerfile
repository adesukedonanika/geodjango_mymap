# syntax=docker/dockerfile:1

# 非公式リンクからpython3.6.5をダウンロードできる
# https://pythonlinks.python.jp/ja/index.html

FROM python:3.6
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/

RUN createdb -U postgres -E UTF-8 geodjangodb
RUN psql -U postgres -d geodjangodb -c "CREATE EXTENSION postgis;"

