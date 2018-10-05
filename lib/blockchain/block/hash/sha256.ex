defmodule Blockchain.Block.Hash.SHA256 do

  alias Blockchain.{Block, Crypto}

  @behaviour Block.Hash.Algorithm

  @doc """
  compute sha256 hash from given block
  """
  @spec compute(Block.t) :: String.t
  def compute(
    %Block{
      header: %Block.Header{
        index: i,
        previous_hash: h,
        timestamp: ts,
        nonce: n
      },
      data: data,
  }) do
    "#{i}#{h}#{ts}#{Block.Data.hash(data)}#{n}"
    |> Crypto.sha256_hash
    |> Base.encode16
  end

end