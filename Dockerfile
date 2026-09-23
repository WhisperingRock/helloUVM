FROM ubuntu:24.04

#ARG VERILATOR_VERSION=983a06a16f2aea1cf4bda3a45099c8bad24d112c\
ARG VERILATOR_REF=stable
ARG UVM_REF=1800.2-2017-1.0

# ~~~~ Install verilator ~~~~
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git \
	help2man \
	perl \
	python3 \
	make \
	autoconf \
	g++ \
	flex \
	bison \
	ccache \
	libgoogle-perftools-dev \
	libjemalloc-dev \
	numactl \
	perl-doc \
	libfl2 \
	libfl-dev \
	zlibc \
	zlib1g \
	zlib1g-dev \
	liblz4 \
	liblz4-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch v${VERILATOR_VERSION} \
      https://github.com/verilator/verilator.git /tmp/verilator \
    && cd /tmp/verilator \
    && autoconf \
    && ./configure --prefix=/usr/local \
    && make -j"$(nproc)" \
    && make install \
	&& verilator --version \
    && rm -rf /tmp/verilator

WORKDIR /workspace

# ~~~~ Grab UVM Library ~~~~
#RUN wget https://www.accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz /opt/uvm
RUN git clone --depth 1 \
      --branch "${UVM_REF}" \
      https://github.com/accellera-official/uvm.git \
      /opt/uvm

ENV UVM_HOME=/opt/uvm/src
ENV PATH="/usr/local/bin:${PATH}"

# Validate the installation
RUN command -v verilator \
    && verilator --version \
    && test -f "${UVM_HOME}/uvm_pkg.sv"

CMD ["bash"]


