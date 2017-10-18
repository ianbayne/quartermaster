class UsersController < ApplicationController
  def show
    @user = current_user
    @contracts = @user.contracts
  end
end
