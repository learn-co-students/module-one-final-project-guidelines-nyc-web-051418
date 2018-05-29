require 'bundler'
require 'pry'
require 'tty-prompt'
require 'tty-table'
require 'pastel'
require 'tty-font'
require 'rest-client'
require 'json'
require 'htmlentities'


Bundler.require
# require_relative './prompt.rb'


old_logger = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
# require_all 'lib'
