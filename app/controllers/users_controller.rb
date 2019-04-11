class UsersController < ApplicationController
    
    get '/users/show' do 
       @message = 'The page you are looking for does not exist; it may have been moved, or removed'
       erb :error
    end

    post '/users/login' do
      @user = User.find_by(email: params["email"],password: params["password"])
      if @user
      session[:user_id] = @user.id
      @post = current_user.post.all
      @total_post = current_user.post.count
  
      erb :"/post/index"

      else
        @message = "No user found!"
        erb :index
      end
    end

    get '/users/login' do
       if logged_in?
        @user = User.find(session[:user_id])
        @post = current_user.post.all
        @total_post = current_user.post.count
        erb :"/post/index"
        

       else  
        erb :'/index'
       end
    end

    post "/users/signup" do
      
      @user = User.new(:name => params[:name], :username =>  params[:username], :email => params[:email], :password => params[:password], :city => params[:city])
      @user.save
      session[:user_id] = @user.id
      if @user.save
      @post = current_user.post.all
      @total_post = current_user.post.count
      erb :"/post/index"
      end
      
    end

 
  
    get "/users/:id" do
      if logged_in?
          @user = User.find(session[:user_id])
          erb :'/users/show'
      else 
        @message = 'Access denied! you do not have permision to see this!'
        erb :error
      end
    end
  
    get'/logout' do
      if logged_in?
      session.clear
      erb :index
      
      end
    end

        
  
end