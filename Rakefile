require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new

TEST_DB = FileList['spec/resources/test.db']

desc 'Create the testing database used by the specs'
file TEST_DB do
 `sqlite3 spec/resources/test.db 'CREATE TABLE table_one(id int, a_column varchar(20))'`
 `sqlite3 spec/resources/test.db 'CREATE TABLE table_two(id int, another_column varchar(50))'`
end

task :default => [TEST_DB, :spec]
