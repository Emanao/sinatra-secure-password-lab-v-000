class UsersController < ApplicationController
  get "/" do
    erb :index
  end
  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end
end
