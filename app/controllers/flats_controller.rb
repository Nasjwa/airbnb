class FlatsController < ApplicationController
  def index
    @flats = Flat.with_attached_photo.all
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
