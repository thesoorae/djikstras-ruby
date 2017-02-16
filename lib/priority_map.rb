require_relative 'heap2'

class PriorityMap
  def initialize(&prc)

    @map = {}
    @queue = BinaryMinHeap.new do |a, b|
      prc.call(@map[a], @map[b])
    end
  end

  def [](key)
    return nil unless self.has_key?(key)
    @map[key]
  end

  def []=(key, value)
    if self.has_key?(key)
      self.update(key,value)
    else
      self.insert(key, value)
    end
  end

  def count
    @map.length
  end

  def empty?
    @map.empty?
  end

  def extract

    key = @queue.extract
    temp = @map[key]
    @map.delete(key)
    [key, temp]

  end

  def has_key?(key)
    @map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value

    @queue.push(key)

  end



  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
    
  end
end
