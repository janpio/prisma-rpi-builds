FROM debian:stretch

ENV PATH=/root/.cargo/bin:$PATH

RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev libc6-dev-armhf-cross g++-arm-linux-gnueabihf

# cross compile OpenSSL
# latest version can be found here: https://www.openssl.org/source/
ENV OPENSSL_VERSION=openssl-1.1.1h
ENV DOWNLOAD_SITE=https://www.openssl.org/source
RUN wget $DOWNLOAD_SITE/$OPENSSL_VERSION.tar.gz && tar zxf $OPENSSL_VERSION.tar.gz
RUN cd $OPENSSL_VERSION && ./Configure linux-armv4 --cross-compile-prefix=/usr/bin/arm-linux-gnueabihf- --prefix=/opt/openssl-arm --openssldir=/opt/openssl-arm -static && make install
# This env var configures rust-openssl to use the cross compiled version
ENV OPENSSL_DIR=/opt/openssl-arm

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add armv7-unknown-linux-gnueabihf

# from rust cross - https://github.com/rust-embedded/cross/blob/master/docker/Dockerfile.aarch64-unknown-linux-gnu#L27
ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc 
ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_RUNNER="/linux-runner armv7"
ENV CC_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-gcc 
ENV CXX_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-g++
ENV QEMU_LD_PREFIX=/usr/arm-linux-gnueabihf
ENV RUST_TEST_THREADS=1
