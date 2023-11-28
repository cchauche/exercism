class Matrix
  def initialize(string_matrix)
    @matrix = string_matrix.split("\n").map { |row| row.split.map(&:to_i) }
  end

  def row(n = 1)
    @matrix[n - 1]
  end

  def column(n = 1)
    @matrix.map { |row| row[n - 1] }
  end
end
