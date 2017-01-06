# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @arr = Array.new(length)
  end

  # O(1)
  def [](index)
    @arr[index]
  end

  # O(1)
  def []=(index, value)
    @arr[index] = value
  end

  protected
  attr_accessor :store
end
