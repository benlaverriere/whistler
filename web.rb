require 'sinatra/base'

module WhistlerBot
  class Web < Sinatra::Base
    get '/' do
      '👏 get 👏 tricks 👏 now 👏'
    end
  end
end
