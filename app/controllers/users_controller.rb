class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @contracts = @user.contracts
  end
end
