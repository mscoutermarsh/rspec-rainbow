RSpec::Support.require_rspec_core 'formatters/base_text_formatter'

class RSpec3 < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self, :example_passed, :initialize

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

  def example_passed(_notification)
    output.print "\e[38;5;#{rainbow}m.\e[0m"
  end

  def rainbow
    @color_index == (@colors.size - 1) ? @color_index = 0 : @color_index += 1
    @colors[@color_index]
  end
end
