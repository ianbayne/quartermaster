class UsersController < ApplicationController
  def show
    @user = current_user
    @contracts = @user.contracts.order(end_time: :asc)
  end
end
