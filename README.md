# spatial


```terminaloutput
$ cargo install wasm-pack --force

$ brew install binaryen
$ wasm-opt --version
wasm-opt version 125

$ wasm-pack build amitu --target web
$ ./scripts/build.sh
$ python3 -m http.server 8088

# for native testing
$ RUST_LOG=info cargo run
```
