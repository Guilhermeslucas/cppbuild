FROM ubuntu:17.04
RUN apt update && apt upgrade -y

# Install GCC 7
RUN apt install software-properties-common python-software-properties make git libboost-python-dev -y
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt update && apt upgrade -y
RUN apt install wget gcc-7 g++-7 -y
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10

# Install cmake v3.9.2
RUN wget https://cmake.org/files/v3.9/cmake-3.9.2.tar.gz
RUN tar xzvf cmake-3.9.2.tar.gz
WORKDIR cmake-3.9.2
RUN ./bootstrap && make && make install
WORKDIR /
RUN rm -rf cmake-3.9.2

# Install boost v1.65.1
RUN wget https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz
RUN tar xzvf boost_1_65_1.tar.gz
WORKDIR boost_1_65_1
RUN ./bootstrap.sh
RUN ./b2 install

# Install openssl 1.1.0f
RUN git clone https://github.com/openssl/openssl.git
WORKDIR openssl
git checkout OpenSSL_1_1_0f
RUN ./config
RUN make
RUN make install
WORKDIR /
RUN rm -rf openssl
