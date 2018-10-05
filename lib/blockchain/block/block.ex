defmodule Blockchain.Block do

  alias Blockchain.Block.{Header, Data}

  @type t :: %__MODULE__{
    header: Header.t(),
    data: Data.t()
  }

  @type hash_function :: (binary() -> String.t())

  defstruct [
    :header,
    :data
  ]

end
