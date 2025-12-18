//! App entry point - delegates to fastn CLI
//!
//! Commands:
//!   cargo run          - Run native shell
//!   cargo run -- build - Build for web (creates dist/)
//!   cargo run -- serve - Build and serve web version

fn main() {
    fastn::main();
}
