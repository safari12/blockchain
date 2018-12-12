defmodule Blockchain do
  @moduledoc """
  API for blockchain operations
  """

  alias Blockchain.Block

  @doc """
  Generates a new blockchain

  ## Parameters
    - options: a list of options for blockchain. The only supported option is
    hash_algorithm in which is defaulted to Block.Hash.SHA256 module.
  """
  def new(options \\ [
    hash_algorithm: Block.Hash.SHA256
  ]) do
    { :ok, pid } = Blockchain.Supervisor.start_child(options)
    pid
  end

  @doc """
  Get the latest block from given chain, which will be top of the chain.
  """
  def latest_block(chain_pid) do
    GenServer.call(chain_pid, :latest_block)
  end

  @doc """
  Gets all blocks from the chain.
  """
  def all_blocks(chain_pid) do
    GenServer.call(chain_pid, :all_blocks)
  end

  @doc """
  Computes a given block wih chain's hash_algorithm from options.
  """
  def compute_block_hash(chain_pid, block) do
    GenServer.call(chain_pid, {:compute_block_hash, block})
  end

  @doc """
  Generates the next block candidate for chain.
  """
  def generate_next_block(chain_pid, data) do
    GenServer.call(chain_pid, {:generate_next_block, data})
  end

  @doc """
  Adds a valid block to chain, if invalid will return an error tuple.
  """
  def add_block(chain_pid, block) do
    GenServer.call(chain_pid, {:add_block, block})
  end

end
