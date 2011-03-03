Bookland
========

[Bookland](http://en.wikipedia.org/wiki/Bookland) provides an ISBN class in Ruby.

Examples
--------

    include Bookland

    isbn10 = ISBN.new('0262011530')
    isbn10.to_isbn13
    => "9780262011532"

    isbn10.to_s(1, 3, 5)
    => "0-262-01153-0"

    isbn13 == ISBN.new('9780262011532')
    => true

    # An invalid ISBN
    not_an_isbn = ISBN.new('0262011531')
    not_an_isbn.valid?
    => false
    not_an_isbn.to_isbn13
    => Bookland::ISBNError: Invalid ISBN

Some utility methods defined in the class level:

    include Bookland

    ISBN.to_13('0262011530')
    => "9780262011532"

    ISBN.to_10('9780262011532')
    => "0262011530"

    ISBN.valid?('9780262011532')
    => true
