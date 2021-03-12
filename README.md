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
fact.text # 2010 is a number for which we're missing a fact (submit one to numbersapi at google mail!).

fact = client.request(number: 2010, type: :math)
fact.text # 2010 is the number of trees on 15 vertices with diameter 7.

fact = client.request(number: 2010, type: :year)
fact.text # 2010 is the year that Kyrgyz President Kurmanbek Bakiyev flees Bishkek amid fierce rioting, sparking a sociopolitical crisis on April 7th.
```

#### `fragment`

Is a boolean flag to return the fact as a sentence fragment where is the first word is lowercase and ending punctuation is omitted. Defaults to `false`

```ruby
fact = client.request(number: 42, fragment: false)
fact.text # 42 is the number of laws of cricket.

fact =  client.request(number: 42, fragment: true)
fact.text # the number of US gallons in a barrel of oil
```

#### `notfound`

* `notfound` - is a strategy what to do if the number is not found.

```ruby
fact = client.request(number: 35353, notfound: :default, default: 'so bored')
fact.number # 35353
fact.text   # so border

fact = client.request(number: 35353, notfound: :floor)
fact.number # 35000
fact.text   # 35000 is the number of genes in a human being.
fact.found  # false

fact = client.request(number: 35353, notfound: :ceil)
fact.number # 43687
fact.text   # 43687 is the number of toilet related accidents in the United States in 1996.
fact.found  # false
```

#### `default`

* `default` - is the default fact message in case of the number is not found.

```ruby
fact = client.request(number: 35353)
fact.text  # 35353 is an uninteresting number.
fact.found # false

fact =  client.request(number: 35353, default: 'so bored')
fact.text  # so bored
fact.found # false
```

#### `min` and `max`

```ruby
fact = client.request(min: 1, max: 3)
fact.number # 3
fact.text   # 3 is the number of spatial dimensions we perceive our universe to have.
```
