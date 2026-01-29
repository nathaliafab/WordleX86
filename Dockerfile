FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    nasm \
    qemu-system-x86 \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["make"]