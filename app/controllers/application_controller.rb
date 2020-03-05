# require "./config/environment"
# require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def valid_user?(params)
      !params[:username].empty? && !params[:password].empty?
    end

    def logged_in?
      # !!session[:user_id]
      current_user()
    end

    def current_user
      @current_user ||= User.find_by(session[:user_id]) if session
    end
  end

end
