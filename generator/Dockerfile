FROM python:3.10-slim

# Install necessary packages including wget, curl, and update CA certificates
RUN apt-get update && apt-get install -y wget curl ca-certificates

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD

ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD

WORKDIR /home/generator

RUN mkdir -p xml/raw xml/processed

COPY generator .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "generate.py"]
