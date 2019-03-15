require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/users/login' do
    erb :'/users/welcome'
end

get  '/index/logout' do
  'Goodbye'
end


end
