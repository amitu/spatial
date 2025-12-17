//! Amitu - Example spatial application using fastn
//!
//! This crate is compiled to WASM and loaded by fastn-shell.
//! It demonstrates using the simplified fastn API.

use fastn::{fastn_app, example_core::ExampleCore};

// Use the example core from fastn - this handles cube loading, VR toggle, etc.
fastn_app!(ExampleCore, ExampleCore::new());
