module HumanValue
  module Helpers
    def humanize(value)
      HumanValue::Value.new(value).to_s
    end

    alias :h :humanize
  end
end
