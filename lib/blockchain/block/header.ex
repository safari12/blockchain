defmodule Blockchain.Block.Header do

  @type t :: %__MODULE__{
    index: integer,
    previous_hash: String.t(),
    timestamp: integer,
    nonce: integer,
    hash: String.t()
  }

  defstruct [
    :index,
    :previous_hash,
    :timestamp,
    :nonce,
    :hash
  ]

end
