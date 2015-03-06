require "active_support/core_ext"
require "active_support/number_helper"
require "human_value/humanization"
require "human_value/value"
require "human_value/helpers"

Gem.find_files("human_value/extensions/**/*.rb").each { |path| require path }
Gem.find_files("human_value/integration/**/*.rb").each { |path| require path }

module HumanValue
  def self.humanizations
    @humanizations ||= []
  end

  def self.humanize(type, options = {}, &block)
    modifier = options[:prepend] ? :unshift : :push
    humanizations.public_send modifier, Humanization.new(type).instance_eval(&block)
  end

  def self.enable_extension(extension_name)
    "HumanValue::Extensions::#{extension_name.to_s.classify}".constantize.load
  rescue NameError
    raise "Unknown extension '#{extension_name}'"
  end

  humanize :boolean do
    test   { |v| [true, false].include?(v) }
    coerce { |v| v ? "Yes" : "No" }
  end

  humanize :number do
    test   { |v| v.is_a?(Numeric) }
    coerce { |v| ActiveSupport::NumberHelper.number_to_delimited(v) }
  end

  humanize :timeish do
    test   { |v| v.respond_to?(:strftime) }
    coerce { |v| I18n.localize(v) }
  end

  humanize :humanizable do
    test   { |v| v.respond_to?(:human) }
    coerce { |v| v.human }
  end

  humanize :enumerable do
    test   { |v| v.respond_to?(:each) }
    coerce { |v| Value.wrap(v).join(', ') }
  end

  humanize :model_name do
    test   { |v| v.respond_to?(:model_name) }
    coerce { |v| v.model_name.human }
  end
end
