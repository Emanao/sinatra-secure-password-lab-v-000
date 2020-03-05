# require "./config/environment"
# require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    user = User.new(:username=> params[:username], :password=> params[:password])
    if valid_user?(params) && user.save
      redirect '/login'
    else
      redirect '/failure'
    end

  end




  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username=> params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get "/success" do
    if logged_in?
      erb :account
    else
      redirect "/login"
    end
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
