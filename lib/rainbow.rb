require 'rspec/core/formatters/progress_formatter'

class Rainbow < ::RSpec::Core::Formatters::ProgressFormatter
  
  def initialize(options)
    @colors = (31..36).to_a
    @color_index = 0
    super(options)
  end

  def rainbow
    @color_index == (@colors.size - 1) ? @color_index = 0 : @color_index += 1
    @colors[@color_index]
  end

  def color(text, color_code)
    colorize(text, rainbow)
  end

  def color_code_for(code_or_symbol)
    return code_or_symbol if code_or_symbol.is_a?(Integer)
    super
  end

end