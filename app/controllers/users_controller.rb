class UsersController < ApplicationController
    before_action :authorized, except: [:create, :createRequest]
    
    def index
        @users = User.all
    end

    def create
        @user = User.new
    end

    def createRequest
        @user = User.new(user_fields)
        if @user.save
            redirect_to root_path
        else
            render :create,
            status: :unprocessable_entity
        end
    end

    def read
        @user
        @posts = @user.posts
        rescue ActiveRecord::RecordNotFound
            redirect_to home_path
    end

    def update
        @user
    end

    def updateRequest
        if @user.update(user_fields)
            redirect_to read_users_path
        else
            render :update,
            status: :unprocessable_entity
        end
    end

    def deleteRequest
        @user.destroy
        $token = nil
        redirect_to root_path
    end

    def logoutRequest
        $token = nil
        redirect_to root_path
    end

    private

    def user_fields
        params.require(:user).permit(:name, :email, :password, :image)
    end
end