defmodule BlockchainTest do
  use ExUnit.Case, async: true
  doctest Blockchain

  alias Blockchain.Block

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

      0..9
      |> Enum.each(fn index ->
        previous_index = index - 1
        previous_block = Enum.at(blocks, previous_index)
        current_block = Enum.at(blocks, index)
        current_block_hash = Blockchain.compute_block_hash(
          chain,
          current_block
        )

        if previous_index >= 0 do
          assert current_block.header.previous_hash ==
            previous_block.header.hash
        end

        assert current_block.header.index == index
        assert current_block.header.hash == current_block_hash
        assert current_block.header.nonce == 0
        assert current_block.data == "hello#{index + 1}"
      end)
    end

  end

  describe "compute_block_hash" do

    test "by default should compute with sha256 hash", %{chain: chain} do
      b = Blockchain.generate_next_block(chain, "hello")
      assert Blockchain.compute_block_hash(chain, b) ==
        Block.Hash.SHA256.compute(b)
    end

    test "should compute hash with a different hashing algorithm" do
      chain = Blockchain.new [
        hash_algorithm: Block.Hash.MD5
      ]

      b = Blockchain.generate_next_block(chain, "hello")

      assert Blockchain.compute_block_hash(chain, b) ==
        Block.Hash.MD5.compute(b)
    end

  end

end
