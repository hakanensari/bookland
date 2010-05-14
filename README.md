![ISBN](http://upload.wikimedia.org/wikipedia/commons/thumb/2/28/EAN-13-ISBN-13.svg/900px-EAN-13-ISBN-13.svg.png)

Bookland provides a simple ISBN class in Ruby.

    $ irb -r "bookland"
    >> include Bookland
    >> book = ISBN.new("0262011530")
    >> book.to_isbn13
    => "9780262011532"
    >> book.to_s(1, 3, 5)
    => "0-262-01153-0"
    >> ISBN.new("9780262011532") == book
    => true
    >> invalid_book = ISBN.new("0262011531") # This is an invalid ISBN
    >> invalid_book.valid?
    => false
    >> invalid_book.to_isbn13
    => Bookland::ISBNError: ISBN not valid
