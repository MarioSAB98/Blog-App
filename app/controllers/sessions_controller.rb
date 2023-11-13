class SessionsController < ApplicationController


    def loginRequest
        @user = User.find_by(email: params[:session][:email])

        if @user && @user.authenticate(params[:session][:password])
            token = encode_token({user_id: @user.id})
            cookies[:auth] = {
                :value => token,
                :expires => 1.year.from_now
              }
              $loggedin = 1
              redirect_to home_path
        else
            render json: {error: "Invalid email or password"}, status: 422
        end
    end

    def logoutRequest
        $loggedin = 0
        cookies.delete(:auth)
        redirect_to root_path
    end  
    

    private

    def user_fields
        params.require(:user).permit(:name, :email, :password, :image)
    end
end