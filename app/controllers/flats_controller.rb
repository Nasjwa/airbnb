class FlatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  def index
    @flats = Flat.with_attached_photo.all
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def new
    @flat = current_user.flats.build
  end

  def create
    @flat = current_user.flats.build(flat_params)
    if @flat.save
      redirect_to @flat, notice: "Flat created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flat.update(flat_params)
      redirect_to @flat, notice: "Flat updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: "Flat deleted."
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    # permit :photo — file uploads handled by Active Storage
    params.require(:flat).permit(:title, :description, :location, :photo)
  end
end
