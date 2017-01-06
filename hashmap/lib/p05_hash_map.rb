require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    @count += 1 unless self.include?(key)
    bucket(key).insert(key, val)
    resize! if @count >= num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if self.include?(key)
    bucket(key).remove(key)
  end

  def each
    @store.each do |ll|
      llhead = ll.first
      while llhead
        yield [llhead.key, llhead.val]
        llhead = llhead.next
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash = HashMap.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |el|
        new_hash.set(el.key, el.val)
      end
    end
    @store = new_hash.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
