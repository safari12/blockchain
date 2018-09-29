# Blockchain

Data structure for a generic blockchain. Each block takes a Block.Header module
and Block.Data protocol module. Implementation modules for Block.Data protocol
must implement the required the `hash` and `verify` functions. To compute the
hash of a block, one must provide implementation fo the `compute` function
in the Block.Hash protocol. Default implementation is sha256 algorithm.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `blockchain` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:blockchain, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/blockchain](https://hexdocs.pm/blockchain).
