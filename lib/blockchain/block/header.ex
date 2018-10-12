defmodule Blockchain.Block.Header do
  @moduledoc """
  Data structure for holding block's metadata
  """

  alias __MODULE__

  defprotocol Extra do
    @moduledoc """
    Protocol confirming different types of extra metadata that a block header
    can hold.
    """

    @doc """
    computes hash of extra metadata for block's header
    """
    @spec hash(t) :: String.t
    def hash(extra)
  end

  defimpl Header.Extra, for: Map do
    def hash(extra) do
      keys = extra
      |> Map.keys
      |> Enum.join(",")

      values = extra
      |> Map.values
      |> Enum.join(",")

      :crypto.hash(:sha256, "#{keys}#{values}")
    end
  end

  @type t :: %__MODULE__{
    index: integer,
    hash: String.t,
    previous_hash: String.t,
    timestamp: integer,
    extra: Header.Extra
  }

  defstruct [
    :index,
    :hash,
    :previous_hash,
    :timestamp,
    :extra
  ]

end
