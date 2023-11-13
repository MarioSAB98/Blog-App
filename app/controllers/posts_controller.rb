class PostsController < ApplicationController
    before_action :authorized

    
    def index
        @posts = Post.all
    end

    def create
        @post = Post.new
    end

    def createRequest
        user_id = decoded_token[0]['user_id']
        @post = Post.new(post_fields.merge(user_id: user_id))
        if @post.save
            PostCleanupWorkerJob.perform_in(24.hours, @post.id)
            redirect_to read_post_path(@post.id)
        else
            render :create,
            status: :unprocessable_entity
        end
    end

    def read
        @comment = Comment.new
        @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_to home_path
    end

    def update
        @post = Post.find(params[:id])
    end

    def updateRequest
        @post = Post.find(params[:id])
        if @post.update(post_fields)
            redirect_to read_post_path(@post.id)
        else
            render :update,
            status: :unprocessable_entity
        end
    end

    def deleteRequest
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to home_path
    end

    def show
        @comment = @post.comments.build
       end

    private

    def post_fields
        params.require(:post).permit(:title, :body, :tags)
    end
end