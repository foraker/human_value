require "human_value"

RSpec.configure do |config|
  class MockI18n
    def initialize(translations = {})
      @translations = translations
    end

    def localize(value)
      value.strftime('%m/%d/%Y')
    end

    def translate(value, options = {})
      @translations.fetch(value) do
        options[:default]
      end
    end
  end

  config.before do
    stub_const("I18n", MockI18n.new)
  end

  def coerced(value)
    HumanValue::Value.new(value).to_s
  end
end

