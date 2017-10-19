class UsersController < ApplicationController
  def show
    @user = current_user
    @contracts = @user.contracts.order(end_time: :asc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if @user.update(user_params)
      flash[:success] = "Your profile was updated correctly."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end

end
