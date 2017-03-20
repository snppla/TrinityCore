FROM debian:jessie

RUN apt-get update && \
 apt-get install -y build-essential autoconf libtool gcc g++ make cmake git-core \
 wget p7zip-full libncurses5-dev zlib1g-dev libbz2-dev openssl libssl-dev \
 libreadline6-dev libboost-dev libboost-thread-dev libboost-system-dev \
 libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev screen libzmq-dev libmysqlclient-dev libmysql++-dev  \
 && mkdir -p /data && cd /data

RUN mkdir -p /data/TrinityCore/build

ADD . /data/TrinityCore
WORKDIR /data/TrinityCore/build
RUN cmake ../ -DCMAKE_INSTALL_PREFIX=/data/TrinityCore.install -DTOOLS=1 \
 && nice -n 20 make -j $(nproc) install

RUN apt-get update && apt-get install -y openssl mysql-client libboost-system1.55.0 libboost-filesystem1.55.0 libboost-thread1.55.0 libboost-program-options1.55.0 libboost-iostreams1.55.0 libmysqlclient18


WORKDIR /data/TrinityCore.install/bin

