# Usage
* C -> WASM Development
  * Build Docker Image: `docker build . --file c_to_wasm.dockerfile -t c_to_wasm`
  * Run Development Shell: `docker run -it --rm -v $(pwd)/app/:/app c_to_wasm bash`