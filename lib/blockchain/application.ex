defmodule Blockchain.Application do
  use Application

  def start(_type, _args) do
    Blockchain.Supervisor.start_link([])
  end

end
