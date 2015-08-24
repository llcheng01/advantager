require 'yaml'

class Challenger
  # data is a hash object
  # { 10: [], 5: []}
  attr_accessor :input, :data, :cache_file

  def initialize input = [], cache_file = false
    @input = input
    @cache_file = cache_file
    # @data = cache_file ? YAML::load(File.read(cache_file)) : {}
  end

  # Set data after all source is calculated
  def calculate_factors
    # created a copy of source. sad face!
    original = @input.dup
    @input.inject({}) do |data, elem|
      target = substring elem, original
      result = factors elem, target, []
      data[elem] = result
      data
    end
  end
  
  def calculate_multipliers
    # created a copy of source. sad face!
    original = @input.dup
    @input.inject({}) do |data, elem|
      target = substring elem, original
      result = multipliers elem, target, []
      data[elem] = result
      data
    end
  end

  # return target array without the source element
  def substring source, target
    i = target.index(source)
    len = target.length
    return [] if (len == 0 || len == 1)
    return target[1..len] if i == 0
    return target[0..len-2] if i == len - 1
    target[0..i-1] + target[i+1..len-1]
  end
  # Providing an integer and a list of integer
  # push factor for integer in result
  # result is empty initially
  # return list of integer or empty array
  def factors source, target, result
    return result if target.length == 0

    x = target.pop
    result << x if (source % x).zero?

    return factors source, target, result
  end

  # Providing an integer and a list of integer
  # push multipliers for integer in result
  def multipliers source, target, result
    return result if target.length == 0
    
    x = target.pop
    result << x if (x % source).zero?

    return multipliers source, target, result
  end

  def save_to_yaml data
    # @cache_file = cache_file || "cache.yml"
    File.open @cache_file, "w" do |f|
      f.write YAML::dump data
    end
  end

end
