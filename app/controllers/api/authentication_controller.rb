class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate_token!, raise: false

  def create
    user = User.find_by(email: params[:user][:email])
    if user.valid_password? params[:user][:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"] }
    end
  end
end

