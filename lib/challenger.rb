class Challenger
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

end
