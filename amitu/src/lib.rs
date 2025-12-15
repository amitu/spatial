#[wasm_bindgen::prelude::wasm_bindgen(start)]
pub fn main() {
    // hello! lets see if target caching worked
    fastn::render_glb("cube.glb");
}
