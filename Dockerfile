FROM python:3.7
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get upgrade -y \
    # imageのサイズを小さくするためにキャッシュ削除
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # pipのアップデート
    && pip install --upgrade pip

RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/



# # 作業するディレクトリを変更
# WORKDIR /home/geodjango

# COPY requirements.txt ${PWD}

# # pythonのパッケージをインストール
# RUN pip install -r requirements.txt

# # 作業するディレクトリを変更
# # コンテナの内部には入った際のディレクトリの位置を変更している
# WORKDIR /home/geodjango/src

