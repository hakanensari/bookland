# Bookland

[Bookland][bo] provides ISBN and ASIN classes, which should come in handy when trading books online.

## Installation

```bash
gem install bookland
```

## Usage

```ruby
include 'bookland'

ISBN.valid?('9780262011532') # => true
ASIN.from_isbn('9780262011532') # => "0262011530"
ASIN.to_isbn('0262011530') # => "9780262011532"
```

[bo]: http://en.wikipedia.org/wiki/Bookland
