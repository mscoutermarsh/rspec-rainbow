require 'rspec/core/formatters/progress_formatter'

class RSpec2 < ::RSpec::Core::Formatters::ProgressFormatter
  PI_3 = Math::PI / 3

  def initialize(options)
    # colors calculation stolen from Minitest's Pride Plugin
    # https://github.com/seattlerb/minitest
    @colors = (0...(6 * 7)).map do |n|
      n *= 1.0 / 6
      r  = (3 * Math.sin(n) + 3).to_i
      g  = (3 * Math.sin(n + 2 * PI_3) + 3).to_i
      b  = (3 * Math.sin(n + 4 * PI_3) + 3).to_i

      36 * r + 6 * g + b + 16
    end
    @color_index = 0
    super(options)
  end

  def rainbow
    @color_index == (@colors.size - 1) ? @color_index = 0 : @color_index += 1
    @colors[@color_index]
  end

  def color(text, color_code)
    color_code = rainbow if text == '.'
    super
  end

  def color_code_for(code_or_symbol)
    return "38;5;#{code_or_symbol}" if code_or_symbol.is_a?(Integer)
    super
  end
end
