class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @equipment = Equipment.search(params[:search])
  end
end
