require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

require_relative '../lib/play'
require_relative '../lib/welcome_menu'
require_relative '../app/models/game'
require_relative '../app/models/user'
require_relative '../app/models/word'
require 'terminal-table'
require 'colorized_string'
