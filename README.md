# Human Value

`HumanValue` translates values into human-friendly formats.

For example, humans like to read "1,000,000" rather than "1000000", or "12/12/2012 at 4:30 PM MT" rather than "2012-12-12 16:30:00 -0700".

### Example usage in Rails

In Rails, use the `h` abbreviated helper method.

```ERB
<span><%= h 1000 %></span>
```

to produce

```HTML
<span>1,000</span>
```

## Installation

Add this line to your application's Gemfile and run `bundle install`:

    gem 'human_value'

## Default humanizations

Out of the box, `HumanValue` knows how to humanize the following types:

- Booleans
- Numerics
- Dates and times
- Enumerables
- Classes with a `model_name` (i.e. `ActiveModel` and `ActiveRecord` classes)

## Extensions

`HumanValue` also comes with extensions for humanizing values from common Rails libraries. Extensions are enabled as follows in a `config/initializers/human_value.rb` file.

```Ruby
HumanValue.enable_extension(:carrierwave)
```

#### The following extensions are supported:

- `:carrierwave`
  - renders image attachments as `<img>` tags
  - renders file attachments as `<a>` tags

- `:naming`
  - tries to render names by calling a `name` method

## Writing custom humanizations

You may add your own humanizations using the `HumanValue.humanization` hook. You must define a `test` block (i.e. does this humanization apply) and a `coerce` block which performs the humanization.

For example, let's assume we have a `User` class with a `name` method which should fall back to the `email` method. We can add a custom humanization in `config/initializers/human_value.rb`.

```Ruby
HumanValue.humanization :user do
  test   { |value| value.is_a?(User) }
  coerce { |value| value.name || value.email }
end
```

```ERB
<% user_1 = User.new(name: "Timothy Tyler", email: "tim@gmail.com") %>
<% user_2 = User.new(name: nil, email: "anon@gmail.com") %>

<%= h user_1 %>
<%= h user_2 %>
```

which produces

```HTML
Timothy Tyler
anon@gmail.com
```

## Overriding existing humanizations

If you need to add a custom humanization which supercedes one of the default humanizations, use the `:prepend` option.

For example, perhaps you want to humanize booleans to "Yep" and "Nope" rather than "Yes" and "No".

```Ruby
HumanValue.humanization :boolean, prepend: true do
  test   { |value| [true, false].include?(value) }
  coerce { |value| value ? "Yep" : "Nope" }
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## About Foraker Labs

<img src="http://assets.foraker.com/foraker_logo.png" width="400" height="62">

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.

Foraker Labs is a Boulder-based Ruby on Rails and iOS development shop. Please reach out if we can [help build your product](http://www.foraker.com).
