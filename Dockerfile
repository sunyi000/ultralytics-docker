FROM pytorch/pytorch:2.7.0-cuda12.6-cudnn9-runtime

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    MKL_THREADING_LAYER=GNU \
    OMP_NUM_THREADS=1 \
    TF_CPP_MIN_LOG_LEVEL=3 

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc git zip unzip wget curl htop libgl1 libglib2.0-0 libpython3-dev gnupg libsm6 \
    && rm -rf /var/lib/apt/lists/*

RUN apt upgrade --no-install-recommends -y openssl tar

WORKDIR /ultralytics
# Clone the ultralytics repository
RUN git clone https://github.com/ultralytics/ultralytics .

RUN pip install -e .

RUN pip install numpy==1.26.4 scikit-image==0.25.0 collection termcolor scikit-learn=1.6.1
