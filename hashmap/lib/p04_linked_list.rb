class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    cur_el = @head
    while cur_el
      cur_el = cur_el.next if cur_el.next
    end
    return cur_el
  end

  def empty?
    return false if @head
    true
  end

  def get(key)
    cur_el = @head
    while cur_el
      if cur_el.key == key
        return cur_el.val
      end
      cur_el = cur_el.next
    end
    nil
  end

  def get_link(key)
    cur_el = @head
    while cur_el
      if cur_el.key == key
        return cur_el
      end
      cur_el = cur_el.next
    end
    nil
  end

  def include?(key)
    cur_el = @head
    while cur_el
      if cur_el.key == key
        return true
      end
      cur_el = cur_el.next
    end
    false
  end

  def insert(key, val)
    cur_el = @head
    if cur_el
      while cur_el
        if cur_el.key == key
          cur_el.val = val
          return true
        end
        if cur_el.next
          cur_el = cur_el.next
        else
          break
        end
      end
      new_link = Link.new(key, val)
      cur_el.next = new_link
      new_link.prev = cur_el
    else
      new_link = Link.new(key, val)
      @head = new_link
    end

  end

  def remove(key)
    to_delete = self.get_link(key)
    if to_delete
      if to_delete.prev
        to_delete.prev = to_delete.next
      else
        @head = to_delete.next
      end
      return true
    else
      return false
    end
  end

  def each
    cur_el = @head
    while cur_el
      yield cur_el
      cur_el = cur_el.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
