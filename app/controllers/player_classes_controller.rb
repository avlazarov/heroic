class PlayerClassesController < ApplicationController
  # GET /player_classes
  def index
    @player_classes = PlayerClass.all
  end
end
