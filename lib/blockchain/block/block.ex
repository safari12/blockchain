defmodule Blockchain.Block do

  alias Blockchain.Block.{Header, Data, Hash}

  @type t :: %__MODULE__{
    header: Header.t(),
    data: Data.t()
  }

  defstruct [
    :header,
    :data
  ]

  @spec compute_and_add_hash(t, Hash.Algorithm.t) :: t
  def compute_and_add_hash(block, hash_algo) do
    hash = hash_algo.compute(block)
    %{block | header: %{block.header | hash: hash}}
  end

end
