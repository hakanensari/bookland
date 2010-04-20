![ISBN](http://upload.wikimedia.org/wikipedia/commons/thumb/2/28/EAN-13-ISBN-13.svg/750px-EAN-13-ISBN-13.svg.png)

Bookland provides an ISBN class. The class abstracts ISBN-10 and ISBN-13s and offers methods to convert and compare one to the other.

    $ irb -r "bookland"
    >> book = ISBN.new("0262011530")
    => "0262011530"
    >> book.to_isbn13
    => "9780262011532"
    >> book.to_s(1,3,5)
    => "0-262-01153-0"
    >> ISBN.new("9780262011532") == book
    => true
    >> ISBN.new("0262011531") # This is an invalid ISBN
    => false
