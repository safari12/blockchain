defmodule Blockchain.Block.Header do
  @moduledoc """
  Data structure for holding block's metadata
  """

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
