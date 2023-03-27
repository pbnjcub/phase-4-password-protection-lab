class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def create
        if user_params[:password] != user_params[:password_confirmation]
          render json: { errors: ["Password confirmation doesn't match Password"] }, status: :unprocessable_entity
        else
          user = User.create(user_params)
          session[:user_id] = user.id
          render json: user, status: :created
        end
      end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { errors: ["Unauthorized"] }, status: :unauthorized
        end
    end



    private

    def user_params
        params.permit(:id, :username, :password, :password_confirmation)
    end

end
