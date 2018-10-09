# Blockchain - A generic extensible blockchain library

## Table Of Contents

<!-- BEGIN generated TOC -->
* [Dependency](#dependency)
* [Usage](#usage)
* [Details](#details)
<!-- END generated TOC -->

## Dependency

``` elixir
{ :blockchain, github: "safari12/blockchain" }
```

## Usage

### API

```elixir
# create new blockchain
chain = Blockchain.new

# create new blockchain with options, default for hash_algorithm
# is Block.Hash.SHA256 algorithm module
chain = Blockchain.new [
  hash_algorithm: Block.Hash.SHA256
]

# generate next block candidate for chain
block = Blockchain.generate_next_block(chain, "block's data")

# add block to chain
block = Blockchain.generate_next_block(chain, "block's data")
:ok = Blockchain.add_block(chain, block)

# add block to chain by pipeline
:ok = chain
|> Blockchain.generate_next_block("block's data")
|> (&Blockchain.add_block(chain, &1)).()

# get all blocks from chain
blocks = Blockchain.latest_block(chain)

# get latest block from chain
latest_block = Blockchain.latest_block(chain)

# compute block's hash with chain's hash algorithm
hash = Blockchain.compute_block_hash(chain, block)
```

### Generate \ View HTML Docs

```elixir
# Generate docs via ExDoc tool
mix docs
open docs/index.html
```

## Details

### Block structure

Each Block contains a header and data field. Header follows the `Blockchain.Block.Header` module
in which contains metadata for the block. And the data field follows the `Blockchain.Block.Data` protocol
in which contains data for the block. By default the library implements BitString for the data protocol,
but users can implement their own data type for the block's data. The data type must confirm
to the `Blockchain.Block.Data` protocol by implementing `hash` and `verify` functions.
Below is an example of how the block looks:

```elixir
%Blockchain.Block{
  data: "block's data",
  header: %Blockchain.Block.Header{
    hash: "EBBC67B29B80F9D8C491418271F0C13DBFD846CE55C27FBF871582C6565A1A74",
    index: 0,
    nonce: 0,
    previous_hash: "0",
    timestamp: 1539042786
  }
}
```

### Creating a blockchain process

Calling `Blockchain.new` returns a pid. It creates a child process
under a dynamic supervisor; each blockchain is a process for keeping state. The pid is used
for doing operations for the newly created blockchain by passing it in the `Blockchain` API functions.

Also when a user creates a new blockchain by calling `Blockchain.new`, the user can
pass it options. The only supported option is `hash_algorithm`, in which is
responsible for computing the block's hash. Users of library can pass in any
custom module to compute the block's hash. The module must follow / implement the
callback function `compute` for `Blockchain.Block.Hash.Algorithm` module. By default the
library comes with `Blockchain.Block.Hash.SHA256` and `Blockchain.Block.Hash.MD5`
modules and uses the SHA256 to compute the block's hash.
