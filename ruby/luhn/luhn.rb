module Luhn
  def self.valid?(string)
    parsed = parse_input(string)

    return false if !parsed

    parsed.reverse.each_with_index do |el, i|
      num = el.to_i
      doubled = num * 2

      num = doubled > 9 ? doubled - 9 : doubled if (i % 2) > 0

      parsed[i] = num
    end

    parsed.sum % 10 == 0
  end

  def self.parse_input(string)
    stripped = string.gsub(/\s/, "")

    return nil if stripped.length <= 1

    digits = string.scan(/\d/)

    return nil if stripped.length > digits.length

    digits
  end
end
