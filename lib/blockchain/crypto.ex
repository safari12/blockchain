defmodule Blockchain.Crypto do

  @type hash_algorithms :: :md5 | :ripemd160 | :sha | :sha224 | :sha256 | :sha384 | :sha512

  @spec hash(iodata, hash_algorithms) :: String.t()
  def hash(data, algo), do: :crypto.hash(algo, data)

  def sha256_hash(data), do: hash(data, :sha256)
  def md5_hash(data), do: hash(data, :md5)

end
