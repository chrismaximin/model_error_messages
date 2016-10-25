# Model Error Messages

A simple Rails helper which displays a HTML div with the validation errors attached to a model.

## Install

**Model Error Messages**'s installation is pretty standard, add the following line to your `Gemfile`, then run `bundle install`:

```rb
gem 'model_error_messages'
```

## What this gem does / How to use

This gem allows you to use a helper called `model_error_messages`.  
If you have a typical form, you would want to display `model_error_messages(@model_instance)` next to it, which will render something like:

```html
<div class="alert alert-danger article-error-messages">
  <ul>
    <li>Title can't be blank</li>
    <li>You must select an author</li>
  </ul>
</div>
```

... or if there is only one error:

```html
<div class="alert alert-danger article-error-messages">
  <p>Title can't be blank</p>
</div>
```

Example of integration:

```erb
<%= model_error_messages(@article) %>

<%= form_for @article do |f| %>
  <!-- ... form fields ... -->
<% end %>
```

## What this gem doesn't do

* Include any other dependencies
* Influence the generation of errors
* Inject or execute any code in your controllers and models
* Do anything with the `flash` messages
* Anything not listed in "What this gem does"

## Optional configuration

You can change the default behavior of `model_error_messages` by:

## Setting an initializer

Create a file `config/initializers/model_error_messages.rb` and replace one of the defaults:

```rb
ModelErrorMessages.configuration do |config|
  # Multiple errors will rendered in a several <li> in a <ul>, while one error will be rendered in a <p>
  config.single_error_in_paragraph = true

  # The following classes will be added in the main wrapper div.
  config.classes = lambda do |model|
    [
      'alert',
      'alert-danger',
      model.class.model_name.param_key + '-error-messages'
    ]
  end

  # HTML that will be added before the list of errors.
  config.prepend_html = lambda { |model| String.new }

  # HTML that will be added after the list of errors.
  config.append_html = lambda { |model| String.new }
end
```

## Passing options when calling `model_error_messages`

Examples:

```erb
<%= model_error_messages(@article, single_error_in_paragraph: false) %>
```

## Contributing

Don't hesitate to send a pull request!

## Testing

```sh
$ bundle install
$ bundle exec rspec spec/
```

## License

This software is distributed under the MIT License. Copyright (c) 2016, Christophe Maximin
