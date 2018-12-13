defmodule Blockchain.Supervisor do
  use DynamicSupervisor

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_child(options) do
    child_spec = {Blockchain.Server, options}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
