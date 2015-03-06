if defined?(Sinatra)
  ::Sinatra::Application.send(:helpers, HumanValue::Helpers)
end
