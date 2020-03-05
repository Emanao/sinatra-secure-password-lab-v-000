class RegistrationsController < ApplicationController
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
end
