require_relative 'dynamic_array'
require_relative 'ring_buffer'

# darr = DynamicArray.new
# 8.times do |i|
#   darr.push(i)
# end
#
# p darr
# darr.shift
# p darr
# darr.unshift(5)
# p darr
# darr.unshift(5)
# p darr

rb = RingBuffer.new

5.times do |i|
  rb.push(i)
  rb.unshift(i)
end

p rb
