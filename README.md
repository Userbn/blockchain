# blockchain

Blockchain is simple implementation of Blockchain

The blockchain.rb file contains following classes :
 Blockchain : To create your own blockchain ex :
 ```ruby
 block_chain = Blockchain.new('Bitcoin', 'BTC')
 ```
 Block : To create a simple block :
```ruby
block =  Block.new(block_index, block_transaction_date, block_data, block_previous_hash)
```

To add a block to a blockchain :
```ruby
block_chain.add(block)
```

You can launch test using :
```bash
~: ruby blockchain.rb
```

Feel free to make a pull request

Next features :
  - split blockchain into files (one by classe / test)
  - deal block adding with transaction
