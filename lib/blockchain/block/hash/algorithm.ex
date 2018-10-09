defmodule Blockchain.Block.Hash.Algorithm do
  @moduledoc """
  Behaviour for computing block hash.
  Default for library is SHA256 algorithm
  """

  @doc """
  Takes a block and computes hash
  """
  @callback compute(Block.t) :: String.t

end
