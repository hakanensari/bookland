Bookland
========

[Bookland](http://en.wikipedia.org/wiki/Bookland) provides an ISBN class in
Ruby.

Usage
-----

    require 'bookland'

    isbn10 = ISBN.new('0262011530')
    isbn10.to_isbn13
    => "9780262011532"

    isbn10.to_s(1, 3, 5)
    => "0-262-01153-0"

    isbn13 == ISBN.new('9780262011532')
    => true

    # Does an invalid ISBN quack like an ISBN?
    bad_isbn = ISBN.new('0262011531')
    bad_isbn.valid?
    => false
    bad_isbn.to_isbn13
    => Bookland::ISBNError: Invalid ISBN

Some utility methods defined on the class level:

    ISBN.to_13('0262011530')
    => "9780262011532"

    ISBN.to_10('9780262011532')
    => "0262011530"

    ISBN.valid?('9780262011532')
    => true
