defmodule Blockchain do

  alias Blockchain.{Block}

  defdelegate genesis_block, to: Block, as: :genesis

  def new do
    { :ok, pid } = Supervisor.start_child(Blockchain.Supervisor, [])
    pid
  end

  def latest_block(chain_pid) do
    GenServer.call(chain_pid, :latest_block)
  end

end
