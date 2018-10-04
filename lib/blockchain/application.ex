defmodule Blockchain.Application do
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      worker(Blockchain.Server, []),
    ]

    options = [
      name: Blockchain.Supervisor,
      strategy: :simple_one_for_one
    ]

    Supervisor.start_link(children, options)
  end

end
