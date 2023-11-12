class SessionsController < ApplicationController

    def loginRequest
        @user = User.find_by(email: params[:session][:email])

        if @user && @user.authenticate(params[:session][:password])
            $token = encode_token({user_id: @user.id})
            redirect_to home_path
        else
            render json: {error: "Invalid email or password"}, status: 422
        end
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