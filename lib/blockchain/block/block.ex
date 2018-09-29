defmodule Blockchain.Block do

  alias Blockchain.Block
  alias Blockchain.Block.{Header, Data}

  @genesis_block Application.get_env(:blockchain, :genesis_block)

  @type t :: %__MODULE__{
    header: Header.t(),
    data: Data.t()
  }

  defstruct [
    :header,
    :data
  ]

  @spec genesis() :: t
  def genesis do
    %Block{
      header: %Header{
        index: @genesis_block[:index],
        previous_hash: @genesis_block[:previous_hash],
        timestamp: @genesis_block[:timestamp],
        nonce: @genesis_block[:nonce],
        hash: @genesis_block[:hash]
      },
      data: @genesis_block[:data]
    }
  end

end
