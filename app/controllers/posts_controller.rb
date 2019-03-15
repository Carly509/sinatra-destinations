class PostsController < ApplicationController

    get '/home' do
        if logged_in?
            @post = current_user.post.all
            @user = User.find(session[:user_id])
            @total_post = current_user.post.count
            erb :'post/index'
          else
            @message ='You must login first'
            redirect"/users/login"
         end
        
    end

    patch '/update/:id' do
        if logged_in?
            @post = Post.find(params[:id])
                if @post && @post.user == current_user
                    @post.title = params[:title]
                    @post.content = params[:content]
                    @post.save
                    redirect to "/post/#{@post.id}"
                else

                    @message = 'Access denied! you do not have permision to edit this post'
                    erb :error

                end

        else
            redirect"/users/login"
        end
      
    end

    

    get '/post/new' do
        if logged_in?
        erb :'post/new'
    else
        @message ='You must login first to create new post please login or sign up '
        redirect"/users/login"
     end

    end

    get '/post/:id' do
        if logged_in?
            @post = Post.find(params[:id])

        if @post && @post.user == current_user
                erb :'post/show'  
        
        else 
            @message = 'Access denied! you do not have permision to see this post'
            erb :error
        end
    else
            @message ='You must login first'
            redirect"/users/login"
     end 
    end

    
    get '/post/:id/edit' do
        if logged_in?
            @post = Post.find(params[:id])
                if @post && @post.user == current_user
                    erb :'post/edit'

        else 
            @message ='Access denyed! you do not have permision to edit this post'
            erb :error
        end
    else
        @message ='You must login first'
        redirect"/users/login"
     end
    end

    post '/post/create' do
        if logged_in?
            title = params[:title]
            content = params[:content]
            #@post = Post.create(title:title, content:content)
            @post = current_user.post.build(params[:post])
            @post.save
            erb :'post/show'

       else
            @message ='You must login first'
            redirect"/users/login"
     end
    end

    
    delete '/post/:id/delete' do 
        if logged_in?
            @post = Post.find(params[:id])
            @post.delete
            @total_post = current_user.post.count
            redirect to '/home'

        else 
            @message ='You must login first'
            redirect"/users/login"
        end
    end

    
end