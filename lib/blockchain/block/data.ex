defprotocol Blockchain.Block.Data do
  @moduledoc """
  An protocol for confirming different types of data being stored in a block.
  The data type must confirm to hash and verify functions. BitString is
  implemented by default for this protocol
  """

  @spec hash(t) :: String.t()
  def hash(data)

  @spec verify(t, [Blockchain.Block.t()]) :: :ok | {:error, String.t()}
  def verify(data, chain)

end

defimpl Blockchain.Block.Data, for: BitString do

  def hash(string) do
    string
    |> (&:crypto.hash(:sha256, &1)).()
    |> Base.encode16
  end

  def verify(_string, _chain), do: :ok

end
