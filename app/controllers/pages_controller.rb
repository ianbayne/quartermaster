class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @equipment = Equipment.all
  end
end
