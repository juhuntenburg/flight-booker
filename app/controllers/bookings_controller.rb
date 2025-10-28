class BookingsController < ApplicationController

  def new
    @flight = Flight.find(request_params[:flight_id])
    @booking = Booking.new(flight: @flight)
    request_params[:n_passengers].to_i.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params[:booking])

    if @booking.save
      @booking.passengers.each do |passenger|
        PassengerMailer.with(
          passenger: passenger,
          booking: @booking
        ).booking_confirmation.deliver_later
      end

      redirect_to @booking, notice: "Booking confirmed!"
    else
      @flight = @booking.flight
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def request_params
    params.permit(:flight_id,
                  :n_passengers,
                  :commit).tap { |p| p.delete(:commit) }
  end

  def booking_params
    return params.permit(
      :n_passengers,
      booking: [:flight_id, passengers_attributes: [[:id, :name, :email]]]
    )
  end
end
