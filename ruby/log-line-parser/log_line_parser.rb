class LogLineParser
  def initialize(line)
    level, message = line.split(':')
    @message = message.strip
    @log_level = level.slice(1..-2).downcase
  end

  def message
    @message
  end

  def log_level
    @log_level
  end

  def reformat
    "#{@message} (#{@log_level})"
  end
end
