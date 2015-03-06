module HumanValue
  module Extensions
    module Carrierwave
      def self.load
        HumanValue.humanize :image do
          test do |v|
            v.respond_to?(:content_type) &&
            v.content_type.to_s.starts_with?("image")
          end

          coerce { |v| "<img src='#{v}'>".html_safe }
        end

        HumanValue.humanize :file do
          test   { |v| v.respond_to?(:content_type) }
          coerce { |v| "<a href='#{v}'>#{v.filename}</a>".html_safe }
        end
      end
    end
  end
end
