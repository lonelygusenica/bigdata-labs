FROM quay.io/jupyter/minimal-notebook:latest

USER root

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt