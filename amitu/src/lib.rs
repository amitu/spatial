#[wasm_bindgen::prelude::wasm_bindgen(start)]
pub fn main() {
    fastn::render_glb("cube.glb");
}
