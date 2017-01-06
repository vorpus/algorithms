class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0
    self.each_with_index do |el, idx|
      hash += (el.hash + idx).hash
    end
    hash
  end
end

class String
  def hash
    self.split('').map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0
    self.keys.each do |key|
      hash += self[key].to_s.hash + key.to_s.hash
    end
    hash
  end
end
