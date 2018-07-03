require 'digest'
require "test/unit"

class Block
  attr_accessor :index, :transaction_date, :data, :previous_hash, :associated_hash
  def initialize(index, transaction_date, data, previous_hash)
    self.index            = index
    self.transaction_date = transaction_date
    self.data             = data
    self.previous_hash    = previous_hash
    self.associated_hash  = generate_hash_from_block(self)
  end

  def generate_hash_from_block(block)
    Digest::SHA256.hexdigest "#{index}#{transaction_date}#{data}#{previous_hash}"
  end
end

class Blockchain
  attr_accessor :blocks, :name, :acronym
  def initialize(name, acronym)
    self.name     = name
    self.acronym  = acronym
    self.blocks = []
  end

  def add_block(block)
    self.blocks << block
  end
end

block_chain    = Blockchain.new('UserbnCoin', 'UBC')
bigbang_block  = Block.new(0, Time.now, 'This is my data', 'bigbang')
block_chain.add_block(bigbang_block)


class TestBlock < Test::Unit::TestCase
  def test_block
    block_index            = (0..100).to_a.sample
    block_transaction_date = Time.now
    block_data             = 'Fake data'
    block_previous_hash    = 'thisIsTestHash'
    block_hash             = Digest::SHA256.hexdigest "#{block_index}#{block_transaction_date}#{block_data}#{block_previous_hash}"
    block                  = Block.new(block_index, block_transaction_date, block_data, block_previous_hash)
    assert_equal(block_index, block.index)
    assert_equal(block_transaction_date, block.transaction_date)
    assert_equal(block_data, block.data)
    assert_equal(block_previous_hash, block.previous_hash)
    assert_equal(block_hash, block.associated_hash)
  end
end

class TestBlockChain < Test::Unit::TestCase
  def test_block_chain_init
    block_chain_name    = 'UserbnCoin'
    block_chain_acronym = 'UBC'
    block_chain         = Blockchain.new(block_chain_name, block_chain_acronym)
    assert_equal(block_chain.name, block_chain_name)
    assert_equal(block_chain.acronym, block_chain_acronym)
  end

  def test_block_chain_adding_block
    block_chain_name       = 'UserbnCoin'
    block_chain_acronym    = 'UBC'
    block_chain            = Blockchain.new(block_chain_name, block_chain_acronym)
    block_index            = (0..100).to_a.sample
    block_transaction_date = Time.now
    block_data             = 'Fake data'
    block_previous_hash    = 'thisIsTestHash'
    block_hash             = Digest::SHA256.hexdigest "#{block_index}#{block_transaction_date}#{block_data}#{block_previous_hash}"
    block                  = Block.new(block_index, block_transaction_date, block_data, block_previous_hash)

    block_chain.add_block(block)
    next_block_index            = (0..100).to_a.sample
    next_block_transaction_date = Time.now
    next_block_data             = 'Fake data'
    next_block_previous_hash    = block.hash
    next_block_hash             = Digest::SHA256.hexdigest "#{block_index}#{block_transaction_date}#{block_data}#{block_previous_hash}"
    next_block                  = Block.new(next_block_index, next_block_transaction_date, next_block_data, next_block_previous_hash)

    block_chain.add_block(next_block)

  end
end
