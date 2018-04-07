FROM snppla/trinity_base

ADD . /data/TrinityCore
WORKDIR /data/TrinityCore/build
RUN cmake ../ -DCMAKE_INSTALL_PREFIX=/data/TrinityCore.install -DTOOLS=1 \
 && nice -n 20 make -j $(nproc) install && make clean

RUN apt-get update && apt-get install -y openssl mysql-client libboost-system1.55.0 libboost-filesystem1.55.0 libboost-thread1.55.0 libboost-program-options1.55.0 libboost-iostreams1.55.0 libmysqlclient18


WORKDIR /data/TrinityCore.install/bin

