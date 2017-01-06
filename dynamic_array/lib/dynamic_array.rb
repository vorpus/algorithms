require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @arr = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index + 1 > @length
    @arr[index]
  end

  # O(1)
  def []=(index, value)

    @arr[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0

    popped = @arr[@length-1]
    @arr[@length-1] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)

    if @length >= @capacity
      resize!
    end

    @arr[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    shifted = @arr[0]

    (@length-1).times do |time|
      @arr[time] = @arr[time+1]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length >= @capacity
      resize!
    end

    (@length).times do |time|
      @arr[@length-time] = @arr[@length-time-1]
    end
    @arr[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    tempArr = StaticArray.new(@capacity*2)
    @capacity.times do |cap|
      tempArr[cap] = @arr[cap]
    end
    @capacity = @capacity*2
    @arr = tempArr
  end
end
