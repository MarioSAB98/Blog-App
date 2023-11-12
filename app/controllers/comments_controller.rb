class CommentsController < ApplicationController
    before_action :authorized

    def createRequest
        user_id = decoded_token[0]['user_id']
        post_id = params[:id]
        @comment = Comment.new(comment_fields.merge(user_id: user_id,post_id: post_id))
        if @comment.save
            redirect_to @comment.post
        else
        end
    end

    def update
        @comment = Comment.find(params[:id])
    end

    def updateRequest
        @comment = Comment.find(params[:id])
        if @comment.update(comment_fields)
            redirect_to @comment.post
        else
            render :update,
            status: :unprocessable_entity
        end
    end

    def deleteRequest
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to @comment.post
    end

    private

    def comment_fields
        params.require(:comment).permit(:post_id, :body)
    end

end