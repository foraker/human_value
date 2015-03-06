module HumanValue
  class Humanization
    def initialize(type)
      @type
    end

    def matches?(value)
      @test.call(value)
    end

    def call(value)
      @coerce.call(value)
    end

    def test(&block)
      @test = block
      self
    end

    def coerce(&block)
      @coerce = block
      self
    end
  end
end
