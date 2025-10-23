class FlatsController < ApplicationController
  def index
    @flats = Flat.with_attached_photo.all
  end

  def show
    @flats = Flat.find(params[:id])
  end
end
