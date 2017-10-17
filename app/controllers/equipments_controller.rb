class EquipmentsController < ApplicationController
  def index
    @equipment = Equipment.all
  end

end
