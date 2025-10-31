class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def index
    # Show all bookings for the logged-in user (newest first)
    # Preload flats and their attached photos for performance
    @bookings = current_user.bookings
                            .includes(flat: { photos_attachments: :blob })
                            .order(start_date: :desc)
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = current_user.bookings.build(booking_params.merge(flat: @flat))

    if @booking.save
      redirect_to bookings_path, notice: "Booking created successfully!"
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end
end
