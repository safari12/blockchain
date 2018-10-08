# Blockchain - A generic extensible blockchain library

## Table Of Contents

<!-- BEGIN generated TOC -->
* [Dependency](#dependency)
* [Usage](#usage)
* [Details](#details)
<!-- END generated TOC -->

## Dependency

{ :blockchain, github: "safari12/blockchain" }

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

## Details

Calling `Blockchain.new` returns a pid. It creates a child process
in a dynamic supervisor; each blockchain is a process for keeping state. The pid is used
for doing operations for the newly created blockchain by passing it in the `Blockchain` API functions.

Also when a user creates a new blockchain by calling `Blockchain.new`, the user can
pass it options. The only supported option is `hash_algorithm`, in which is
responsible for computing the block's hash. Users of library can pass in any
custom module to compute the block's hash. The module must follow / implement
callback functions for `Blockchain.Block.Hash.Algorithm` module. By default the
library comes with `Blockchain.Block.Hash.SHA256` and `Blockchain.Block.Hash.MD5`
modules and uses the SHA256 to compute the block's hash.
