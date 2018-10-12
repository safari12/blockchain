defmodule Blockchain.Block.Hash.MD5 do
  @moduledoc """
  Computes block's hash using MD5
  """

  alias Blockchain.Block

  @behaviour Block.Hash.Algorithm

  @doc """
  compute md5 hash from given block
  """
  @spec compute(Block.t) :: String.t
  def compute(
    %Block{
      header: %Block.Header{
        index: i,
        previous_hash: h,
        timestamp: ts,
        extra: ex,
      },
      data: data,
  }) do
    "#{i}#{h}#{ts}#{Block.Data.hash(data)}#{Block.Header.Extra.hash(ex)}"
    |> (&:crypto.hash(:md5, &1)).()
    |> Base.encode16
  end

end
