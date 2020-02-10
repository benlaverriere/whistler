# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'whistler-bot'
require 'web'

Thread.abort_on_exception = true

Thread.new do
  WhistlerBot::Bot.run
rescue Exception => e
  warn "ERROR: #{e}"
  warn e.backtrace
  raise e
end

run WhistlerBot::Web
