#!/usr/bin/env bash

set -e -x

# Build WASM
wasm-pack build amitu --target web

# Optimize WASM
# refer [package.metadata.wasm-pack.profile.release] in amitu/Cargo.toml.
# we also need --enable-nontrapping-float-to-int which handles the
# i32.trunc_sat_f64_u instructions (saturating float-to-int conversions).
wasm-opt amitu/pkg/amitu_bg.wasm -o amitu/pkg/amitu_bg.wasm -O \
  --enable-bulk-memory \
  --enable-nontrapping-float-to-int

# Generate content hashes for cache busting
# Use first 8 chars of sha256 hash
# Works on both macOS (shasum) and Linux (sha256sum)
if command -v sha256sum &> /dev/null; then
    WASM_HASH=$(sha256sum amitu/pkg/amitu_bg.wasm | cut -c1-8)
    JS_HASH=$(sha256sum amitu/pkg/amitu.js | cut -c1-8)
else
    WASM_HASH=$(shasum -a 256 amitu/pkg/amitu_bg.wasm | cut -c1-8)
    JS_HASH=$(shasum -a 256 amitu/pkg/amitu.js | cut -c1-8)
fi

# Create hashed filenames
WASM_FILE="amitu_bg.${WASM_HASH}.wasm"
JS_FILE="amitu.${JS_HASH}.js"

# Rename WASM file
mv amitu/pkg/amitu_bg.wasm "amitu/pkg/${WASM_FILE}"

# Update JS file to reference hashed WASM filename, then rename it
# sed -i works differently on macOS vs Linux, so use a temp file approach
sed "s/amitu_bg\.wasm/${WASM_FILE}/g" amitu/pkg/amitu.js > amitu/pkg/amitu.js.tmp
mv amitu/pkg/amitu.js.tmp "amitu/pkg/${JS_FILE}"
rm -f amitu/pkg/amitu.js

# Generate index.html with hashed JS filename
cat > amitu/pkg/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Spatial</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: #1a1a2e;
        }
    </style>
</head>
<body>
<script type="module">
    import init from './${JS_FILE}';
    init();
</script>
</body>
</html>
EOF

# Copy to root for easy local serving
cp "amitu/pkg/${WASM_FILE}" .
cp "amitu/pkg/${JS_FILE}" .
cp amitu/pkg/index.html .

# Clean old hashed files from root and pkg
find . -maxdepth 1 -name "amitu_bg.*.wasm" ! -name "${WASM_FILE}" -delete
find . -maxdepth 1 -name "amitu.*.js" ! -name "${JS_FILE}" -delete
find amitu/pkg -maxdepth 1 -name "amitu_bg.*.wasm" ! -name "${WASM_FILE}" -delete
find amitu/pkg -maxdepth 1 -name "amitu.*.js" ! -name "${JS_FILE}" -delete

echo "Generated files:"
echo "  WASM: ${WASM_FILE}"
echo "  JS:   ${JS_FILE}"
echo "  HTML: index.html"
