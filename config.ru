require 'rubygems'
require 'sinatra' 
require 'moonitor'

set :run, false
set :environment, :production

run Sinatra::Application
