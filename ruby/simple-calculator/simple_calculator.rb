class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    if not ALLOWED_OPERATIONS.include? operation
      raise UnsupportedOperation
    end
    if (not first_operand.is_a? Numeric) || (not second_operand.is_a? Numeric)
      raise ArgumentError
    end
    answer = 0
    begin
      case operation
      when "+"
        answer = first_operand + second_operand
      when "/"
        begin
          answer = first_operand / second_operand
        rescue ZeroDivisionError => e
          return "Division by zero is not allowed."
        end
      when "*"
        answer = first_operand * second_operand
      end
    rescue
    end
    return "#{first_operand} #{operation} #{second_operand} = #{answer}"
  end
end
