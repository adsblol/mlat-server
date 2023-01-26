FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN apt-get update && \
    apt-get -y install gcc && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*
COPY . .
RUN python3 setup.py build_ext --inplace
COPY . .
ENTRYPOINT [ "python", "/app/mlat-server"]
