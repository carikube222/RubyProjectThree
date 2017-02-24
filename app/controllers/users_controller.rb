class UsersController < ApplicationController
    before_action :check_status, except: [:index, :create, :login, :logout]

    def index

    end

    def create
        user = User.create(name: params[:name], alias: params[:alias], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        if user.valid?
            session[:user_id] = user.id
            redirect_to '/show'
        else
            flash[:errors] = user.errors.full_messages.to_sentence
            redirect_to '/'
        end
    end

    def login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/show'
        else
            flash[:message] = "Something was wrong with login credentials"
            redirect_to '/'
        end
        # redirect_to '/'
    end

    def show
        @user = User.find(session[:user_id])
        @posts= Idea.all
        # @post_likes = @user.users_liking
        @post_likes = @user.likes
        # render json: params
    end

    def delete
        user = User.find(session[:user_id])
        Idea.find(params[:id]).destroy
        redirect_to "/show"
    end

    def info
        @user = User.find(params[:id])
        @post = Idea.where(user_id: params[:id])
    end

    def post
        @user = User.find(session[:user_id])
        @post = Idea.find(params[:id])
        @posts = Idea.all
        @likes = @post.users_liking
        # @likes = Like.where(idea_id: params[:id])
        # @likes = @post.likes
        @users = User.all



    end

    def update
        user = User.find(session[:user_id])
        if Idea.create(content: params[:content], user: user )
            redirect_to "/show"
        else
            flash[:notes] = "You need to post something."
            redirect_to "/show"
        end
    end

    def like
    user = User.find(session[:user_id])
    idea = Idea.find(params[:id])
    Like.create(user:user, idea:idea)
    redirect_to "/show"
    end

    def unlike
    user = User.find(session[:user_id])
    idea = Idea.find(params[:id])
    Like.where(user_id:session[:user_id], idea_id:params[:id]).destroy_all
    redirect_to "/show"
    end

    def logout
        session[:user_id] = nil
        redirect_to '/'
    end

    private

    def check_status
        if !session[:user_id]
            redirect_to '/'
        end
    end

end
