class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(arr)
    return arr if arr.length <= 1
    pivot = arr.first
    left = []
    right = []

    1.upto(arr.length-1) do |idx|
      if arr[idx] < pivot
        left << arr[idx]
      else
        right << arr[idx]
      end
    end
    return QuickSort.sort1(left).concat([pivot]).concat(QuickSort.sort1(right))

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return if length <= 1
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, 0, pivot, &prc)
    QuickSort.sort2!(array, pivot + 1, length - pivot, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    length.times do |time|
      idx = start + time
      switch = prc.call(array[start], array[idx])
      if switch == 1
        array.insert(start, array.delete_at(idx))
        start += 1
      end
    end

    return start
  end
end
