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

class Scrabble
  LETTER_VALUES = {
    /[AEIOULNRST]/ => 1,
    /[DG]/ => 2,
    /[BCMP]/ => 3,
    /[FHVWY]/ => 4,
    /[K]/ => 5,
    /[JX]/ => 8,
    /[QZ]/ => 10
  }

  def initialize(word)
    @word = word.to_s.upcase
  end

  def self.score(word)
    (new word).score
  end

  def score
    word_score = 0

    LETTER_VALUES.each do |letters, value|
      word_score += (@word.scan(letters).count * value)
    end

    word_score
  end
end
