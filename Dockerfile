FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN export BUILD_DEPS="gcc cmake make" && \
    apt-get update && \
    apt-get -y install $BUILD_DEPS && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -y --auto-remove $BUILD_DEPS && \
    rm -rf /var/lib/apt/lists/*
COPY . .
RUN apt-get update && apt-get -y install gcc && \
    python3 setup.py build_ext --inplace && \
    apt-get purge -y --auto-remove gcc && \
    rm -rf /var/lib/apt/lists/*

COPY . .
ENTRYPOINT ["python", "/app/mlat-server"]
