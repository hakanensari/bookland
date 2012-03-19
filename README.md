# Bookland

[![travis] [1]] [2]

[Bookland] [3] provides ISBN and EAN classes in Ruby.

## Installation

```ruby
# Gemfile
gem 'bookland'
```

## Usage

```ruby
include 'bookland'

isbn = ISBN.new "9780262011532"
isbn.valid? # => true
isbn10 = isbn.to_isbn_10
isbn10.to_s # => "0262011530"
```

Alternatively, use utility methods defined on the class level:

```ruby
EAN.valid?  '0814916013890' # => true
ISBN.valid? '0814916013890' # => false
```

[1]: https://secure.travis-ci.org/hakanensari/bookland.png
[2]: http://travis-ci.org/hakanensari/bookland
[3]: http://en.wikipedia.org/wiki/Bookland
