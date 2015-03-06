if defined?(::Rails)
  module HumanValue
    class Railtie < ::Rails::Railtie
      initializer "human_value.view_helpers" do
        ActionView::Base.send :include, HumanValue::Helpers
      end
    end
  end
end
