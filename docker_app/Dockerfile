# docker_app/Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY data.csv .
COPY script.py .

CMD ["python", "script.py"]
