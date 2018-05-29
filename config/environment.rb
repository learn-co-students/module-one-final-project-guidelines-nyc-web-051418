require 'bundler'
require 'pry'
require 'tty-prompt'
require 'pastel'
require 'tty-font'
require 'rest-client'
require 'json'
Bundler.require
# require_relative './prompt.rb'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all 'lib'
