defmodule BlockchainTest do
  use ExUnit.Case, async: true
  doctest Blockchain

  describe "latest_block" do

    setup do
      {:ok, %{chain: Blockchain.new}}
    end

    test "should return nil when chain is empty", %{chain: chain} do
      assert Blockchain.latest_block(chain) == nil
    end

    test "should return the most recent block added", %{chain: chain} do
      new_block = Blockchain.generate_next_block(chain, "hello")
      latest_block = chain
      |> Blockchain.add_block(new_block)
      |> Blockchain.latest_block

      assert latest_block == new_block
    end

  end

end
