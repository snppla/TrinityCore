FROM debian:stretch as base

RUN apt-get update && apt-get install -y git clang cmake make gcc g++ libmariadbclient-dev libssl1.0-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev mysql-server p7zip
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

RUN mkdir -p /data/TrinityCore/build

ADD . /data/TrinityCore
WORKDIR /data/TrinityCore/build
RUN cmake ../ -DCMAKE_INSTALL_PREFIX=/data/TrinityCore.install -DTOOLS=1 \
 && nice -n 20 make -j $(nproc) install && make clean


WORKDIR /data/TrinityCore.install/bin

