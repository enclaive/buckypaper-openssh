#/bin/sh
set -ex
export MAKE_DEFINES="-j2"
export MAKE_INSTALL="install-nokeys"
export DEFAULT_INSTALL_DIR=/opt/oqs-ssh
export INSTALL_DIR=${DEFAULT_INSTALL_DIR}
export OPENSSH_BUILD_OPTIONS=""
cd /opt
git clone --depth 1 --branch main https://github.com/open-quantum-safe/liboqs
git clone --depth 1 --branch OQS-v8 https://github.com/open-quantum-safe/openssh ossh-src
cd /opt/liboqs
mkdir build-static && cd build-static && cmake .. ${LIBOQS_BUILD_DEFINES} -DCMAKE_BUILD_TYPE=${LIBOQS_BUILD_TYPE} -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=/opt/ossh-src/oqs && make ${MAKE_DEFINES} && make install
cd /opt/ossh-src
autoreconf && ./configure \
    --with-libs=-lm \
    --prefix=${INSTALL_DIR} \
    --sysconfdir=${INSTALL_DIR} \
    --with-liboqs-dir=/opt/ossh-src/oqs \
    --with-mantype=man \
    ${OPENSSH_BUILD_OPTIONS}
make ${MAKE_DEFINES} && make ${MAKE_INSTALL}