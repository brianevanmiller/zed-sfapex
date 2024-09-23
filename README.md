# zed-sfapex

Provides Apex, SOQL and SOSL syntax highlighting for [Zed](https://github.com/zed-industries/zed).

Based on [tree-sitter-sfapex](https://github.com/aheber/tree-sitter-sfapex).

## License

MIT

## Local testing

- Clone this repo: `git clone https://github.com/brianevanmiller/zed-sfapex sfapex`
- Clone the [tree-sitter-sfapex](https://github.com/aheber/tree-sitter-sfapex) repo: `https://github.com/aheber/tree-sitter-sfapex`
- CD into the repo: `cd tree-sitter-sfapex`
- Build the WASM: `tree-sitter build-wasm` (might require docker-engine running)
- Rename the WASM file to `apex.wasm`
- Move the WASM file into `apex/grammars` (this repository)
- Move the `sfapex` repository to `~/Library/Application Support/Zed/extensions/installed`