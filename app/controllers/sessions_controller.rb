class SessionsController < ApplicationController
  
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

end
