require 'sinatra'
require 'sinatra/activerecord'

class App < Sinatra::Application
  set :enviroment, ENV['RACK_ENV']
  enable :sessions

  # use Rack::Session::Cookie, :key => 'rack.session',
  #                          :domain => 'myawesomeapp.com',
  #                          :path => '/',
  #                          :expire_after => 2592000,
  #                          :secret => 'random_text',
  #                          :old_secret => 'another_random_text'

  configure do

  end

  Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each{ |model| require model }
  Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each { |lib| load lib }
end
