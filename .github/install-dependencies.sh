#/bin/sh
set -ex
apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    autoconf \
    automake \
    cmake \
    gcc \
    libtool \
    libssl-dev \
    make \
    ninja-build \
    pkg-config \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*