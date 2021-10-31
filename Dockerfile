
FROM ubuntu:18.04

LABEL maintainer="tomer.klein@gmail.com"

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

#install pip3
RUN apt update

RUN apt install -yqq python3-pip && \
    apt install -yqq libffi-dev && \
    apt install -yqq fping && \
    apt install -yqq libssl-dev

RUN pip3 install --upgrade pip setuptools  --no-cache-dir && \
    pip3 install flask --no-cache-dir && \
    pip3 install flask_restful --no-cache-dir && \ 
    pip3 install loguru --no-cache-dir && \
    pip3 install cryptography==2.6.1 --no-cache-dir
