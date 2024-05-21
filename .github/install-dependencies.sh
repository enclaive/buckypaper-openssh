#/bin/sh
set -ex
sudo apt-get update && sudo apt-get install --no-install-recommends --no-install-suggests -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    debhelper \
    devscripts \
    gcc \
    libtool \
    libssl-dev \
    make \
    ninja-build \
    pkg-config \
    zlib1g-dev \
    && sudo rm -rf /var/lib/apt/lists/*