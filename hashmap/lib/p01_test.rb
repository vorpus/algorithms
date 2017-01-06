require_relative 'p04_linked_list'


list = LinkedList.new
p list

k_v_pairs = { first: 1, second: 2, third: 3 }
k_v_pairs.each do |key, val|
  p key
  list.insert(key, val)
end
list.insert(:second, 99)

p list.get(:first)
p list.get(:second)
p list.get(:third)
