defmodule BlockchainTest do
  use ExUnit.Case, async: true
  doctest Blockchain

  setup do
    {:ok, %{chain: Blockchain.new}}
  end

  describe "latest_block" do

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

  describe "all_blocks" do

    test "should return empty array when chain is empty", %{chain: chain} do
      assert Blockchain.all_blocks(chain) == []
    end

    test "should return all blocks for chain", %{chain: chain} do
      1..10
      |> Enum.each(fn i ->
        b = Blockchain.generate_next_block(chain, "hello#{i}")
        Blockchain.add_block(chain, b)
      end)

      blocks = Blockchain.all_blocks(chain) |> Enum.reverse

      1..10
      |> Enum.each(fn n ->
        index = n - 1
        b = Enum.at(blocks, index)

        assert b.header.index == index
      end)
    end

  end

end
