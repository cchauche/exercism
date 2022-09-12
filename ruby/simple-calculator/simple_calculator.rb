class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    if not operation in ALLOWED_OPERATIONS
      raise UnsuportedOperation
    end
    answer = 0
    begin
      case operation
      when "+"
        answer = first_operand + second_operand
      when "/"
        answer = first_operand / second_operand
      when "*"
        answer = first_operand * second_operand
      end 
    rescue
    end
    "#{first_operand} #{operation} #{second_operand} = #{answer}"
  end
end
