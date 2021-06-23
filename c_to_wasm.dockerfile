# Usage: `docker build . --file c_to_wasm.dockerfile -t c_to_wasm`

FROM debian

# Installing GCC
RUN apt-get update
RUN apt-get install -y build-essential

# Installing Wasmer
RUN apt-get install -y curl
RUN curl https://get.wasmer.io -sSfL | sh
RUN ["/bin/bash", "-c", "source /root/.wasmer/wasmer.sh"]

# Updating Env to Support Wasmer
ENV WASMER_DIR="/root/.wasmer"
ENV WASMER_CACHE_DIR="$WASMER_DIR/cache"
ENV PATH="$WASMER_DIR/bin:$PATH:$WASMER_DIR/globals/wapm_packages/.bin"

# Installing WASI
RUN apt-get install -y wget
RUN wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-12/wasi-sdk-12.0-linux.tar.gz
RUN tar xvf wasi-sdk-12.0-linux.tar.gz
RUN CC="/wasi-sdk-12.0/bin/clang --sysroot=/wasi-sdk-12.0/share/wasi-sysroot"

# Installing Enscripten
RUN apt-get install -y git
RUN apt-get install -y python3
RUN git clone https://github.com/emscripten-core/emsdk.git
WORKDIR /emsdk
RUN ./emsdk install latest
RUN ./emsdk activate latest

# Updating Env to Support Enscripten
ENV PATH="$PATH:/emsdk"
ENV PATH="$PATH:/emsdk/upstream/emscripten"
ENV PATH="$PATH:/emsdk/node/14.15.5_64bit/bin"
ENV EMSDK="/emsdk"
ENV EM_CONFIG="/emsdk/.emscripten"
ENV EMSDK_NODE="/emsdk/node/14.15.5_64bit/bin/node"

WORKDIR /app