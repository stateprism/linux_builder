FROM ubuntu:noble
LABEL maintainer="Matheus Xavier <soft.song[at]fastmail[the most common tld]>"
LABEL description="Docker image for building the Linux kernel"
LABEL version="1.0"

RUN mkdir /scripts /build
RUN apt-get update && apt-get upgrade -yy

RUN apt-get install -y \
	libncurses-dev \
	gawk \
	flex \
	bison \
	openssl \
	libssl-dev \
	dkms \
	libelf-dev \
	libudev-dev \
	libpci-dev \
	libiberty-dev \
	autoconf \
	llvm \
	git \
	gcc \
	g++ \
	make \
	build-essential \
	wget \
	tar \
	rustc \
	bash \
	curl \
	bc \
	cargo

WORKDIR /build

# Volume for the build directory
VOLUME [ "/build" ]

COPY build.sh setup_build.sh scripts_ver /scripts/
RUN chmod +x /scripts/build.sh /scripts/setup_build.sh

CMD [ "/bin/bash", "/scripts/setup_build.sh" ]
