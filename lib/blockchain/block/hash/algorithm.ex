defmodule Blockchain.Block.Hash.Algorithm do
  @moduledoc """
  Behaviour for block hashing algorithms.
  Default for library is SHA256 algorithm
  """

  @callback compute(Block.t) :: String.t

end
