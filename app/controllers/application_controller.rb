class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    # before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 'MySecret')
    end

    def decoded_token
        if $token
            begin
                JWT.decode($token, 'MySecret', true, algorithm: 'HS256')
                rescue JWT::DecodeError
                    nil
            end
        end
    end

    def logged_in_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorized
        unless !!logged_in_user
            render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

end
