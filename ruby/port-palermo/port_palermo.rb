module Port
  Port::IDENTIFIER = :PALE

  def self.get_identifier(city)
    city[0,4].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    cargo = ship_identifier.to_s[0,3]
    if cargo == "OIL" || cargo == "GAS"
      return :A
    end
    return :B
  end
end
