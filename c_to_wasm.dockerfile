# Usage: `docker build . --file c_to_wasm.dockerfile -t c_to_wasm`

FROM debian

# Installing GCC
RUN apt-get update
RUN apt-get install -y build-essential

# Installing Wasmer
RUN apt-get install -y curl 
RUN curl https://get.wasmer.io -sSfL | sh
RUN source /root/.wasmer/wasmer.sh

# Installing WASI
RUN apt-get install -y wget
RUN wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-12/wasi-sdk-12.0-linux.tar.gz
RUN tar xvf wasi-sdk-12.0-linux.tar.gz
RUN CC="/wasi-sdk-12.0/bin/clang --sysroot=/wasi-sdk-12.0/share/wasi-sysroot"

# Usage: $CC hello.c -o hello.wasm
