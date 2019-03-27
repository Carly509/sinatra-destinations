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
        erb :'/users/login'
       end
    end

    post "/users/signup" do
      if !logged_in?
      name = params[:name]
      email = params[:email]
      username = params[:username]
      city = params[:city]
      password = params[:password]
      @user = User.create(name:name,email:email,username:username,city:city,password:password)
      session[:user_id] = @user.id

      @post = current_user.post.all
      @total_post = current_user.post.count
      erb :"/post/index"

      else
        @user = User.find(session[:user_id])
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
      else 

      end
    end

        
  
end