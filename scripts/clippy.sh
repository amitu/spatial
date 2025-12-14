#!/usr/bin/env bash

set -e -x

cargo clippy
cargo clippy --target wasm32-unknown-unknown
