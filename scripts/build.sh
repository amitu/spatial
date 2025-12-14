#!/usr/bin/env bash

wasm-pack build amitu --target web

# refer [package.metadata.wasm-pack.profile.release] in amitu/Cargo.toml.
#
# we also need --enable-nontrapping-float-to-int which handles the
# i32.trunc_sat_f64_u instructions (saturating float-to-int conversions).
wasm-opt amitu/pkg/amitu_bg.wasm -o amitu/pkg/amitu_bg.wasm -O \
  --enable-bulk-memory \
  --enable-nontrapping-float-to-int
