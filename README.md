# Bookland

> [Bookland][bo] is a fictitious country that exists solely for the purposes of non-geographically cataloguing books in the otherwise geographically keyed EAN coding system.

## Usage

**Bookland** provides EAN and ISBN classes:

```ruby
include 'bookland'

# functional
EAN.valid?('0814916013890') # => true
ISBN.valid?('9780262011532') # => true

# oo
isbn = ISBN.new('9780262011532')
isbn.valid? # => true
```

**Bookland** also comes with an ASIN class:

```ruby
isbn = '9780262011532'
asin = ASIN.from_isbn(isbn) # => "0262011530"
ASIN.to_isbn(asin) # => "9780262011532"
```

Caveat: `ASIN` does not calculate the checksum digit for propietary ASINs. If you happen to break their algo, ping me.

All three classes expose a class-level `calculate_checksum_digit` method:

```ruby
data_digits = [9, 7, 8, 0, 2, 6, 2, 1, 1, 5, 3]
ISBN.calculate_checksum_digit(data_digits) # => 2
```

**Bookland** includes custom EAN, ISBN, and ASIN validators if Active Model is loaded. Use it like so:

```ruby
class Book
  include ActiveModel::Model

  attr_accessor :isbn

  validates :isbn, isbn: true
end
```

[bo]: http://en.wikipedia.org/wiki/Bookland
