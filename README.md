# Bookland

[Bookland] [1] provides an ISBN class in Ruby.

[![travis](https://secure.travis-ci.org/hakanensari/bookland.png)](http://travis-ci.org/hakanensari/bookland)

## Usage

    require "bookland"

    isbn = ISBN.new("0262011530")
    isbn.to_isbn13
    => "9780262011532"
    isbn.valid?
    => true

Bookland provides certain utility methods defined on the class level:

    ISBN.to_13("0262011530")
    => "9780262011532"

    ISBN.to_10("9780262011532")
    => "0262011530"

    ISBN.valid?("9780262011532")
    => true

[1]: http://en.wikipedia.org/wiki/Bookland
