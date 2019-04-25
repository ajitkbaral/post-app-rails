class PostsController < ApplicationController

    #GET request
    #Get the index page
    def index
        @posts = Post.all #get all the posts
    end
    
    #GET Request
    #Show the form for inserting a single post
    def new
        @post = Post.new #returns an empty post
    end

    #GET request
    #Get the specific post using id
    def show
        @post = Post.find(params[:id]) #get the post from the id and return the post
    end

    #GET Request
    #Show the form with post information to be edited by the user
    def edit
        @post = Post.find(params[:id])
    end

    #POST Request
    #Gets the data from the user from the form showing by new function
    def create
        # render plain: params[:post].inspect #get the inspected parameters filled by the user in the form
        @post = Post.new(post_params) #Create a new post with the supplied post parameters
        if(@post.save) #Saves the post to the database
            redirect_to @post #Redirects to the show method
        else
            render 'new' #If got any errors while saving, render the new.html.erb page and show the error 
        end
    end

    #PATCH Request
    #Updates the posts to the database
    def update
        @post = Post.find(params[:id]) #get the post from the id
        if(@post.update(post_params)) #check if the post gets updated
            redirect_to @post #returns the post to the 
        else
            render 'edit' #If got any errors while updating, render the new.html.erb page and show the error 
        end
    end

    #DELETE Method
    #Delete the data from the database
    def destroy
        @post = Post.find(params[:id]) #get the post from the id
        @post.destroy #removes the post

        redirect_to posts_path #returns to the index page, posts_path => index page
    end




    #Private Method
    
    private def post_params
        params.require(:post).permit(:title, :description)
    end


end
