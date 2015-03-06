module HumanValue
  class Value
    def self.wrap(objects)
      objects.map{ |object| new(object) }
    end

    def initialize(raw)
      @raw = raw
    end

    def to_s
      HumanValue.humanizations.each do |humanization|
        return humanization.call(raw) if humanization.matches?(raw)
      end

      raw.to_s
    end

    private

    attr_reader :raw
  end
end
