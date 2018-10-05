defmodule Blockchain.Chain do
  @moduledoc """
  Data structure for storing blocks in a reverse order
  """

  alias Blockchain.Block

  @doc """
  get most recent block that was added to chain
  """
  @spec latest_block([Block.t()]) :: Block.t()
  def latest_block([]), do: nil
  def latest_block(chain) do
    [h | _] = chain
    h
  end

  @doc """
  add block to chain if valid
  """
  @spec add_block([Block.t], Block.t, Block.Hash.Algorithm.t) :: [Block.t]
  def add_block([], block, hash_algo) do
    cond do
      validate_block_hash(block, hash_algo) ->
        {:error, :invalid_block_hash}
      true ->
        [block]
    end
  end

  def add_block(chain, block, hash_algo) do
    [previous_block | _] = chain

    case validate_block(previous_block, block, chain, hash_algo) do
      {:error, reason} ->
        {:error, reason}
      :ok ->
        [block | chain]
    end
  end

  @doc """
  generate the next block candidate for chain
  """
  @spec generate_next_block(
    [Block.t],
    BlockData.t,
    Block.Hash.Algorithm.t
  ) :: Block.t
  def generate_next_block([], data, hash_algo) do
    %Block{
      header: %Block.Header{
        index: 0,
        previous_hash: "0",
        timestamp: System.system_time(:second),
        nonce: 0,
      },
      data: data
    }
    |> Block.compute_and_add_hash(hash_algo)
  end

  def generate_next_block(chain, data, hash_algo) do
    latest_block = latest_block(chain)

    %Block{
      header: %Block.Header{
        index: latest_block.header.index + 1,
        previous_hash: latest_block.header.hash,
        timestamp: System.system_time(:second),
        nonce: 0,
      },
      data: data
    }
    |> Block.compute_and_add_hash(hash_algo)
  end

  @spec validate_block(
    Block.t,
    Block.t,
    [Block.t],
    Block.Hash.Algorithm
  ) :: :ok | {:error, atom()}
  defp validate_block(previous_block, block, chain, hash_algo) do
    cond do
      previous_block.header.index + 1 != block.header.index ->
        {:error, :invalid_block_index}

      previous_block.header.hash != block.header.previous_hash ->
        {:error, :invalid_block_previous_hash}

      validate_block_hash(block, hash_algo) ->
        {:error, :invalid_block_hash}

      true ->
        validate_block_data(block, chain)
    end
  end

  @spec validate_block_data(Block.t(), [Block.t()]) :: :ok | {:error, atom()}
  defp validate_block_data(%Block{data: data}, chain), do: Block.Data.verify(data, chain)

  defp validate_block_hash(block, hash_algo) do
    block.header.hash != hash_algo.compute(block)
  end

end
