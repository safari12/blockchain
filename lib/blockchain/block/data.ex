defprotocol Blockchain.Block.Data do

  @spec hash(t) :: String.t()
  def hash(data)

  @spec verify(t, [Blockchain.Block.t()]) :: :ok | {:error, String.t()}
  def verify(data, chain)

end

defimpl Blockchain.Block.Data, for: BitString do

  def hash(string) do
    string
    |> Blockchain.Crypto.hash(:sha256)
    |> Base.encode16
  end

  def verify(_string, _chain), do: :ok

end
