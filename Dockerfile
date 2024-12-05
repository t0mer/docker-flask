
FROM ubuntu:24.10

LABEL maintainer="tomer.klein@gmail.com"

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

#install pip3
RUN apt update

RUN apt install -yqq python3-pip && \
    apt install -yqq libffi-dev && \
    apt install -yqq fping && \
    apt install -yqq libssl-dev

RUN pip3 install --upgrade pip setuptools  --no-cache-dir

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt
