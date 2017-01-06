require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @start_idx = 0
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index + 1 > @length
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index + 1 > @length
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0

    @length -= 1
    @store[(@start_idx + @length) % @capacity]
  end

  # O(1) ammortized
  def push(val)
    if @length >= @capacity
      resize!
    end

    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0

    shifted = @store[(@start_idx) % @capacity]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    if @length >= @capacity
      resize!
    end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val

    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    tempArr = StaticArray.new(@capacity*2)
    @capacity.times do |cap|
      tempArr[cap] = self[cap]
    end
    @capacity = @capacity*2
    @store = tempArr
    @start_idx = 0
  end
end
