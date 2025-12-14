#!/usr/bin/env bash

cargo clippy
cargo clippy --target wasm32-unknown-unknown
