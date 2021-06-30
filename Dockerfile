FROM ubuntu:20.04
WORKDIR /opt
ENV PATH="/opt/build:${PATH}"
RUN apt update && DEBIAN_FRONTEND="noninteractive" apt install -y wget libssl-dev zlib1g zlib1g-dev cmake build-essential python3 python3-pip
RUN wget https://github.com/pyth-network/pyth-client/archive/refs/heads/v2.tar.gz -O - | tar --strip-components 1 -xzf -
RUN mkdir build && cd build && cmake .. && make
RUN pip3 install websockets

# cleanup
RUN apt remove -y wget cmake build-essential && apt autoremove -y && apt autoclean
RUN rm -rf /var/lib/apt/lists/*
