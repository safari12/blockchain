defmodule Blockchain.Chain do
  @moduledoc """
  Data structure for storing blocks in a reverse order
  """

  alias Blockchain.{Block}

  @spec latest_block([Block.t()]) :: Block.t()
  def latest_block(chain) do
    [h | _] = chain
    h
  end

end
