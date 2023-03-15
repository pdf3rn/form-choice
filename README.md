# FormChoice

Adds form_choice control to form.

## Usage



## Installation

Add this line to your application's Gemfile:

```ruby
gem "form_choice", git: "git@github.com:pdf3rn/form-choice.git"
```

And then execute:

```bash
$ bundle install
```

Añadir al `importmap.rb`:

```ruby
pin 'choices', to: 'choices.js.js'
pin 'form_choice', to: 'form_choice.js'
```

En `app/javascript/controllers/application.js`

```javascript
// ...
const application = Application.start()
application.register('form-choice', ChoicesField)
// ...
```

Stylesheets
```css
@import "form_choice.css";
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
