class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Show all bookings for the logged-in user
    @bookings = current_user.bookings.includes(:flat)
  end

  def new
    # Show booking form for one flat
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new
  end

  def create
    # Create the booking linked to the flat and user
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
