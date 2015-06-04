FROM python:3.4

RUN mkdir -p /opt/app/
ADD . /opt/app/
WORKDIR /opt/app/
RUN pip install -e .
