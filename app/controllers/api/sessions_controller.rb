module Api
  class SessionsController < ApplicationController
    def create
      @user = User.find_or_create_by!(username: params[:username])

      render json: serialize(@user)
    end

    private

    def serialize(user)
      {
        id: user.id,
        username: user.username
      }
    end
  end
end
