require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1 unless self.include?(key)
    self[key].push(key)
    resize! if @count >= num_buckets
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if self.include?(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |el|
        new_set.insert(el)
      end
    end
    @store = new_set.store
  end
end
