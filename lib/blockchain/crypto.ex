defmodule Blockchain.Crypto do

  @type hash_algorithms :: :md5 | :ripemd160 | :sha | :sha224 | :sha256 | :sha384 | :sha512

  @spec hash(iodata, hash_algorithms) :: String.t()
  def hash(data, algo), do: :crypto.hash(algo, data)

end
