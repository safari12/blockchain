defmodule Blockchain do

  alias Blockchain.Crypto

  def new(options \\ [
    hash_function: &Crypto.sha256_hash/1
  ]) do
    { :ok, pid } = Supervisor.start_child(Blockchain.Supervisor, [options])
    pid
  end

  def latest_block(chain_pid) do
    GenServer.call(chain_pid, :latest_block)
  end

  def compute_block_hash(chain_pid, block) do
    GenServer.call(chain_pid, {:compute_block_hash, block})
  end

  def generate_next_block(chain_pid, data) do
    GenServer.call(chain_pid, {:generate_next_block, data})
  end

  def add_block(chain_pid, block) do
    GenServer.call(chain_pid, {:add_block, block})
  end

end
