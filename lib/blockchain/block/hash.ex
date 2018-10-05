defmodule Blockchain.Block.Hash do

  alias Blockchain.Block

  def compute(
    %Block{
      header: %Block.Header{
        index: i,
        previous_hash: h,
        timestamp: ts,
        nonce: n
      },
      data: data,
    },
    hash_function
  ) do
    "#{i}#{h}#{ts}#{Block.Data.hash(data)}#{n}"
    |> hash_function.()
    |> Base.encode16()
  end

end
