defmodule Blockchain.Server do
  use GenServer

  alias Blockchain.{Block, Chain}

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

  def handle_call({:compute_block_hash, block}, _from, state) do
    {:reply, Block.Hash.compute(block, state.options[:hash_function]), state}
  end

  def handle_call({:generate_next_block, data}, _from, state) do
    {
      :reply,
      Chain.generate_next_block(
        data,
        Chain.latest_block(state.chain),
        state.options[:hash_function]
      ),
      state
    }
  end

  def handle_call({:add_block, block}, _from, state) do
    case Chain.add_block(
      state.chain,
      block,
      state.options[:hash_function]
    ) do
      {:error, reason} ->
        {:reply, {:error, reason}, state}
      new_chain ->
        {:reply, new_chain, %{state | chain: new_chain}}
    end
  end

end
