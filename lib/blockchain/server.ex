defmodule Blockchain.Server do
  use GenServer

  alias Blockchain.Chain

  def start_link(options) do
    GenServer.start_link(__MODULE__, options)
  end

  def init(options) do
    {:ok, %{
      chain: [],
      options: options
    }}
  end

  def handle_call(:latest_block, _from, state) do
    {:reply, Chain.latest_block(state.chain), state}
  end

  def handle_call(:all_blocks, _from, state) do
    {:reply, state.chain, state}
  end

  def handle_call({:compute_block_hash, block}, _from, state) do
    {:reply, state.options[:hash_algorithm].compute(block), state}
  end

  def handle_call({:generate_next_block, data, extra_metadata}, _from, state) do
    {
      :reply,
      Chain.generate_next_block(
        state.chain,
        data,
        state.options[:hash_algorithm],
        extra_metadata
      ),
      state
    }
  end

  def handle_call({:add_block, block}, _from, state) do
    case Chain.add_block(
      state.chain,
      block,
      state.options[:hash_algorithm]
    ) do
      {:error, reason} ->
        {:reply, {:error, reason}, state}
      new_chain ->
        {:reply, self(), %{state | chain: new_chain}}
    end
  end

end
