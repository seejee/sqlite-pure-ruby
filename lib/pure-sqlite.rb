require_relative "pure-sqlite/structures"
require_relative "pure-sqlite/database"
require_relative "pure-sqlite/header"
require_relative "pure-sqlite/page"
require_relative "pure-sqlite/database_record"

module PureSQLite
  extend self

  def list_tables(filename)
    Database.open(filename) do |db|
      db.tables
    end
  end

end
