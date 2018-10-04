defmodule Blockchain.Server do
  use GenServer

  alias Blockchain.{Block, Chain}

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, [Block.genesis]}
  end

  def handle_call(:latest_block, _from, chain) do
    {:reply, Chain.latest_block(chain) , chain}
  end

end
