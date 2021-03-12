# Number::Facts

A simple wrapper for the numbersapi.com service API.

```ruby
client = Numbers::Facts::Client.new
client.request(number: 42)
```

## Quick start

Install via Rubygems

```shell
gem install 'number-facts'
```

or add to your Gemfile

```ruby
gem "number-facts", "~> 1.0"
```

Access the library in Ruby

```ruby
require 'number-facts'

Number::Facts.request(number: 42)
```

## Usage

```ruby
#!/usr/bin/env ruby
require 'number-facts'

client = Numbers::Facts::Client.new(api_endpoint: 'https://<new-api-hostname>')
result = client.request(
    number: 42,
    type: :trivia,
    fragment: true,
    default: 'what a bored number'
)
result.success? # true
result          # { "text": "the number of kilometers in a marathon", "number": 42, "found": true, "type": "trivia"}
```

### Options for the `request`

All options are optional and can be combined in many ways.

#### `number`

The `number` options - is an integer or the keyword `:random` or a day of year in the form `month/day`. Defaults to `:random`

```ruby
fact = client.request(number: 42)
fact.text # 42 is the number of spots (or pips, circular patches or pits) on a pair of standard six-sided dice.

fact =  client.request(number: :random)
fact.text # 31 is the number of days in the months January, March, May, July, August, October and December.
```
#### `type`

The `type` option is one of fact types `:trivia`, `:math`, `:date`, or `:year`. Defaults to `:trivia`.

```ruby
fact = client.request(number: 2010, type: :trivia)
fact.text #

fact = client.request(number: 2010, type: :math)
fact.text #

fact = client.request(number: 2010, type: :year)
fact.text #
```

#### `fragment`

Is a boolean flag to return the fact as a sentence fragment where is the first word is lowercase and ending punctuation is omitted. Defaults to `false`

```ruby
fact = client.request(number: 42, fragment: false)
fact.text #

fact =  client.request(number: 42, fragment: true)
fact.text #
```

#### `notfound`

* `notfound` - is a strategy what to do if the number is not found.

```ruby
fact = client.request(number: 35353, notfound: :default, default: 'so bored')
fact.number #
fact.text   #

fact = client.request(number: 35353, notfound: :floor)
fact.number #
fact.text   #

fact = client.request(number: 35353, notfound: :ceil)
fact.number #
fact.text   #
```

#### `default`

* `default` - is the default fact message in case of the number is not found.

```ruby
fact = client.request(number: 35353)
fact.text #

fact =  client.request(number: 35353, default: 'so bored')
fact.text #
```

#### `min` and `max`

```ruby
fact = client.request(min: 1, max: 3)
fact.number #
fact.text   #
```
