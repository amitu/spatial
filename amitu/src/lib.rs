//! Amitu - Example spatial app
//!
//! Build: cargo build -p amitu --target wasm32-unknown-unknown --release
//! Run:   fastn-shell ./target/wasm32-unknown-unknown/release/amitu.wasm
//!
//! # Swift equivalent:
//! ```swift
//! RealityView { content in
//!     let box = ModelEntity(
//!         mesh: .generateBox(size: 0.5),
//!         materials: [SimpleMaterial(color: .cyan, isMetallic: false)]
//!     )
//!     content.add(box)
//! }
//! ```

use fastn::{ModelEntity, MeshResource, SimpleMaterial, RealityViewContent};

#[fastn::app]
fn app(content: &mut RealityViewContent) {
    // Create a cyan box
    let cube = ModelEntity::new(
        MeshResource::generate_box(0.5),
        SimpleMaterial::new().color(0.2, 0.6, 0.9)
    );
    content.add(cube);
}
