pure-sqlite: A SQLite implementation in 100% ruby.

At the moment, this library only reads the 100 byte header and the schema
page so that a list of tables can be retrieved.

To get the list of tables:
  
    require 'PureSQLite'
    
    PureSQLite::Database.open(filename) do |db|
      db.tables
    end
    
For information about the file format itself, please see the following link:

http://www.sqlite.org/fileformat.html

This library works makes extensive use of Ruby's String#unpack method to read
from a valid SQLite database file. The hierarchy of decoded objects looks
like:

File
 -> Header
 -> N Pages
    -> N Cells
      -> 1 Database Record
        -> N Data Fields