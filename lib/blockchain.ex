defmodule Blockchain do

  alias Blockchain.Block

  defdelegate genesis_block, to: Block, as: :genesis

end
