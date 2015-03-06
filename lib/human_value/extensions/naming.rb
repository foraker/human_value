module HumanValue
  module Extensions
    module Naming
      def self.load
        HumanValue.humanize :named do
          test   { |v| v.respond_to?(:name) }
          coerce { |v| v.name.to_s }
        end
      end
    end
  end
end

