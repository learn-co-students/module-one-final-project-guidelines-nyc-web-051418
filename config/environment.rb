require 'bundler'
Bundler.require

require "timeout"
require_relative '../app/models/user.rb'
require_relative '../app/models/word.rb'
require_relative '../app/models/game.rb'
require_relative "../lib/api_call.rb"
require_relative "../lib/play.rb"
require_relative "../lib/welcome.rb"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
