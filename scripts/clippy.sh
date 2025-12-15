#!/usr/bin/env bash

set -e -x

# cargo clippy  # we no longer support native compilation, only wasm
cargo clippy --target wasm32-unknown-unknown
