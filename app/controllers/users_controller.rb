class UserController < ApplicationController
    
    get '/users/show' do 
       @message = 'The page you are looking for does not exist; it may have been moved, or removed'
       erb :error
    end

    post '/users/login' do
      # binding.pry
      @user = User.find_by(email: params["email"],password: params["password"])

      if @user
      session[:user_id] = @user.id
      @post = current_user.post.all
      @total_post = current_user.post.count
  
      erb :"/post/index"

      else
        @message = "No user found for these info."
        erb :'/users/login'
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

    get '/users/signup' do 
      
      erb :'/users/signup'
    end


    post "/users/signup" do
      if !logged_in?
      # raise params.inspect
      name = params[:name]
      email = params[:email]
      pasword = params[:password]
      @user = User.create(name:name,email:email,password:pasword )
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
        # @user = User.find(params[:id])
          erb :'/users/show'
      else 
        @message = 'Access denied! you do not have permision to see this!'
        erb :error
      end
    end
  
    get'/logout' do
      if logged_in?
      session.clear
      erb :"/users/login"
      else 

      end
    end

        
  
end