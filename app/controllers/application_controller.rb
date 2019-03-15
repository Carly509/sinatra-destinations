require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  get "/" do
    if logged_in?
      @post = current_user.post.all
      @user = User.find(session[:user_id])
      erb :'post/index'
    else
      erb :index
   end
  end


get  '/users/logout' do
  erb :'/users/welcome'
end


end
