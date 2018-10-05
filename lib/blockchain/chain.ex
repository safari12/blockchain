defmodule Blockchain.Chain do
  @moduledoc """
  Data structure for storing blocks in a reverse order
  """

  alias Blockchain.Block

  @type hash_function :: (binary() -> String.t())

  @spec latest_block([Block.t()]) :: Block.t()
  def latest_block([]), do: nil
  def latest_block(chain) do
    [h | _] = chain
    h
  end

  @spec add_block([Block.t], Block.t, hash_function) :: [Block.t]
  def add_block([], block, hash_function) do
    cond do
      validate_block_hash(block, hash_function) ->
        {:error, :invalid_block_hash}
      true ->
        [block]
    end
  end

  def add_block(chain, block, hash_function) do
    [previous_block | _] = chain

    case validate_block(previous_block, block, chain, hash_function) do
      {:error, reason} ->
        {:error, reason}
      :ok ->
        [block | chain]
    end
  end

  @spec generate_next_block(BlockData.t, Block.t, hash_function) :: Block.t
  def generate_next_block(data, nil, hash_function) do
    %Block{
      header: %Block.Header{
        index: 0,
        previous_hash: "0",
        timestamp: System.system_time(:second),
        nonce: 0,
      },
      data: data
    }
    |> compute_block_header_hash(hash_function)
  end

  def generate_next_block(data, %Block{} = latest_block, hash_function) do
    %Block{
      header: %Block.Header{
        index: latest_block.header.index + 1,
        previous_hash: latest_block.header.hash,
        timestamp: System.system_time(:second),
        nonce: 0,
      },
      data: data
    }
    |> compute_block_header_hash(hash_function)
  end

  @spec validate_block(Block.t(), Block.t(), [Block.t()], hash_function) :: :ok | {:error, atom()}
  defp validate_block(previous_block, block, chain, hash_function) do
    cond do
      previous_block.header.index + 1 != block.header.index ->
        {:error, :invalid_block_index}

      previous_block.header.hash != block.header.previous_hash ->
        {:error, :invalid_block_previous_hash}

      validate_block_hash(block, hash_function) ->
        {:error, :invalid_block_hash}

      true ->
        validate_block_data(block, chain)
    end
  end

  @spec validate_block_data(Block.t(), [Block.t()]) :: :ok | {:error, atom()}
  defp validate_block_data(%Block{data: data}, chain), do: Block.Data.verify(data, chain)

  defp validate_block_hash(block, hash_function) do
    block.header.hash != Block.Hash.compute(block, hash_function)
  end

  defp compute_block_header_hash(block, hash_function) do
    hash = Block.Hash.compute(block, hash_function)
    %{block | header: %{block.header | hash: hash}}
  end

end
